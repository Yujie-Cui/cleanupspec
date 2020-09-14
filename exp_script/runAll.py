#!/usr/bin/python3
import sys
import os
import optparse
#os.system('pwd')
#os.system('source virPara.sh')
parser = optparse.OptionParser()
parser.add_option('--benchmark',help='Benchmark program you want to run')
parser.add_option('--scheme',help="The protection scheme you want to implement ")
(options,args)=parser.parse_args()
if(options.benchmark==None):
    options.benchmark="spectre"
if(options.scheme==None):
    options.scheme="UnsafeBaseline"
print("\n"+"benchmark: "+options.benchmark+"    scheme: "+options.scheme+"&> ../spectre/"+options.scheme+"_base.log")
if(options.benchmark=="spectre"):
    os.system("./run_spectre.sh "+options.scheme+"&> ../spectre/"+options.scheme+"_base.log")
	
else :
    os.system("./runscript "+options.benchmark+" "+options.scheme+" "+options.benchmark+"_"+options.scheme+".log") 
