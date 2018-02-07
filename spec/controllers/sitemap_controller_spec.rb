require 'rails_helper'

RSpec.describe SitemapController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index, format: :xml
      expect(response).to have_http_status(:success)
    end

    it 'has all fields' do
      get :index, format: :xml
      response_xml = Nokogiri::XML(response.body)
      response_xml.xpath('//xmlns:url').each do |url|
        expect(url.xpath('xmlns:loc').text).to be_present
        expect(url.xpath('xmlns:changefreq').text).to be_present
        expect(url.xpath('xmlns:priority').text).to be_present
      end
    end
  end
end
