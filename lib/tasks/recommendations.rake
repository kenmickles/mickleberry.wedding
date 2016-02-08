namespace :recommendations do
  desc "Reset recommendations from Google Doc"
  task :reload => :environment do
    recs = [
      {
        name: "Center City Pretzel Co",
        address: "816 Washington Ave Philadelphia, PA 19147",
        link: "http://www.centercitypretzel.com/",
        category: "restaurant",
        description: "Best soft pretzels in Philadelphia",
        image: "http://s3-media4.fl.yelpcdn.com/bphoto/WFQS1DJBjffag0EzZdKsHQ/o.jpg"
      },
      {
        name: "Hotel Palomar Philadelphia",
        address: "117 South 17th Street, Philadelphia, PA 19103",
        link: "http://www.tripadvisor.com/Hotel_Review-g60795-d1510002-Reviews-Hotel_Palomar_Philadelphia_a_Kimpton_Hotel-Philadelphia_Pennsylvania.html",
        category: "hotel",
        description: "A nice hotel. Mostly this is on here so I can test the hotel icon.",
        image: "https://d1xyolhen8fnqh.cloudfront.net/media/hotels/slideshow_images_staged/large/1035769.jpg"
      },
      {
        name: "Kensington Kinetic Sculpture Derby & Arts Festival 2016",
        address: "Trenton Avenue and E Susquehanna Philadelphia, PA 19125",
        link: "http://www.visitphilly.com/events/philadelphia/kensington-kinetic-sculpture-derby/",
        category: "attraction",
        description: "Off-beat design competition and community arts festival",
        image: "http://www.visitphilly.com/resize/images/Kensington-Kinetic-Sculpture-Derby-JFusco-900VP-587x0.jpg"
      },
      {
        name: "Mütter Museum",
        address: "19 South 22nd Street, Philadelphia, Pennsylvania, 19103",
        link: "http://muttermuseum.org/",
        category: "attraction",
        description: "Medical wonders in an architectural gem",
        image: "http://www.visitphilly.com/resize/images/MutterMuseum-003-BKrist-900vp-587x0.jpg"
      }
    ]

    Recommendation.destroy_all

    recs.each do |rec|
      r = Recommendation.create!(rec)
      puts "Loaded #{r.name}"
      sleep 1.0 # prevent geocoder rate limiting
    end
  end
end