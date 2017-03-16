class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :first
      t.string :middle
      t.string :last

      t.timestamps
    end
  end
end
