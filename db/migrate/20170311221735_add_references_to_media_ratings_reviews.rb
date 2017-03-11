class AddReferencesToMediaRatingsReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :media, :resource, index: true

    add_reference :ratings, :medium, index: true
    add_reference :ratings, :review, index: true

    add_reference :reviews, :resource, index: true
  end
end
