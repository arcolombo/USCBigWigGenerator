#!/bin/bash

#this script runs a bedGraphToBigWig iteratively in a virtual machine with sample names as a directory. 

#this script then runs through each sample name director, and finds the zipped  bedgraph file and converts into bigwig and then moves the output.bw into an output folder within the virtual machine.

#requirements - i) the chrom sizes needs to be mounted as a volume that the virtual machine can access
#ii) the bedgraph_to_bigwig function needs to also be mounted and publicly accessed 

#BSFS Notes - the files under /data/input are read only, need to copy into /data/scratch

#author - anthonycolombo60@gmail.com
sudo mkdir -p /data/output/appresults/$2/bigwig_output
#for i in /data/input/appresults/$1/samples/*;
#do
 #   for j in $i/replicates/*;
  #  do

   #      SUBDIR="/data/input/appresults/$1/samples/$i/replicates/$j";
    #    PARENT_DIR=$(basename $SUBDIR);

       files=();
       while IFS=  read -r -d $'\0'; do
                 files+=("$REPLY")
        done < <(find /data/input/appresults/$1 -name "*.bedGraph.gz" -print0)
       echo $files;
       echo ${#files[@]};
          for i in "${files[@]}"
           do
              echo $i;
              cp $i /data/scratch;
              file_name=$(basename $i);
              chmod 777 /data/scratch/$file_name;
              gzip -d "/data/scratch/$file_name";
              sampleName=`echo $file_name | cut -f1 -d '.'`;
               bgName=${file_name%.gz};
               /bin/bedGraphToBigWig /data/scratch/$bgName /home/chrom_sizes/hg19.chrom.sizes /data/scratch/$sampleName.bw;
               mv "/data/scratch/$sampleName.bw" /data/output/appresults/$2/bigwig_output;
             done

       #  chmod 777 /data/scratch/$PARENT_DIR.coverage.bedGraph.gz;
     #    gzip -d /data/scratch/$PARENT_DIR.coverage.bedGraph.gz;
      #  /bin/bedGraphToBigWig /data/scratch/$PARENT_DIR.coverage.bedGraph /home/chrom_sizes/hg19.chrom.sizes /data/scratch/$PARENT_DIR.bw;
       #  mv "/data/scratch/$PARENT_DIR.bw" /data/output/appresults/$2/bigwig_output;
        #done
# done




#do /bin/bedGraphToBigWig $i /home/chrom_sizes/hg19.chrom.sizes "$i.bw" && mv "$i.bw" /home/output_bigwig_directory; done
