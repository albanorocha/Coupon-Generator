json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :title, :description, :valid_from, :valid_until
  json.url coupon_url(coupon, format: :json)
end
