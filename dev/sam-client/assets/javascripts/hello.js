import { getApiUrl } from './utilles'

import $ from 'jquery'
$(function () {
  $("#hello_button").click(function (e) {
    e.preventDefault();
    $("#message").html("Now loading...");

    $.ajax({
      url: getApiUrl('hello'),
      type: "GET",
      success : function(callback){
      },
      error : function(){
        alert("Error to save data");
      }
    })
      .done(function(json) {
        $("#message").html(json['message']);
      });
  })
});
