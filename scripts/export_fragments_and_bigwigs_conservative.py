

#run in snapatac2 docker
print('loading libraries',flush = True)
import sys

print(sys.path)
import snapatac2 as snap
#import scanpy as sc
import pandas as pd
import os
import pathlib
import sys
from pathlib import Path
import random
import glob
import re
import numpy as np
import shutil
import numpy as np
from more_itertools import chunked
import argparse
# get resolution to focus on
parser = argparse.ArgumentParser()
parser.add_argument('--resolution', action="store", dest='resolution', default=0)
parser.add_argument('--args', action="store", dest='sample_index', default=0)

args = parser.parse_args()
resolution =  args.resolution
sample_index = int(args.sample_index)

dat = pd.read_csv('/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/results/conservative_dataset.csv') # this is a dataframe of all groups constructed from the samp.dat- it is used to select arguments for the function below
#subset dat to indicated resolution # 
dat = dat[dat['resolution']==resolution] #1201 supertype label, 337 subclass, 35 class -in batches - array-values = supertype:0-24 subclass: 0-6, class: 0
dat = dat.reset_index()
tempdir = '/allen/programs/celltypes/workgroups/mct-t200/marcus/tmp'

#change for different files
groupBy = resolution



print("sample_index", flush = True)
print(str(sample_index), flush = True)
#1374 groups to call w/ >50 cells per supertype

#process in chunks (28 chunks 0-27)
chunks = list(chunked(dat.index.tolist(),50))
indices = chunks[sample_index]
dat = dat.iloc[indices]

#groupBy = str(dat['resolution'].tolist()[0])
selection = dat['grouping'].tolist()
bw_out_dir = dat['bw_out_dir'].tolist()[0]
frag_out_dir = dat['frag_out_dir'].tolist()[0]
print('groupBy:', flush = True)
print(groupBy, flush = True)
print('selection:', flush = True)
print(selection, flush = True)
print('bw_out_dir:', flush = True)
print(bw_out_dir, flush = True)
print('frag_out_dir:',flush = True)
print(frag_out_dir,flush = True)


if resolution == 'supertype_label':
    adata = snap.read_dataset('dataset_copy_V1.h5ads',mode = 'r+')
elif resolution == 'subclass_label':
    adata = snap.read_dataset('dataset_copy_V2.h5ads',mode = 'r+')
elif resolution == 'class_label' | resolution == "neighborhood":
    adata = snap.read_dataset('dataset_copy_V3.h5ads',mode = 'r+')
else:
    print('resolution not in allowed options, not loading data')

try:
    snap.ex.export_coverage(adata = adata, groupby = groupBy, selections=selection, bin_size=10, blacklist=None, normalization='RPKM', ignore_for_norm=None, min_frag_length=None, max_frag_length=2000, out_dir=bw_out_dir, prefix='', suffix='.bw', output_format='bigwig',compression=None, compression_level=None, tempdir=tempdir, n_jobs=8)
    snap.ex.export_fragments(adata=adata, groupby = groupBy, selections=selection, min_frag_length=None, max_frag_length=None, out_dir=frag_out_dir, prefix='', suffix='.zst', compression=None, compression_level=None)
except:
    print('error exporting')
adata.close()
