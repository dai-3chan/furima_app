class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    root_path(resource)
  end


  def production?
      Rails.env.production?
  end

  def logged_in?
    if current_user.nil?
      redirect_to new_user_session_url, alert: "ログインしてください"
    end
  end

  #クレジットカードが登録されているか？
  def card_holder?
    redirect_to new_credit_card_path if CreditCard.where(user_id: current_user.id).nil?
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
