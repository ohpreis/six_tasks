class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.text :title
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddDefaultStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :status, from: nil, to: 1
  end
end
