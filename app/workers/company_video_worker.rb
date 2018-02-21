class CompanyVideoWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)
    if company.youtube?
      channel = get_channel(company.youtube)
      channel_videos = get_videos(channel)
      channel_videos.each do |video|
        company.videos.create(title: video.title, embed_code: get_embed_code(video.id))
      end
      broadcast_to_channel(company)
    end
  end

  private

  def broadcast_to_channel(company)
    ActionCable.server.broadcast "youtube_channel_user_#{company.user.id}",
                                 company: company.id,
                                 videos: ApplicationController
                                   .render(partial: 'account/companies/html/youtube_videos',
                                           locals: { company: company,
                                                     videos: company.videos.take(3) })
  end

  def get_channel(channel_link)
    channel_id = channel_link.split('channel/').last
    authenticate(channel_id)
  end

  def get_videos(channel)
    channel.videos
  end

  def authenticate(id)
    Yt::Channel.new(id: id)
  end

  def get_embed_code(id)
    "<iframe src='https://www.youtube.com/embed/#{id}"\
      "?rel=0' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
  end
end
