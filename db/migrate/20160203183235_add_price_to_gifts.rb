class AddPriceToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :price, :decimal, precision: 10, scale: 2
  end
end
