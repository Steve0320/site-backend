class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :key, null: false, index: true
      t.text :menu_text, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.text :github_link
      t.datetime :start_date
      t.datetime :finish_date
      t.text :status

      t.timestamps
    end
  end
end
