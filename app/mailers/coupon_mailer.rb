class CouponMailer < ApplicationMailer
  default from: 'craosx.solutions@gmail.com'

  def coupon_confirmation(redeemed_coupon)
    @redeemed_coupon = redeemed_coupon
    @coupon = redeemed_coupon.coupon
    mail(to: @redeemed_coupon.client_email,
          subject: "Cupom #{@coupon.title} Gerado com Sucesso!")
  end
end
