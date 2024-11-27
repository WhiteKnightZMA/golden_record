function_r <- function(path_file){
library(openxlsx)
library(tidyverse)
source("G:/repo/universal/my_functions.R") 
source("G:/repo/golden_record/analysis_processing_r/validate_snils.R") 
source("G:/repo/golden_record/analysis_processing_r/validate_inn.R") 

# path_file <- "G:/WD/t1_hack/ds_dirty_fin_20241004/ds_dirty_fin_202410041147.csv"
input_data <- read.csv(path_file)
#delete full duplicates
input_data <- u(input_data)

input_data$inn_validation <- NA

input_data$inn_validation[!is.na(input_data$client_inn)] <- sapply(input_data$client_inn[!is.na(input_data$client_inn)], FUN=validate_inn)
table(input_data$inn_validation)

#count n of characters in inn
input_data$inn_nchar <- NA
# 12-digits INN
t1 <- Sys.time()
input_data$inn_nchar[!is.na(input_data$client_inn)] <- sapply(input_data$client_inn[!is.na(input_data$client_inn)], FUN = nchar)
t2 <- Sys.time()
t2-t1

table(input_data$inn_nchar)

nrow(input_data1)
#987673
#checkings
# different create dates for client_id

###manual processing

#есть ли разные id с разными датами создания?
df_id_create <- u(input_data[, c("client_id", "create_date")])
nrow(df_id_create)
# 985865
lu(input_data[,c("client_id")])
#985864

summary(input_data$client_id)
sum(is.na(input_data$client_id))
sort(u(input_data$client_id))[1:100]
###
which(duplicated(df_id_create$client_id))
df_id_create$client_id[which(duplicated(df_id_create$client_id))
]
View(input_data[which(input_data$source_cd == ""), ])
### delete id with different dates
input_data <- input_data[ -which(input_data$source_cd == ""), ]

#есть ли разные id с разными sources? - 
df_id_create <- u(input_data[, c("client_id", "source_cd")])
nrow(df_id_create)
# 985671
lu(input_data[,c("client_id")])
#985864
#ответ нет
#есть ли разные id с разными  inn?
df_id_create <- u(input_data[, c("client_id", "create_date")])
nrow(df_id_create)
# 985865
lu(input_data[,c("client_id")])
#985864

summary(input_data$client_id)
sum(is.na(input_data$client_id))
sort(u(input_data$client_id))[1:100]
###
which(duplicated(df_id_create$client_id))
df_id_create$client_id[which(duplicated(df_id_create$client_id))
]
View(input_data[which(input_data$source_cd == ""), ])




delete_double_spaces <- function(x){
 x <-  gsub("  "," ",x)
 return(x)
}


input_data$client_fio_full <- gsub("  "," ",input_data$client_fio_full)

#view suspicious subset by Побег из Шоушенка
# View(input_data[ which(input_data$source_cd != "" & input_data$stream_favorite_show=="Побег из Шоушенка"), ])

# different sources for client_id




#check bdata
# check year

#24 year
nn_bd_high <- which(as.numeric(gsub("-.*", "", input_data$client_bday))>2024)
# input_data$client_bday[nn_bd_high[1:100]]

nn_bd_low <- which(as.numeric(gsub("-.*", "", input_data$client_bday))<1900)
# input_data$client_bday[nn_bd_low[1:100]]
#potential action - replace with 2 rules (first 09 -> 19;  first 00  & second>24 -> first 19)

##TODO Marianna check month and day

#check create and update dates 

#TODO Nikita
###

### INN, SNILS
class(input_data$client_snils)
summary(input_data$client_snils)
sort(input_data$client_snils)[1:100]

#TODO delete INN

#TODO SNILS Marianna

class(input_data$client_inn)
summary(input_data$client_inn)
sort(input_data$client_inn)[1:100]


###

lu(input_data$client_id)
# 985864
input_data$client_fio_full[which(input_data$client_fio_full=="")] <- NA
input_data$client_fio_full <- gsub("  "," ",input_data$client_fio_full)

input_data$client_fio_full[which(input_data$client_fio_full==" ")] <- NA
sum(is.na(input_data$client_fio_full))

sort(input_data$client_fio_full[1:1000])


#client subset

# 1)get golden record for fio
input_data$client_bday[100000:1001000]

sum(as.numeric(gsub("-.*", "", input_data$client_bday))>2024, na.rm = T)

u(input_data$client_resident_cd[1:100000])
u(input_data$client_gender[1:10000000])
u(input_data$client_marital_cd[1:10000000])# по дате
u(input_data$client_graduate[1:10000000])# по дате
u(input_data$client_child_cnt[1:10000000])# по дате
u(input_data$client_mil_cd)# по дате
u(input_data$client_zagran_cd)# по дате
u(input_data$client_vip_cd)# пр-ло решения конфликта : если заполнены числа, берем последний по дате, если есть число и ответ да, то берем число, если есть число и ответ нет - ?
u(input_data$client_vip_cd)

##проверка числовых признаков - 
# 10 укладываются в интервал (время - не позднее текущей даты, тип числе - и т.д., натуральные числа = натуральные,   )
#subset contact
u(input_data$contact_vc)
lu(input_data$contact_vc)
# 50912
for(i in grep("contact", colnames(input_data))){
  print("#######################")
  print(colnames(input_data)[i])
print(u(input_data[,i])[1:100])
print(lu(input_data[,i]))
}
#subset address - start idea: all adresses or last?

for(i in grep("addr_", colnames(input_data))){
  print("#######################")
  print(colnames(input_data)[i])
  print(u(input_data[,i])[1:100])
  print(lu(input_data[,i]))
}

#subset address - start idea: all adresses or last?

for(i in grep("fin_loan", colnames(input_data))){#по актуальности #нужны ли погашенные/просроченные долги?
  print("#######################")
  print(colnames(input_data)[i])
  print(u(input_data[,i])[1:100])
  print(lu(input_data[,i]))
}




###

# table(input_data$source_cd)

# View(input_data[ which(input_data$source_cd == ""), ])


# View(input_data[ which(input_data$source_cd != "" & input_data$stream_favorite_show=="Побег из Шоушенка"), ])
path2 <- gsub(".csv", "after_r.csv", path_file)
write.csv(input_data, path2, row.names = F)
# colnames(input_data)           
return(path2)
}


