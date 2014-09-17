require 'open-uri'
require 'nokogiri'

def image_url(page_url = 'http://photography.nationalgeographic.com/photography/photo-of-the-day')
  html = open(page_url)
  doc = Nokogiri::HTML(html)
  src = doc.css('.primary_photo > a > img').first['src']
  "http:#{src}"
end

`curl #{image_url} > ng_daily_image.jpg`

filepath = File.join(Dir.pwd, "ng_daily_image.jpg")

`sh ./ng_reset.sh`
sleep(1)
`sh ./ng_set.sh #{filepath}`

`rm ng_daily_image.jpg`
