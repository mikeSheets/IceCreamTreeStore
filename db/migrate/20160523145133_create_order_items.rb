class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :source_type
      t.string :source_id
      t.string :order_id
      t.interger :quantity

      t.timestamps null: false
    end
  end
end
