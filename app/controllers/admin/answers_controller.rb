class Admin::AnswersController < Admin::AdminController
  before_action :set_answer_and_question, only: [:show, :edit, :update, :destroy]

  # GET /questions/1/answers
  def index
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end


  # GET /questions/answers/1/edit
  def edit
  end

  # POST /answers
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    if @answer.save
      redirect_to admin_question_answers_path(@question), notice: 'Answer was successfully created.'
    else
      render action: 'index3'
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      redirect_to admin_question_answers_path(@question), notice: 'Answer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    redirect_to admin_question_answers_path(@question), notice: 'Answer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_and_question
      @question = Question.find(params[:question_id])
      @answer = Answer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_params
      params.require(:answer).permit(:content, :is_correct)
    end
end
