document.getElementById("toggleVisibilityButton").addEventListener("click", function(button) {
    if (document.getElementById("displaytable2").style.display === "block")
        document.getElementById("displaytable2").style.display = "none";
    document.getElementById("displaytable").style.display = "block";
});

document.getElementById("toggleVisibilityButton2").addEventListener("click", function(button) {
    if (document.getElementById("displaytable").style.display === "block")
        document.getElementById("displaytable").style.display = "none";
    document.getElementById("displaytable2").style.display = "block";
});