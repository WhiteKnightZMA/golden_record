import pandas as pd 

from .cleaner import EmailCleanerStrategy, DropDuplicatesStrategy, SourceCleanerStrategy

def process_file(file_data, output_file: str) -> int:
      df = pd.read_csv(file_data)

      email_validation = EmailCleanerStrategy()
      email_df = email_validation.validate_set(df)

      source_validation = SourceCleanerStrategy()
      source_df = source_validation.validate_set(email_df)

      full_validation = DropDuplicatesStrategy()
      full_df = full_validation.validate_set(source_df)

      full_df.to_csv(output_file, index=False)

      return len(full_df)
