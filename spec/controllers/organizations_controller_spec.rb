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
end
