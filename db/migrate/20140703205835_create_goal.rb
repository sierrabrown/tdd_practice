class CreateGoal < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :status, null: false, default: "INCOMPLETE"
      t.boolean :private, null: false, default: true
      t.integer :user_id
    end
    add_index :goals, :user_id
  end
end
