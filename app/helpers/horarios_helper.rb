module HorariosHelper

  def dia_semana dia
    if dia == 0
      semana = 'Dom'
    elsif dia == 1
      semana = 'Seg'
    elsif dia == 2
      semana = 'Ter'
    elsif dia == 3
      semana = 'Qua'
    elsif dia == 4
      semana = 'Qui'
    elsif dia == 5
      semana = 'Sex'
    else
      semana = 'Sab'
    end
    return semana
  end

end
