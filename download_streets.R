
if(!is.element("devtools", installed.packages()[,1])) {install.packages("devtools")} 
library(devtools)
install_github("jiristipl/strviewr")
library(strviewr)

#change this string to your Google API key
key="key"


d=read.csv2("streets.csv", stringsAsFactors = F)

i=2

while (i < length(d$link_A)) {
  
  print(paste0("Downloading ",i,". street."))
  
  if(d[i,3] !="" & d[i,4] !="") {
  c1= coors(d[i,3])
  c2= coors(d[i,4])
  print(c1)
  print(c2)
  download_track(start = c1,
                 end = c2,
                 track_code = i,
                 key = key)
  }
  else{
    print(paste0("Row ",i," is empty."))
  }
  
  i=i+1
}


 coors <- function(link){
 pattern ="[0-9]{2}.[0-9]*!4d[0-9]{2}.[0-9]*"
  m=gregexpr(pattern, link)
  coors=gsub("!4d",",",regmatches(link, m))
  coors=  strsplit(coors,",")
  return (as.numeric(unlist(coors)))
  
}
