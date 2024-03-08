class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user_id
    current_user.id if user_signed_in?
  end
end
