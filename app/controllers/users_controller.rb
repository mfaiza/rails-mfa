class UsersController < ApplicationController
  
  def index
    # @users = User.order("created_at ASC")
    @users = User.paginate(page: params[:page])

  end
  
  def show
    set_user
    @articles = set_user.articles.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to MFA-Blog #{@user.username}, you have successfully sign in"
      redirect_to articles_path
    else
      render 'new' # 'new'
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    if set_user.update(user_params)
      flash[:notice] = "Your account successfully updated!!!"
      redirect_to @user
    else
      render :edit
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
