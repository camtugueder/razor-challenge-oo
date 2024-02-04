# frozen_string_literal: true

class RemoteShowFetcher
  URL = "https://shows-remote-api.com"

  def self.fetch_data
    response = Faraday.get(URL)

    unless response.status == 200
      handle_unsuccessful_response(response)
      return nil  # or return an empty array/hash depending on your expected return type
    end

    parse_json(response.body)
  rescue Faraday::ConnectionFailed => e
    puts "Connection failed: #{e.message}"
    nil  # or return an empty array/hash depending on your expected return type
  rescue Faraday::TimeoutError => e
    puts "Request timed out: #{e.message}"
    nil  # or return an empty array/hash depending on your expected return type
  rescue JSON::ParserError => e
    puts "JSON parsing error: #{e.message}"
    nil  # or return an empty array/hash depending on your expected return type
  end

  def self.parse_json(data)
    JSON.parse(data, symbolize_names: true)
  end

  def self.handle_unsuccessful_response(response)
    puts "Unsuccessful response received. Status: #{response.status}, Body: #{response.body}"
    # Here, you can add more specific handling based on status codes or response body
  end
end