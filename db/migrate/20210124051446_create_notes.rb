class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :task_id
      
      t.timestamps null: false
    end
  end
end
