
type=$1

results_dir=""


if [[ "$type" == "four" ]]; then 
   results_dir="average_four_features"
else 
   results_dir="average"
fi


for a in Final_results/*/$results_dir; do
  i=1
  echo $a
  for d in $a/clusters_files/*; do
     touch $a/cluster_${i}
     
     while read line; do
         page=${line:8}
         #echo $page
         echo $page >> $a/cluster_${i}   
                 
     done < $d
     i=$((i + 1)) 
  done
done
