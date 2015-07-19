Interactive pyspark shell on Comet
=================================

* Set `module load python scipy` in `.bashrc`
* Submit `spark` job to SLURM with `qsub spark.cmd`
* Load environment with `source slurm-env.sh` (created after `spark` starts)
* Login to the head node with `ssh $SLURMD_NODENAME`
* Configure the environment with:

        source slurm-env.sh
        source ~/mycluster.conf/spark/spark-env.sh
        
* Start the interactive console with `pyspark`
