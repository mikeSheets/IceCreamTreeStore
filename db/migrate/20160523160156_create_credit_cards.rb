class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :cvc
      t.string :last_four
      t.integer :month
      t.integer :year
      t.references :user
      t.string :name


      t.timestamps null: false
    end
  end
end
