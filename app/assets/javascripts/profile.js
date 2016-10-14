'use strict';

var targets_array = [];
var index = 0;

//Document ready function
$(function () {
  if (window.location.pathname === '/users/categorize') {
    $.get('/users/categorize.json').then(function (response) {
      targets_array = response;
      if(targets_array.length > 0){
        get_ticket_by_id();
      }
    });
  }
});


function get_ticket_by_id() {
  $.get('/users/get_ticket_by_id/' + targets_array[index]).then(function (response) {
    if ($('div.row.ticket .user-ticket').length > 0) {
      $('div.row.ticket .user-ticket').replaceWith(response);
    }
    else {
      $('div.row.ticket').append(response);
    }
    $('.col-ticket .counter-email').replaceWith(['<span>', 'Email ', (index+1), '/</span><span>', targets_array.length, '</span>'].join(''))
    if(targets_array.length == 1){
      $(".user-ticket input[type='submit']").val('Show Reports');
    }
  })
}

function getTickets() {
  $.get('/users/get_tickets');
}

function reciveEmail(type) {
  if (type === 'categorize') {
    $.post('/users/recive_category');
  }
  else if (type === 'report') {
    $.post('/users/recive_report');
  }
}
