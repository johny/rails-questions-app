class Admin::QuestionsController < Admin::AdminController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    if params[:quiz_id].nil?
      @questions = Question.all
    else
      @quiz = Quiz.find(params[:quiz_id])

      if @quiz.questions.size < 10
        @index = @quiz.questions.size + 1
        @question = Question.new
        4.times do
          @question.answers.build
        end
      end

      render template: 'admin/quizzes/questions'
    end

  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)


    if @question.save
      flash[:notice] = 'Question was successfully created.'
      if params[:quiz_id].nil?
        redirect_to admin_question_answers_path(@question)
      else
        @quiz = Quiz.find params[:quiz_id]
        @quiz.questions << @question
        redirect_to admin_quiz_questions_path(@quiz)
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, notice: 'Question was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to admin_questions_path, notice: 'Question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:title, :workflow_state, answers_attributes: [:id, :content, :is_correct])
    end
end
