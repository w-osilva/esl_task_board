module ProjectsHelper
  def pending_stories(project)
    project.stories.with_status(:pending)
  end
  def started_stories(project)
    project.stories.with_status(:started)
  end
  def delivered_stories(project)
    project.stories.with_status(:delivered)
  end
  def accepted_stories(project)
    project.stories.with_status(:accepted)
  end
end
