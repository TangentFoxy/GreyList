function check(id) {
  $("#id" + String(id)).addClass("strike")
  $.post(location.origin + "/command", { check: id })
    .fail(function() {
      $("#id" + String(id).removeClass("strike"))
    })
}

function uncheck(id) {
  $("#id" + String(id)).removeClass("strike")
  $.post(location.origin + "/command", { uncheck: id })
    .fail(function() {
      $("#id" + String(id)).addClass("strike")
    })
}

function new_item() {
  event.preventDefault()
  console.log($("#new_item").serialize())
}
