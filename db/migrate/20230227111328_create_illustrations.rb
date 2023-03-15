class CreateIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :illustrations do |t|
      t.integer :account_id, null: false
      t.string :title, null: false
      t.text :introduction, null: false
      t.boolean :is_draft
      t.timestamps
    end
  end
end
