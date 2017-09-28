class AddUserIdToFuncionarios < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :funcionario_id
    add_column :funcionarios, :user_id, :integer
  end
end
