class VisitorsController < ApplicationController
  def index
    @coupons = Coupon.where("valid_from <= :today AND valid_until >= :today", {today: Date.today})
  end

  def getcoupon
    @redeemed_coupon = RedeemedCoupon.new
    @coupon = Coupon.find(params[:coupon_id])
  end

  def show
      @redeemed_coupon = RedeemedCoupon.new
      @coupon = Coupon.find(params[:coupon_id])
  end

  def redeem
    @redeemed_coupon = RedeemedCoupon.new(redeem_params)
    @coupon = @redeemed_coupon.coupon
    @redeemed_coupon.expiration_date = Date.today + 7
    @redeemed_coupon.code = SecureRandom.hex(5)

    respond_to do |format|
      if @redeemed_coupon.save
        CouponMailer.coupon_confirmation(@redeemed_coupon).deliver_later
        format.html { redirect_to coupon_code_path(@redeemed_coupon.code), notice: 'Cupom criado com sucesso' }
      else
        format.html { render "getcoupon" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  def coupon_code
    @redeemed_coupon = RedeemedCoupon.find_by_code(params[:coupon_code])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def redeem_params
      params.require(:redeemed_coupon).permit(:client_name, :client_email, :coupon_id)
    end
end
