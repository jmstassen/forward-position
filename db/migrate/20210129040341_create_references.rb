class CreateReferences < ActiveRecord::Migration
  def change 
    create_table :references do |t|
      t.text :title
      t.integer :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
