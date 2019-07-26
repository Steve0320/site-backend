class ChangeGithubLinkToRepoName < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :github_link, :repo_name
  end
end
