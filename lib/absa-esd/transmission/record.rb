module Absa
  module Esd
    module Transmission
    
      class Record
        include Strata::RecordWriter
        extend Strata::RecordWriter::ClassMethods
    
        set_record_length 550
        set_delimiter "\r\n"
        #set_allowed_characters ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a.map(&:to_s) + ['.','/','-','&','*',',','(',')','<','+','$',';','>','=',"'",' '] # move to config file

        def initialize(options = {})
          set_layout_variables(options)
          validate! options
        end
      
        def self.class_layout_rules
          file_name = "#{Absa::Esd::CONFIG_DIR}/#{self.name.split("::")[-3].underscore}/#{self.name.split("::")[-2].underscore}.yml"
          record_type = self.name.split("::")[-1].underscore
      
          YAML.load(File.open(file_name))[record_type]
        end
      
      end

    end    
  end
end