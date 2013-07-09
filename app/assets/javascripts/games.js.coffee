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
      $('#browser_urls').hide()
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    stop: (e, data) ->
      $('#upload').hide

  $('#new_windows_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-windows-files", data.files[0]))
      $('#windows-file').append(data.context)
      $('#new_windows_file_uploader').hide()
      $('#browser_urls').hide()
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#windows-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})
      $('#windows-file').append("File Uploaded")
    stop: (e, data) ->
      $('#upload-windows').hide()

  $('#new_mac_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-mac-files", data.files[0]))
      $('#mac-file').append(data.context)
      $('#new_mac_file_uploader').hide()
      $('#browser_urls').hide()
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#mac-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})
      $('#mac-file').append("File Uploaded")
    stop: (e, data) ->
      $('#upload-mac').hide()

  $('#new_linux_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-linux-files", data.files[0]))
      $('#linux-file').append(data.context)
      $('#new_linux_file_uploader').hide()
      $('#browser_urls').hide()
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#linux-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})
      $('#linux-file').append("File Uploaded")
    stop: (e, data) ->
      $('#upload-linux').hide()

  $('#new_traditional_file_uploader').fileupload
    dataType: "xml"
    add: (e, data) ->
      data.context = $(tmpl("template-upload-traditional-files", data.files[0]))
      $('#traditional-file').append(data.context)
      $('#new_traditional_file_uploader').hide()
      $('#browser_urls').hide()
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $.post($('#traditional-file').data('url'), {key: data.jqXHR.responseXML.getElementsByTagName("Key")[0].childNodes[0].nodeValue})
      $('#traditional-file').append("File Uploaded")
    stop: (e, data) ->
      $('#upload-traditional').hide()