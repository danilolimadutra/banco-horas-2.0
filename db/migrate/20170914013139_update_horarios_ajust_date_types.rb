class UpdateHorariosAjustDateTypes < ActiveRecord::Migration[5.0]
  def change
    remove_column :horarios, :data
    add_column :horarios, :data, :date
  end
end
