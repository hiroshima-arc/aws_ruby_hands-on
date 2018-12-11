import $ from 'jquery'

$(() => {
  $("#menu-hello").click(() => {
    $("#sub-menu-hello").css("display", "block");
  });

  $("#sub-menu-hello-1").click(() => {
    $("#art-1").css("display", "block");
    $("#art-2").css("display", "none");
  });

  $("#sub-menu-hello-2").click(() => {
    $("#art-1").css("display", "none");
    $("#art-2").css("display", "block");
  });
});