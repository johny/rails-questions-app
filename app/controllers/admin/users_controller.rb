class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :expire]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def publish
    @quiz.publish!
    redirect_to admin_quizzes_path, notice: "Quiz published!"
  end

  def unpublish
    @quiz.unpublish!
    redirect_to admin_quizzes_path, notice: "Quiz unpublished!"
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:title, :name, :parent_id)
    end
end
