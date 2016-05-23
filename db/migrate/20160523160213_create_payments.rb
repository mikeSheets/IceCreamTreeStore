class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :order_id
      t.string :credit_card_id

      t.timestamps null: false
    end
  end
end
