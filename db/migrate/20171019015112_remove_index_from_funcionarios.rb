class RemoveIndexFromFuncionarios < ActiveRecord::Migration[5.0]
  def change
    remove_index :funcionarios, :cpf
  end
end
