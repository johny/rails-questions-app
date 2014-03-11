class Admin::QuizzesController < Admin::AdminController

  before_filter :find_quiz, only: [:show, :questions, :edit, :update, :destroy, :publish, :unpublish, :expire]

  def index
    @quizzes = Quiz.all
  end

  def show
  end

  def new
    @quiz = Quiz.new
    @quiz.date = Date.today
  end

  def import
    if request.post?
      upload = params[:quiz_file]
      content = upload.is_a?(StringIO) ? upload.read : File.read(upload.path)
      @yaml = YAML::load(content)
      if @yaml && @yaml['quiz']
        yaml =  @yaml['quiz']
        @quiz = Quiz.new
        @quiz.title = yaml['title']
        @quiz.description = yaml['description'] unless yaml['description'].blank?
        @quiz.date = yaml['date'] unless yaml['date'].blank?

        yaml['questions'].each do |yaml_question|
          question = Question.new
          question.title = yaml_question['title']
          yaml_question['answers'].each do |yaml_answer|
            answer = Answer.new
            # if its a valid answer
            if yaml_answer.match(/\+\+\+/)
              yaml_answer.gsub!(/\+\+\+/, '')
              answer.is_correct = true
            end
            answer.content = yaml_answer
            question.answers << answer
          end
          @quiz.questions << question
        end

        if @quiz.valid?
          @quiz.save
          flash[:notice] = 'Quiz was successfully created.'
          redirect_to admin_quiz_path(@quiz)
        else
          flash.now[:error] = "There was an error when importing file. Please check format!"
        end

      end
    end
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

  def publish
    @quiz.publish!
    redirect_to admin_quizzes_path, notice: "Quiz published!"
  end

  def unpublish
    @quiz.unpublish!
    redirect_to admin_quizzes_path, notice: "Quiz unpublished!"
  end

  def expire
    @quiz.expire!
    redirect_to admin_quizzes_path, notice: "Quiz expired!"
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
