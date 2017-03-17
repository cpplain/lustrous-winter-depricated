require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe 'GET authors#index' do
    before do
      @author1 = FactoryGirl.create(:author)
      @author2 = FactoryGirl.create(:author)
      get :index
      json = JSON.parse(response.body)
      @author_ids = json.collect { |author| author['id'] }
    end

    it 'returns all authors in the response body' do
      expect(@author_ids).to eq([@author1.id, @author2.id])
    end

    it 'returns HTTP status ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end
