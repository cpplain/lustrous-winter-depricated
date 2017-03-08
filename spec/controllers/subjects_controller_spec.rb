require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'POST subjects#create' do
    context 'without validation errors' do
      before do
        post :create, params: { subject: { name: 'Parent' } }
        parent = Subject.last
        post :create, params: { subject: { name: 'Child', parent: parent['id'] } }
      end

      it 'returns HTTP status success' do
        expect(response).to have_http_status(:success)
      end

      it 'saves a new parent subject in the database' do
        parent = Subject.first
        expect(parent.name).to eq('Parent')
      end

      it 'saves a new child subject in the database' do
        parent = Subject.first
        child = Subject.last
        expect(child.parent).to eq(parent)
      end

      it 'returns the created subject in the response body' do
        json = JSON.parse(response.body)
        expect(json['name']).to eq('Child')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with validation errors' do
      before do
        post :create, params: { subject: { name: '' } }
      end

      it 'returns JSON error' do
        json = JSON.parse(response.body)
        expect(json).to include('errors')
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
