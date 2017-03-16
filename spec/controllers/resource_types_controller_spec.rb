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

  describe 'POST resource_types#create' do
    context 'without errors' do
      before do
        post :create, params: { resource_type: { resource_type: 'Book' } }
        @resource_type = ResourceType.last
        @json = JSON.parse(response.body)
      end

      it 'saves a new resource_type to the database' do
        expect(@resource_type.resource_type).to eq('Book')
      end

      it 'returns the created resource_type in the response body' do
        expect(@json['resource_type']).to eq('Book')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with errors' do
      before do
        post :create, params: { resource_type: { resource_type: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns errors in the response body' do
        expect(@json['errors']['resource_type']).to eq(["can't be blank"])
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH resource_types#update' do
    context 'without errors' do
      before do
        @resource_type = FactoryGirl.create(:resource_type)
        patch :update, params: { id: @resource_type.id, resource_type: { resource_type: 'Course' } }
        @resource_type.reload
        @json = JSON.parse(response.body)
      end

      it 'saves updates to the database' do
        expect(@resource_type.resource_type).to eq('Course')
      end

      it 'returns the updated resource_type in the response body' do
        expect(@json['resource_type']).to eq('Course')
      end

      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with errors' do
      before do
        resource_type = FactoryGirl.create(:resource_type)
        patch :update, params: { id: resource_type.id, resource_type: { resource_type: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns errors in the response body' do
        expect(@json['errors']['resource_type']).to eq(["can't be blank"])
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
