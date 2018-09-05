correct=0
while read line; do 
   echo $line
  
   predicted_label="$(echo $line | cut -d"," -f 1)"
   real_label="$(echo $line | cut -d"," -f 2)"

   if [[ $predicted_label == $real_label ]]; then
      correct=$((correct+1))
   fi
done < FINAL_RESULT

echo $correct
