class AddFuncionarioIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :funcionario_id, :integer
  end
end
