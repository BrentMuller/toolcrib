<apply template="base">
    <apply template = "nav_bar"/>
    <apply template = "header"/>
    <h2>Print</h2>
  <div class="row">
   <div class="col-sm-4"></div>
   <div class="col-sm-4">

    <form method="post" action="print" >
    <div class="input-group">
    <!--
        <input type="submit" class="btn btn-info" value="Print" 
               onclick = "acceptChecked()" style= "margin: 30px">
               -->
        <input type="submit" class="btn btn-info" value="Print" 
                style= "margin: 30px">
    </div>
    </form>
 </div> 
   <div class="col-sm-4"></div>
 </div> 
    <tableSplice/>
    <p id = "output"></p>
    <apply template = "footer"/>
<script>
/*
function acceptChecked() {
    var rows = document.getElementsByTagName("tr");
    var i=1;
    var nodeVals = new Array()
    while(i<rows.length){
        var receiptNo = getRow(i,rows);
        if (receiptNo !== ""){
            nodeVals.push(Number(receiptNo));
        } 
       ++i;
    }
    jsonArray=JSON.stringify(nodeVals);
    var xhttp = new XMLHttpRequest(); 
    xhttp.open("POST", "print", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send(jsonArray);
}
function getRow(i,rows){
    if (rows[i].childNodes[5].firstChild.checked){
        return rows[i].childNodes[0].innerHTML;
    }else{
        return "";
    }
}
*/
</script>
</apply>
