<apply template="base">
    <apply template = "nav_bar"/>
    <apply template = "header"/>
    <h3>Property Entry</h3>

<div class = "row">
<div class="col-sm-4"></div>
<div class="col-sm-8">
<form method="post" action="enterProperty">
  <table id="property">
    <tr>
      <td>property name:</td><td><input type="text" name="property" size="20" 
        required class="form-control" autocomplete = "off"/></td>
    </tr>
    <tr>
      <td>address:</td><td><input type="address" 
        required name="address" size="20" class="form-control"/></td>
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

