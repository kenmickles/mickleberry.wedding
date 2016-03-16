class MakePhotoCaptionLonger < ActiveRecord::Migration
  def change
    change_column :photos, :caption, :text
  end
end
