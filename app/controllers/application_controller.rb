class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

    # ...

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

  around_action :rescue_from_fk_contraint, only: [:destroy]
  
    def rescue_from_fk_contraint
      begin
        yield
      rescue ActiveRecord::InvalidForeignKey
        # Flash and render, render API json error... whatever
      end
    end
end