class MakeProjectKeyUnique < ActiveRecord::Migration[6.0]
  def down
    change_column :projects, :key, :string, null: false
  end

  def up
    change_column :projects, :key, :string, null: false
    remove_index :projects, name: "index_projects_on_key"
    add_index :projects, :key, unique: true
  end
end
