class Admin::UsersController < Admin::AdminController

  def index
    @users = policy_scope(User.all)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

    # GET /admin/users/new
  def new
    @user = User.new
    authorize @user
  end


  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new()
    authorize @user

    respond_to do |format|
      if @user.update(permitted_attributes(@user))
        format.html { redirect_to admin_users_path, notice: 'Usuário foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: [:admin, @user] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @user].errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize @user
  end


  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to admin_users_path, :notice => "User updated."
    else
      redirect_to admin_users_path, :alert => "Unable to update user."
    end
  end

  # GET /admin/users/1/edit
  def edit_password
    @user = User.find(params[:id])
    authorize @user
  end

  # GET /admin/users/1/edit
  def update_password
    @user = User.find(params[:id])
    authorize @user

    respond_to do |format|
      if @user.update(permitted_attributes(@user))
        format.html { redirect_to admin_user_path(@user), notice: 'Usuário foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: [:admin, @user] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @user].errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to admin_users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
