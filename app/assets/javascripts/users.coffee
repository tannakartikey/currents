# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".new_user").validate
    debug: true
    rules:
      "user[licence]":
        required:
          depends: () ->
            if($('#user_subscription_tier').val().toLowerCase() == "commercial")
              true
            else
              console.log('false matched')
              $("#user_licence").rules('remove', 'required')
      "user[password]":
        minlength: 6
      "user[password_confirmation]":
        minlength: 6
        #equalTo: "user[password]"
    messages:
      "user[password]":
        minlength: "At least 6 chars are required"
      "user[password_confirmation]":
        equalTo: "Password and confirm password should be the same."

  showLicenceUpload = (value) ->
    if(value.toLowerCase() == "commercial")
      $('.licence').css("display", "block")
    else
      $('.licence').css("display", "none")

  $("#user_subscription_tier").on('change', ->
    showLicenceUpload(this.value)
  )
