class YoutubeVideoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "youtube_channel_user_#{user.id}"
  end
end
