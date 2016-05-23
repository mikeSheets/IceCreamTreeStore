class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :last_four
      t.integer :exp_month
      t.integer :exp_year
      t.string :user_id
      t.string :name

      t.timestamps null: false
    end
  end
end
