require 'statistics'

class MainController < ApplicationController
  # GET /
  def index
  end

  # POST /analyze
  def analyze
    dataset = params[:dataset].split(',').map { |e| e.to_i }
    render json: Statistics.analyze(dataset)
  end
end
