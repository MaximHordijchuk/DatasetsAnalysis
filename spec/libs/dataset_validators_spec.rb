require 'rails_helper'

RSpec.describe DatasetValidators, type: :lib do
  describe 'valid_float?' do
    it 'should return correct answer' do
      numbers = [['1', true],
                 ['1e-2', true],
                 ['1.43e-2', true],
                 ['+3', true],
                 ['-4', true],
                 ['-4.4', true],
                 ['-.4', true],
                 ['-0.4', true],
                 ['4.', true],
                 ['433.11.1', false],
                 ['-4 ', false],
                 ["-4\n", false],
                 [' -4', false],
                 [' -4 ', false]]
      numbers.size.times do |i|
        expect(DatasetValidators.valid_float?(numbers[i][0])).to eq numbers[i][1]
      end
    end
  end

  describe 'valid_array?' do
    it 'should return correct answer' do
      arrays = [[nil, false],
                 ['1', false],
                 ['1,2', false],
                 ['1,2,', false],
                 ['1 2 3', false],
                 ['', false],
                 ['1, 2, 3', false],
                 ['1,2,3,a', false],
                 [',1,2,3', false],
                 ['1,2,,3', false],
                 [' , , ', false],
                 ['1,2,3,4', true],
                 ['1,1,1', true],
                 ['1,0.,1.', true],
                 ['1,0.4e-1,1.', true],
                 ['1,0.4e+5,1', true],
                 ['1,2,3', true]]
      arrays.size.times do |i|
        expect(DatasetValidators.valid_array?(arrays[i][0])).to eq arrays[i][1]
      end
    end
  end

  describe 'valid_for_correlation?' do
    it 'should return correct answer' do
      arrays = [[[1,2,3], [1,2,3], true],
                [[1,1,1,1,2,3], [10,11,21,12,3,7], true],
                [[1,2,3], [1,2,3,4], false],
                [[1,2,3], [1,1,1], false],
                [[1,1,1], [1,2,3], false],
                [[1,2,3], [1,2,2], false],
                [[1,2], [1,2,2], false],
                [[1,2,2], [1,2], false],
                [[1,2,2,2,2,2], [1,2,2,2,2,2], false],
                [[], [1,2,2,2,2,2], false],
                [[1,2,2,2,2,2], [], false],
                [[], [], false],
                [[1,2,3,4], [1,2,3], false]]
      arrays.size.times do |i|
        expect(DatasetValidators.valid_for_correlation?(arrays[i][0], arrays[i][1])).to eq arrays[i][2]
      end
    end
  end

  describe 'has_different_values?' do
    it 'should return correct answer' do
      arrays = [[[1,2,3], true],
                [[1,1,1,1,2,3], true],
                [[-1,-2,5], true],
                [[1,1,1,1,1], false],
                [[1,1,1,1,1,2,2,2], false],
                [[1,1,1], false],
                [[1,2,2,1,2,1,2,1,1,1,2,2], false],
                [[], false],
                [[0,0,1,0,0,1,1,2], true],
                [[0,0,1,0,0,1,1,2], true],
                [[0.003,0.03,0.3], true]]
      arrays.size.times do |i|
        expect(DatasetValidators.has_different_values?(arrays[i][0])).to eq arrays[i][1]
      end
    end
  end
end