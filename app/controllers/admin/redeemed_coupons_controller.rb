class Admin::RedeemedCouponsController < Admin::AdminController
  def index
    @redeemed_coupons = policy_scope(RedeemedCoupon.all)

  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @redeemed_coupon = RedeemedCoupon.find(params[:id])
    authorize @redeemed_coupon

    @redeemed_coupon.destroy
    respond_to do |format|
      format.html { redirect_to admin_redeemed_coupons_path, notice: 'Cupom foi DELETADO com sucesso.' }
      format.json { head :no_content }
    end
  end

  def validate
    @redeemed_coupon = RedeemedCoupon.find(params[:id])
    authorize @redeemed_coupon


    respond_to do |format|
      if @redeemed_coupon.update(validated: true)
        format.html { redirect_to admin_redeemed_coupons_path,
            notice: 'Código validado com sucesso.' }
      else
        format.html {
            flash[:Error] = "Código já validado"
            redirect_to admin_redeemed_coupons_path}
      end
    end
  end
end
