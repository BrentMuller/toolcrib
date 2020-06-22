<apply template="base">
    <apply template = "nav_bar"/>
    <apply template = "header"/>
    <h3>Tenant Entry</h3>
<bootStrapWarning/>
<div class = "row">
<div class="col-sm-4"></div>
<div class="col-sm-8">
<form method="post" action="enterTenant">
  <table id="tenant">
    <tr>
      <td>tenant:</td>
          <td>
            <input type="text" name="tenant" size="20" 
            required class="form-control" autocomplete = "off"
            />
          </td>
    </tr>
    <tr>
      <td>starting date:</td><td><input type="text" 
        id = "dateField"
        required name="starting_date" size="20" class="form-control"/></td>
    </tr>
    <tr>
      <td>due on date:</td><td><input type="number" 
                name="due_on_date" min= "1" max = "30" value = "1" 
                class="form-control"/></td>
    </tr>
    <tr>
      <td>rent amount:</td><td><input type="text" 
         required  name="rent_amount"  class="form-control"
         pattern = "[0-9]*\.\d{0,2}" size = "20" /></td>
    </tr>
    <tr>
     <div class="dropdown">
      <td>property:</td><td><input type="text" id = "autocomplete_prop" 
         required  name="property"  class="form-control"
         autocomplete = "off" list = "property_autocomplete"
         /></td>
    </div>
                    <autocompleteList/>
    </tr>

    <tr>
      <td>memo:</td><td><input type="text" 
        name="memo_tenant_entry" size="20" class="form-control"/></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="submit" value="Enter" class="form-control"/></td>
    </tr>
  </table>
</form>
</div>
</div>
    <apply template = "footer"/>
</apply>

<script>
$('#dateField').datepicker({dateFormat: "mm-dd-yy"});
$('#dateField').datepicker('setDate', new Date());
</script>
