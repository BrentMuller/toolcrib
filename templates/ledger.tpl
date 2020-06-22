<apply template="base">
  <apply template = "nav_bar"/>
  <apply template = "header"/>
  <h2>Ledger Entry</h2>
<div class = "row">
<div class="col-sm-4"></div>
<div class="col-sm-8">
<form method="post" action="/ledger">
  <table id="ledgerTab">
    <tr>
            <div class="dropdown">
              <td>tenant:</td><td><input id = "autocomplete" type="text" 
                    name="tenant" size="20" required autocomplete = "off"
                    list = "tenant_autocomplete" class="form-control" 
                     /></td>
            </div>
                    <autocompleteList/>
    <tr>
      <td>date:</td><td><input type="text" name="date" size="20" 
        required class="form-control" id = "date" /></td>
    </tr>
    <tr>
      <td>amount:</td><td><input type="text" id = "amount"
        required name="amt" size="20" class="form-control"/></td>
    </tr>
    <tr>
    <td>type:</td>
      <td>
         <div class="form-group">
          <select class="form-control" name = "type" id="type">
            <option>Rent</option>
            <option>Wages</option>
            <option>Expense</option>
            <option>Other</option>
          </select>
        </div> 
      </td>
    </tr>
    <tr>
      <td>memo:</td><td><input type="text" id = "memo"
        name="memo" size="20" class="form-control"/></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="submit" value="Enter" class="form-control"/></td>
    </tr>
  </table>
</form>
</div>
</div>
    <bootStrapWarning/>
    <apply template = "footer"/>
</apply>
<script>
    var today = new Date();
    var fromDay = new Date();
    fromDay.setDate(1)
    var toDay = new Date();
    toDay.setMonth(toDay.getMonth() + 1);
    toDay.setDate(0);
    $('#date').datepicker({ dateFormat: "mm-dd-yy" });
    $('#date').datepicker('setDate',fromDay);
</script>







