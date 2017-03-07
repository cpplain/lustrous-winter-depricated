require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe 'GET resources#index' do
    it 'should return all resources in the database' do
      resource1 = FactoryGirl.create(:resource)
      resource2 = FactoryGirl.create(:resource)
      get :index
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(2)
      response_ids = []
      response_ids = response_value.collect do |resource|
        resource['id']
      end
      expect(response_ids).to eq([resource1.id, resource2.id])
    end
  end

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

  describe 'PUT resources#update' do
    it 'should update a resource in the database' do
      resource = FactoryGirl.create(:resource)
      put :update, params: { id: resource.id, resource: { name: 'New Name' } }
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value['name']).to eq('New Name')
      resource.reload
      expect(resource.name).to eq('New Name')
    end
  end

  describe 'DELETE resources#destroy' do
    it 'should delete a resource from the database' do
      resource = FactoryGirl.create(:resource)
      delete :destroy, params: { id: resource.id }
      expect(response).to have_http_status(:success)
      expect(Resource.find_by_id(resource.id)).to eq(nil)
    end
  end
end
