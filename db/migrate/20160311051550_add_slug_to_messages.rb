class AddSlugToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :slug, :string
    add_index :messages, :slug, unique: true
  end
end
