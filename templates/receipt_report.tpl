<apply template="base">
    <apply template = "nav_bar"/>
    <apply template = "header"/>
    <h3>Receipt Report</h3>
 <div class="row">
   <div class="col-sm-4"></div>
   <div class="col-sm-4">
    <form method="post" action="receiptReport">
    <div class="input-group">
       <input type="text" name = "tenant" class="form-control" placeholder="Tenant"
        value = ${tenantSplice} list = "tenant_autocomplete" autocomplete = "off" >
        <autocompleteList/>
       <div class="input-group-btn">
        <button class="btn btn-default" type="submit" >
        <i class="fas fa-search"></i>
        </button>
       </div>
    </div>
    </form>
   </div>
   <div class="col-sm-4"></div>
 </div> 
    <bootStrapWarning/>
    <tableSplice/>
    <apply template = "footer"/>
<script>
//this function will be used in the tablesplice
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
    window.alert("Sorry, not implemented.." + jsonArray);
    var xhttp = new XMLHttpRequest(); 
//    xhttp.open("POST", "print", true);
    xhttp.open("POST", "/test", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send(jsonArray);
}
function getRow(i,rows){
    if (rows[i].childNodes[7].firstChild.checked){
        return rows[i].childNodes[0].innerHTML;
    }else{
        return "";
    }
}
</script>
</apply>
