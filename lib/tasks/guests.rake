
def bad_date(name)
  name.blank? || name.to_s.strip.downcase == "plus one" || name.to_s.strip.split(' ').length < 2
end

desc "Reload Guest list from Google Doc"
task :guests => :environment do
  session = GoogleDrive.saved_session(File.join(Rails.root, "config", "google_drive.json"))
  sheet = session.spreadsheet_by_key(ENV['GUESTS_DOC_ID']).worksheets[0]

  Guest.destroy_all

  # skip the heading row
  (2..sheet.num_rows).each do |row|
    if sheet[row, 1].present?
      Guest.create!(
        name: sheet[row, 1].strip,
        plus_one: sheet[row, 2].present?
      )

      unless bad_date(sheet[row, 2])
        Guest.create!(
          name: sheet[row, 2].strip,
          plus_one: true
        )
      end
    end
  end
end