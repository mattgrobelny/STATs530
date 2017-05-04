# Stats 530 - HW5
Mateusz Grobelny

## Problem 1
Using the linear model to fit the Y random variable may result in output value
outside binary range of  0 and 1.

A better model for a binary data set would be logistic regression  

## Problem 2  
Low quality bases indicate uncertainty in the base call, which means that a range
of low quality bases is unlikely to represent a true/real sequence present in an
organism. If low quality bases are not removed then during assembly of the reads
will not assemble correctly, potentially resulting in increased number of assembled genes
in RNAseq as low quality reads will be treated as unique sequences during assembly.

## Problem 3a  
```
$ cat hw_rna-seq.fastq | fastx_barcode_splitter.pl --bcfile barcodes_orginal.txt --prefix ./out/HW5_rna_demulti_ --bol --mismatches 1
```  

What is the smallest and largest number of reads that you see belonging to any subject after demultiplexing?   
largest  = 1  
smallest = 0  

How many reads are unmatched to a subject?  
995  

## Problem 3b  
Problem:  
`grep "\\barcode\\" hw_rna-seq.fastq`   
Shows that there is an 'N' preceding each barcode for each read     

Solution: Trim first base from each read  

```
fastx_trimmer -f 2 -i hw_rna-seq.fastq -o hw_rna-seq_1st_base_trime.fastq

cat hw_rna-seq_1st_base_trime.fastq | fastx_barcode_splitter.pl --bcfile barcodes_orginal.txt --prefix ./out/HW5_rna_demulti_ --bol --mismatches 1
```   

What is the smallest and largest number of reads that you see belonging to any subject after demultiplexing?    
largest  = 58  
smallest = 3  

How many reads are unmatched to a subject?  
16  

## Problem 4
First 10 bases of the first reads of each output file:  
File1 : NCAGTTACT  
File2 : TTGATTTGT  
