xml.instruct! :xml, version: "1.0"

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml << render(partial: 'xml_url', locals: { loc: root_url,     freq: 'weekly', priority: '1.0' })
  xml << render(partial: 'xml_url', locals: { loc: about_us_url, freq: 'weekly', priority: '0.9' })
  xml << render(partial: 'xml_url', locals: { loc: contacts_url, freq: 'weekly', priority: '0.9' })
  xml << render(partial: 'xml_url', locals: { loc: pricing_url,  freq: 'weekly', priority: '0.9' })
end
