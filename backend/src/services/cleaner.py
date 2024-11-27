from abc import ABCMeta, abstractmethod
import pandas as pd
import re


class BaseCleanStrategy:

    __metaclass__ = ABCMeta

    @abstractmethod
    def validate_set(self, data_set):
        pass

class SourceCleanerStrategy(BaseCleanStrategy):

    def validate_set(self, data_set):
        data_set.columns = data_set.columns.str.replace('"', '')
        data_set = data_set.dropna(subset = ["source_cd"])
        return data_set

class DropDuplicatesStrategy(BaseCleanStrategy):

    def validate_set(self, data_set):
        data_set = data_set.drop_duplicates(keep = False)
        return data_set

class EmailCleanerStrategy(BaseCleanStrategy):
    
      def validate_set(self, data_set):
            print(data_set.columns)
            data_set.columns = data_set.columns.str.replace('"', '')
            print(data_set.columns.to_list)
            
            regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
            valid_emails = data_set[data_set['contact_email'].apply(lambda x: bool(re.match(regex, str(x))))]
            return valid_emails