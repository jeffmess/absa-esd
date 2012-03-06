require 'spec_helper'

describe Absa::Esd::Statement4Unpacked do
  
  before(:each) do
    
  end
  
  it "should be able to read the recon transmission header record" do
    
  end
  
  it "should be able to read the recon transmission trailer record" do
    
  end
  
  it "should be able to read the recon account header record" do
    
  end
  
  it "should be able to read the recon account detail record" do
    
  end
  
  it "should be able to read the recon account trailer record" do
    
  end
  
  it "should be able to parse an entire 'statement 4 unpacked' file format" do
    input_string = File.open("./spec/examples/statement4_unpacked.dat", "rb").read
    
    puts input_string.inspect
    document = Absa::Esd::Transmission::Document.from_s(input_string)
    
    puts document.inspect
  end
  
end