import os

with open("slurm-env.sh", "w") as f:
    for k,v in os.environ.iteritems(): 
        if k.startswith("SLURM"):
            f.write('export {}="{}"\n'.format(k,v))
    f.write("export PYSPARK_DRIVER_PYTHON=ipython\n")
