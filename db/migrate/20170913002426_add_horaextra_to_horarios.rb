class AddHoraextraToHorarios < ActiveRecord::Migration[5.0]
  def change
    add_column :horarios, :hora_extra, :boolean
  end
end
