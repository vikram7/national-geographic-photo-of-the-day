require 'pry'
require 'net/http'
require 'uri'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

link = open('http://photography.nationalgeographic.com/photography/photo-of-the-day/')
prefix = "images.nationalgeographic.com/wpf/media-live"
image = link.split("images.nationalgeographic.com/wpf/media-live")[1].split("/>")[0].split('"')[0]

image_location = prefix + image
`curl #{image_location} > ng_daily_image.jpg`

filepath = File.join(Dir.pwd, "ng_daily_image.jpg")

`sh ./ng_reset.sh`
sleep(1)
`sh ./ng_set.sh #{filepath}`

`rm ng_daily_image.jpg`
