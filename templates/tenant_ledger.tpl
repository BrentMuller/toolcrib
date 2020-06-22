<apply template="base">
    <apply template = "nav_bar"/>
    <apply template = "header"/>
    <h2>Tenant Ledger</h2>
 <div class="row">
   <div class="col-sm-4"></div>
   <div class="col-sm-4">
    <form method="post" action="tenantLedger">
    <div class="input-group">
       <input type="text" name = "tenant" class="form-control" placeholder="Tenant"
        value = ${tenantSplice} list = "tenant_autocomplete" autocomplete = "off" >
        <autocompleteList/>
       <div class="input-group-btn">
        <button class="btn btn-default" type="submit">
        <i class="fas fa-search"></i>
        </button>
       </div>
    </div>
    </form>
   </div>
   <div class="col-sm-4"></div>
 </div> 
    <p style="border-style:solid; border-width: 1px; max-width: 300px; margin-left: auto;
    margin-right: auto; padding: 25px; width: 40%;" >
        Tenant Balance:
        <span style="border-style:solid;border-width: 1px;
            background: #aaa; color:white;" >
        <amountTotalSplice/>
        </span>
    </p>
    <tableSplice/>
    <bootStrapWarning/>
    <apply template = "footer"/>
</apply>



















