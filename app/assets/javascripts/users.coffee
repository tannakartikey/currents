# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".new_user").validate
    debug: true
    rules:
      new_user_licence:
        required:
          depends: () ->
            $('#user_subscription_tier').val().toLowerCase() == "commercial"
      password:
        minlength: 6
      confirm_password:
        minlength: 6
    messages:
      password:
        minlength: "At least 6 chars are required"
        equalTo: "#user_password"

  showLicenceUpload = (value) ->
    if(value.toLowerCase() == "commercial")
      $('.licence').css("display", "block")
    else
      $('.licence').css("display", "none")

  $("#user_subscription_tier").on('change', ->
    showLicenceUpload(this.value)
  )
