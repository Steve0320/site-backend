class CheckGithubJob < ApplicationJob

  queue_as :low_priority

  def perform

    puts "Querying Github for changes"

    github_base_url = Rails.configuration.github_base_url

    # Setup connection protocols
    connection = Faraday::Connection.new "https://#{github_base_url}"
    connection.headers['Content-Type'] = 'application/json;charset=utf-8'
    connection.headers['Accept'] = 'application/vnd.github.v3+json'

    # Query Github for the current rate limit
    rate_limit = connection.get 'rate_limit'
    return unless rate_limit.status == 200

    # Bail out early if we know our request will be denied
    core_remaining = JSON.parse(rate_limit.body).dig('resources', 'core', 'remaining')
    puts "API will allow #{core_remaining} more requests until reset"

    unless core_remaining > 0
      puts "Request limit reached, exiting job..."
      return
    end

    # Check each Project record, updating as necessary
    # TODO: Minor optimization: only load as many objects as we can query the API for
    Project.find_each do |project|

      data = project.github_data(connection)

      puts "#{project.name} update status: #{data[:message]}"

      case data[:status]
      when 403        # 403 indicates that we've exceeded our rate limit, so skip the rest
        break
      when 200        # 200 indicates success, so update the stored attributes
        project.update(data[:attributes])
      else            # Anything else is treated as a failure for this project only
        next
      end

    end

  end

end
