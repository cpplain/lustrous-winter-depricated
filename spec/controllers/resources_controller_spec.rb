require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe 'POST resources#create' do
    it 'should create a new resource in the database' do
      post :create, params: { resource: { name: 'Name', description: 'Description' } }
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value['name']).to eq('Name')
      expect(response_value['description']).to eq('Description')
      expect(Resource.last.name).to eq('Name')
    end
  end
end
