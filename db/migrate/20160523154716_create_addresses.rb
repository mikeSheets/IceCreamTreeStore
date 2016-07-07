class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :line1
      t.string :line2
      t.string :city
      t.references :state
      t.integer :zip
      t.references :user

      t.timestamps null: false
    end
  end
end