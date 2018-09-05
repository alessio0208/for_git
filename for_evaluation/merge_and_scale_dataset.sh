to_be_evaluated=$1

#get range 
cat $to_be_evaluated/*1/*/*/* >> WSC_Eval_simple_TCP.merged
cat $to_be_evaluated/*1/mainPages_TCP >> WSC_Eval_simple_TCP.merged

./svm-scale -l -1 -u 1 -s WSC_Eval_simple_TCP.range WSC_Eval_simple_TCP.merged 


for d in $to_be_evaluated/*/*/*; do 
    ./svm-scale -l -1 -u 1 -r WSC_Eval_simple_TCP.range $d > ${d}_temp
    rm $d 
    mv ${d}_temp $d
done

#svm-scale -l -1 -u 1 -r WSC_Eval_simple_TCP.range ciao.txt > ciao_temp


    



