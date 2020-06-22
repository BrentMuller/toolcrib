
<div class = "row">
  <div class="col-sm-4"></div>
  <div class="col-sm-4">
    <h4>Enter Receipt</h4>
    <div class="form-group">
        <form method="post" action="receipt">
          <table id="receipt_entry">
            <tr>
            <div class="dropdown">
              <td>tenant:</td><td><input id = "autocomplete" type="text" 
                    name="tenant" size="20" required autocomplete = "off"
                    list = "tenant_autocomplete" class="form-control" 
                    oninput = "amtFunc(value,${keySplice})" /></td>
            </div>
                    <autocompleteList/>
            </tr>
            <tr>
              <td>amount:</td><td><input type="text" name="amount" class="form-control" 
                 size="20" required id = "amountField"
                 pattern = "[0-9]*\.\d{0,2}"/></td>
            </tr>
            <tr>
             <td>date:</td><td><input type="text" name="date" size="20" 
            id = "dateField" required class="form-control"/></td>
            </tr>
            <tr>
              <td>memo:</td><td><input type="text" name="memo" size="30" 
                class="form-control" /></td>
            </tr>
            <tr>
              <td>from:</td><td><input type="text" name="from" size="30" 
                class="form-control" id="fromField"/></td>
            </tr>
            <tr>
              <td>to:</td><td><input type="text" name="to" size="30" 
                class="form-control" id = "toField"/></td>
            </tr>
            <tr>
              <td>enter debit:</td><td><input type="checkbox"
                class="checkbox" value = "checked" size = "30" name = "chkbox"
                checked
                onclick="onChangeEnterDebit()" /></td>
            </tr>
            <tr>
              <td>debit amount:</td>
              <td><input type="text" name="debit" class="form-control" 
                 size="20" required id = "debitField"
                 pattern = "-?[0-9]*\.\d{0,2}"/></td>
            </tr>
            <tr>
             <td>debit date:</td><td><input type="text" name="debitDate" size="20" 
               id = "debitDateField" required class="form-control"/></td>
            </tr>
            <tr>
               <td></td>
              <td><input type="submit" value="Enter" class="form-control" /></td>
            </tr>
          </table>
        </form >
    </div>
  </div>
  <div class="col-sm-4"></div>
</div>
<script>
    var today = new Date();
    var fromDay = new Date();
    fromDay.setDate(1)
    var toDay = new Date(today.getFullYear(), today.getMonth()+1, 0);
    $('#dateField').datepicker({dateFormat: "mm-dd-yy"});
    $('#dateField').datepicker('setDate', today);
    $('#fromField').datepicker({ dateFormat: "mm-dd-yy" });
    $('#fromField').datepicker('setDate',fromDay);
    $('#toField').datepicker({dateFormat: "mm-dd-yy"});
    $('#toField').datepicker('setDate', toDay);
    $('#debitDateField').datepicker({dateFormat: "mm-dd-yy"});
    //TODO: look up actual due on date
    $('#debitDateField').datepicker('setDate', fromDay);
    //look up a rent value based on a tenant; fill in fields
    function amtFunc(val,keySplice){
        map = new Map(keySplice);
        var map_val = map.get(val);
        document.getElementById("amountField").value = map_val
        document.getElementById("debitField").value = "-" + map_val;
    }
    toggle = false;
    function onChangeEnterDebit(){
        if (toggle) {
            document.getElementById("debitField").disabled = false;
            document.getElementById("debitDateField").disabled = false;
            document.getElementById("debitField").value ="-" + document.getElementById
                                                            ("amountField").value;
            toggle = false;
        }else{
            document.getElementById("debitField").disabled = true;
            document.getElementById("debitDateField").disabled = true;
            document.getElementById("debitField").value = "";
            toggle = true;
        }
    }
</script>






