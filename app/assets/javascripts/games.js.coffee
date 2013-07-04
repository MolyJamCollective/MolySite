# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.best_in_place').best_in_place()
  $('#new_screenshot').fileupload
    dataType: "script"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-screenshots", data.files[0]))
      $('#new_screenshot').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
  $('#edit_game').fileupload
    dataType: "script"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-files", data.files[0]))
      $('#edit_game').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')