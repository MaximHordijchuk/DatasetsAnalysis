require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #analyze' do
    login_user

    it 'returns http success status' do
      post :analyze, dataset: '1,2,3,4,5,6,7,8'
      expect(response).to have_http_status(:success)
    end

    it 'responds to JSON' do
      post :analyze, dataset: '1,2,3,4,5,6,7,8'
      expect(response.content_type).to eq 'application/json'

      post :analyze
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns http unprocessable entity status' do
      datasets = [nil, '1', '1,2', '1,2,', '1 2 3', '', '1, 2, 3', '1,2,3,a', ',1,2,3', '1,2,,3', ' , , ']
      datasets.each do |dataset|
        post :analyze, dataset: dataset
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'result should contain max, min, average, median, q1, q3, outliers keys' do
      post :analyze, dataset: '1,2,3'
      result = JSON.parse(response.body)
      keys = %w(average min max q1 median q3 outliers)
      keys.each { |key| expect(result).to have_key key }
    end

    it 'returns correct dataset results' do
      datasets = %w(1,2,3 1,2,3,4,5 1.2,1e-3,3e+4,100,250,10 0,0,0 1,1,1)
      10.times { datasets << Array.new(5) { rand(-10000..10000) }.join(',') }
      10.times { datasets << Array.new(5) { rand(-10000..10000) / 10000.0 }.join(',') }
      10.times { datasets << Array.new(5) { rand(-1..1) / 1000000.0 }.join(',') }
      10.times { datasets << Array.new(5) { rand(-1..1) / 100000000000.0 }.join(',') }
      datasets.each do |dataset|
        post :analyze, dataset: dataset
        expect(response).to have_http_status(:success)
        dataset = dataset.split(',').map { |e| e.to_f }
        expected_result = Statistics.analyze(dataset).to_json
        expect(response.body).to eq expected_result
      end
    end

    it 'redirects to index page if user is not sign in' do
      sign_out @user
      post :analyze, dataset: '1,2,3,4,5,6,7,8'
      expect(response).to redirect_to('/')
    end
  end

  describe 'POST #correlation' do
    login_user

    it 'returns http success status' do
      post :correlation, dataset1: '1,2,3', dataset2: '4,5,6'
      expect(response).to have_http_status(:success)
    end

    it 'responds to JSON' do
      post :correlation, dataset1: '1,2,3', dataset2: '4,5,6'
      expect(response.content_type).to eq 'application/json'

      post :analyze
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns http unprocessable entity status: check invalid arrays' do
      datasets = [nil, [], '1', '1,2', '1,2,', '1 2 3', '', '1, 2, 3', '1,2,3,a', ',1,2,3', '1,2,,3', ' , , ']
      datasets.each do |dataset|
        if dataset.nil?
          another_dataset = nil
        else
          another_dataset = [1,2,3,4,5,6,7,8,9][0...dataset.size].join(',')
        end

        post :correlation, dataset1: dataset, dataset2: another_dataset
        expect(response).to have_http_status(:unprocessable_entity)

        post :correlation, dataset1: another_dataset, dataset2: dataset
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'returns http unprocessable entity status: check invalid combinations' do
      datasets1 = %w(1,2,3 1,2,3,4 1,2 1,2,3 1,1,1 1,2,3 1,1,2 1,1,1 1,1,1,1,1,2,2,2 1,2,3)
      datasets2 = %w(1,2,3,4 1,2,3 1,2,3 1,2 1,2,3 1,1,1 1,2,3 1,1,1 1,2,3 1,1,1,1,1,2,2,2)
      datasets1.size.times do |i|
        post :correlation, dataset1: datasets1[i], dataset2: datasets2[i]
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'result should contain result key' do
      post :correlation, dataset1: '1,2,3', dataset2: '1,2,3'
      result = JSON.parse(response.body)
      expect(result).to have_key 'result'
    end

    it 'returns correct correlation result' do
      datasets = %w(1,2,3,4,5 1.2,1e-3,3e+4,100,250 0,0,0,1,2 1,1,1,2,3)
      10.times { datasets << Array.new(5) { rand(-10000..10000) }.join(',') }
      10.times { datasets << Array.new(5) { rand(-10000..10000) / 10000.0 }.join(',') }
      10.times { datasets << Array.new(5) { rand(-1..1) / 1000000.0 }.join(',') }
      10.times { datasets << Array.new(5) { rand(-1..1) / 100000000000.0 }.join(',') }
      datasets = datasets.select do |elem|
        DatasetValidators.has_different_values?(elem.split(',').map { |e| e.to_f })
      end
      1000.times do
        dataset1 = datasets.sample
        dataset2 = datasets.sample

        post :correlation, dataset1: dataset1, dataset2: dataset2
        expect(response).to have_http_status(:success)

        dataset1 = dataset1.split(',').map { |e| e.to_f }
        dataset2 = dataset2.split(',').map { |e| e.to_f }

        expected_result = { result: Statistics.correlation(dataset1, dataset2) }.to_json
        expect(response.body).to eq expected_result
      end
    end

    it 'redirects to index page if user is not sign in' do
      sign_out @user
      post :correlation, dataset1: '1,2,3', dataset2: '1,2,3'
      expect(response).to redirect_to('/')
    end
  end
end
