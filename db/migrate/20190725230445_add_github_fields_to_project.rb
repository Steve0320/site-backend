class AddGithubFieldsToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :gh_url, :string
    add_column :projects, :gh_description, :string
    add_column :projects, :gh_created_at, :datetime
    add_column :projects, :gh_last_pushed_at, :datetime
    add_column :projects, :gh_last_updated_at, :datetime
    add_column :projects, :gh_clone_url, :string
    add_column :projects, :gh_homepage, :string
    add_column :projects, :gh_size, :integer
    add_column :projects, :gh_license, :string
    add_column :projects, :gh_languages, :string
  end
end
