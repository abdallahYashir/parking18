module ApplicationHelper

  def get_user_business
    Business.where(user_id: current_user.id)
  end

  def user_has_business?
    !get_user_business.first.nil?
  end

  def redirect_business
    if !user_has_business?
      redirect_to businesses_url
    end
  end

end
