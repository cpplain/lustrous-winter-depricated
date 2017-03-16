require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET organizations#index' do
    before do
      @organization1 = FactoryGirl.create(:organization)
      @organization2 = FactoryGirl.create(:organization)
      get :index
      json = JSON.parse(response.body)
      @organization_ids = json.collect { |organization| organization['id'] }
    end

    it 'returns all organizations in the response body' do
      expect(@organization_ids).to eq([@organization1.id, @organization2.id])
    end

    it 'returns HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST organizations#create' do
    context 'without errors' do
      before do
        post :create, params: { organization: { name: 'Org' } }
        @organization = Organization.last
        @json = JSON.parse(response.body)
      end

      it 'saves a new organization to the database' do
        expect(@organization.name).to eq('Org')
      end

      it 'returns the created organization in the response body' do
        expect(@json['name']).to eq('Org')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with errors' do
      before do
        post :create, params: { organization: { name: '' } }
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

  describe 'PATCH organizations#update' do
    context 'without errors' do
      before do
        @organization = FactoryGirl.create(:organization)
        patch :update, params: { id: @organization.id, organization: { name: 'Org' } }
        @organization.reload
        @json = JSON.parse(response.body)
      end

      it 'saves updates to the database' do
        expect(@organization.name).to eq('Org')
      end

      it 'returns the updated organization in the response body' do
        expect(@json['name']).to eq('Org')
      end

      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with errors' do
      before do
        organization = FactoryGirl.create(:organization)
        patch :update, params: { id: organization.id, organization: { name: '' } }
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
end
