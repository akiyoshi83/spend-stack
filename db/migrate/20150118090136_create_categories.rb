class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :color, null: false, default: '#ffffff', length: 7
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :users
    add_index :categories, [:user_id, :name]
  end
end
