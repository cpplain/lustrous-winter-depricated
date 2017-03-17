class AuthorsController < ApplicationController
  def index
    render_success(:ok, Author.order(last: :asc, first: :asc, middle: :asc))
  end
end
