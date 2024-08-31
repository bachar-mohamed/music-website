const deleteBtn = document.querySelector(".delete_btn");
const updateBtn = document.querySelector(".update_btn");
const overlay = document.querySelector(".overlay");
const removeWindow = document.querySelector("div[class^='div_remove--']");
const updateWindow = document.querySelector("div[class^='div_update--']");
const closeBtn = document.querySelectorAll(".close_btn");
const updateSongBtn = document.querySelector(".update-btn");
//song_preview.jsp

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

/*updateSongBtn.addEventListener("click",(e)=>{
    e.preventDefault();
    const songUrl =document.querySelector("#song_url");
    console.log(songUrl);
    const songIdRetriever = getId(songUrl.value);
    if(songIdRetriever==null){
    songUrl.style.border="2px,solid,red";
    alert("invalid youtube url");
    }else{
    const formIdentifier = document.querySelector("#identifier");
    const songId = document.querySelector("#songId");
    const userId= document.querySelector("#userId");
    const songTitle = document.querySelector("#song_title");
    const album = document.querySelector("#album_id");
    const description = document.querySelector("#song_description");
    const date = document.querySelector("#release_date");
    const language = document.querySelector("#language");
    const songUrl = document.querySelector("#song_url");
    const link = `/JSP/song_preview.jsp?${formIdentifier.getAttribute("name")}=${formIdentifier.value}&${songId.getAttribute("name")}=${songId.value}&${userId.getAttribute("name")}=${userId.value}&${album.getAttribute("name")}=${album.value}&${songTitle.getAttribute("name")}=${songTitle.value}&${description.getAttribute("name")}=${description.value}&${date.getAttribute("name")}=${date.value}&${language.getAttribute("name")}=${language.value}&${songUrl.getAttribute("name")}=${songIdRetriever}`;
    window.location.href =link;
    }

})*/

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
