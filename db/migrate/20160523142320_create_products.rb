class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :permalink
      t.integer :on_hand, default: 0
      t.boolean :available, default: true
      t.decimal :price
      t.string :description
      t.string :image

      t.timestamps null: false
    end
  end
end
