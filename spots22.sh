#!/usr/bin/bash

tmp_dir="/C/ztmp"
mkdir -pv $tmp_dir

rm -f $tmp_dir/*

for ins in `cat ins_list.txt`
do
    lis1=`echo -en $lis1\'$ins\'\,`
done

lis1=${lis1::-1}

for ins in `cat ins_list.txt`
do
    lis2=`echo -en $lis2\'$ins\'\ `
done


for regi in eu-central-1 eu-north-1 eu-west-1 eu-west-2 eu-west-3 us-east-1 us-east-2 us-west-1 us-west-2
do
	aws ec2 describe-spot-price-history  --start-time $(date -d "6 hours ago" +"%FT%T") \
	  --filters "Name=instance-type,Values=$lis1" \
	  --product-description "Linux/UNIX" --query 'SpotPriceHistory[*].[AvailabilityZone,InstanceType,SpotPrice,Timestamp]' \
	  --output table --region $regi
done > $tmp_dir/prices_spot.txt

grep ":" $tmp_dir/prices_spot.txt|sort +4 > $tmp_dir/sorted_sort.txt

for inst in `cat ins_list.txt`
do
	grep $inst $tmp_dir/sorted_sort.txt|head -4 >> $tmp_dir/ins_per_pri.txt
	echo >> $tmp_dir/ins_per_pri.txt
done
	  #--filters "Name=instance-type,Values='t2.xlarge','t2.large','t2.micro','t3.medium','t4g.medium','t3a.medium','t2.medium','c3.large','m4.large'" \
#for inst in 't2.xlarge' 't2.large' 't2.micro' 't3.medium' 't4g.medium' 't3a.medium' 't2.medium' 'c3.large' 'm4.large'



#--instance-types "string" "string"

#aws ec2 describe-instance-types --instance-types 'm4.large' 'm5.large' 'm5a.large' 'm6a.large' 'm7a.large' 't2.large' 't3.large' 't3a.large' 't4g.large'\
# 't2.xlarge' 't2.large' 't2.micro' 't3.medium' 't4g.medium' 't3a.medium' 't2.medium' 'c3.large' 'm4.large' \
#  --query 'InstanceTypes[*].[InstanceType,SupportedArchitectures,SupportedUsageClasses,VCpuInfo,MemoryInfo]' --output table --region us-east-1


#aws ec2 describe-instance-types --instance-types 'm4.large' 'm5.large' 'm5a.large' 'm6a.large' 'm7a.large' 't2.large' 't3.large' 't3a.large' 't4g.large' 't2.xlarge' 't2.large' 't2.micro' 't3.medium' 't4g.medium' 't3a.medium' 't2.medium' 'c3.large' 'm4.large'   --query 'InstanceTypes[*].[InstanceType,ProcessorInfo.SupportedArchitectures[0],ProcessorInfo.SupportedArchitectures[1],SupportedUsageClasses[1],VCpuInfo.DefaultVCpus,VCpuInfo.DefaultCores,VCpuInfo.DefaultThreadsPerCore,MemoryInfo.SizeInMiB]' --output table --region us-east-1

#aws ec2 describe-instance-types --instance-types 'm4.large' 'm5.large' 'm5a.large' 'm6a.large' 'm7a.large' 't2.large' 't3.large' 't3a.large' 't4g.large' 't2.xlarge' 't2.large' 't2.micro' 't3.medium' 't4g.medium' 't3a.medium' 't2.medium' 'c3.large' 'm4.large'   --query 'InstanceTypes[*].[InstanceType,ProcessorInfo.SupportedArchitectures[1],ProcessorInfo.SupportedArchitectures[0],SupportedUsageClasses[1],VCpuInfo.DefaultVCpus,VCpuInfo.DefaultCores,VCpuInfo.DefaultThreadsPerCore,MemoryInfo.SizeInMiB]' --output table --region us-east-1


# --------------------------------------------------------------------
# |                       DescribeInstanceTypes                      |
# +------------+---------+---------+-------+----+----+-----+---------+
# |  t3.medium |  x86_64 |  None   |  spot |  2 |  1 |  2  |  4096   |
# |  m5a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t2.xlarge |  x86_64 |  None   |  spot |  4 |  4 |  1  |  16384  |
# |  m6a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  m5.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t2.micro  |  i386   |  x86_64 |  spot |  1 |  1 |  1  |  1024   |
# |  m4.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t2.medium |  i386   |  x86_64 |  spot |  2 |  2 |  1  |  4096   |
# |  t3a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t2.large  |  x86_64 |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t3a.medium|  x86_64 |  None   |  spot |  2 |  1 |  2  |  4096   |
# |  m7a.large |  x86_64 |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t3.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t4g.large |  arm64  |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t4g.medium|  arm64  |  None   |  spot |  2 |  2 |  1  |  4096   |
# |  c3.large  |  i386   |  x86_64 |  spot |  2 |  1 |  2  |  3840   |
# +------------+---------+---------+-------+----+----+-----+---------+

# |  t2.micro  |  i386   |  x86_64 |  spot |  1 |  1 |  1  |  1024   |
# |  c3.large  |  i386   |  x86_64 |  spot |  2 |  1 |  2  |  3840   |
# |  t2.medium |  i386   |  x86_64 |  spot |  2 |  2 |  1  |  4096   |
# |  t3.medium |  x86_64 |  None   |  spot |  2 |  1 |  2  |  4096   |
# |  t3a.medium|  x86_64 |  None   |  spot |  2 |  1 |  2  |  4096   |
# |  t4g.medium|  arm64  |  None   |  spot |  2 |  2 |  1  |  4096   |
# |  m4.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  m5.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  m5a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  m6a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  m7a.large |  x86_64 |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t2.large  |  x86_64 |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t3.large  |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t3a.large |  x86_64 |  None   |  spot |  2 |  1 |  2  |  8192   |
# |  t4g.large |  arm64  |  None   |  spot |  2 |  2 |  1  |  8192   |
# |  t2.xlarge |  x86_64 |  None   |  spot |  4 |  4 |  1  |  16384  |

