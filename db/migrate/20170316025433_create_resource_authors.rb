class CreateResourceAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_authors do |t|
      t.references :resource, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
