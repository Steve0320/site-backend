class Project < ApplicationRecord

  # Validate presence of required fields
  validates :key, presence: true, alphabetic: true, uniqueness: true
  validates :menu_text, presence: true
  validates :name, presence: true
  validates :description, presence: true

  # Validate github link is HTTPS, if present
  #validates :github_link, HTTPS: true

  # Retrieve data from the associated GitHub repository, if it exists
  # Mirrors HTML status codes as much as possible
  def github_data(connection = nil)

    return {message: 'No linked repository', status: 404} unless repo_name.present?

    github_base_url = Rails.configuration.github_base_url
    github_user = Rails.configuration.github_user

    # Only permit Faraday connections so we know what we're getting
    conn = if connection.is_a?(Faraday::Connection)
             connection
           else
             Faraday::Connection.new("https://#{github_base_url}") do |c|
               c.adapter Faraday.default_adapter
               c.headers['Content-Type'] = 'application/json;charset=utf-8'
               c.headers['Accept'] = 'application/vnd.github.v3+json'
             end
           end

    repo_request = conn.get "repos/#{github_user}/#{repo_name}"

    return {message: 'Request error', status: repo_request.status} unless repo_request.status == 200

    repo_json = JSON.parse(repo_request.body)

    # TODO: This should probably be moved somewhere global
    time_format = '%Y-%m-%dT%H:%M:%S'

    output = {
        status: 200,
        message: 'Success',
        attributes: {
            gh_url: repo_json['html_url'],
            gh_description: repo_json['description'],
            gh_created_at: DateTime.strptime(repo_json['created_at'], time_format),
            gh_last_pushed_at: DateTime.strptime(repo_json['pushed_at'], time_format),
            gh_last_updated_at: DateTime.strptime(repo_json['updated_at'], time_format),
            gh_clone_url: repo_json['clone_url'],
            gh_homepage: repo_json['homepage'],
            gh_size: repo_json['size'],
            gh_license: repo_json['license'],
            gh_languages: nil
        }
    }

    language_request = conn.get "repos/#{github_user}/#{repo_name}/languages"
    if language_request.status == 200
      output[:attributes][:gh_languages] = JSON.parse(language_request.body)
    end

    return output

  end

end
