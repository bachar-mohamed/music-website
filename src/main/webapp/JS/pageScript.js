"use strict";

const musicContainer = document.querySelector("ul");
let parent;
let target;
let image;
const status = document.getElementById("query-status");
const errorMsg = document.querySelector(".error-msg");


console.log(status);
if(status.value=="false"){
errorMsg.classList.remove("hidden-li");
}else{
errorMsg.classList.add("hidden-li");
}

musicContainer.addEventListener("mouseover", (e) => {
  parent = e.target.closest("li");
  if (parent === null) return;
  target = parent.querySelector(".play_btn")??parent.querySelector(".more_btn");
  console.log(target);
  image = parent.querySelector(".img_container");
  image.classList.add("zoomIn");
  target.classList.remove("hidden");
  parent.classList.add("highlighted");
});

musicContainer.addEventListener("mouseout", () => {
  if (parent === null && target === null) return;
  target.classList.add("hidden");
  parent.classList.remove("highlighted");
  image.classList.remove("zoomIn");
});


