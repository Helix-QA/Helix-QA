from flask import Flask, jsonify, request, make_response
from flask_cors import CORS
from flask_caching import Cache
import psycopg
from psycopg_pool import ConnectionPool
import requests

app = Flask(__name__)
CORS(app, resources={
    r"/api/*": {
        "origins": ["https://melodious-snickerdoodle-4c15c0.netlify.app", "http://localhost:*"],
        "methods": ["GET", "POST", "PUT", "DELETE"],
        "allow_headers": ["Content-Type", "Authorization"]
    }
})
cache = Cache(app, config={'CACHE_TYPE': 'simple'})

# Настройка пула соединений с PostgreSQL
db_pool = ConnectionPool(
    conninfo="dbname=testerstart user=postgres password=postgres host=localhost port=5432",
    min_size=1,
    max_size=20
)

@cache.cached(timeout=300)  # Кэширование на 5 минут
@app.route('/api/products', methods=['GET'])
def get_products():
    try:
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT name FROM products")
                products = [row[0] for row in cursor.fetchall()]
                
                if not products:  # Если нет продуктов
                    return jsonify({"error": "No products found"}), 404
                    
                response = jsonify(products)
                response.headers['Content-Type'] = 'application/json'
                return response
                
    except Exception as e:
        app.logger.error(f"Error in get_products: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500
@cache.cached(timeout=300, query_string=True)  # Кэширование с учетом параметра product
@app.route('/api/services/<product>', methods=['GET'])
def get_services(product):
    try:
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    """
                    SELECT s.name, s.description, s.block_id, sb.name as block_name
                    FROM services s
                    LEFT JOIN service_blocks sb ON s.block_id = sb.id
                    WHERE s.product_id = %s
                    """,
                    (product_id[0],)
                )
                services = [
                    {
                        "name": row[0],
                        "description": row[1],
                        "block_id": row[2],
                        "block_name": row[3] or "Default"
                    } for row in cursor.fetchall()
                ]
        return jsonify(services)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/services/<product>', methods=['POST'])
def add_service(product):
    try:
        data = request.get_json()
        name = data.get('name')
        description = data.get('description')
        block_id = data.get('block_id')
        
        if not name or not description:
            return jsonify({"error": "Name and description are required"}), 400
        
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                if block_id:
                    cursor.execute("SELECT id FROM service_blocks WHERE id = %s AND product_id = %s", (block_id, product_id[0]))
                    if not cursor.fetchone():
                        return jsonify({"error": "Block not found"}), 404
                
                cursor.execute(
                    "SELECT id FROM services WHERE product_id = %s AND name = %s",
                    (product_id[0], name)
                )
                if cursor.fetchone():
                    return jsonify({"error": "Service already exists"}), 400
                
                cursor.execute(
                    """
                    INSERT INTO services (product_id, name, description, block_id)
                    VALUES (%s, %s, %s, %s)
                    """,
                    (product_id[0], name, description, block_id)
                )
                conn.commit()
        cache.delete('view/%s' % request.path)  # Очистка кэша при добавлении
        return jsonify({"message": "Service added successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/services/<product>/<service>', methods=['DELETE'])
def delete_service(product, service):
    try:
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    "DELETE FROM services WHERE product_id = %s AND name = %s",
                    (product_id[0], service)
                )
                if cursor.rowcount == 0:
                    return jsonify({"error": "Service not found"}), 404
                conn.commit()
        cache.delete('view/%s' % request.path.replace('/<service>', ''))  # Очистка кэша при удалении
        return jsonify({"message": "Service deleted successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/blocks/<product>', methods=['GET'])
def get_blocks(product):
    try:
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    "SELECT id, name FROM service_blocks WHERE product_id = %s",
                    (product_id[0],)
                )
                blocks = [{"id": row[0], "name": row[1]} for row in cursor.fetchall()]
        return jsonify(blocks)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/blocks/<product>', methods=['POST'])
def add_block(product):
    try:
        data = request.get_json()
        name = data.get('name')
        
        if not name:
            return jsonify({"error": "Block name is required"}), 400
        
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    "SELECT id FROM service_blocks WHERE product_id = %s AND name = %s",
                    (product_id[0], name)
                )
                if cursor.fetchone():
                    return jsonify({"error": "Block already exists"}), 400
                
                cursor.execute(
                    "INSERT INTO service_blocks (product_id, name) VALUES (%s, %s) RETURNING id",
                    (product_id[0], name)
                )
                block_id = cursor.fetchone()[0]
                conn.commit()
        cache.delete('view/%s' % request.path)  # Очистка кэша при добавлении
        return jsonify({"message": "Block added successfully", "block_id": block_id})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/blocks/<product>/<block_id>', methods=['PUT'])
def update_block(product, block_id):
    try:
        data = request.get_json()
        name = data.get('name')
        
        if not name:
            return jsonify({"error": "Block name is required"}), 400
        
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    "SELECT id FROM service_blocks WHERE id = %s AND product_id = %s",
                    (block_id, product_id[0])
                )
                if not cursor.fetchone():
                    return jsonify({"error": "Block not found"}), 404
                
                cursor.execute(
                    "UPDATE service_blocks SET name = %s WHERE id = %s AND product_id = %s",
                    (name, block_id, product_id[0])
                )
                conn.commit()
        cache.delete('view/%s' % request.path.replace('/<block_id>', ''))  # Очистка кэша
        return jsonify({"message": "Block updated successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/blocks/<product>/<block_id>', methods=['DELETE'])
def delete_block(product, block_id):
    try:
        with db_pool.connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT id FROM products WHERE name = %s", (product,))
                product_id = cursor.fetchone()
                if not product_id:
                    return jsonify({"error": "Product not found"}), 404
                
                cursor.execute(
                    "SELECT id FROM service_blocks WHERE id = %s AND product_id = %s",
                    (block_id, product_id[0])
                )
                if not cursor.fetchone():
                    return jsonify({"error": "Block not found"}), 404
                
                # Delete associated services first
                cursor.execute(
                    "DELETE FROM services WHERE block_id = %s AND product_id = %s",
                    (block_id, product_id[0])
                )
                # Delete the block
                cursor.execute(
                    "DELETE FROM service_blocks WHERE id = %s AND product_id = %s",
                    (block_id, product_id[0])
                )
                conn.commit()
        cache.delete('view/%s' % request.path.replace('/<block_id>', ''))  # Очистка кэша
        return jsonify({"message": "Block deleted successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/build-status/<product>', methods=['GET'])
def get_build_status(product):
    try:
        # Конфигурация Jenkins
        JENKINS_URL = 'http://192.168.2.71:8080'
        JENKINS_AUTH_TOKEN = 'cm9vdDoxMTAzNGM0NzM2YjA5MDhiMzFkNWMzMDk2ZDU1MzdiY2Qy'
        
        # Запрашиваем историю сборок для задачи debug
        response = requests.get(
            f'{JENKINS_URL}/job/debug/api/json?tree=builds[number,building,actions[parameters[name,value]]]{0,10}',
            headers={'Authorization': f'Basic {JENKINS_AUTH_TOKEN}'}
        )
        if not response.ok:
            return jsonify({"error": f"Failed to get build status: {response.status_code}"}), 500
        
        job_data = response.json()
        builds = job_data.get('builds', [])
        
        # Проверяем, есть ли активные сборки для данного продукта
        for build in builds:
            if build.get('building', False):
                # Проверяем параметры сборки
                parameters = next((action.get('parameters', []) for action in build.get('actions', []) if action.get('parameters')), [])
                product_param = next((param.get('value') for param in parameters if param.get('name') == 'PRODUCT'), None)
                if product_param == product:
                    resp = make_response(jsonify({
                        "isBuilding": True,
                        "buildNumber": build['number']
                    }))
                    resp.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
                    return resp
        
        resp = make_response(jsonify({"isBuilding": False}))
        resp.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
        return resp
    except Exception as e:
        resp = make_response(jsonify({"error": str(e)}), 500)
        resp.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
        return resp

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)