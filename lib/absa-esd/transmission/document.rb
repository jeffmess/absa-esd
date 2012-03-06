module Absa
  module Esd
    module Transmission
    
      class Document < Set
      
        def self.from_s(string)
          options = self.hash_from_s(string)
          self.build(options[:data])
        end
      
        def from_file!(filename)
          self.from_s(File.open(filename, "rb").read)
        end
  
      end

    end
  end
end
