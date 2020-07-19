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

      setTimeout(function(){ $(selected).html('Link') }, 3000);
  })
}

function commentFormValidation() {
  $('#commentForm').on('submit', function(e){
    const field = $('#comment_content_trix_input_comment').val()
    const button = $('#commentForm input[type="submit"]')
    if(field == "") {
      e.preventDefault()
      $('trix-editor').addClass('invalid-comment')
    } else {
      button.prop('disabled', true)
    }
  })
}

$(document).ready(function() {
  $(".alert-success").fadeOut(6000)
  bsCustomFileInput.init()
  copyScript()
  commentFormValidation()
})

$(function(){
  $(document).on("turbolinks:load", function(){
    bsCustomFileInput.init()
    copyScript()
    commentFormValidation()
  })
})
