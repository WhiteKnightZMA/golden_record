rownames_to_col<-function(x,column_name="rownames"){
  x<-cbind.data.frame(rownames(x),x)
  colnames(x)[1] <- column_name
  return(x)
}
col_to_rownames <- function(x,col_number=1){
  rownames(x) <- x[,col_number]
  x <- x[,-col_number]
  return(x)
}

combineFiles_M<-function (input,file_names=F,extension="csv"){
  library(tidyverse)
  # setwd(input)
  if(file_names==F){
  files <- list.files(input,pattern = paste0("*.",extension),full.names = T)
  }else{
    files <- input
  }
  if(extension=="csv"){
    separator <- ","
  }
  if(extension=="tsv"|extension=="txt"){
    separator <- "\t"
  }
  df <- files %>% map_dfc(read.table,row.names=1,sep=separator,header=T)
  return(df)
}

opendir <- function(dir = getwd()){
  if (.Platform['OS.type'] == "windows"){
    shell.exec(dir)
  } else {
    system(paste(Sys.getenv("R_BROWSER"), dir))
  }
}

qh <- function(x, n = 2, m = 2) {
  print(x[1:n, 1:m])
}

su <- function(x){
  sort(unique(x))
}
lu <- function(x){
  length(unique(x))
}
u <- function(x){
  unique(x)
}

`%notin%` <- Negate(`%in%`)

z_score <- function(x){
  z <- (x-mean(x, na.rm = T))/sd(x, na.rm = T)
  return(z)
}