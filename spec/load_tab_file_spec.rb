require_relative '../lib/load_tab_file.rb'
require_relative 'spec_helper.rb'
# Test Load File into an Array
describe LoadTabFile do
  it 'loads tab separated values from a text file into an array' do
    file_name = 'raw_customers_test.txt'
    LoadTabFile.new(file_name).read_file_into_array.nil? == false
  end
end
