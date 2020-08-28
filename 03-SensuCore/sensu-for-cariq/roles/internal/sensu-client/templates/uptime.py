#!/usr/bin/python

from datetime import timedelta
import subprocess
from time import time

#host=call(["/bin/hostname"])
#host = subprocess.Popen(["/bin/hostname"], stdout=subprocess.PIPE).communicate()[0]

host = subprocess.check_output("/bin/hostname", stderr=subprocess.STDOUT)

with open('/proc/uptime', 'r') as f:
    uptime_seconds = float(f.readline().split()[0])
#    uptime_string = str(timedelta(seconds = uptime_seconds))
    uptime_string = str(uptime_seconds)
    current_time = int(time())

#print mytime[0]
#print current_time
print(host.rstrip()+".uptime "+uptime_string+" "+str(current_time))
