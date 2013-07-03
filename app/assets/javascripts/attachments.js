/*
 * attachments.js
 *
 * Attachment widget code to improve uploading assets to S3 and attaching them
 * to prettymuch any model
 */
 var userFileUploadedFn = function(fileObj) {
   console.log("No File handler for file attachment", fileObj);
 };

 var attachmentsContainer = null;
 var userFileAttachedFn = function(fileObj) {
   if(attachmentsContainer) {
     $('#attachment_popup').html('').hide();

     attachmentsContainer.html('reloading...');
     $.get('/attachments/reload/'+fileObj.attachment_id, function(response){
      attachmentsContainer.html(response);
      attachmentsContainer = null;
     });

   } else {
     console.log("No attachment focused");
   }
 };




var FILEUPLOAD_CONFIG = {
   add: function(e, data) {
     var file = data.files[0];
     data.context = $(tmpl("template-upload", file));
     $('#files').prepend(data.context);
     return data.submit();
   },
   progress: function(e, data) {
     var progress;

     if (data.context) {
       progress = parseInt(data.loaded / data.total * 100, 10);
       return data.context.find('.bar').css('width', progress + '%');
     }
   },
   done: function(e, data) {
     var content, domain, file, path, to;

     file = data.files[0];
     domain = $('#fileupload').attr('action');
     path = $('#fileupload input[name=key]').val().replace('${filename}', file.name);
     to = $('#fileupload').data('post');
     content = {};
     content['full_path'] = domain + path;
     content['file_size'] = file.size;
     content['file_name'] = file.name;
     $.post(to, content, userFileUploadedFn, 'json');
     if (data.context) {
       return data.context.remove();
     }
   },
   fail: function(e, data) {
     alert("" + data.files[0].name + " failed to upload.");
     console.log("Upload failed:");
     return console.log(data);
   }
};
$('#fileupload').fileupload(FILEUPLOAD_CONFIG);

$("a.attachment_link").on('click', function(event) {
  //Don't follow the link, pop it up
  event.preventDefault();

  var url = $(this).attr('href');

  //Set file upload action, to attachment
  userFileUploadedFn = userFileAttachedFn;

  attachmentsContainer = $(this).parent();
  $.get(url, function(response){

    $attachmentPopup = $('#attachment_popup');
    if($attachmentPopup.length == 0) {
      //No popup exists yet, create one
      $('body').append('<div id="attachment_popup"></div>');
      $attachmentPopup = $('#attachment_popup');
    }

    $attachmentPopup.html(response).show();

    $('#fileupload').fileupload(FILEUPLOAD_CONFIG);
    $("#link_attachment_form").bind("ajax:success", function(xhr, data, status) {
      userFileAttachedFn(data);
    });
  });



  return false;
});
