class CreateMorningPages < ActiveRecord::Migration[7.2]
  def change
    create_table :morning_pages do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
