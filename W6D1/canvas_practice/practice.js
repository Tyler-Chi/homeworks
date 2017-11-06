document.addEventListener("DOMContentLoaded", function(){
  const theCanvas = document.getElementById("mycanvas");
  theCanvas.width = 500;
  theCanvas.height = 500;

  const ctx = theCanvas.getContext("2d");

  ctx.fillStyle = 'red';
  ctx.fillRect(0,0,500,500);

  ctx.beginPath();
  ctx.arc(100,100,20,0,2*Math.PI,true);
  ctx.strokeStyle = "green";
  ctx.lineWidth = 5;
  ctx.stroke();
  ctx.fillStyle = "blue";
  ctx.fill();

  ctx.clearRect();

});
