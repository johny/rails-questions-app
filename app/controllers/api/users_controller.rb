class Api::UsersController < Api::ApiController

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render
    else
      render json: {
        message: 'Validation failed',
        errors: @user.errors.full_messages
      }, status: 422
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
