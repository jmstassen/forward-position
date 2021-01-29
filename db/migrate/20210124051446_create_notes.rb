class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :task_id
      t.text :status
      t.integer :user_id
      t.integer :reference_id
      t.integer :contact_id

      t.timestamps null: false
    end
  end
end
