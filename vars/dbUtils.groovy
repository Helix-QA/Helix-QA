
def runDbOperation(operation, args) {
    bat "${env.DB_OPERATIONS_SCRIPT} ${operation} ${args}"
    echo "Выполнена операция: ${operation} ${args}"
}