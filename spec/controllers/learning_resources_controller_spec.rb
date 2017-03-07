require 'rails_helper'

RSpec.describe LearningResourcesController, type: :controller do
  describe 'GET learning_resources#index' do
    it 'should return all learning_resources in the database' do
      learning_resource1 = FactoryGirl.create(:learning_resource)
      learning_resource2 = FactoryGirl.create(:learning_resource)
      get :index
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(2)
      response_ids = []
      response_ids = response_value.collect do |learning_resource|
        learning_resource['id']
      end
      expect(response_ids).to eq([learning_resource1.id, learning_resource2.id])
    end
  end

  describe 'POST learning_resources#create' do
    it 'should create a new learning_resource in the database' do
      post :create, params: { learning_resource: { name: 'Name', description: 'Description' } }
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value['name']).to eq('Name')
      expect(response_value['description']).to eq('Description')
      expect(LearningResource.last.name).to eq('Name')
    end
  end

  describe 'PUT learning_resources#update' do
    it 'should update a learning_resource in the database' do
      learning_resource = FactoryGirl.create(:learning_resource)
      put :update, params: { id: learning_resource.id, learning_resource: { name: 'New Name' } }
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value['name']).to eq('New Name')
      learning_resource.reload
      expect(learning_resource.name).to eq('New Name')
    end
  end

  describe 'DELETE learning_resources#destroy' do
    it 'should delete a learning_resource from the database' do
      learning_resource = FactoryGirl.create(:learning_resource)
      delete :destroy, params: { id: learning_resource.id }
      expect(response).to have_http_status(:success)
      expect(LearningResource.find_by_id(learning_resource.id)).to eq(nil)
    end
  end
end
