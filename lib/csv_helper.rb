require 'csv'
# Csv Helper file
class CsvHelper
  attr_reader :file_relative_path_and_name
  def initialize(file_name)
    file_relative_path = File.dirname(__FILE__)
    @file_relative_path_and_name = "#{file_relative_path}/#{file_name}"
  end

  def is_file_exist?
    File.exist?(@file_relative_path_and_name)
  end

  def add_hash_to_csv_file(output_hash)
    output_hash.each_with_index do |(key, value), index|
      if index == 0
        create_content(value)
      else
        append_content(value)
      end
    end
  end

  def add_text_to_csv_file(line_output_data_array)
    if is_file_exist?
      append_content(line_output_data_array)
    else
      create_content(line_output_data_array)
    end
  end

  def create_content(line_output_data_array)
    # wb will create the file
    CSV.open(@file_relative_path_and_name, 'wb') do |csv|
      csv << line_output_data_array
      return true
    end
    false
  end

  def append_content(line_output_data_array)
    # ab will append to the file
    CSV.open(@file_relative_path_and_name, 'ab') do |csv|
      csv << line_output_data_array
      return true
    end
    false
  end
end
