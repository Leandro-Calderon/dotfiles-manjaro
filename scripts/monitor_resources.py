#!/home/lean/scripts/env/python

import psutil
import time

def monitor_resources():
    try:
        while True:
            cpu = psutil.cpu_percent(interval=1)
            ram = psutil.virtual_memory().percent
            print(f"CPU: {cpu}% | RAM: {ram}%")
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nMonitorización detenida.")

if __name__ == "__main__":
    monitor_resources()

