#Big Wig Generator files
 this git hub repo has the docker files for the BaseSpace app USC BigWig Generator.  The scripts in this directory process bam files into conversion to bigWig files.      
#Species Supported
 The chrom.sizes files are generated by UCSC fetchChromSizes.sh script on the input bedGraph or bam files.  supporting only human, mouse, and drosophila.
# Docker file
 the docker file is built from arcolombo/bedgraph:v45, this docker file is not available, but the docker file located in this directory build atop the begraph:v45 to allow bam conversion.
