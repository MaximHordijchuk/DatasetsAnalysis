require 'statistics'
require 'dataset_validators'

class MainController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  # GET /
  def index
  end

  # POST /analyze
  def analyze
    dataset_string = params[:dataset]
    if DatasetValidators.valid_array?(dataset_string)
      dataset = parse_array(dataset_string)
      render json: Statistics.analyze(dataset)
    else
      render json: { error: 'Array is not valid' }, status: 422
    end
  end

  # POST /correlation
  def correlation
    dataset1_string = params[:dataset1]
    dataset2_string = params[:dataset2]
    if DatasetValidators.valid_array?(dataset1_string) &&
        DatasetValidators.valid_array?(dataset2_string)
      dataset1 = parse_array(dataset1_string)
      dataset2 = parse_array(dataset2_string)
      if DatasetValidators.valid_for_correlation?(dataset1, dataset2)
        render json: { result: Statistics.correlation(dataset1, dataset2) }
      else
        render json: { error: 'Arrays are not valid' }, status: 422
      end
    else
      render json: { error: 'Arrays are not valid' }, status: 422
    end

  end

  private

  def parse_array(array)
    array.split(',').map { |e| e.to_f }
  end
end
