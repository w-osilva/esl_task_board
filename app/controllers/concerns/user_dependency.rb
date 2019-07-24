module UserDependency
  extend ActiveSupport::Concern

  def user_required!
    redirect_to root_path, warning: "You need to choose a country" unless current_user.present?
  end
end
