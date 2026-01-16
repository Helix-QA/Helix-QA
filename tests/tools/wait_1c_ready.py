import time
import subprocess
import sys

MAX_WAIT = 180
STEP = 5
elapsed = 0

while elapsed < MAX_WAIT:
    try:
        result = subprocess.run(
            ['rac', 'cluster', 'list'],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if result.returncode == 0 and result.stdout.strip():
            print("1C server is ready")
            sys.exit(0)
    except Exception:
        pass

    time.sleep(STEP)
    elapsed += STEP

print("1C server NOT ready after timeout")
sys.exit(1)
