<apply template="base">
<!--    <apply template = "nav_bar"/>
-->
    <apply template = "header"/>
    <tableSplice/>
    <bootStrapWarning/>
    <apply template = "footer"/>
</apply>
<script>

function buttonClick(arg){
    var xhttp;  
    xhttp = new XMLHttpRequest();
    // Track the state changes of the request.
    xhttp.onreadystatechange = function () {
        var DONE = 4; // readyState 4 means the request is done.
        var OK = 200; // status 200 is a successful return.
        if (xhttp.readyState === DONE) {
            if (xhttp.status === OK) {
                console.log(xhttp.responseText); // 'This is the output.'
                document.getElementsByClassName("container")[0].innerHTML=xhttp.responseText; 
            } else {
                console.log('Error: ' + xhttp.status); // An error occurred during the request.
            }
        }
    };

    xhttp.open("POST", "splice_tab", true);
    xhttp.send(arg);
//  window.alert("arg was: " + arg)
}


function buttonCopy(copyText){
    var text = copyText;
    text.select;
    document.execCommand("copy");
    window.alert("arg was: " + copyText);
}
// document.querySelector("#buttonCopy").addEventListener("click", copy);
</script>
