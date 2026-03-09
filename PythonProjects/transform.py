import sys
import numpy as np
import pandas as pd

file1=sys.argv[1]
file2=sys.argv[2]

fp1=open(file1,'r')
fp2=open(file2,'r')

name=file1.split('.')[0]


fp3=open(name+'_merged.csv','w')

lines=fp2.read()

if (lines[len(lines)-1]=='\n' and len(lines) > 1):
	lines=lines[0:len(lines)-1]

line_list=lines.split('\n')
first_lines=','.join(line_list)
print ('lines '+lines)
print ('Line list'+str(line_list))

fp3.write(first_lines+'\n')

for line1 in fp1:
 	fp3.write(line1+'\n')

fp3.close()
fp1.close()
fp2.close()

df=pd.read_csv(name+'_merged.csv')

print (df.info())

row_ind=np.random.randint(0,len(df.index),10)
col_ind=np.random.randint(0,len(list(df.columns)),10)
print ('row_index:'+str(row_ind))
print ('col_index:'+str(col_ind))

print ('Array: \n'+str(df.iloc[row_ind,col_ind]))
df.iloc[row_ind,col_ind]=np.nan
print ('Array: \n'+str(df.iloc[row_ind,col_ind]))
print (df.loc[df.isna().any(axis=1),df.isna().any()])
df.to_csv(name+'_merged.csv')



		
