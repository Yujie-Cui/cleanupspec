import m5
from m5.objects import *


#Spectre
diff_time  = Process() # Added by Yujie
diff_time.executable = 'diff_time'
diff_time.cmd = [diff_time.executable]
