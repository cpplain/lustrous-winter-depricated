class AuthorsController < ApplicationController
  def index
    render_success(:ok, Author.order(last: :asc, first: :asc, middle: :asc))
  end

  def create
    author = Author.create(author_params)
    return render_success(:created, author) if author.valid?
    render_error(:unprocessable_entity, author.errors)
  end

  private

  def author_params
    params.require(:author).permit(:first, :middle, :last)
  end
end
