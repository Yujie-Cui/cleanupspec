#!/usr/bin/python3
import os
import sys

if __name__=="__main__":

	invisi_schemes=['UnsafeBaseline','SpectreSafeFence','FuturisticSafeFence',\
	'SpectreSafeInvisibleSpec','FuturisticSafeInvisibleSpec']
	cleanup_schemes=['UnsafeBaseline','L1RandRepl','RandL2',\
	'RandL2_L1RandRepl','Cleanup_FOR_L1','Cleanup_FOR_L1L2']

	if len(sys.argv)==1:
		print('1. invisibleSpec:')
		for  invisi_scheme in invisi_schemes:
			print('\t1.'+str(invisi_schemes.index(invisi_scheme)+1)+': '+invisi_scheme)
		
		print('2. cleanupSpec:')
		for  cleanup_scheme in cleanup_schemes:
			print('\t2.'+str(cleanup_schemes.index(cleanup_scheme)+1)+': '+cleanup_scheme)
		
		print('input your choice? (for examble 2.1)')
		index = input()
		if not (index.startswith('1') or index.startswith('2')) :
			print('error format')
			exit()
	elif len(sys.argv)>3:
		print("for examble  ./execute.py 2.1")
		exit()
	else :
		index = sys.argv[1]
		if not (index.startswith('1') or index.startswith('2')) :
			print('error format')
			exit()
	
	type=int(index[0])
	schemeIndex=int(index[2])
	if type==1:
		sFile='invisi.sh'
		scheme = invisi_schemes[schemeIndex-1]
	else:
		sFile='cleanup.sh'
		scheme = cleanup_schemes[schemeIndex-1]

	if 'debug' in sys.argv:
		sFile='debug_spectre_'+sFile
	else :
		sFile='spectre_'+sFile
	command='./'+sFile+' '+scheme
	print(command)
	os.system(command)


