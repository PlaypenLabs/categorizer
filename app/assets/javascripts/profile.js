'use strict';

var targets_array = [];
var index = 0;

//Document ready function
$(function () {
  if (window.location.pathname === '/users/profile') {
    $.get('/users/profile.json').then(function (response) {
      targets_array = response;
      get_ticket_by_id();
    });
  }
});


function get_ticket_by_id() {
  $.get('/users/get_ticket_by_id/' + targets_array[index]).then(function (response) {
    if ($('div.row.ticket .user-ticket').length > 0) {
      $('div.row.ticket .user-ticket').replaceWith(response);
      $('.col-ticket .counter-email').replaceWith('<span>'+ (index+1) + '/</span><span>' + targets_array.length + '</span>')
    }
    else {
      $('div.row.ticket').append(response);
      $('.col-ticket .counter-email').append('<span>'+ (index+1) + '/</span><span>' + targets_array.length + '</span>')
    }
  })
}

function getTickets() {
  $.get('/users/get_tickets');
}

function next() {
  index++;
  if (index >= targets_array.length) {
    index = 0;
  }
  get_ticket_by_id();
}

function prev() {
  index--;
  if (index <= -1) {
    index = targets_array.length - 1;
  }
  get_ticket_by_id();
}