class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :source, polymorphic: true, index: true
      t.references :order
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
