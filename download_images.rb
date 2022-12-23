require 'httparty'
require 'json'

annotations = File.read('data/annotations_dec.json').then(&JSON.method(:parse))
annotations['images']
  .each do |image|
    File.open("data/images/#{image['file_name']}", "wb+") do |file|
      HTTParty.get(image['coco_url'], stream_body: true) do |fragment|
        file.write(fragment)
      end
    end
  end
