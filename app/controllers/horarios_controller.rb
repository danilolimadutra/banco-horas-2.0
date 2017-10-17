require 'time'

class HorariosController < ApplicationController
  before_action :set_horario, only: [:show, :edit, :update, :destroy, :validar_horario]
  before_action :require_user
  before_action :require_funcionario, only: [:new, :meus_horarios]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index]
  
  # GET /horarios
  # GET /horarios.json
  def index
    @horarios = Horario.paginate(page: params[:page], per_page: 20).order('id DESC')
  end

  # GET /horarios/1
  # GET /horarios/1.json
  def show
  end

  # GET /horarios/new
  def new
    @horario = Horario.new
  end

  # GET /horarios/1/edit
  def edit      
    #impedir edição de horário validado
    if @horario.hora_valida 
      flash[:danger] = "Você não pode editar um horário validado."
      redirect_to meus_horarios_horarios_path
    end
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @horario = Horario.new(horario_params)
    @horario.user = current_user
    
    set_funcionario
    @horario.funcionario_id = @funcionario.id
    
    @horario.total_horas = total_horas
    
    respond_to do |format|
      if @horario.save
        format.html { 
          flash[:success] = 'Horário cadastrado com sucesso.'
          redirect_to meus_horarios_horarios_path
        }
      else
        format.html { render :new }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horarios/1
  # PATCH/PUT /horarios/1.json
  def update
    params_update = horario_params
    params_update[:total_horas] = total_horas
  
    respond_to do |format|
      if @horario.update(params_update)
        format.html { 
          flash[:success] = 'Horário atualizado com sucesso.'
          redirect_to meus_horarios_horarios_path
        }
        format.json { render :show, status: :ok, location: @horario }
      else
        format.html { render :edit }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /horarios/1
  # DELETE /horarios/1.json
  def destroy
    @horario.destroy
    respond_to do |format|
      format.html { 
        flash[:danger] = 'Horários excluído com sucesso'
        redirect_to meus_horarios_horarios_path
      }
      format.json { head :no_content }
    end
  end
  
  def validar_horario
    @horario.hora_valida = true
    
    horario = Hash.new( "horario" )
    horario = {"id" => params[:id]}

      if @horario.update(horario)
        #format.html { redirect_to @horario, notice: 'Horario was successfully updated.' }
        flash[:success] = "Horário validado com sucesso."
        redirect_to horarios_path
      else
        flash[:danger] = "falha na validação do horário."
        redirect_to horarios_path
      end
  end
  
  def validar
    @horarios = Horario.paginate(page: params[:page], per_page: 20)
  end
  
  def meus_horarios
    set_funcionario
    @horarios = @funcionario.horarios.paginate(page: params[:page], per_page: 20).order('data DESC')
    
    @total_extra = @funcionario.horarios.where(:hora_extra => true).sum('total_horas')
    
    @teste = @funcionario.horarios.where(:hora_extra => true).sum('total_horas')
    
    @total_compensado = @funcionario.horarios.where(:hora_extra => false).sum('total_horas')
    
    @saldo_hora = @total_extra - @total_compensado
    
    #historico_mensal
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
      #@horario.inicio = "00:01"

    end
    
    def set_funcionario
        @funcionario = Funcionario.find_by(user_id: current_user.id) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario).permit(:data, :inicio, :fim, :motivo, :hora_extra)
    end
    
    def total_horas
      hora_inicio = Time.parse(params[:horario][:inicio])
      hora_fim = Time.parse(params[:horario][:fim])
      total_horas = ( ( hora_fim - hora_inicio ) / 60 ) / 60
    end
    
    def require_same_user
      if @horario.user != current_user and !current_user.admin?
        flash[:danger] = "Somente o dono tem permissão."
        redirect_to root_path
      end
    end
    
    def historico_mensal
      date = Time.current - 6.month
      @horarios = @funcionario.horarios.where("data >= :start_date", start_date: date)
      
      i = 0
      @totais_mensais = Hash.new
      
      while i < 7 do
        extra = 1
        compensado = 2
        saldo = 3
        
        @totais_mensais[date.strftime("%F")] = [extra, compensado, saldo]

        date += 1.month 
        i += 1
      end
    end
end
