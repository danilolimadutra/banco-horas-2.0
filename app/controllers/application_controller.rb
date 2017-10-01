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
      flash[:danger] = "Você precisa estar logado para executar essa ação."
      redirect_to root_path
    end
  end
  
  def require_admin
      if logged_in? and !current_user.admin?
          flash[:danger] = "Permissão exclusiva para administradores."
          redirect_to root_path
      end
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "Você só pode editar sua própria conta."
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
