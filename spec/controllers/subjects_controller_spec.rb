require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'POST subjects#create' do
    context 'without validation errors' do
      before do
        post :create, params: { subject: { name: 'Parent' } }
        @parent = Subject.last
        post :create, params: { subject: { name: 'Child', parent: @parent['id'] } }
        @child = Subject.last
        @json = JSON.parse(response.body)
      end

      it 'saves a new parent subject in the database' do
        expect(@parent.name).to eq('Parent')
      end

      it 'saves a new child subject in the database' do
        expect(@child.parent).to eq(@parent)
      end

      it 'returns the created subject in the response body' do
        expect(@json['name']).to eq('Child')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with validation errors' do
      before do
        post :create, params: { subject: { name: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns JSON with errors' do
        expect(@json).to include('errors')
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT resources#update' do
    context 'without validation errors' do
      before do
        parent = FactoryGirl.create(:subject)
        @child = FactoryGirl.create(:subject, parent: parent)
        put :update, params: { id: @child.id, subject: { name: 'Parent', parent: nil } }
        @child.reload
        @json = JSON.parse(response.body)
      end

      it 'saves nil to parent column (child to parent promotion)' do
        expect(@child.parent).to eq(nil)
      end

      it 'returns the updated subject in the response body' do
        expect(@json['name']).to eq('Parent')
      end

      it 'returns HTTP status OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with validation errors' do
      before do
        subject = FactoryGirl.create(:subject)
        put :update, params: { id: subject.id, subject: { name: '' } }
        @json = JSON.parse(response.body)
      end

      it 'returns JSON with errors' do
        expect(@json).to include('errors')
      end

      it 'returns HTTP status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
