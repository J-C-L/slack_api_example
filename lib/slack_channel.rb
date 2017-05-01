
class SlackChannel

  # Nesting classes
  class SlackException < StandardError
  end

  BASE_URL = "https://slack.com/api/"

  attr_reader :name

  def initialize(name)
    @name = name
  end


  def send(message)

    query_params = {
      "token" => ENV["SLACK_API_TOKEN"],
      "channel" => @name,
      "text" => message,
      "username" => "WhoAmI?",
      # "icon_url" => "http://www.nzamt.org.nz/images/Math-Tree.jpg",
      "icon_emoji" => ":smiling_imp:",
      "as_user" => "false"
    }


    url = "#{BASE_URL}chat.postMessage"
    response = HTTParty.post(url, query: query_params)
    if response["ok"]
      puts "Everything went swell"
    else
      raise SlackChannel::SlackException.new(response["error"])
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
      # More verbose way of doing the above:
      # channel_list = []
      # response["channels"].each do |channel_data|
      #   channel_list << SlackChannel.new(channel_data)
      # end
    else
      raise SlackChannel::SlackException.new(response["error"])
      # puts "On no there was an error: #{response["error"]}"
    end
  end

end
