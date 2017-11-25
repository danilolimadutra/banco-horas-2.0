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

  #FIXME: transformar lista_datas em um hash e ajustar view
  def historico_mensal funcionario
    date = Time.now
    ano = date.strftime("%Y")
    mes = date.strftime("%m")
    data_inicio = Date.new(ano.to_i, mes.to_i, 1) - 5.month

    #consultar periodos anteriores a 6 meses
    extra_inicial = funcionario.horarios.where("hora_extra = ? and data < ?", true, data_inicio).sum("total_horas")
    compensado_inicial = funcionario.horarios.where("hora_extra = ? and data < ?", false, data_inicio).sum("total_horas")

    i = 0
    acumulado = 0
    lista_datas = {}
    totais_mensal = {}

    while i < 6 do
      data_fim = data_inicio + 1.month - 1.day

      if i == 0
        data = "Meses anteriores"
      else
        data = data_inicio.strftime("%m/%Y")
      end

      extra = funcionario.horarios.where("hora_extra = ? and data between ? and ?", true, data_inicio, data_fim).sum("total_horas") + extra_inicial
      compensado = funcionario.horarios.where("hora_extra = ? and data between ? and ?", false, data_inicio, data_fim).sum("total_horas") + compensado_inicial
      saldo = extra - compensado
      acumulado = acumulado + saldo

      lista_datas[i] = [data, extra, compensado, saldo, acumulado]

      data_inicio = data_inicio + 1.month
      i += 1
      extra_inicial = 0
      compensado_inicial = 0
    end

    return lista_datas
  end
end
