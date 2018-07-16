class UsersController < ApplicationController
   def get_current_user
     user = authenticate_user_or_throw_error
     if !user.nil?
      render json: user, status: 200
     end
   end

   def new
     @user = User.new(user_params)
   end

   def show
     @user = User.find(params[:id])
   end

  def create
    @user = User.new
    if @user.save
      render json: { user: @user }, status: :create
    else
      render json:  { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def edit
    @user = User.find(get_current_user.id)
  end

  def update
    @user = User.find(get_current_user.id)

    if @user.update(user_params)
      redirect_to @user
    else
      render edit
    end
  end

  def destroy
    @user = User.find(get_current_user.id)
    @user.destroy
    redirect_to new_user_url
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :password_digest)
  end
end
