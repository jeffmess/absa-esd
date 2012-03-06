module Absa
  module Esd

    module Statement4Unpacked
      
      class ReconTransmission < Transmission::Set
        class Header < Transmission::Record; end
        class Trailer < Transmission::Record; end
      end
      
      class ReconAccount < Transmission::Set
        class Header < Transmission::Record; end
        class Detail < Transmission::Record; end
        class Trailer < Transmission::Record; end
      end
  
    end
    
  end
end