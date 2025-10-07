function checkForm() {
    var name = document.getElementById("name1").value;
    var age = document.getElementById("age1").value;
    var email = document.getElementById("email1").value;
    var password = document.getElementById("password1").value;

    if (name === '' || age === '' || email === '' || password === '') {
        alert("Fill All Fields");
    } else {
        var nameMsg = document.getElementById("name").innerHTML;
        var ageMsg = document.getElementById("age").innerHTML;
        var emailMsg = document.getElementById("email").innerHTML;
        var passwordMsg = document.getElementById("password").innerHTML;

        if (nameMsg.includes("Must") || ageMsg.includes("Invalid") || emailMsg.includes("Invalid") || passwordMsg.includes("short")) {
            alert("Please fix validation errors before submitting.");
        } else {
            alert(" Registration form validated successfully!");
            document.getElementById("registerForm").reset();
        }
    }
}

function validate(field, query) {
    var xmlhttp;
    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
    } else {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState != 4 && xmlhttp.status == 200) {
            document.getElementById(field).innerHTML = "Validating...";
        } else if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById(field).innerHTML = xmlhttp.responseText;
        }
    };

    xmlhttp.open("GET", "http://localhost/FoodDelivery/validation.php?field=" + field + "&query=" + query, true);
    xmlhttp.send();
}
