class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
 

  def index
    # @users = User.order("created_at ASC")
    @users = User.paginate(page: params[:page])

  end
  
  def show
    @articles = set_user.articles.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to MFA-Blog #{@user.username}, you have successfully sign in"
      redirect_to articles_path
    else
      render 'new' # 'new'
    end
  end

  def edit
  end

  def update
    if set_user.update(user_params)
      flash[:notice] = "Your account successfully updated!!!"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Akun dan semua article nya telah dihapus"
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your account!!"
      redirect_to @user
    end 
  end

end
