function initialize_greeting() {
  var today = new Date();
  var hourNow = today.getHours();
  var greeting;

  if (hourNow > 18) {
    greeting = 'Pleasant evening!';
  } else if (hourNow > 12) {
    greeting = 'Good afternoon!';
  } else if (hourNow > 0) {
    greeting = 'Jolly good morning!';
  } else {
    greeting = 'Welcome';
  }

  var welcome_user = document.getElementById("welcome_user_script");
  
  if (welcome_user) {
    welcome_user.innerHTML='<h3>' + greeting + '</h3>'; 
  }
}

$(document).ready(initialize_greeting);
$(document).on('page:load', initialize_greeting);