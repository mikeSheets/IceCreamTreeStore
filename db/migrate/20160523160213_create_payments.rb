class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.references :order
      t.references :credit_card
      t.string :state

      t.timestamps null: false
    end
  end
end
