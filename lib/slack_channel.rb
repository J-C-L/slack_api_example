class SlackChannel
  class SlackException < StandardError
  end

  BASE_URL = "https://slack.com/api/"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def send(message)
    # Extra data!
    query_params = {
      "token" => ENV["SLACK_API_TOKEN"],
      "channel" => @name,
      "text" => message,
      "username" => "Roberts-Robit",
      "icon_emoji" => ":robot_face:",
      "as_user" => "false"
    }

    url = "#{BASE_URL}chat.postMessage"
    response = HTTParty.post(url, query: query_params)

    if response["ok"]
      return response
    else
      raise SlackException.new(response["error"])
    end
  end

  def self.all
    url = "#{BASE_URL}channels.list?token=#{ENV["SLACK_API_TOKEN"]}"
    response = HTTParty.get(url).parsed_response

    if response["ok"]
      channel_list = response["channels"].map do |channel_data|
        self.new(channel_data["name"])
      end

      return channel_list
    else
      raise SlackException.new(response["error"])
    end
  end
end
