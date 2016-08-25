module DatasetValidators
  def self.valid_float?(number_string)
    if number_string =~ /\A[+-]?((\d+_?)*\d+(\.((\d+_?)*\d+)?)?|\.(\d+_?)*\d+)([eE][+-]?(\d+_?)*\d+)?\z/
      return true
    end
    false
  end

  def self.valid_array?(array_string)
    return false if array_string[-1] == ','
    splitted = array_string.split(',')
    return false if splitted.size < 3
    splitted.each { |e| return false unless self.valid_float?(e) }
    true
  end

  def self.valid_for_correlation?(dataset1, dataset2)
    return false if dataset1.size != dataset2.size
    return false if !has_different_values?(dataset1) || !has_different_values?(dataset2)
    true
  end

  def self.has_different_values?(dataset)
    h = Set.new
    dataset.each do |e|
      h.add(e)
      return true if h.size >= 3
    end
    false
  end
end