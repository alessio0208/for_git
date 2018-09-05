# This script creates the input files for easy_WSC.py

type=$1
foldNum=$2

results_dir=""

if [[  "$type" == "four" ]]; then 
   results_dir="all_instances_four_features"
else 
   results_dir="all_instances"
fi

cluster_total_index=1

for a in Final_results/*; do
  
  
  aux="$(echo $a | rev | cut -d'/' -f 1 | rev)"  
     
  
 
  site=${aux%%_*}
     
  echo $site
  if [[ "$type" == "four" ]]; then
     mkdir ALL_INSTANCES_FOUR_FEATURES/$site
  else
     mkdir ALL_INSTANCES/$site
  fi

  for cluster in $a/$results_dir/cluster_*; do  
    i=1

     
    for d in fold${foldNum}/$site/trainSet_*/*; do

            file="$(echo $d| rev | cut -d'/' -f 1 | rev)"
           
           
            if [[ "$file" == http* ]]; then
              
   #           echo "break"
 #              echo $file 
               
              if grep -Fxq "$file " $cluster; then  
                  
  #                echo "break 2"
                  clusterNum="$(echo $cluster| rev | cut -d'/' -f 1 | rev)" 
                   
   
                  if [[ "$type" == "four" ]]; then
                     awk -v x=$i '$1=x ' $d >>  ALL_INSTANCES_FOUR_FEATURES/$site/wsc_${site}_${clusterNum}_TCP
                  else 
                     awk -v x=$i '$1=x ' $d >>  ALL_INSTANCES/$site/wsc_${site}_${clusterNum}_TCP
                  fi
                 
                  i=$((i+1)) 
              fi
            

            else 
         
               if grep -Fxq "$file " $cluster; then

                   if [[  "$type" == "four" ]]; then
                      awk -v x=$cluster_total_index '$1=x ' $d >>  ALL_INSTANCES_FOUR_FEATURES/mainPages_TCP
                   else 
                      awk -v x=$cluster_total_index '$1=x ' $d >>  ALL_INSTANCES/mainPages_TCP
                   fi 
               fi
            fi
    done

    echo "CLUSTER " + $cluster + " CLUSTER TOTAL INDEX " + $cluster_total_index             
    cluster_total_index=$((cluster_total_index+1))       
            
  done
done

