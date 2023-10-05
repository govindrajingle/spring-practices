<!DOCTYPE html>
<html>
<head>
<title>Live Clock</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background-color: cream;
	text-align: center;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
	transition: background-color 0.5s, color 0.5s;
}

#clock {
	font-family: 'Gabarito', sans-serif;
	font-size: 10vw;
	/* Adjust the font size to occupy 80% of the screen width */
	color: black;
	border-radius: 10px;
	padding: 10px;
	background-color: white;
	width: 80%; /* Make the clock occupy 80% of the screen width */
	box-sizing: border-box;
	transition: background-color 0.5s;
}

#darkModeButton {
	width: 100%;
	padding: 10px;
	border: none;
	font-size: 16px;
	font-weight: bold;
	color: white;
	background-color: black; /* Dark creamy background */
	transition: background-color 0.5s, color 0.5s;
}

#darkModeButton:hover {
	background-color: wheat; /* Change hover color to wheat */
}

body.dark-mode {
	background-color: black;
	color: white;
}

body.dark-mode #clock {
	background-color: black;
	color: yellow; /* Change text color to yellow in dark mode */
}

body.dark-mode #darkModeButton {
	color: black; /* Change button text color in dark mode */
	background-color: white;
	/* Change button background color in dark mode */
}

body.dark-mode #darkModeButton:hover {
	background-color: wheat; /* Change hover color to wheat in dark mode */
}
</style>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Gabarito">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
  <div id="darkModeContainer">
    <button id="darkModeButton" onclick="toggleDarkMode()">Dark Mode</button>
  </div>
  <div id="clock"></div>
  <script>
    var darkMode = false;

    function toggleDarkMode() {
      darkMode = !darkMode;
      updateTheme();
    }

    function updateTheme() {
      document.body.classList.toggle('dark-mode', darkMode);
      // Update button text based on the mode
      document.getElementById('darkModeButton').innerText = darkMode ? 'Light Mode' : 'Dark Mode';
    }

    // JavaScript code to update the clock
    function updateClock() {
      var now = new Date();
      var daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
      var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      
      var dayOfWeek = daysOfWeek[now.getDay()];
      var month = months[now.getMonth()];
      var day = now.getDate();
      var year = now.getFullYear();

      var formattedTime = now.toLocaleTimeString([], {
        hour : '2-digit',
        minute : '2-digit',
        second : '2-digit'
      });

      var formattedDate = dayOfWeek + ', ' + month + ' ' + day + ', ' + year;
      var finalFormattedTime = formattedDate + ' ' + formattedTime;
      
      document.getElementById("clock").innerText = finalFormattedTime;
    }
    // Update the clock every second
    setInterval(updateClock, 1000);
    // Initial update
    updateClock();
  </script>
</body>
</html>
