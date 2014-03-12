class Admin::TopicsController < Admin::AdminController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :expire]

  # GET /topics
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)


    if @topic.save
      flash[:notice] = 'Topic was successfully created.'
      redirect_to admin_topics_path
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      redirect_to admin_topics_path, notice: 'Topic was successfully updated.'
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

  # DELETE /topics/1
  def destroy
    @topic.destroy
    redirect_to admin_topics_path, notice: 'Topic was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params
      params.require(:topic).permit(:title, :name, :parent_id)
    end
end
