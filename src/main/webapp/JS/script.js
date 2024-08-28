"use strict";

const overlay = document.querySelector(".overlay");
const closeBtn = document.querySelectorAll(".close_tab");
const menu = document.querySelector(".menu");
let model;

menu.addEventListener("click", (e) => {
  const trigger = e.target.closest(".main_btn");
  if (trigger === null) return;
  model = document.querySelector(`${trigger.dataset.model}`);
  overlay.classList.remove("inactive");
  model.classList.remove("inactive");
});

menu.addEventListener("mouseover", (e) => {
  const target = e.target.closest(".main_btn");
  if (target == null) return;
  target.classList.add("highlighted");
});

menu.addEventListener("mouseout", (e) => {
  const target = e.target.closest(".main_btn");
  if (target == null) return;
  target.classList.remove("highlighted");
});

closeBtn.forEach((btn) =>
  btn.addEventListener("click", (e) => {
    overlay.classList.add("inactive");
    model.classList.add("inactive");
  })
);
