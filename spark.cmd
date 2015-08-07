#!/bin/bash
################################################################################
#  A simple Scala based example for Spark
#  Designed to run on SDSC's Comet resource.
#  Mahidhar Tatineni, San Diego Supercomputer Center   June 2015
################################################################################
#SBATCH --job-name="spark-demo"
#SBATCH --output="spark-demo.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=24
#SBATCH --export=ALL
#SBATCH -t 01:00:00

### Environment setup for Hadoop and Spark
export MODULEPATH=$MODULEPATH:/share/apps/compute/modulefiles/applications
module load spark/1.4.1
export PATH=/opt/hadoop/2.6.0/sbin:$PATH
export HADOOP_CONF_DIR=$HOME/mycluster.conf
export WORKDIR=`pwd`

myhadoop-configure.sh

### Start HDFS.  Starting YARN isn't necessary since Spark will be running in
### standalone mode on our cluster.
start-dfs.sh

### Load in the necessary Spark environment variables
source $HADOOP_CONF_DIR/spark/spark-env.sh

### Start the Spark masters and workers.  Do NOT use the start-all.sh provided 
### by Spark, as they do not correctly honor $SPARK_CONF_DIR
myspark start

python save_slurm_env.py

sleep 60m

### Copy the data into HDFS
# hdfs dfs -mkdir -p /user/$USER
# hdfs dfs -put $WORKDIR/facebook_combined.txt /user/$USER/
# 
# run-example org.apache.spark.examples.graphx.LiveJournalPageRank facebook_combined.txt --numEPart=8
# 
# ### Shut down Spark and HDFS
# myspark stop
# stop-dfs.sh
# 
# ### Clean up
# myhadoop-cleanup.sh
