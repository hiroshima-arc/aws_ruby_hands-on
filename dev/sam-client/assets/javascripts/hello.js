import {getApiUrl} from './utilles'
import $ from 'jquery'

$(() => {
  $("#hello_button").click((e) => {
    e.preventDefault();
    $("#message_ajax").html("Now loading...");

    $.ajax({
      url: getApiUrl('hello'),
      type: "GET",
      success: function (callback) {
      },
      error: function () {
        alert("Error to save data");
      }
    })
      .done(function (json) {
        $("#message_ajax").html(json['message']);
      });
  })
});
