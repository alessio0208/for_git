# This script creates a file for each cluster containing all the pages grouped in that cluster.

type=$1

results_dir=""

if [[  "$type" == "four"  ]]; then 
   results_dir="all_instances_four_features"
else 
   results_dir="all_instances"
fi

for a in Final_results/*/$results_dir; do
  i=1
  for d in $a/clusters_files/*; do
     touch $a/cluster_${i}
     
     while read line; do
         aux=${line:6}
         page="$(echo ${aux%_*})"  
          
 #       echo "PAGE "$page
         if grep -q "$page " $a/cluster_${i}; then
                echo ""
         else
                echo "$page " >> $a/cluster_${i}   
         fi         
     done < $d
     i=$((i + 1)) 
  done
done
