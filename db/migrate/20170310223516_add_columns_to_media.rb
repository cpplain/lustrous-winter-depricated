class AddColumnsToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :medium_type, :string
    add_column :media, :provider, :string
    add_column :media, :isbn, :string
    add_column :media, :url, :string
    add_column :media, :city, :string
    add_column :media, :state, :string
    add_column :media, :country, :string
    add_column :media, :free, :boolean
  end
end
