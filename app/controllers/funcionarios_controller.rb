class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  

  # GET /funcionarios
  # GET /funcionarios.json
  def index
    @funcionarios = Funcionario.all
  end

  # GET /funcionarios/1
  # GET /funcionarios/1.json
  def show
  end

  # GET /funcionarios/new
  def new
    @funcionario = Funcionario.new
  end

  # GET /funcionarios/1/edit
  def edit
  end

  # POST /funcionarios
  # POST /funcionarios.json
  def create
    @funcionario = Funcionario.new(funcionario_params)
    
    @funcionario.user_id = params[:user_id][:user_id]

    respond_to do |format|
      if @funcionario.save
        format.html { 
          flash[:success] = 'Funcionário cadastrado com sucesso.'
          redirect_to @funcionario
          }
        format.json { render :show, status: :created, location: @funcionario }
      else
        format.html { render :new }
        format.json { render json: @funcionario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funcionarios/1
  # PATCH/PUT /funcionarios/1.json
  def update
    @funcionario.user_id = params[:user_id][:user_id]
    
    respond_to do |format|
      if @funcionario.update(funcionario_params)
        format.html { 
          flash[:success] = 'Funcionário atualizado com sucesso.'
          redirect_to @funcionario
        }
        format.json { render :show, status: :ok, location: @funcionario }
      else
        format.html { render :edit }
        format.json { render json: @funcionario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.json
  def destroy
    @funcionario.destroy
    respond_to do |format|
      format.html { 
        flash[:danger] = 'Funcionário excluído com sucesso.'
        redirect_to funcionarios_url
      }
      format.json { head :no_content }
    end
  end

  def horarios
  
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funcionario
      @funcionario = Funcionario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funcionario_params
      params.require(:funcionario).permit(:nome, :cpf, :user_id)
    end
end
