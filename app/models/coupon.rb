class Coupon < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :redeemed_coupons, dependent: :destroy
end
