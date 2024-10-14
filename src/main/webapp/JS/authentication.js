"use strict";

const parent = document.querySelector(".main");
const header = document.querySelector("h1");
const formContainer = document.querySelectorAll(".container");
const loginForm = document.querySelector("#login-form");
const signupForm = document.querySelector("#signUp-form");
const anchors = document.querySelectorAll("span");

console.log(loginForm);
console.log(signupForm);


anchors.forEach((anchor) => {
  anchor.addEventListener("click", (e) => {
    const targetClass = e.target.dataset.type;
    formContainer.forEach((container) => {
      if (container.classList.contains(targetClass)) {
        container.classList.remove("hidden");
        header.textContent="User Login"
      } else {
        container.classList.add("hidden");
        header.textContent="User Signup"
      }
    });
  });
});


const loginHandler=function(email,password){
 const request = new XMLHttpRequest();
  request.open("GET",`json_login.jsp?email=${email.value}&password=${password.value}`);
  request.responseType = 'json';
    request.send();
    request.addEventListener("load", function (e) {
    console.log(request);
    const result=request.response.code;
       if(result==200){
       const id = request.response.userId;
       const link = `/JSP/main.jsp?id=${id}`
         window.location.href =link;
      } else {
        alert("login is wrong");
      }
    });
}

const signUpHandler = function(userName,email,password){
 const request = new XMLHttpRequest();
  request.open("GET",`json_signup.jsp?username=${userName.value}&email=${email.value}&password=${password.value}`);
  request.responseType = 'json';
    request.send();
    request.addEventListener("load", function (e) {
    console.log(request);
    const result=request.response.code;
    const message = request.response.message;
       if(result==200){
        alert(message);
      } else {
        alert(message);
      }
    });
}


const emptyFieldsChecker = function(fields){
 let empty=false;
  fields.forEach(field=>{
  if(field.value===""){
  field.style.border="2px solid red"
  empty=true;
  }})
 return empty;
  }

 loginForm.addEventListener("submit", (e) => {
  e.preventDefault();
  let userMail;
  let userPassword;
  const inputFields = loginForm.querySelectorAll("input");
   if(!emptyFieldsChecker(inputFields)){
     userMail = loginForm.querySelector("#email");
     userPassword = loginForm.querySelector("#password");
     loginHandler(userMail,userPassword);
  }
  })


 signupForm.addEventListener("submit",(e)=>{
 e.preventDefault();
 console.log(`sign up submitted`);
 const inputFields = signupForm.querySelectorAll("input");
  if(!emptyFieldsChecker(inputFields)){
   const userName = signupForm.querySelector("#userName");
   const userMail = signupForm.querySelector("#userEmail");
   const userPassword = signupForm.querySelector("#userPassword");
   const confirmPassword = signupForm.querySelector("#confirmPassword");
   if(userPassword.value!==confirmPassword.value){
    userPassword.style.border="2px solid red";
    confirmPassword.style.border="2px solid red";
    alert("password and confirm password fields not not match!")
   }
   signUpHandler(userName,userMail,userPassword);
   console.log(`${userMail.value},${userPassword.value},${confirmPassword.value},${userName.value}`);
  }
});



