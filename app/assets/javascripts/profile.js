'use strict';

var targets_array = [];
var index = 0;

//Document ready function
$(function () {
  $.get('/users/profile.json').then(function (response) {
    targets_array = response;
    get_ticket_by_id();
  });
});


function get_ticket_by_id() {
  $.get('/users/get_ticket_by_id/' + targets_array[index]).then(function (response) {
    if ($('div.row.ticket .col-lg-6.col-md-6.col-ticket').length > 0) {
      $('div.row.ticket .col-lg-6.col-md-6.col-ticket').replaceWith(response);
    }
    else {
      $('div.row.ticket').append(response);
    }
  })
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
  if (index <= 0) {
    index = targets_array.length-1;
  }
  get_ticket_by_id();
}