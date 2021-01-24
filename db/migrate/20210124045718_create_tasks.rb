class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :due_date
      t.date :do_date
      t.string :type
      t.integer :size
      t.string :status
      t.date :done_date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
