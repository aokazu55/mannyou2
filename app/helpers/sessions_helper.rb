module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def admin_user?
    if current_user.present? && @current_user.admin == true
      true
    end
  end
end
