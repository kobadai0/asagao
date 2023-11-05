$(document).on('turbolinks:load', function() {
  var cb = $("#article_no_expiration");
  var field = $("#article_expired_at");

  var changeExpiredAt = function() {
    if (cb.prop("checked"))
      field.hide()
    else
      field.show()
  }

  cb.on("click", changeExpiredAt);

  changeExpiredAt();
});