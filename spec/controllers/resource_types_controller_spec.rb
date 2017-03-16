require 'rails_helper'

RSpec.describe ResourceTypesController, type: :controller do
  describe 'GET resource_types#index' do
    before do
      @resource_type1 = FactoryGirl.create(:resource_type)
      @resource_type2 = FactoryGirl.create(:resource_type)
      get :index
      json = JSON.parse(response.body)
      @resource_type_ids = json.collect { |resource_type| resource_type['id'] }
    end

    it 'returns all resource_types in the response body' do
      expect(@resource_type_ids).to eq([@resource_type1.id, @resource_type2.id])
    end

    it 'returns HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end
