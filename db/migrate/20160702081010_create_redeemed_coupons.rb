class CreateRedeemedCoupons < ActiveRecord::Migration
  def change
    create_table :redeemed_coupons do |t|
      t.string :client_name
      t.string :client_email
      t.string :code
      t.references :coupon, index: true, foreign_key: true
      t.date :expiration_date
      t.boolean :validated, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
