class Statistics
  def self.analyze(dataset)
    sorted = dataset.sort
    q1 = first_quartile(sorted)
    q3 = third_quartile(sorted)
    {
        average: average(dataset),
        min: dataset.min,
        max: dataset.max,
        q1: q1,
        median: median(sorted),
        q3: q3,
        outliers: outliers(sorted, q1, q3)
    }
  end

  def self.average(dataset)
    dataset.inject(:+).to_f / dataset.size
  end

  def self.median(sorted_dataset)
    len = sorted_dataset.size
    len % 2 == 1 ? sorted_dataset[len / 2] : (sorted_dataset[len / 2 - 1] + sorted_dataset[len / 2]) / 2.0
  end

  def self.first_quartile(sorted_dataset)
    len = sorted_dataset.size
    idx = len / 4
    case len % 4
      when 0
        first_quartile = (sorted_dataset[idx - 1] + sorted_dataset[idx]) / 2.0
      when 1, 2
        first_quartile = sorted_dataset[idx]
      when 3
        first_quartile = (sorted_dataset[idx] + sorted_dataset[idx + 1]) / 2.0
      else
        first_quartile = 0
    end
    first_quartile
  end

  def self.third_quartile(sorted_dataset)
    len = sorted_dataset.size
    idx = len / 2 + len / 4
    case len % 4
      when 0
        third_quartile = (sorted_dataset[idx - 1] + sorted_dataset[idx]) / 2.0
      when 1, 2
        third_quartile = sorted_dataset[idx]
      when 3
        third_quartile = (sorted_dataset[idx] + sorted_dataset[idx + 1]) / 2.0
      else
        third_quartile = 0
    end
    third_quartile
  end

  # q1 - first quartile
  # q3 - third quartile
  # Return an array of outliers
  def self.outliers(dataset, q1, q3, k = 1.5)
    difference = q3 - q1
    lower_val = q1 - k * difference
    upper_val = q3 + k * difference
    dataset.select { |elem| elem < lower_val || elem > upper_val }
  end
end