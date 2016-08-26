module DatasetValidators
  # Check if string that contains float number is valid.
  # E.g., '2', '4.2', '0.1', '5.', '.7', '3e+4', '1e4', '4.12e-3'
  def self.valid_float?(number_string)
    if number_string =~ /\A[+-]?((\d+_?)*\d+(\.((\d+_?)*\d+)?)?|\.(\d+_?)*\d+)([eE][+-]?(\d+_?)*\d+)?\z/
      return true
    end
    false
  end

  # Check if string that contains float numbers array is valid.
  # Array must have 3 or more valid float numbers and mustn't
  # have comma at the end.
  # E.g., '1,2,3', '1,2.4,5.,3,.6'
  def self.valid_array?(array_string)
    return false if array_string[-1] == ','
    splitted = array_string.split(',')
    return false if splitted.size < 3
    splitted.each { |e| return false unless self.valid_float?(e) }
    true
  end

  # Check if strings that contain float numbers' arrays are valid.
  # Every dataset must have 3 or more different values and
  # datasets must have equal sizes.
  def self.valid_for_correlation?(dataset1, dataset2)
    return false if dataset1.size != dataset2.size
    return false if !has_different_values?(dataset1) || !has_different_values?(dataset2)
    true
  end

  # Check if dataset have 3 or more different values
  def self.has_different_values?(dataset)
    h = Set.new
    dataset.each do |e|
      h.add(e)
      return true if h.size >= 3
    end
    false
  end
end