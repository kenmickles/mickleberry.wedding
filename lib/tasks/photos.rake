namespace :photos do
  desc "Fetch Instagram photos tagged #mickleberry"
  task :instagram => :environment do
    tags = ENV['INSTAGRAM_TAGS'].split(',').map(&:strip)
    max_iterations = 5

    tags.each do |tag|
      puts "Searching ##{tag}..."

      items = []
      max_id = nil
      i = 0

      while true do
        data = HTTParty.get("https://i.instagram.com/api/v1/feed/tag/#{tag}/?rank_token=1982135374_E7D741D2-BBDC-4C9B-B871-BABEE15F7110&ranked_content=true&max_id=#{max_id}", {
          headers: {
            "User-Agent" => "Instagram 7.15.0 (iPhone8,1; iPhone OS 9_2; en_US; en-US; scale=2.00; 750x1334) AppleWebKit/420+",
            "Cookie" => "ds_user=#{ENV['INSTAGRAM_USER']}; ds_user_id=#{ENV['INSTAGRAM_USER_ID']}; sessionid=#{ENV['INSTAGRAM_SESSION_ID']}"
          }
        })

        if data['status'] == 'fail'
          raise "Instagram API said: #{data['message']}"
        end

        items += data['items'] if data['items']
        
        if data['more_available'] && i < max_iterations
          i += 1
          max_id = data['next_max_id']
          sleep 1.0
        else
          break
        end
      end

      # only keep the photos
      items.select! { |i| i['media_type'] == 1 }

      item_ids = items.collect { |i| i['id'] }
      existing_ids = Photo.where(instagram_id: item_ids).pluck(:instagram_id)
      new_items = items.reject { |i| existing_ids.include?(i['id']) }

      puts "Found #{new_items.length} new photos."

      new_items.each do |item|
        Photo.create!(
          image: item['image_versions'].first['url'],
          photographer: item['user']['username'],
          avatar: item['user']['profile_pic_url'],
          caption: item['caption']['text'],
          instagram_id: item['id'],
          created_at: Time.at(item['taken_at']),
          source: "instagram"
        )
      end

      sleep 1.0 unless tag == tags.last
    end
  end
end