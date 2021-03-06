class HomeController < ApplicationController
  include UserDependency
  before_action :user_required!, only:[:index]

  def index
    @projects = Project.where(manager: current_user)
  end
end
