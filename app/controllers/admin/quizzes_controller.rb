class Admin::QuizzesController < Admin::AdminController

  before_filter :find_quiz, only: [:show, :questions, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.all
  end

  def show
  end

  def new
    @quiz = Quiz.new
    @quiz.date = Date.today
  end

  # POST /quizzes
  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /quizzes/1
  def update
    if @quiz.update(quiz_params)
      redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /quizzes/1
  def destroy
    @quiz.destroy
    redirect_to admin_quizzes_path, notice: 'Quiz was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quiz_params
      params.require(:quiz).permit(:title, :description, :date, :workflow_state)
    end
end
