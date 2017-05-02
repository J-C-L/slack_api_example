class ChatsController < ApplicationController


  # List all the slack channels
  def index
    @channels = SlackChannel.all
  end

  # Form to type a new message to a given slack channel
  def new_message
    @channel = SlackChannel.new(params[:channel])
  end

  # Handle the result of the above form
  def send_message
    channel =SlackChannel.new(params[:channel])
    channel.send(params[:message])
    redirect_to chats_path
  end

end
