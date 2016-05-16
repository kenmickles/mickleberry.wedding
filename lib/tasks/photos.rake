namespace :photos do
  desc "Fetch Instagram photos tagged #mickleberry"
  task :instagram => :environment do
    tags = ENV['INSTAGRAM_TAGS'].split(',').map(&:strip)
    max_iterations = 5
    urls = []

    # start with the mickleberry.wedding user feed
    urls << "https://i.instagram.com/api/v1/feed/user/3070735638/"

    # then search the tag feeds
    tags.each do |tag|
      urls << "https://i.instagram.com/api/v1/feed/tag/#{tag}/"
    end

    urls.each do |url|
      puts "Fetching #{url}..." unless ENV['SILENT']

      items = []
      max_id = nil
      i = 0

      while true do
        data = HTTParty.get("#{url}?rank_token=1982135374_E7D741D2-BBDC-4C9B-B871-BABEE15F7110&ranked_content=true&max_id=#{max_id}", {
          headers: {
            "User-Agent" => "Instagram 8.0.0 (iPhone8,1; iPhone OS 9_3_1; en_US; en-US; scale=2.00; 750x1334) AppleWebKit/420+",
            "Cookie" => "ds_user=#{ENV['INSTAGRAM_USER']}; ds_user_id=#{ENV['INSTAGRAM_USER_ID']}; sessionid=#{ENV['INSTAGRAM_SESSION_ID']}"
          }
        })

        if data['status'] == 'fail'
          raise "Instagram API said: #{data['message']}"
        end

        items += data['items'] if data['items']
        items += data['ranked_items'] if data['ranked_items']
        
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
      new_items = {}
      items.reject { |i| existing_ids.include?(i['id']) }.each do |item|
        new_items[item['id']] = item
      end
      new_items = new_items.values

      puts "Found #{new_items.length} new photos." unless ENV['SILENT']

      new_items.each do |item|
        Photo.create!(
          image: item['image_versions'].first['url'],
          photographer: item['user']['username'],
          avatar: item['user']['profile_pic_url'],
          caption: item['caption']['text'],
          instagram_id: item['id'],
          instagram_code: item['code'],
          created_at: Time.at(item['taken_at']),
          source: "instagram"
        )
      end

      sleep 1.0 unless url == urls.last
    end
  end
end