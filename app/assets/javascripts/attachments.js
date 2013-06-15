/*
 * attachments.js
 *
 * Attachment widget code to improve uploading assets to S3 and attaching them
 * to prettymuch any model
 */

$("a.attachment_link").on('click', function(event) {
  //Don't follow the link, pop it up
  event.preventDefault();

  var url = $(this).attr('href');

  //Pretty ugly and old-school but it's easier not to mess with the carrierwave form for now
  window.open(url);

  return false;
});
