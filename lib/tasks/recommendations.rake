require "google/api_client"
require "google_drive"

desc "Reload recommendations from Google Doc"
task :recommendations => :environment do
  # Creates a session. This will prompt the credential via command line for the
  # first time and save it to config.json file for later usages.
  session = GoogleDrive.saved_session(File.join(Rails.root, "config", "google_drive.json"))

  # get first sheet in recommendations doc
  sheet = session.spreadsheet_by_key(ENV['RECOMMENDATIONS_DOC_ID']).worksheets[0]

  Recommendation.destroy_all

  # skip the heading row
  (2..sheet.num_rows).each do |row|
    r = Recommendation.create!(
      name: sheet[row, 1],
      category: sheet[row, 2],
      address: sheet[row, 3],
      description: sheet[row, 4],
      link: sheet[row, 5],
      image: sheet[row, 6],
      latitude: sheet[row, 7],
      longitude: sheet[row, 8]
    )

    puts "Loaded recommendation ##{r.id}: #{r.name}"

    # save lat and lon back to doc so we don't need to fetch it again
    if sheet[row, 7].blank? || sheet[row, 8].blank?
      sheet[row, 7] = r.latitude
      sheet[row, 8] = r.longitude
      sheet.save
      sleep 1.0 # prevent geocoder rate limiting
    end
  end
end