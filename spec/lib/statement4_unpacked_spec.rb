require 'spec_helper'

describe Absa::Esd::Statement4Unpacked do
  
  before(:each) do
    @input_string = File.open("./spec/examples/statement4_unpacked.dat", "rb").read
  end
  
  it "should be able to read the recon transmission header record" do
    hash = Absa::Esd::Statement4Unpacked::ReconTransmission::Header.string_to_hash(@input_string.split(/^/)[0])
    
    hash.should == {
      rec_type: "0", 
      filler_1: "0000000000000000000", 
      status: "P", 
      date: "20021119", 
      client_code: "3174", 
      client_name: "TEST", 
      destination_code: "3174", 
      filler_2: "", 
      gen_no: "295", 
      filler_3: ""
    }
  end
  
  it "should be able to read the recon transmission trailer record" do
    hash = Absa::Esd::Statement4Unpacked::ReconTransmission::Trailer.string_to_hash(@input_string.split(/^/)[-2])
    
    hash.should == {
      rec_type: "9",
      account_number: "9999999999999999999",
      status: "P",
      date: "20021119",
      filler_1: "",
      rec_count: "50",
      filler_2: "",
      generation_number: "295",
      filler_3: ""
    }
  end
  
  it "should be able to read the recon account header record" do
    hash = Absa::Esd::Statement4Unpacked::ReconAccount::Header.string_to_hash(@input_string.split(/^/)[1])
    
    hash.should == {
      rec_type: "1",
      account_number: "4011111809", 
      statement_number: "264", 
      filler_1: "00001", 
      processing_date: "20021118", 
      account_branch_code: "0", 
      filler_2: "", 
      filler_3: "+000000000000000", 
      hd_op_bals: "+", 
      hd_op_bal: "0", 
      filler_4: "", 
      function_code: "AA0A", 
      filler_5: "", 
      generation_number: "000000295", 
      filler_6: ""
    }
  end
  
  it "should be able to read the recon account detail record" do
    hash = Absa::Esd::Statement4Unpacked::ReconAccount::Detail.string_to_hash(@input_string.split(/^/)[3])
    
    hash.should == {
      rec_type: "2", 
      account_number: "4011111809", 
      statement_number: "264", 
      page_number: "1", 
      transaction_processing_date: "20021118", 
      transaction_effective_date: "20021118", 
      cheque_number: "0", 
      transaction_reference_number: "56571", 
      transaction_amount_sign: "+", 
      transaction_amount: "649363", 
      account_balance_sign: "+", 
      account_balance_after_transaction: "3280033", 
      transaction_description: "CREDIT TRANSFER      CASHFOCUS", 
      dep_id: "440151586", 
      transaction_code: "CF71", 
      cheques_function_code: "CFAC", 
      charge_levied_amount_sign: "+", 
      charge_levied_amount: "0", 
      charge_type: "", 
      stamp_duty_amount_sign: "+", 
      stamp_duty_levied_amount: "0", 
      cash_deposit_fee_sign: "+", 
      cash_deposit_fee: "0", 
      charges_accrued: "", 
      event_number: "12537", 
      statement_line_sequence_number: "6", 
      vat_amount: "0", 
      cash_portion: "0", 
      deposit_number: "0", 
      transaction_time: "0", 
      filler_1: "", 
      filler_2: "", 
      sitename: "", 
      category: "0510", 
      transaction_type: "", 
      deposit_id_description: "", 
      pod_adjustment_amount: "000000000000000", 
      pod_adjustment_reason: "", 
      pod_returned_cheque_reason_code: "0", 
      pod_returned_cheque_drawee: "", 
      fedi_payor: "", 
      fedi_number: "0", 
      redirect_description: "", 
      account_number_redirect: "0", 
      unpaid_cheque_reason_description: "", 
      filler_3: "", 
      generation_number: "000000295", 
      old_reconfocus_category1: "51", 
      old_reconfocus_category2: "58", 
      filler_4: ""
    }
  end
  
  it "should be able to read the recon account trailer record" do
    hash = Absa::Esd::Statement4Unpacked::ReconAccount::Trailer.string_to_hash(@input_string.split(/^/)[-3])
    
    hash.should == {
      rec_type: "8", 
      account_number: "9999999999999999999", 
      filler_1: "", 
      hash_amount_sign: "+", 
      hash_amount: "0", 
      filler_2: "", 
      rec_count: "48", 
      filler_3: "", 
      generation_number: "000000295", 
      filler_4: ""
    }
  end
  
  it "should be able to parse an entire 'statement 4 unpacked' file format" do
    pending
  end
  
end
