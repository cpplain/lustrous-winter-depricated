class AddPolymorphicReferenceToRatings < ActiveRecord::Migration[5.0]
  def change
    add_reference :ratings, :morphic_rating, polymorphic: true, index: true
  end
end
