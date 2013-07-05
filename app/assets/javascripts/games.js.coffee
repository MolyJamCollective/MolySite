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

  $('#new_windows_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-files", data.files[0]))
      $('#windows-file').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#windows-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})

  $('#new_mac_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-files", data.files[0]))
      $('#mac-file').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#mac-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})

  $('#new_linux_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-files", data.files[0]))
      $('#linux-file').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
     done: (e, data) ->
      $.post($('#linux-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})