import os
import numpy as np
import pandas as pd
import sys
import subprocess
from os import listdir
from os.path import isfile, join
import glob
import re
#run zstd -d *.zst (to decompress all fragments in shell prior to running this script)

sample_index = int(sys.argv[2]) # for slurm array job

wdir = '/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/supertype_conservative/' #the directory where peaks are exported to from snapatac2 (in a previous script)
os.chdir(wdir)
out_file_name = "supertype_peak_files.csv"

files = glob.glob('*.zst') #get all exported fragments
names = [f.replace('.zst','') for f in files]
files_df = pd.DataFrame({"compressed_files": files,
	'files': [f.replace('.zst','') for f in files],
	"names": names,
	"out_dir": [wdir + 'out/'+f.replace('.zst','_out') for f in files],
	"peak_file":[wdir + '/out/'+f.replace('.zst','_out/')+f.replace('.zst','_peaks.xls') for f in files],
	"narrow_peak_file":[wdir + '/out/'+f.replace('.zst','_out/')+f.replace('.zst','_peaks.narrowPeak') for f in files],
	"narrow_peak_file":[wdir + '/out/'+f.replace('.zst','_out/')+f.replace('.zst','_summits.bed') for f in files]  })

compressed_file = files_df.iloc[sample_index]["compressed_files"]
filename = files_df.iloc[sample_index]["names"]
file = files_df.iloc[sample_index]["files"]
out_dir = wdir+ 'out/'+compressed_file.replace('.zst','_out')


#run macs3
subprocess.run(args = ['macs3', 'callpeak','-t',file, '--name', filename, '--format','BEDPE', '--gsize', '2652783500',
	'--qvalue','0.05','--min-length','100', '--shift','-100', '--extsize', '200' ,'--outdir',out_dir])


#outputs a file with locations of all called peaks, these need to be read in later and added to the snapatac2 object.
files_df.to_csv(wdir+out_file_name)

