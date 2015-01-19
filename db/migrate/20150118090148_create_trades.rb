class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :amount, null: false
      t.datetime :trade_at, null: false
      t.text :memo
      t.references :user, index: true, null: false
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :trades, :users
    add_foreign_key :trades, :categories
  end
end
