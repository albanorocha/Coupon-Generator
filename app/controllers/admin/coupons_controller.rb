class Admin::CouponsController < Admin::AdminController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = policy_scope(Coupon.paginate(:page => params[:page], :per_page => 10).order('created_at DESC'))
    authorize @coupons
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    authorize @coupon
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
    authorize @coupon

  end

  # GET /coupons/1/edit
  def edit
    authorize @coupon
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)
    authorize @coupon


    respond_to do |format|
      if @coupon.save
        format.html { redirect_to [:admin, @coupon], notice: 'Cupom foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: [:admin, @coupon] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @coupon].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    authorize @coupon

    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to [:admin, @coupon], notice: 'Cupom foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: [:admin, @coupon] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @coupon].errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    authorize @coupon

    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to admin_coupons_path, notice: 'Cupom foi DELETADO com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:title, :description, :valid_from, :valid_until, :redemption_limit, :image)
    end
end
