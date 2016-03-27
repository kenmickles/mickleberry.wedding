require 'google/api_client'
require 'google_drive'
require 'prawn/labels'
require 'street_address'

desc "Generate mailing labels for guests"
task :labels => :environment do
  session = GoogleDrive.saved_session(File.join(Rails.root, "config", "google_drive.json"))
  sheet = session.spreadsheet_by_key(ENV['GUESTS_DOC_ID']).worksheets[0]

  addresses = []

  # skip the heading row
  (2..sheet.num_rows).each do |row|
    name = sheet[row, 1]
    mailing_name = sheet[row, 6]
    name = [mailing_name, name].select(&:present?).first
    address_str = sheet[row, 7]

    if name.present? && address_str.present?
      if address = StreetAddress::US.parse(address_str)
        lines = [name, address.line1, "#{address.city}, #{address.state} #{address.postal_code}"]
        addresses << lines.join("\n")
      else
        addresses << [name, address_str].join("\n")
      end
    end
  end

  # This makes the Avery5160 template print correctly on my Brother 2170W
  # (Solution via https://github.com/jordanbyron/prawn-labels/issues/30)
  Prawn::Labels.types["Avery5160Adjusted"] = Prawn::Labels.types["Avery5160"].dup
  Prawn::Labels.types["Avery5160Adjusted"]["top_margin"] += 10
  Prawn::Labels.types["Avery5160Adjusted"]["left_margin"] += 10
  Prawn::Labels.types["Avery5160Adjusted"]["column_gutter"] += 5
  Prawn::Labels.types["Avery5160Adjusted"]["row_gutter"] += 5

  Prawn::Labels.generate(File.join(Rails.root, "tmp", "labels.pdf"), addresses, type: "Avery5160Adjusted") do |pdf, address|
    pdf.font File.expand_path("~/Library/Fonts/Albertus Medium Regular.ttf")
    pdf.text address, size: 10, leading: 5
  end
end