// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("trix")
require("@rails/actiontext")
import("bootstrap")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


function copyScript() {
  $('#copy button').click(function() {
      $(this).html('Copied!')

      const temp = $("<input>")

      $("body").append(temp)

      temp.val($(this).val()).select()

      document.execCommand("copy")
      
      temp.remove()
      
      const selected = this

      setTimeout(function(){ $(selected).html('Copy link') }, 3000);
  })
}

$(document).ready(function() {
  $(".alert-success" ).fadeOut(3000);
  bsCustomFileInput.init()
  copyScript()
});

$(function(){
  $(document).on("turbolinks:load", function(){
    bsCustomFileInput.init()
    copyScript()
  })
})

