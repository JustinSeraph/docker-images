##Docker Run Command:
docker run -p <ip/domain>:5022:22 --name server -it <Image ID/REPOSITORY>

## Standalone Operation
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar grep input output 'dfs[a-z.]+'
cat output/*