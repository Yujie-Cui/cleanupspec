#!/usr/bin/python3

'''

list dict : Underscore
		  : Hump method

command like 

perlbench,bzip2	,mcf,gobmk,hmmer,sjeng,libquantum,h264ref	,omnetpp	,astar	,bwaves	
milc	
zeusmp	
gromacs	
cactusADM	
namd	
soplex	
calculix	
GemsFDTD	
tonto	
lbm	
sphinx	
gcc	
wrf	
dealII	
povray	
xalancbmk	
gamess

'''
import os
import sys
import collections

class UserCommand(object):
	def __init__(self):

		self.scheme_name=['invisibleSpec','cleanupSpec'] #
		self.scheme_file={'invisibleSpec':'invisi.sh','cleanupSpec':'cleanup.sh'}
		self.invisi_schemes=['UnsafeBaseline','SpectreSafeFence','FuturisticSafeFence',\
		'SpectreSafeInvisibleSpec','FuturisticSafeInvisibleSpec']
		self.cleanup_schemes=['UnsafeBaseline','L1RandRepl','RandL2',\
		'RandL2_L1RandRepl','Cleanup_FOR_L1','Cleanup_FOR_L1L2']
		self.strategies=collections.OrderedDict()
		self.strategies['invisibleSpec']=self.invisi_schemes
		self.strategies['cleanupSpec']=self.cleanup_schemes
		self.allBenchmark=['perlbench', 'bzip2', 'mcf', 'gobmk', 'hmmer', 'sjeng', 'libquantum', 'h264ref', 'omnetpp', \
			'astar', 'bwaves', 'milc', 'zeusmp', 'gromacs', 'cactusADM', 'namd', 'soplex', 'calculix', \
			'GemsFDTD', 'tonto', 'lbm', 'sphinx', 'gcc', 'wrf', 'dealII', 'povray', 'xalancbmk', 'gamess']
		# choice
		self.invisiScheme  ="UnsafeBaseline "
		self.cleanupScheme ="UnsafeBaseline "
		
		self.RUN_CONFIG ="Test"       # decide the output dir  
		self.choseDebug = "withoutDebug"   # test whether to be debug
		self.debugFlag="O3CPUAll"
		self.allFlags=['O3CPUAll','ExecAll','Exec']
		self.benchmarkName='hello'     # if spec2006 , benchmark name
		self.command='./benchmark.sh '
		self.option=''
	
	def setUserInput(self,userInput):
		self.userInput=userInput
	def printChoice(self):
		for strategy ,schemes in self.strategies.items():
			straIndex=str(list(self.strategies.keys()).index(strategy)+1)
			print(straIndex+'. '+strategy)
			for scheme in schemes:
				schemeIndex=str(schemes.index(scheme)+1)
				print('\t'+straIndex+'.'+schemeIndex+'. '+scheme)
	def setChoices(self):
		#Mutable types are passed by reference.
		#Immutable types are passed by value.
		
		#print('setChoice:userInput=',end='')
		#print(userInput)
		
		# To modify global variables in functions, first use global declarations
		userInput=self.userInput[0]
		if(not self.isCorrectFormat(userInput)):
			print("error format")
			return 

		userInput=self.userInput[0]

		strategyIndex = int(userInput[0])-1
		schemeIndex = int(userInput[2])-1
		
		#name
		strategyName  = list(self.strategies.keys())[strategyIndex]
		schemeName=list(self.strategies[strategyName])[schemeIndex]
		if strategyIndex==0:
			self.invisiScheme=schemeName
		else:
			self.cleanupScheme=schemeName
		del self.userInput[0]
		if 'real' in self.userInput:
			self.RUN_CONFIG ="real"
			self.userInput.remove('real')
		if 'debug' in self.userInput:
			self.choseDebug='needDebug'
			self.userInput.remove('debug')
		for flag in self.allFlags:
			if flag in self.userInput:
				self.debugFlag=flag
				self.userInput.remove(flag)
				break
		#solve the benchmark situation in the final
		if len(self.userInput) >1:
			print("wrong input")
		if len(self.userInput) !=0:
			self.benchmarkName = self.userInput[0] 
		# if len(self.userInput)== 1:
		# 	return
		# elif len(self.userInput)!=2:
		# 	print('wrong number')
		# 	return 
		# else:
		# 	self.isBenchmark =True
		# 	self.benchmark='benchmark'
		# 	if self.userInput[0] in self.allBenchmark:
		# 		self.benchmarkName = self.userInput[0]
		# 		self.userInput.remove(self.benchmarkName)
		# 	else:
		# 		self.benchmarkName = self.userInput[1]
		# 		self.userInput.remove(self.benchmarkName)
	
	def isCorrectFormat(self,choice):
		straIndex=choice[0]
		schemeIndex=choice[2]
		if choice[1]!='.' or len(choice)!=3:
			return False
		if not (straIndex.isdecimal() and int(straIndex)<=len(self.strategies.keys())):
			return False
		strategy=list(self.strategies.keys())[int(straIndex)-1]
		if not (schemeIndex.isdecimal() and int(schemeIndex)<=len(self.strategies[strategy])):
			return False
		return True

	def getCommand(self):

		self.setChoices()
		self.command+=	' '+self.cleanupScheme+\
						' '+self.invisiScheme+\
						' '+self.benchmarkName+\
						' '+self.RUN_CONFIG+\
						' '+self.choseDebug+\
						' '+self.debugFlag
		return self.command

if __name__=="__main__" :
	userInput=sys.argv
	cmd = UserCommand()
	if len(sys.argv)==1:
		cmd.printChoice()
		print('input your choice? (for examble 2.1 real debug spectre ExecAll)')
		userInput = input().split()
	else :
		userInput = userInput[1:]

	cmd.setUserInput(userInput)
	# cmd.setChoices()
	command = cmd.getCommand()
	print(command)
	os.system(command)

