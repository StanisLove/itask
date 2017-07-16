class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :state, default: 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
