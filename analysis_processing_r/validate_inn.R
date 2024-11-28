# Function to validate INN (10 or 12 digits)
validate_inn <- function(inn) {
  
  inn <- as.character(inn)
  # Check if input is numeric and either 10 or 12 digits long
  if (!grepl("^[0-9]{10,12}$", inn)) {
    return("Invalid input. INN must be 10 or 12 digits.")
  }
  
  # Convert the INN to a numeric vector
  digits <- as.numeric(unlist(strsplit(inn, "")))
  
  # Coefficients for 12-digit INN (n1 and n2)
  coef_n1_12 <- c(7, 2, 4, 10, 3, 5, 9, 4, 6, 8)
  coef_n2_12 <- c(3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8)
  
  # Coefficients for 10-digit INN (n1)
  coef_n1_10 <- c(2, 4, 10, 3, 5, 9, 4, 6, 8)
  
  if (nchar(inn) == 12) {
    # Calculate n1 for 12-digit INN
    n1_sum <- sum(digits[1:10] * coef_n1_12)
    n1 <- n1_sum %% 11
    if (n1 == 10) n1 <- 0
    
    # Calculate n2 for 12-digit INN
    n2_sum <- sum(digits[1:11] * coef_n2_12)
    n2 <- n2_sum %% 11
    if (n2 == 10) n2 <- 0
    
    # Validate both control digits
    if (n1 == digits[11] && n2 == digits[12]) {
      return("Valid 12-digit INN.")
    } else {
      return("Invalid 12-digit INN.")
    }
  } else if (nchar(inn) == 10) {
    # Calculate n1 for 10-digit INN
    n1_sum <- sum(digits[1:9] * coef_n1_10)
    n1 <- n1_sum %% 11
    if (n1 == 10) n1 <- 0
    
    # Validate control digit
    if (n1 == digits[10]) {
      return("Valid 10-digit INN.")
    } else {
      return("Invalid 10-digit INN.")
    }
  } else {
    return("Invalid input. INN must be either 10 or 12 digits.")
  }
}

# Example usage
inn_12 <- "500100732259" # Valid 12-digit INN
inn_10 <- "7830002293"   # Valid 10-digit INN
inn_10 <- 7830002293   # Valid 10-digit INN
invalid_inn <- "1234567890" # Invalid INN
w_inn <- 500100732259 # Wiki INN
real_inn <- 771610335194 # Wiki INN

validate_inn(inn_12)  # Expected: "Valid 12-digit INN."
validate_inn(inn_10)  # Expected: "Valid 10-digit INN."
validate_inn(invalid_inn) # Expected: "Invalid 10-digit INN."
validate_inn(w_inn) # Expected: "Valid 12-digit INN."
validate_inn(real_inn) # Expected: "Valid 12-digit INN."
validate_inn_by_number_of_characters <- function(inn) {
  inn <- as.character(inn)
  # Check if input is numeric and either 10 or 12 digits long
  if (!grepl("^[0-9]{10,12}$", inn)) {
    return("Invalid input. INN must be 10 or 12 digits.")
  } else {
    return("Valid 12-digit INN.")
  }
}
  