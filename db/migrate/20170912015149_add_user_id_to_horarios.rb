class AddUserIdToHorarios < ActiveRecord::Migration[5.0]
  def change
    add_column :horarios, :user_id, :integer
    add_column :horarios, :funcionario_id, :integer
    add_column :horarios, :motivo, :text
  end
end
