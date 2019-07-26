class RemoveMenuTextFromProject < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :menu_text
  end
end
