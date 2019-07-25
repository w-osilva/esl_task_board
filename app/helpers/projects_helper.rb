module ProjectsHelper

  def filter_stories(project, status: '')
    case status.to_sym
    when :pending then project.stories.with_status(:pending)
    when :started then project.stories.with_status(:started)
    when :delivered then project.stories.with_status(:delivered)
    when :accepted then project.stories.with_status(:accepted)
    else project.stories
    end
  end

end
