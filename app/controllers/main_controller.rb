require 'statistics'

class MainController < ApplicationController
  # GET /
  def index
  end

  # POST /analyze
  def analyze
    dataset = parse_array(params[:dataset])
    render json: Statistics.analyze(dataset)
  end

  # POST /correlation
  def correlation
    dataset1 = parse_array(params[:dataset1])
    dataset2 = parse_array(params[:dataset2])
    render json: { result: Statistics.correlation(dataset1, dataset2) }
  end

  private

  def parse_array(array)
    array.split(',').map { |e| e.to_i }
  end
end
