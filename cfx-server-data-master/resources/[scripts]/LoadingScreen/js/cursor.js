document.body.addEventListener("mousemove", function (event) {
  var x = event.pageX
  var y = event.pageY
  document.getElementById("cursor").style.left = x;
  document.getElementById("cursor").style.top = y;
})
