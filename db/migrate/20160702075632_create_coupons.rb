class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :title
      t.text :description
      t.date :valid_from
      t.date :valid_until

      t.timestamps null: false
    end
  end
end
