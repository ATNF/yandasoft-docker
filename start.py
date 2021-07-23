#!/usr/bin//python

import os
from subprocess import Popen, PIPE, check_call

# build the image
check_call(["docker","build","-t", "yanda-dev","."])
#start up yandasoft service
check_call(["docker-compose","up","-d"])
p = Popen(["docker","ps","-aq"],stdout=PIPE,stderr=PIPE)
p.wait()

