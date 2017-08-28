##Docker Run Command:
docker run -p <ip/domain>:5022:22 --name server -it <Image ID/REPOSITORY>
sudo docker run -h namenode1 -P -p 50070:50070 -p 8088:8088 -p 5022:22 --name namenode1 -itd justinxu/hadoop-cluster

## Cluster-Distributed Operation
http://hadoop.apache.org/docs/r2.8.0/hadoop-project-dist/hadoop-common/ClusterSetup.html

