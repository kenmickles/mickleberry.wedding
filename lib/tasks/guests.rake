
def bad_date(name)
  name.blank? || name.to_s.strip.downcase == "plus one" || name.to_s.strip.split(' ').length < 2
end

namespace :guests do
  desc "Delete and reload guest list"
  task :reload => :environment do
    Guest.destroy_all

    CSV.read("/Users/ken/Downloads/guests.csv", headers: true).each do |row|
      if row['Guest'].present?
        Guest.create!(
          name: row['Guest'].strip,
          plus_one: row['Date'].present?
        )

        unless bad_date(row['Date'])
          Guest.create!(
            name: row['Date'].strip,
            plus_one: true
          )
        end
      end
    end
  end
end