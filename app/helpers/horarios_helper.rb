module HorariosHelper
  def float_para_hora hora_decimal
      fracao_hora = hora_decimal.to_i
      decimal_minuto = hora_decimal - fracao_hora
      
      fracao_minuto = decimal_minuto * 60
      
      hora = fracao_hora.to_s
      if hora.length == 1
        hora = "0"+hora
      end
      
      minuto = fracao_minuto.to_i.to_s
      if minuto.length == 1
        minuto = "0"+minuto
      end
      
      hora_completa = hora+":"+minuto
      
      return hora_completa
    end
end
