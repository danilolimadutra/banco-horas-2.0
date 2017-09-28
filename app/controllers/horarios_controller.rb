require 'time'

class HorariosController < ApplicationController
  before_action :set_horario, only: [:show, :edit, :update, :destroy, :validar_horario]
  before_action :require_user
  before_action :require_funcionario, only: [:create, :meus_horarios]

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
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @horario = Horario.new(horario_params)
    @horario.user = current_user
    
    set_funcionario
    @horario.funcionario_id = @funcionario.id
    
    total_horas
    
    respond_to do |format|
      if @horario.save
        format.html { redirect_to @horario, notice: 'Horario was successfully created.' }
        format.json { render :show, status: :created, location: @horario }
      else
        format.html { render :new }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horarios/1
  # PATCH/PUT /horarios/1.json
  def update
    total_horas
  
    respond_to do |format|
      if @horario.update(horario_params)
        format.html { redirect_to @horario, notice: 'Horario was successfully updated.' }
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
      format.html { redirect_to horarios_url, notice: 'Horario was successfully destroyed.' }
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
    
    @total_extra =  @funcionario.horarios.where(:hora_extra => true).sum('total_horas')
    @total_compensado = @funcionario.horarios.where(:hora_extra => false).sum('total_horas')
    @saldo_hora = @total_extra - @total_compensado
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end
    
    def set_funcionario
        @funcionario = Funcionario.find_by(user_id: current_user.id) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario).permit(:data, :inicio, :fim, :motivo, :hora_extra)
    end
    
    def total_horas
      hora_inicio = Time.parse(@horario.inicio)
      hora_fim = Time.parse(@horario.fim)
      @horario.total_horas = ( ( hora_fim - hora_inicio ) / 60 ) / 60
    end
end
