class AddHoraValidaToHorarios < ActiveRecord::Migration[5.0]
  def change
    add_column :horarios, :hora_valida, :boolean
  end
end
