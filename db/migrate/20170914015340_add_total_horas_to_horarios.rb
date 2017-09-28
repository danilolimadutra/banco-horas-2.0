class AddTotalHorasToHorarios < ActiveRecord::Migration[5.0]
  def change
    add_column :horarios, :total_horas, :float
    add_column :horarios, :fator_hora, :float
    add_column :horarios, :status, :boolean
  end
end
