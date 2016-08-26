require 'rails_helper'

RSpec.describe Statistics, type: :lib do
  describe 'analyze' do
    it 'should contain max, min, average, median, q1, q3, outliers keys' do
      result = Statistics.analyze([1, 2, 3])
      keys = %w(average min max q1 median q3 outliers)
      keys.each { |key| expect(result).to have_key key.to_sym }
    end

    it 'should return correct max value' do
      datasets = []
      datasets << Array.new(200) { rand(-100..100) }
      datasets << Array.new(200) { rand(-1000..1000) / 100.0 }
      datasets << Array.new(200) { rand(-1000..1000) / 10.0 }
      datasets << Array.new(200) { rand(-100000..100000) / 10000.0 }
      datasets << Array.new(200) { rand(-1000..1000) / 100000.0 }
      datasets.each do |dataset|
        max = Statistics.analyze(dataset)[:max]
        expect(max).to eq dataset.max
      end
    end

    it 'should return correct min value' do
      datasets = []
      datasets << Array.new(200) { rand(-100..100) }
      datasets << Array.new(200) { rand(-1000..1000) / 100.0 }
      datasets << Array.new(200) { rand(-1000..1000) / 10.0 }
      datasets << Array.new(200) { rand(-100000..100000) / 10000.0 }
      datasets << Array.new(200) { rand(-1000..1000) / 100000.0 }
      datasets.each do |dataset|
        min = Statistics.analyze(dataset)[:min]
        expect(min).to eq dataset.min
      end
    end

    it 'should return correct average value' do
      datasets = [[1,2,3,4], [1,2,3,4,5], [1,1,1,1,1], [0,0,0,0,0], [-1,-1,-1], [-3,-2,-1],
                  [1,1,1,2,2,2,3,3,3], [0.5, 0.5, 0.5]]
      results = [2.5, 3, 1, 0, -1, -2, 2, 0.5]
      datasets.each_with_index do |dataset, i|
        avg = Statistics.analyze(dataset.shuffle)[:average]
        expect(avg).to eq results[i]
      end
    end

    it 'should return correct median value' do
      datasets = [[1,2,3,4], [1,2,3,4,5], [1,1,1,1,1], [0,0,0,0,0], [-1,-1,-1], [-3,-2,-1],
                  [1,1,1,2,2,2,3,3,3], [0.5, 0.5, 0.5], [1,2,5,7,10]]
      results = [2.5, 3, 1, 0, -1, -2, 2, 0.5, 5]
      datasets.each_with_index do |dataset, i|
        median = Statistics.analyze(dataset.shuffle)[:median]
        expect(median).to eq results[i]
      end
    end

    it 'should return correct first quartile value' do
      datasets = [[1,2,3,4], [1,2,3,4,5], [1,1,1,1,1], [0,0,0,0,0], [-1,-1,-1], [-3,-2,-1],
                  [1,1,1,2,2,2,3,3,3], [0.5, 0.5, 0.5], [1,2,5,7,10]]
      results = [1.5, 2, 1, 0, -1, -2.5, 1, 0.5, 2]
      datasets.each_with_index do |dataset, i|
        q1 = Statistics.analyze(dataset.shuffle)[:q1]
        expect(q1).to eq results[i]
      end
    end

    it 'should return correct third quartile value' do
      datasets = [[1,2,3,4], [1,2,3,4,5], [1,1,1,1,1], [0,0,0,0,0], [-1,-1,-1], [-3,-2,-1],
                  [1,1,1,2,2,2,3,3,3], [0.5, 0.5, 0.5], [1,2,5,7,10]]
      results = [3.5, 4, 1, 0, -1, -1.5, 3, 0.5, 7]
      datasets.each_with_index do |dataset, i|
        q3 = Statistics.analyze(dataset.shuffle)[:q3]
        expect(q3).to eq results[i]
      end
    end

    it 'should return correct outliers value' do
      datasets = [[1,2,3,4], [100,200,300], [1,2,3,4,5,6,7,8], [100,101,102], [1,1,1,1], [-2,-3,-4,-5,-6],
                  [0.5,0.7,0.9,1.4]]
      datasets.each do |dataset|
        outliers = Statistics.analyze(dataset.shuffle)[:outliers]
        expect(outliers).to be_empty
      end

      datasets = [[1,2,3,4,5,6,7,100,101], [-100,1,1,1,1,2,2,2,234,300], [1,2,3,4,5,6,1,1,1,1,10]]
      results = [[100,101], [-100,234,300], [10]]
      datasets.each_with_index do |dataset, i|
        outliers = Statistics.analyze(dataset.shuffle)[:outliers]
        expect(outliers).to match_array(results[i])
      end
    end
  end
end