class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :address

      t.timestamps null: false
    end
  end
end
