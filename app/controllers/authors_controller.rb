class AuthorsController < ApplicationController
  def index
    render_success(:ok, Author.order(last: :asc, first: :asc, middle: :asc))
  end

  def create
    author = Author.create(author_params)
    return render_success(:created, author) if author.valid?
    render_error(:unprocessable_entity, author.errors)
  end

  def update
    current_author.update(author_params)
    return render_success(:ok, current_author) if current_author.valid?
    render_error(:unprocessable_entity, current_author.errors)
  end

  private

  def author_params
    params.require(:author).permit(:first, :middle, :last)
  end

  def current_author
    @current_author ||= Author.find_by_id(params[:id])
  end
end
