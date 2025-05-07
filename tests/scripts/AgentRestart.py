import subprocess
import time
import sys
import os

def run_command(command):
    """Execute a command and return the result."""
    try:
        # Decode output as cp1251 (Windows-1251)
        result = subprocess.run(command, shell=True, capture_output=True, text=True, encoding='cp1251')
        # Re-encode output to UTF-8 for correct display
        stdout_utf8 = result.stdout.encode('utf-8').decode('utf-8', errors='replace')
        stderr_utf8 = result.stderr.encode('utf-8').decode('utf-8', errors='replace')
        
        if result.returncode == 0:
            print(f"Command '{command}' executed successfully: {stdout_utf8}")
        else:
            print(f"Error executing command '{command}': {stderr_utf8}")
        return result.returncode
    except UnicodeDecodeError as ude:
        print(f"Output decoding error for command '{command}': {str(ude)}")
        return 0  # Assume success if only decoding error
    except Exception as e:
        print(f"Exception executing command '{command}': {str(e)}")
        return 1

def restart_1c_service():
    """Restart the 1C:Enterprise 8.3 Server Agent (x86-64) service."""
    service_name = "1C:Enterprise 8.3 Server Agent (x86-64)"
    print(f"Stopping service '{service_name}'...")
    stop_result = run_command(f'net stop "{service_name}"')
    
    if stop_result != 0:
        print(f"Failed to stop service '{service_name}'. Return code: {stop_result}")
        sys.exit(1)
    
    # Allow time for the service to stop
    time.sleep(5)
    
    print(f"Starting service '{service_name}'...")
    start_result = run_command(f'net start "{service_name}"')
    
    if start_result != 0:
        print(f"Failed to start service '{service_name}'. Return code: {start_result}")
        sys.exit(1)
    
    print(f"Service '{service_name}' successfully restarted.")

if __name__ == "__main__":
    try:
        # Set UTF-8 encoding for console output
        sys.stdout.reconfigure(encoding='utf-8')
        os.environ['PYTHONIOENCODING'] = 'utf-8'
        restart_1c_service()
    except Exception as e:
        print(f"Critical error: {str(e)}")
        sys.exit(1)