class CreateStateChanges < ActiveRecord::Migration
  def change
    create_table :state_changes do |t|
      t.string      :previous_state
      t.string      :next_state
      t.integer     :created_by_id
      t.references  :source,  polymorphic: true
      t.timestamps
    end
  end
end
