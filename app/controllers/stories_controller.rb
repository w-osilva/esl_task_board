class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /stories
  def index
    @stories = Story.all
  end

  # GET /stories/1
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new(requester: current_user)
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  def create
    @story = Story.new(story_params)

    if @story.save
      redirect_to project_path(@project), notice: 'Story was successfully created.'
    else
      redirect_to project_path(@project), alert: @story.errors.full_messages
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    redirect_to project_path(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.fetch(:story, {}).permit(:name,
                                      :description,
                                      :project_id,
                                      :requester_id,
                                      :owner_id,
                                      :points,
                                      :status,
                                      :started_at,
                                      :finished_at,
                                      :deadline,
                                      tasks_attributes: [
                                          :id,
                                          :description,
                                          :done,
                                          :_destroy
                                      ]
      )
    end
end
