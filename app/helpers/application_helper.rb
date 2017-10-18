module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
  
  def float_para_hora_old hora_decimal
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
    
  def float_para_hora hora_decimal
    hora_decimal = hora_decimal*60*60
    mm, ss = hora_decimal.round.divmod(60)
    hh, mm = mm.divmod(60)
    hora = "%d:%d" % [hh, mm]
    
    return hora
  end
  
  def float_para_dia_hora hora_decimal
    hora_decimal = hora_decimal*60*60
    mm, ss = hora_decimal.round.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(9)
    hora = "%d:%d" % [hh, mm]
    
    dias = "%d" % [dd]
    if dias.to_i > 0
      dias = "%d dias, " % [dd]
      hora = dias+hora
    end
    
    return hora
  end
end
