// This can be placed anywhere in the parent application's javascript
// load path. It must be loaded after jQuery. Also verify the version
// of jQuery that your using as the ajaxComplete function may have been
// renamed.

$(document).ajaxComplete(function(event, request) {
  var flash = $.parseJSON(request.getResponseHeader('X-Flash-Messages'));
  if (!flash) return;
  if (flash.notice) $('.notice').html(flash.notice);
  if (flash.error) alert(flash.error);
}
