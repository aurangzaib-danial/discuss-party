//= require jquery
//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap
//= require bs_custom_file_input.min
//= require_tree .



$(document).ready(function() {
  $(".alert-success" ).fadeOut(3000);
});

$(function(){
  $(document).on("turbolinks:load", function(){
    bsCustomFileInput.init();
  });
});
