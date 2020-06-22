
<nav class="navbar-expand-sm bg-dark navbar-dark fixed-top">
<div class="container-fluid">
  <div class="navbar-header">
    <ul class="nav navbar-nav">
        <li>
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Receipts</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/receipt/">Receipt Entry</a>
          <a class="dropdown-item" href="/receiptReport/">Receipt Report</a>
          <a class="dropdown-item" href="/print/">Receipt Print</a>
         </div>
        </li>
    <li>
     <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Tenants</a> 
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/enterTenant/">Tenant Entry</a>
          <a class="dropdown-item" href="/tenants/">Tenant List</a>
         </div>
    </li>
    <li>
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Properties</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/enterProperty/">Property Entry</a>
          <a class="dropdown-item" href="/properties/">Properties List</a>
         </div>
    </li>
    <li>
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Rent Ledger</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="/ledger/">Ledger Entry</a>
          <a class="dropdown-item" href="/tenantLedger/">Tenant Ledger</a>
         </div>
    </li>
    <li>
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Help</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" onclick = "aboutClick()" >About</a> 
          <a class="dropdown-item" href="/help">Help</a>
         </div>
    </li>
    </ul>
  </div>
</div>
<script>
function aboutClick(){
    window.alert("Tool Crib- machine tooling database");
}
</script>
</nav>
