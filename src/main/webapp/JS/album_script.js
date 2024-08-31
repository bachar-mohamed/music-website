const deleteBtn = document.querySelector(".delete_btn");
const updateBtn = document.querySelector(".update_btn");
const overlay = document.querySelector(".overlay");
const removeWindow = document.querySelector("div[class^='div_remove--']");
const updateWindow = document.querySelector("div[class^='div_update--']");
const closeBtn = document.querySelectorAll(".close_btn");

console.log(deleteBtn);
console.log(overlay);
console.log(removeWindow);
console.log(updateWindow);
console.log(closeBtn);

function getId(url) {
  if(url==""){
  return ""
  }
  const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
  const match = url.match(regExp);
  return match && match[2].length === 11 ? match[2] : null;
}

deleteBtn.addEventListener("click", (e) => {
  overlay.classList.remove("hidden");
  removeWindow.classList.remove("hidden");
});

updateBtn.addEventListener("click", (e) => {
  overlay.classList.remove("hidden");
  updateWindow.classList.remove("hidden");
});

closeBtn.forEach((btn) => {
  btn.addEventListener("click", (e) => {
    overlay.classList.add("hidden");
    removeWindow.classList.add("hidden");
    updateWindow.classList.add("hidden");
  });
});
