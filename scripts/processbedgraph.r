library(jsonlite)

message("printing /data/input/ directory")
print(list.files("/data/input/"))
fileJSON<-fromJSON("/data/input/AppSession.json")
selectNames<-fileJSON$Properties$Items$Name
project_Id<-fileJSON$Properties$Items$Content[[which(selectNames=="Input.project-id")]][1]$Id
message("project_Id is for output")
print(project_Id)

#FIX ME: use which commands from selectNames object to programmatively identify the IDs from JSON.

#FIX ME:  identify file type  .bedGraph  or .bam

#FIX ME:  identify species type,  use corresponding chrom sizes.
speciesInput<-fileJSON$Properties$Items$Items[which(selectNames=="Input.species-radio")]
  if(speciesInput==1) {
     #select Mouse chrom sizes

    }

  if(speciesInput==2){
    #select Human chrom sizes

    }


   if(speciesInput==3){
    #select rat chrom sizes

    }



message("appresults ID from JSON:")
#the file structure is /data/input/appresults/appresults-ID
appresults_ID<-fileJSON$Properties$Items$Items[[3]]$Id
print(appresults_ID)

message("file names loaded from File Chooser: ")
fileNames<-fileJSON$Properties$Items$Items[[6]]$Name
print(fileNames)
message("checking file names; must contain 'bedGraph'")
for (i in 1:length(fileNames)){
fileName<-fileNames[i]
if (grepl("bedGraph",fileName)=="FALSE"){
   print("Must only have bedGraph files input, terminate R")
    q(save="no", runLast=TRUE)
} #if

}#for
message("the appresults Id :")
print(appresults_ID)
message("running the bedgraph conversion")
for(i in 1:length(appresults_ID)){

  appresult_Id <- appresults_ID[i] 
  command<- paste("./bin/conversion.sh",appresult_Id, project_Id, sep=" ")
 system(command)

}  #for
message("contents of /data/scratch directory:")
print(list.files("/data/scratch/"))
