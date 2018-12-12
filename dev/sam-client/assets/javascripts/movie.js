import {getApiUrl} from './utilles'
import $ from 'jquery'

$(() => {
  function getParams() {
    var title = $("#movie-component__art-1__input__title").val();
    var year = $("#movie-component__art-1__input__year").val();
    var plot = $("#movie-component__art-1__input__info-plot").val();
    var rating = $("#movie-component__art-1__select__info-rating").val();

    return {title, year, plot, rating};
  }

  function validateInputParams() {
    var {title, year, plot, rating} = getParams();

    if (validate(title, year, plot, rating) === false) {
      $("#movie-component__art-1__message").html('未入力の項目が存在します。');
      return false;
    } else {
      return true;
    }
  }

  function validate(title, year, plot, rating) {
    $("#movie-component__art-1__input__title").css('background-color', '');
    $("#movie-component__art-1__input__year").css('background-color', '');
    $("#movie-component__art-1__input__info-plot").css('background-color', '');
    $("#movie-component__art-1__select__info-rating").css('background-color', '');

    var chek = true;
    if (title === "") {
      $("#movie-component__art-1__input__title").css('background-color', 'red');
      chek = false;
    }

    if (year === "") {
      $("#movie-component__art-1__input__year").css('background-color', 'red');
      chek = false;
    }

    if (plot === "") {
      $("#movie-component__art-1__input__info-plot").css('background-color', 'red');
      chek = false;
    }

    if (rating === "") {
      $("#movie-component__art-1__select__info-rating").css('background-color', 'red');
      chek = false;
    }
    return chek;
  }

  $("#movie-component__art-1__button--form").click((e) => {
    validateInputParams();
  });

  $("#movie-component__art-1__button").click((e) => {
    e.preventDefault();
    $("#movie-component__art-1__message").html("Now processing...");

    if (validateInputParams() === false) {
      return
    } else {
      var {title, year, plot, rating} = getParams();
    }

    $.ajax({
      url:  getApiUrl('movie/new'),
      type: "POST",
      data: {
        title: title,
        year: year,
        info: {
          plot: plot,
          rating: rating
        }
      },
      dataType: 'json',
      success: function (json) {
        $("#movie-component__art-1__message").html(json['message']);
      },
      error: function (json) {
        alert("Error to save data" + JSON.stringify(json));
        $("#movie-component__art-1__message").html(json['statusText']);
      }
    })
  })
});