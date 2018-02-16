class YoutubeVideoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "youtube_channel_user_#{user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
