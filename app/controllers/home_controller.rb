class HomeController < ApplicationController
  include UserDependency
  before_action :user_required!, only:[:index]

  def index
    @projects = current_user.projects
  end
end
