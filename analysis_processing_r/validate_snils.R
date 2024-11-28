# Function to validate an 11-digit SNILS number
validate_snils <- function(snils) {
  # Check if input is numeric and 11 digits long
  if (!grepl("^[0-9]{11}$", snils)) {
    return(F)
  }
  
  # Extract the main number and control digits
  main_number <- substr(snils, 1, 9)
  control_digits <- as.numeric(substr(snils, 10, 11))
  
  # Convert the main number to a numeric vector
  digits <- as.numeric(unlist(strsplit(main_number, "")))
  
  # Check if the number is greater than 001001998
  if (as.numeric(main_number) <= 001001998) {
    #checking with control number is impossible
    #we should believe?
    return(T)
  }
  
  # Calculate the weighted sum
  positions <- 9:1
  weighted_sum <- sum(digits * positions)
  
  # Compute the control number
  calculated_control <- weighted_sum %% 101
  if (calculated_control == 100) {
    calculated_control <- 0
  }
  
  # Compare the calculated control number with the provided one
  if (calculated_control == control_digits) {
    return(T)
  } else {
    return(F)
  }
}

# Example usage
snils_number <- "11223344595"
snils_number <- 11223344595
validate_snils(snils_number)
validate_snils_by_number_of_characters <- function(snils) {
  # Check if input is numeric and 11 digits long
  if (!grepl("^[0-9]{11}$", snils)) {
    return(F)
  }else{
return(T)
  }
}