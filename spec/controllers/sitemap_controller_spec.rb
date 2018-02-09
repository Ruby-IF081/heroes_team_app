require 'rails_helper'

RSpec.describe SitemapController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index, format: :xml
      expect(response).to have_http_status(:success)
    end

    it 'has all links with all fields' do
      get :index, format: :xml
      response_xml = Nokogiri::XML(response.body)
      response_url_path = response_xml.xpath('//xmlns:url')
      expect(response_url_path.count).to be_equal(4)
      response_url_path.each do |url|
        expect(url.xpath('xmlns:loc').text).to be_present
        expect(url.xpath('xmlns:changefreq').text).to be_present
        expect(url.xpath('xmlns:priority').text).to be_present
      end
    end
  end
end
