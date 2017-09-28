class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
    def require_funcionario
        @funcionario = Funcionario.find_by(user_id: current_user.id) 
        if @funcionario == nil
            flash[:danger] = "Você ainda não tem funcionário vinculado. Por favor, entre em contato com o administrador."
            redirect_to root_path
            return
        end
    end
end
