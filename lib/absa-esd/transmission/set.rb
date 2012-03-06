module Absa
  module Esd
    module Transmission
    
      class Set
    
        attr_accessor :records
    
        def initialize
          self.records = []
        end
    
        def self.build(data)
          set = self.new
      
          data.each do |hash|
            if hash[:data].is_a? Array
              klass = "Absa::Esd::Statement4Unpacked::#{hash[:type].capitalize.camelize}".constantize
              set.records << klass.build(hash[:data])
            else
              klass = "Absa::Esd::Statement4Unpacked::#{self.partial_class_name}::#{hash[:type].capitalize.camelize}".constantize
              set.records << klass.new(hash[:data])
            end
          end
      
          set.validate!
          set
        end
    
        def header
          records[0]
        end
    
        def trailer
          records[-1]
        end
    
        def transactions
          records[1..-2]
        end
    
        def validate!
      
        end
    
        def to_s
          string = ""
          records.each {|record| string += record.to_s }
          string
        end
    
        def self.for_record(record) # move this logic to yml file
          record_id = record[0]
      
          case record_id
          when '0','9'
            return Absa::Esd::Statement4Unpacked::ReconTransmission
          when '1','2','8'
            return Absa::Esd::Statement4Unpacked::ReconAccount
          end
        end
    
        def self.trailer_id(klass)
          case klass.name
          when 'Absa::Esd::Statement4Unpacked::ReconTransmission'
            return '9'
          when 'Absa::Esd::Statement4Unpacked::ReconAccount'
            return '8'
          end
        end  
    
        def self.is_trailer_record?(set, record)
          record_id = record[0]
          self.trailer_id(set) == record_id
        end
    
        def self.process_record(record)
          record_info = {}
      
          self.record_types.each do |record_type|
            klass = "#{self.name}::#{record_type.camelize}".constantize

            if klass.matches_definition?(record)
              options = klass.string_to_hash(record)
              record_info = {type: record_type, data: options}
              break
            end
          end
      
          record_info
        end
    
        def self.hash_from_s(string)
          set_info = {type: self.partial_class_name.underscore, data: []}
          lines = string.split(/^/)
            
          # look for rec_ids, split into chunks, and pass each related class a piece of string
      
          buffer = []
          current_set = nil
          subset = nil
      
          lines.each do |line|
            next if line.length < 10 # TODO: flaky - tighten it up
            if Set.for_record(line) == self
              if subset && (buffer.length > 0)
                set_info[:data] << subset.hash_from_s(buffer.join)
                buffer = []
                subset = nil
              end
          
              record = line
              set_info[:data] << self.process_record(record)
            else
              subset = Set.for_record(line) unless subset        
              buffer << line
          
              if self.is_trailer_record?(subset, line)
                set_info[:data] << subset.hash_from_s(buffer.join)
                buffer = []
                subset = nil
              end
            end
          end
      
          set_info
        end
    
        def self.record_types
          self.layout_rules.map {|k,v| k}
        end
    
        def self.module_name
          self.name.split("::")[0..-1].join("::")
        end
    
        def self.partial_class_name
          self.name.split("::")[-1]
        end
    
        def self.layout_rules
          file_name = "#{Absa::Esd::CONFIG_DIR}/#{self.name.split("::")[-2].underscore}/#{self.partial_class_name.underscore}.yml"
      
          YAML.load(File.open(file_name))
        end
    
        def self.record_type(record_type)
          "#{self.name}::#{record_type.camelize}".constantize
        end
   
      end
   
    end
  end
end