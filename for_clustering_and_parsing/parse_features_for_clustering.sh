cd $1
echo $1
var=$1

char=${var: -1}
if [ "$char" = "/" ]; then
   input_site=${var::-1}

else 
   input_site=$var
fi

   

for site in * ; do
  sed -e 's/ /\n/g' $site > clustering_$site
  sed -i '/:/!d' clustering_$site 
  sed -i 's/^[^:]*://' clustering_$site
   
  
  if [[ "$site" == http* ]]; then
     j=0
     while [ $j -lt 15 ] ; do
    
        start=$((j*104+1))
        end=$((start+103))
    
        awk -v s=$start -v e=$end 'NR>=s&&NR<=e' clustering_$site > clust_${site}_${j}
    
        j=$((j+1))
     done 
 
  else 
     j=0
     while [ $j -lt 20 ] ; do
    
        start=$((j*104+1))
        end=$((start+103))
    
        awk -v s=$start -v e=$end 'NR>=s&&NR<=e' clustering_$site > clust_${site}_${j}
    
        j=$((j+1))
     done 

  fi
 
  echo clust_$site >> listPages_$input_site
  
  
  paste clust_${site}_*  >> AUX_${site}

   
  if [[ "$site" == *http* ]]; then
     awk '{for(i=1;i<=NF;i++) t+=$i; print t/15.0; t=0}' AUX_${site} > AVERAGE_${site}
  else 
     awk '{for(i=1;i<=NF;i++) t+=$i; print t/20.0; t=0}' AUX_${site} > AVERAGE_${site}
  fi

done 

rm AUX_*
rm clustering_*
mv listPages_$input_site ..

mkdir ../clustering_$input_site
mkdir ../average_$input_site
mv AVERAGE_* ../average_$input_site
mv clust_* ../clustering_$input_site








