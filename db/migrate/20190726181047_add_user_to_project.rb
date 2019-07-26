class AddUserToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :github_user, :string
  end
end
