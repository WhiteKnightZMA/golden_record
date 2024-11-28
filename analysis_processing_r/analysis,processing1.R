# Получение аргументов из командной строки
args <- commandArgs(trailingOnly = TRUE)

# Проверка аргументов
if (length(args) < 2) {
  stop("Please provide at least two arguments!")
}

# Вывод аргументов
cat("First argument:", args[1], "\n")
cat("Second argument:", args[2], "\n")


path_file <- args[1]
path_to_r_scripts <- args[2]

# function_r <- function(path_file){
#main PC
# path_to_r_scripts <- "analysis_processing_r/"
# path_file <- "G:/WD/t1_hack/ds_dirty_fin_20241004/ds_dirty_fin_202410041147.csv"
#
path_to_r_scripts <- "C:/Users/S/Documents/repo/golden_record/analysis_processing_r"
path_file <- "C:/Users/S/Documents/WD/t1/ds_dirty_fin_20241004/ds_dirty_fin_202410041147.csv"
library(openxlsx)
library(openxlsx)
library(tidyverse)
library(stringi)

  setwd(path_to_r_scripts)
source("my_functions.R") 
source("validate_snils.R") 
source("validate_inn.R") 

input_data <- read.csv(path_file)
#delete full duplicates
input_data <- u(input_data)

# delete incorrect symbols from fio

for(i in c("client_first_name","client_middle_name", "client_last_name","client_fio_full")){
  input_data[,i] <- gsub("[^A-Za-zА-Яа-яЁё\ \\-]", "", input_data[,i])
  input_data[,i] <- gsub("-", " ", input_data[,i])
}

lu(input_data$client_bday)


# processing of text: delete multiple spaces and replace with NA "" or " "
delete_multiple_spaces <- function(x){
  # Replace multiple spaces with a single space
  x <- gsub("\\s+", " ", x)
  return(x)
}




process_text_column <- function(x){
  x <- delete_multiple_spaces(x)
  x <- tolower(x)
  x[which(x %in% c(""," "))] <- NA
  return(x)
}

for(i in 1:ncol(input_data)){
  if(class(input_data[, i])=="character"){
    input_data[, i] <- process_text_column(input_data[, i]) 
  }
}

### delete id with empty source
input_data <- input_data[!is.na(input_data$source_cd), ]
###delete empty fio and f i o
nn <- which(rowSums(is.na(input_data[,c("client_first_name","client_middle_name", "client_last_name","client_fio_full")]))==4)
input_data <- input_data[-nn,]

# replace empty fio with separatnames if it is not 0
sum(is.na(input_data[,c("client_fio_full")]))
#0

###translit
tranliteration <- function(x){
  x <- ifelse(
    stri_detect_regex(x, "[A-Za-z]"), # Проверяем, есть ли латинские буквы
    stri_trans_general(x, "Latin-Cyrillic"), # Преобразуем
    x # Оставляем текст без изменений
  )
  return(x)
}
##
for(i in c("client_first_name","client_middle_name", "client_last_name","client_fio_full", "client_bplace")){
  input_data[,i] <- tranliteration(input_data[,i])
}
####
clean_email<- function(x) {
  # Проверяем наличие символа @
  if (grepl("@", x)) {
    # Удаляем все символы, кроме букв, цифр, @, -, и _
    return(gsub("[^A-Za-z0-9@\\-_]", "", x))
  } else {
    return(NA)
  }
}
input_data$contact_email <- sapply(FUN=clean_email,input_data$contact_email)

###sort fio

# Функция для сортировки слов в строке
sort_words_in_string <- function(input_string) {
  # Разбиваем строку на слова
  words <- unlist(strsplit(input_string, "\\s+"))
  
  # Сортируем слова
  sorted_words <- sort(words)
  
  # Объединяем слова обратно в строку
  sorted_string <- paste(sorted_words, collapse = " ")
  
  return(sorted_string)
}

input_data$sorted_fio <- sapply(FUN=sort_words_in_string,input_data$client_fio_full)

#validate inn
input_data$inn_validation <- NA
u(input_data$inn_validation)
input_data$inn_validation[!is.na(input_data$client_inn)] <-
  sapply(input_data$client_inn[!is.na(input_data$client_inn)], FUN = validate_inn_by_number_of_characters)

#clear inn
input_data$client_inn[input_data$inn_validation!="Valid 12-digit INN"] <- NA

# table(input_data$inn_validation)

#validate snils
input_data$snils_validation <- NA
input_data$snils_validation[!is.na(input_data$client_snils)] <-
  sapply(input_data$client_snils[!is.na(input_data$client_snils)], FUN = validate_snils_by_number_of_characters)
# clear snils
input_data$client_snils[input_data$snils_validation==F] <- NA


# table(input_data$snils_validation)


##validate dates
validate_date <- function(x, posix=F){
  if(posix==T){
  x <- as.POSIXct(x, format = "%Y-%m-%d %H:%M:%S", tz = "Etc/GMT+3")
  }else{
    x <- as.Date(x)
      }
  y <- 
    ifelse(
      x > "1900-01-01" &
        x < "2024-11-26",
      F,
      T
    )
  x[y] <- NA
  return(x)
}

input_data$client_bday <- validate_date(input_data$client_bday)
input_data$create_date <- validate_date(input_data$create_date, posix = T)
input_data$update_date <- validate_date(input_data$update_date, posix = T)
input_data$fin_loan_begin_dt <- validate_date(input_data$fin_loan_begin_dt)
input_data$fin_loan_end_dt <- validate_date(input_data$fin_loan_end_dt)

# write.csv(input_data,"input_data_clear_1546.csv", row.names = F)
# input_data <- read.csv("input_data_clear_1546.csv")

# ##check if snils may have different inn
# 
# df_snils_inn <- input_data %>% select(contains(c("inn","snils")))  %>% filter(inn_validation=="Valid 12-digit INN" | snils_validation)
#   
# df_snils_inn$client_inn[which(df_snils_inn$inn_validation!="Valid 12-digit INN")]=NA
# df_snils_inn$client_snils[which(df_snils_inn$snils_validation!=T)]=NA
# 
# df_snils_inn_short <- df_snils_inn %>% select(!contains(c("valid"))) %>% unique() %>% na.omit%>% group_by(client_inn) %>% mutate(n_inn=n()) %>% ungroup() %>% group_by(client_snils) %>% mutate(n_snils=n()) %>% ungroup() %>% filter(n_snils>1|n_inn>1)
#   
# snils_treshold <- df_snils_inn_short %>%  filter(n_snils==2) %>% group_by(client_snils) %>% summarise(n_mistypes=adist(client_inn))
# 
# 
# df_snils_inn <- df_snils_inn %>% select(!contains(c("valid"))) %>% unique() %>% group_by(client_inn) %>% mutate(n_inn=n()) %>% ungroup() %>% group_by(client_snils) %>% mutate(n_snils=n()) %>% ungroup() %>% filter(!(is.na(client_inn) & n_snils>1)) %>% filter(!(is.na(client_snils) & n_inn>1)) %>% arrange(client_inn)
#  
# 
# 
# # Import fuzzywuzzy in R
# fuzzywuzzy <- reticulate::import("fuzzywuzzy")

#create cor df
main_cols <- c( "client_snils", "client_inn", "client_bplace", "client_bday", "sorted_fio")


#"client_fio_full",
main_df <- input_data[, main_cols] %>% u() 
# lu(main_df$sorted_fio)
# lu(main_df$client_bday)

main_df$fus <- paste(main_df$client_snils, main_df$client_inn, main_df$client_bplace, main_df$client_bday, main_df$sorted_fio, sep="_")

input_data$fus <- paste(input_data$client_snils, input_data$client_inn, input_data$client_bplace, input_data$client_bday, input_data$sorted_fio, sep="_")


bdata_unique <- u(main_df$client_bday)
h=0
sim_pairs_total <- "5"[-1]
t1 <- Sys.time()
for(i in bdata_unique){
  # i=bdata_unique[1]
  h=h+1
  nn_pers <- which(main_df$client_bday==i)
  fio <- adist(main_df[nn_pers,"sorted_fio"])
fio[is.na(fio)] <- 100
    inn <- adist(main_df[nn_pers,"client_inn"])
    inn[is.na(inn)] <- 100
    
  snils <- adist(main_df[nn_pers,"client_snils"])
  snils[is.na(snils)] <- 100
  
  bs <- adist(main_df[nn_pers,"client_bplace"])
  bs[is.na(bs)] <- 100
  
  bin_matr <- fio<10 & (snils<4 | inn<4| bs<10)   
similar_pairs <- which(bin_matr == T, arr.ind = TRUE)
similar_pairs <- similar_pairs[similar_pairs[,1]>similar_pairs[,2],,drop=F]
similar_pairs[,1] <- nn_pers[similar_pairs[,1]]
similar_pairs[,2] <- nn_pers[similar_pairs[,2]]

sim_pairs_total <- rbind.data.frame(sim_pairs_total, similar_pairs)

}

t2 <- Sys.time()
t2-t1


#### mark in full df
# step1 :create graph
library(igraph)

g <- graph_from_data_frame(sim_pairs_total, directed = FALSE)

# Step 2: Find connected components (groups of records referring to the same person)
connected_components <- components(g)

# Step 3: Assign a unique "person ID" to each connected component
person_ids <- connected_components$membership





# Step 4: Create a dataset of single records, where each record is marked with its "person ID"
single_persons <- data.frame(
  name = V(g)$name,
  person_id = person_ids
)
lu(single_persons$person_id)



main_df$person_ids <- NA
main_df$person_ids[as.numeric(single_persons$name)] <- single_persons$person_id
n_single <- sum(is.na(main_df$person_ids))
n_multiple <- max(main_df$person_ids, na.rm = T)
main_df$person_ids[is.na(main_df$person_ids)] <- c((n_multiple+1):(n_multiple+n_single))



input_data$person_ids <- main_df$person_ids[match(input_data$fus, main_df$fus)]

columns_to_last <- c("update_date", "create_date", "stream_duration", "stream_favorite_show", "contact_vc" ,  "contact_tg"   ,
      "contact_other",  "contact_email"  ,
      "contact_phone",  "addr_region"   ,
      "addr_country",   "addr_zip"   ,
      "addr_street",   "addr_house"   ,
      "addr_body",   "addr_flat"   ,
      "addr_area",   "addr_loc"   ,
      "addr_city",   "addr_reg_dt"   ,
      "addr_str",    "fin_rating"   ,
      "fin_loan_limit",  "fin_loan_value"  ,
      "fin_loan_debt",  "fin_loan_percent" ,
      "fin_loan_begin_dt", "fin_loan_end_dt",
      "client_vip_cd",
      "client_cityzen"  ,
      "client_resident_cd" ,"client_gender"  ,
      "client_marital_cd", "client_graduate" , 
      "client_child_cnt" , "client_mil_cd" , 
      "client_zagran_cd"
      )
columns_to_all <- c( "client_id" ,   "client_first_name" , 
       "client_middle_name" , "client_last_name" ,
       "client_fio_full" ,   
       "client_bplace" ,   "client_inn"   ,
       "client_snils" ,
 "source_cd" )

columns_to_unique <- c(  "client_bday") 
       
library(dplyr)
library(purrr)

gold_records <- input_data %>% filter(!is.na(person_ids)) %>% group_by(person_ids) %>% arrange(person_ids, desc(update_date)) %>%  # Сортировка по person_id и дате
  summarise(across(all_of(columns_to_last), 
                   ~ first(.x[!is.na(.x)])),
                   
            across(all_of(columns_to_all), 
                   ~ paste0(u(.x[!is.na(.x)]),collapse = ";")),
                   across(all_of(columns_to_unique), 
                          ~ u(.x[!is.na(.x)]))
            
                   ) %>% select(client_id, everything())
  

path2 <- gsub(".csv", "after_r.csv", path_file)
write.csv(gold_records, path2, row.names = F)



