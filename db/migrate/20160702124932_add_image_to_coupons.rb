class AddImageToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :image, :string
  end
end
