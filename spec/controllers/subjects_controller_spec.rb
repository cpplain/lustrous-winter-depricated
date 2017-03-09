require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'GET subjects#index' do
    before do
      @subject1 = FactoryGirl.create(:subject)
      @subject2 = FactoryGirl.create(:subject)
      get :index
      json = JSON.parse(response.body)
      @subject_ids = json.collect { |subject| subject['id'] }
    end

    it 'returns all subjects in the response body' do
      expect(@subject_ids).to eq([@subject1.id, @subject2.id])
    end

    it 'returns HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST subjects#create' do
    context 'without errors' do
      before do
        post :create, params: { subject: { name: 'Parent' } }
        @parent = Subject.first
        post :create, params: { subject: { name: 'Child', parent_id: @parent.id } }
        @child = Subject.last
        @json = JSON.parse(response.body)
      end

      it 'saves a new parent subject to the database' do
        expect(@parent.name).to eq('Parent')
      end

      it 'saves a new child subject to the database' do
        expect(@child.parent).to eq(@parent)
      end

      it 'returns the created subject in the response body' do
        expect(@json['name']).to eq('Child')
      end

      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with errors' do
      before do
        post :create, params: { subject: { name: '' } }
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

  describe 'PATCH resources#update' do
    context 'without errors 1' do
      before do
        @parent = FactoryGirl.create(:subject)
        @child = FactoryGirl.create(:subject, parent_id: @parent.id)
        patch :update, params: { id: @child.id, subject: { name: 'Child' } }
        @child.reload
        @json = JSON.parse(response.body)
      end

      it 'saves updates to the database' do
        expect(@child.name).to eq('Child')
      end

      it 'saves updates while keeping parent/child association' do
        expect(@child.parent).to eq(@parent)
      end

      it 'returns the updated subject in the response body' do
        expect(@json['name']).to eq('Child')
      end

      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without errors 2' do
      before do
        parent1 = FactoryGirl.create(:subject)
        @parent2 = FactoryGirl.create(:subject)
        @child = FactoryGirl.create(:subject, parent_id: parent1.id)
        patch :update, params: { id: @child.id, subject: { parent_id: @parent2.id } }
        @child.reload
      end

      it 'saves new :parent_id, changing parent association' do
        expect(@child.parent).to eq(@parent2)
      end
    end

    context 'without errors 3' do
      before do
        parent = FactoryGirl.create(:subject)
        @child = FactoryGirl.create(:subject, parent_id: parent.id)
        patch :update, params: { id: @child.id, subject: { name: 'Parent', parent_id: nil } }
        @child.reload
      end

      it 'saves nil to :parent_id, promoting child to parent' do
        expect(@child.parent).to eq(nil)
      end
    end

    context 'with errors' do
      before do
        subject = FactoryGirl.create(:subject)
        patch :update, params: { id: subject.id, subject: { name: '' } }
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

  describe 'DELETE subjects#destroy' do
    context 'without errors' do
      before do
        @subject = FactoryGirl.create(:subject)
        delete :destroy, params: { id: @subject.id }
      end

      it 'deletes the subject from the databse' do
        expect(Subject.find_by_id(@subject.id)).to eq(nil)
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
