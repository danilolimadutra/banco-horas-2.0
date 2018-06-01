// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


function getDataDesvio() {
  var stringData = $('#horario_data').val();
  var ano = parseInt(stringData.substring(0, 4));
  var mes = parseInt(stringData.substring(5, 7)) - 1;
  var dia = parseInt(stringData.substring(8, 10));

  return new Date(ano, mes, dia);
}

function validateTipo() {
var radios = document.getElementsByName("horario[hora_extra]");
var formValid = false;

  var i = 0;
  while (!formValid && i < radios.length) {
    if (radios[i].checked) formValid = true;
    i++;
  }

  if (!formValid) alert('Obrigatório informar tipo da hora.', 'i');
  return false;
}

function validarForm() {

  validateTipo();

  if ($('#horario_data').val() == '') {
    alert('Obrigatório informar a data.', 'i');
    return false;
  }

  if (getDataDesvio() > new Date()) {
    alert('A data não pode ser futura.', 'i');
    return false;
  }

  if ($('#horario_inicio').val() == '') {
    alert('Obrigatório informar horário de início.', 'i');
    return false;
  }

  if ($('#horario_fim').val() == '') {
    alert('Obrigatório informar horário de fim.', 'i');
    return false;
  }

  if ($('#horario_fim').val() <= $('#horario_inicio').val()) {
    alert('Horário de fim deve ser maior que horário de início.', 'i');
    return false;
  }

  if ($('#horario_motivo').val() == '') {
    alert('Obrigatório informar o motivo.', 'i');
    return false;
  }

  return true;
}
