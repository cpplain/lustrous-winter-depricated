require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe 'GET resources#index' do
    before do
      @resource1 = FactoryGirl.create(:resource)
      @resource2 = FactoryGirl.create(:resource)
      get :index
      json = JSON.parse(response.body)
      @resource_ids = json.collect { |resource| resource['id'] }
    end

    it 'returns all resources in the response body' do
      expect(@resource_ids).to eq([@resource1.id, @resource2.id])
    end

    it 'returns HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST resources#create' do
    context 'without errors' do
      before do
        subject = FactoryGirl.create(:subject)
        post :create, params: {
          resource: {
            name: 'Name', description: 'Description', subject_id: subject.id
          }
        }
        @json = JSON.parse(response.body)
      end

      it 'saves a new resource to the database' do
        expect(Resource.last.name).to eq('Name')
      end

      it 'returns the created resource in the response body' do
        expect(@json['description']).to eq('Description')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with errors' do
      before do
        post :create, params: { resource: { name: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns errors in the response body' do
        expect(@json['errors']['name']).to eq(["can't be blank"])
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET resources#show' do
    context 'without errrors' do
      before do
        @resource = FactoryGirl.create(:resource)
        get :show, params: { id: @resource.id }
        @json = JSON.parse(response.body)
      end

      it 'returns resources in the response body' do
        expect(@json['id']).to eq(@resource.id)
      end

      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with errors' do
      before do
        get :show, params: { id: 'no_id' }
      end

      it 'returns HTTP status not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH resources#update' do
    context 'without errors' do
      before do
        @resource = FactoryGirl.create(:resource)
        patch :update, params: { id: @resource.id, resource: { name: 'Updated' } }
        @resource.reload
        @json = JSON.parse(response.body)
      end

      it 'saves updates to the database' do
        expect(@resource.name).to eq('Updated')
      end

      it 'returns the updated resource in the response body' do
        expect(@json['name']).to eq('Updated')
      end

      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with errors' do
      before do
        resource = FactoryGirl.create(:resource)
        patch :update, params: { id: resource.id, resource: { name: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns errors in the response body' do
        expect(@json['errors']['name']).to eq(["can't be blank"])
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE resources#destroy' do
    context 'without errors' do
      before do
        @resource = FactoryGirl.create(:resource)
        delete :destroy, params: { id: @resource.id }
      end

      it 'deletes the resource from the databse' do
        expect(Resource.find_by_id(@resource.id)).to eq(nil)
      end

      it 'returns HTTP status no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with errors' do
      before do
        delete :destroy, params: { id: 'no_id' }
      end

      it 'returns HTTP status not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
