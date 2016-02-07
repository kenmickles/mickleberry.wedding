require 'open-uri'

namespace :gifts do

  desc "Import gifts from Amazon Wedding Registry"
  task :amazon => :environment do
    list_id = "1XEYPJ43GL6AE"
    url = "http://www.amazon.com/registry/wedding/#{list_id}"
    page = Nokogiri::HTML(open(url))

    page.css('tbody.itemWrapper').each do |el|
      _, _, coliid = el.attributes['name'].value.split('.')
      a = el.css('span.productTitle a').first
      name = a.text

      gift = Gift.find_or_initialize_by(name: name)
      gift.purchased = el.css('span.recQuantityValueText').first.text.to_s.strip.present?

      # this link format seems to trigger the registry stuff on checkout
      gift.link = "#{a.attributes['href'].value}?colid=#{list_id}&coliid=#{coliid}&ref_=wr_it_dp_v_nS_nC&tag=mickleberry-20"
      
      if price = el.css('span.wlPriceBold').first
        gift.price = price.text.gsub(/^\$/,'')
      end

      if gift.image.blank? || gift.price.blank?
        sleep 2.0 # try to prevent rate limiting

        begin
          detail_page = Nokogiri::HTML(open(a.attributes['href'].value))
        # try one more time if we get rate limited
        rescue OpenURI::HTTPError
          sleep 2.0
          detail_page = Nokogiri::HTML(open(a.attributes['href'].value))
        end
        
        if img = detail_page.css('#imgTagWrapperId img').first
          gift.image = img.attributes['data-old-hires'].value

          if gift.image.blank?
            gift.image = img.attributes['src'].value
          end
        end

        if price = detail_page.css('#priceblock_ourprice').first
          gift.price = price.text.gsub(/^\$/,'')
        end
      end

      gift.save!
      puts "Loaded gift ##{gift.id}: #{gift.name}"
    end
  end

end