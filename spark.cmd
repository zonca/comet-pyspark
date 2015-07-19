#!/bin/bash
################################################################################
#  A simple Scala based example for Spark
#  Designed to run on SDSC's Comet resource.
#  Mahidhar Tatineni, San Diego Supercomputer Center   June 2015
################################################################################
#SBATCH --job-name="graphx-demo"
#SBATCH --output="graphx-demo.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=24
#SBATCH --export=ALL
#SBATCH -t 00:30:00

### Environment setup for Hadoop and Spark
module load spark
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

sleep 30m

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
