class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :destination
      t.date :start_date
      t.date :end_date
      t.string :tags
      t.integer :user_id

      t.timestamps
    end
  end
end
