require_relative 'person_information.rb'
# code challenge 04 class
class CodeChallenge04
  def initialize
    @prefix_hash = { 'Ms.' => 1, 'Mr.' => 2, 'Miss' => 3 }
  end

  def format_phone_number(phone_number)
    phone_number = remove_phone_number_format(phone_number)
    if is_numeric?(phone_number) && (phone_number.length == 10)
      format_areacode_and_number_into_hash(phone_number)
    elsif is_numeric?(phone_number) && (phone_number.length == 11)
      phone_number = phone_number.slice(1..phone_number.length)
      format_areacode_and_number_into_hash(phone_number)
    elsif /x/ =~ phone_number
      format_number_with_extension(phone_number)
    end
  end

  def remove_phone_number_format(phone_number)
    phone_number = phone_number.gsub('(', '')
    phone_number = phone_number.gsub(')', '')
    phone_number = phone_number.gsub('-', '')
    phone_number = phone_number.gsub('.', '')
    phone_number.gsub(' ', '')
  end

  def format_areacode_and_number_into_hash(phone_number)
    phone_number_hash = { phone_number: '', extension: '' }
    phone_number_hash[:phone_number] = set_phone_number_format(phone_number)
    phone_number_hash
  end

  def format_number_with_extension(phone_number)
    phone_number_hash = { phone_number: '', extension: '' }
    phone_number_hash[:phone_number] = remove_extension_number(phone_number)
    phone_number_hash[:extension] = extract_extension(phone_number)
    phone_number_hash
  end

  def remove_extension_number(phone_number)
    extension_index = phone_number.index('x')
    phone_number = phone_number.slice(0...extension_index)
    set_phone_number_format(phone_number)
  end

  def extract_extension(phone_number)
    extension_index = phone_number.index('x')
    extension_number = phone_number.slice(extension_index..phone_number.length)
    extension_number.sub('x', '')
  end

  def set_phone_number_format(phone_number)
    phone_number = phone_number.insert(0, '(')
    phone_number = phone_number.insert(4, ')')
    phone_number.insert(8, '-')
  end

  def is_numeric?(input)
    /^0|[1-9]\d*$/ =~ input
  end

  def is_string?(input)
    /^[A-z]+$/ =~ input
  end

  def  is_extension?(input)
    /^[x]|[1-9]\d*$ / =~ input
  end

  def format_string_input_to_csv(text_input)
    person_information = PersonInformation.new
    text_input_array = text_input.split(' ')
    convert_array_input_to_hash(text_input_array, person_information)
    person_information.formated_cvs_values
  end

  def convert_array_input_to_hash(text_input_array, person_information)
    text_input_array.each_with_index do |value, index|
      if person_information.is_prefix?(value)
        person_information.set_prefix(value)
      else
        next_val = text_input_array[index + 1]
        set_rest_of_person_fields(value, next_val, person_information)
      end
    end
    person_information.formated_cvs_values
  end

  def set_rest_of_person_fields(value, next_input, person_information)
    if person_information.get_first_name == ''
      person_information.set_first_name(value)
    elsif person_information.is_middle_name?(value, next_input)
      person_information.set_middle_name(value)
    elsif person_information.get_last_name == ''
      person_information.set_last_name(value)
    elsif person_information.is_suffix?(value)
      person_information.set_suffix(value)
    end
    set_phone_information(value,  person_information)
  end

  def set_phone_information(value,  person_information)
    if is_extension?(value)
      person_information.set_extension(value)
    elsif person_information.is_phone_number?(value)
      person_information.set_phone_number(value)
    end
  end

  def string_array_to_hash_array(input_array)
    output_hash = {}
    input_array.each_with_index do |value, index|
      output_array = format_string_input_to_csv(value)
      output_hash[index] = output_array
    end
    output_hash
  end
end
