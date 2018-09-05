foldNum=1

while [[ $foldNum -lt 2 ]]; do

 for d in fold${foldNum}/*; do
    echo $d
    site="$(echo $d | rev | cut -d'/' -f 1 | rev)"  
  
    cp -r $d/trainSet_${foldNum} ${site}_trainSet_${foldNum}

    ./parse_features_for_clustering.sh ${site}_trainSet_${foldNum}
    ./parse_four_features_for_clustering.sh ${site}_trainSet_${foldNum}
      
 #   ./dbscan.py clustering_${site}_trainSet_${foldNum}/ 
 #   ./dbscan.py clustering_four_${site}_trainSet_${foldNum}/
 #   ./dbscan_average.py average_${site}_trainSet_${foldNum}/
    ./dbscan_average.py average_four_${site}_trainSet_${foldNum}/
     
 done

# ./put_pages_in_clusters.sh all
# ./parse_all_SVMformat.sh all ${foldNum}   

# ./put_pages_in_clusters.sh four
# ./parse_all_SVMformat.sh four ${foldNum}

# ./put_pages_in_clusters_average.sh all
# ./parse_all_SVMformat_average.sh all ${foldNum}

 ./put_pages_in_clusters_average.sh four
 ./parse_all_SVMformat_average.sh four ${foldNum}
 
# mkdir ALL_INSTANCES_FOLD${foldNum}
# mkdir ALL_INSTANCES_FOUR_FEATURES_FOLD${foldNum}
# mkdir AVERAGE_INSTANCES_FOLD${foldNum}
 mkdir AVERAGE_INSTANCES_FOUR_FEATURES_FOLD${foldNum}  

# mv ALL_INSTANCES/* ALL_INSTANCES_FOLD${foldNum}
# mv ALL_INSTANCES_FOUR_FEATURES/* ALL_INSTANCES_FOUR_FEATURES_FOLD${foldNum}
# mv AVERAGE_INSTANCES/* AVERAGE_INSTANCES_FOLD${foldNum}
 mv AVERAGE_INSTANCES_FOUR_FEATURES/* AVERAGE_INSTANCES_FOUR_FEATURES_FOLD${foldNum}
 
 mv Final_results Final_results_FOLD${foldNum}
 mkdir Final_results 
    
 rm -r *trainSet_${foldNum}

 foldNum=$((foldNum + 1))
done
