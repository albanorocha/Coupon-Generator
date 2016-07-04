class Admin::RedeemedCouponsController < Admin::AdminController
  def index
    skip_policy_scope

    @q = RedeemedCoupon.ransack(params[:q])

    @redeemed_coupons = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    #@redeemed_coupons = @q.result.page(params[:page]).to_a.uniq

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
