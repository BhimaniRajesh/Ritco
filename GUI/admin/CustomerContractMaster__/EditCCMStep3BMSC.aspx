<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditCCMStep3BMSC.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_EditCCMStep3BMSC"
    Title="Local" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript">
    
    
   
function locCodeTest(txtid)
{
    var txt=document.getElementById(txtid)
    txt.value=txt.value.toUpperCase();
    if(txt.value=="")    
        return false;
        
        var branchstr="<%=strbranches %>";
        var val=txt.value + ",";
        if(branchstr.indexOf(val)<0)
        {
            alert("Branch Doesn't Exists");
            txt.select();
            return false;
        }
        return true;
}

   
function zoneCodeTest(txtid)
{
    var txt=document.getElementById(txtid)
    txt.value=txt.value.toUpperCase();
    if(txt.value=="")    
        return false;
        
        
        var zonestr="<%=strzones %>";
        var val=txt.value + ",";
        if(zonestr.indexOf(val)<0)
        {
            alert("Zone Doesn't Exists");
            txt.select();
            return false;
        }
    return true;
}

function cityCodeTest(txtid)
{
    var txt=document.getElementById(txtid)
    txt.value=txt.value.toUpperCase();
    if(txt.value=="")    
        return false;

        var citystr="<%=strcities %>";
        var val=txt.value + ",";
        if(citystr.indexOf(val)<0)
        {
            alert("City Doesn't Exists");
            txt.select();
            return false;
        }
        return true;
}


function locCodeHeadTest(txtid,gridid)
{

    if(!locCodeTest(txtid))
    {
        return false;
    }    
    else
    {
           var grid=document.getElementById(gridid);
           var rows=grid.rows.length;
    
            for(var i=2;i<rows+1;i++)
            {
               var pref="";
               if(i<10)
                    pref = gridid + "_ctl0" + i + "_";
               else
                    pref = gridid + "_ctl" + i + "_";

               var txtfrom=document.getElementById(pref+"txtfrom");
               txtfrom.value=document.getElementById(txtid).value;
             }
            
    }
}




function zoneCodeHeadTest(txtid,gridid)
{
    
    if(!zoneCodeTest(txtid))
        return false;
    else
    {
           var grid=document.getElementById(gridid);
           var rows=grid.rows.length;
    
            for(var i=2;i<rows+1;i++)
            {
               var pref="";
               if(i<10)
                    pref = gridid + "_ctl0" + i + "_";
               else
                    pref = gridid + "_ctl" + i + "_";

               var txtfrom=document.getElementById(pref+"txtfrom");
               txtfrom.value=document.getElementById(txtid).value;
            }
            
    }
}



function cityCodeHeadTest(txtid,gridid)
{
    
    if(!cityCodeTest(txtid))
        return false;
    else
    {
           var grid=document.getElementById(gridid);
           var rows=grid.rows.length;
    
            for(var i=2;i<rows+1;i++)
            {
               var pref="";
               if(i<10)
                    pref = gridid + "_ctl0" + i + "_";
               else
                    pref = gridid + "_ctl" + i + "_";

               var txtfrom=document.getElementById(pref+"txtfrom");
               txtfrom.value=document.getElementById(txtid).value;
            }
    }
}



function resetRateType()
{

    if(!confirm("This will reset all Rate Type in this Page.... Are you want to Continue......?"))
        return false;
        
        return true;
}



function checkSlab(slabno,myid)
{
  
    var txt=document.getElementById(myid);
    var from=document.getElementById("ctl00_MyCPH1_txtFromSlab" + slabno);
    var to=document.getElementById("ctl00_MyCPH1_txtToSlab" + slabno);
    
    if(txt.value=="")
        return false;
    
    if(from.value=="")
        from.value="0";
        
    if(to.value=="")
        to.value="0";
        
        
        var dSlab=parseFloat(txt.value);
        var dFrom=parseFloat(from.value);    
        var dTo=parseFloat(to.value);
        
        if(dSlab<dFrom || dSlab>dTo)
        {
            alert("Enter Slab" + slabno + " Value Properly.....");
            txt.select();
            return false;
        }
        
       
        return true;
}


function validateUpperSlabs()
{
    
    for(var i=1;i<7;i++)
    {
        var from=document.getElementById("ctl00_MyCPH1_txtFromSlab" + i);
        var to=document.getElementById("ctl00_MyCPH1_txtToSlab" + i);
        
        if(from.value=="")
            from.value="0";
        
        if(to.value=="")
            to.value="0";
        
         var f=document.getElementById("ctl00_MyCPH1_txtFromSlab1");
        var t=document.getElementById("ctl00_MyCPH1_txtToSlab1");
        
       if(i==1)
        {
            if(isNaN(from.value) || parseFloat(from.value)==0)
            {
                alert("Please Enter Valid Number in From Slab" + i);
                from.select();
                return false;
            }
            
            if(isNaN(to.value) || parseFloat(to.value)==0)
            {
                alert("Please Enter Valid Number in To Slab" + i);
                to.select();
                return false;
            }
            
            if(parseFloat(from.value)>=parseFloat(to.value))
            {
                alert("Please Enter Greater Number in From Slab" + i + " then Number in To Slab" + i);
                to.select();
                return false;
            }
        }
        
        
//        for(var j=1;j<i;j++)
//        {
//            
//            if(i>1)
//            {
//             var Jfrom=document.getElementById("ctl00_MyCPH1_txtFromSlab" + j);
//             var Jto=document.getElementById("ctl00_MyCPH1_txtToSlab" + j);
//  
//                if(parseFloat(Jfrom.value)>=parseFloat(from.value) || parseFloat(Jto.value)>=parseFloat(from.value))
//                {
//                    alert("From Value of Slab" + i + " is in Between of Slab" + j);
//                    from.select();
//                    return false;
//                }
//              
//                if(parseFloat(Jto.value)>=parseFloat(to.value))
//                {
//                    alert("To Value of Slab" + i + " is in Between of Slab" + j);
//                    to.select();
//                    return false;
//                }
//            }
//        }
    
    }
    return true;
}


var chkroadtot=0;
var chkexpresstot=0;
var chkairtot=0;
var chktraintot=0;


function submitValidation()
{
    if(!validateUpperSlabs())
        return false;

    if(!gridValidate('ctl00_MyCPH1_grvroadfreightbranch','Road - Branch'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvairfreightbranch','Air - Branch'))
        return false;        
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightbranch','Express - Branch'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvtrainfreightbranch','Train - Branch'))
        return false;
    
    if(!gridValidate('ctl00_MyCPH1_grvroadfreightzone','Road - Zone'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvairfreightzone','Air - Zone'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightzone','Express - Zone'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvtrainfreightzone','Train - Zone'))
        return false;
    
    if(!gridValidate('ctl00_MyCPH1_grvroadfreightcity','Road - City'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvairfreightcity','Air - City'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightcity','Express - City'))
        return false;
    if(!gridValidate('ctl00_MyCPH1_grvtrainfreightcity','Train - City'))
        return false;
    
    
 if(chkroadtot==0 && chkexpresstot==0 && chkairtot==0 && chktraintot==0)    
   {
        alert("Please Select Atleast one row in Any Matrix........");
        return false;
   }
    
    return true;
}


// THIS IS INNER FUNCTION TO USED IN SUBMIT VALIDATION FUNCTION PURPOSE OF THIS FUNCTION IS TO 
// CHECK DUPLICATION OF FROM AND TO BOXES
function gridValidate(gridid,gridname)
{

    var grid=document.getElementById(gridid);
    var rows=grid.rows.length;
    
    
    
    for(var i=2;i<rows+1;i++)
    {
       var pref="";
       if(i<10)
            pref = gridid + "_ctl0" + i + "_";
       else
            pref = gridid + "_ctl" + i + "_";

       var txtfrom=document.getElementById(pref+"txtfrom");
       var txtto=document.getElementById(pref+"txtto");
       var chkyes=document.getElementById(pref+"chkyes");
       
           for(var j=2;j<rows+1;j++)
           {
               var Jref="";
               if(j<10)
                    Jref = gridid + "_ctl0" + j + "_";
               else
                    Jref = gridid + "_ctl" + j + "_";

               var txtJfrom=document.getElementById(Jref+"txtfrom");
               var txtJto=document.getElementById(Jref+"txtto");
               var chkJyes=document.getElementById(Jref+"chkyes");
               var txtJtransdays=document.getElementById(Jref+"txttransit");
               var cmbJratetype=document.getElementById(Jref+"cmbratetype");
                
                    if(chkJyes.checked==true)
                    {
                       if(gridid.indexOf('road')!=-1 && grid.style.display!='none')
                            chkroadtot++;
                       if(gridid.indexOf('express')!=-1 && grid.style.display!='none')
                            chkexpresstot++;
                       if(gridid.indexOf('air')!=-1 && grid.style.display!='none')
                            chkairtot++;
                       if(gridid.indexOf('train')!=-1 && grid.style.display!='none')
                            chktraintot++;
                    }
               
               
               if(chkJyes.checked==true)
               {
               if(chkyes.checked==true && chkJyes.checked==true)
                    {
                        if(txtfrom.value=="")
                        {
                            alert("Please Enter From value in " + gridname + " .....");
                            txtfrom.select();
                            return false;
                        }
                        if(txtto.value=="")
                        {
                            alert("Please Enter From value in " + gridname + " .....");
                            txtto.select();
                            return false;
                        }
                        if(txtJfrom.value=="")
                        {
                            alert("Please Enter From value in " + gridname + " .....");
                            txtJfrom.select();
                            return false;
                        }
                        if(txtJto.value=="")
                        {
                            alert("Please Enter From value in " + gridname + " .....");
                            txtJto.select();
                            return false;
                        }
                        
                        if(txtJtransdays.value=="")
                        {
                            alert("Please Enter Transit days in " + gridname + " .....");
                            txtJtransdays.select();
                            return false;
                        }
                        
                         if(cmbJratetype.value=="0")
                        {
                            alert("Please Select Rate Type in " + gridname + " .....");
                            txtJtransdays.select();
                            return false;
                        }
                        
               }
               
               
               
               
               
               if(i!=j)
               {
                        if(txtJfrom.value == txtfrom.value && txtJto.value == txtto.value)
                        {
                            alert("Source to Destination Already Exists in " + gridname + " .....");
                            txtJfrom.select();
                            return false;
                        }
                    }
                    
               }
                
                
           }
      
    }   // i for loop  ENDS HERE
    
    return true;
}


// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=0";
            confirmWin=window.open(url,"",winOpts);
            return false;
 }
 
 
 
// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP IN HEADER ALSO
function popuplisthead(mode,ctlid,tbl,head)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head ;
            confirmWin=window.open(url,"",winOpts);
            return false;
 }
 
// this function assignment in keypress doesn't allow any character other than number.
function noEnter(event)
{
    if(event.keyCode==13)
        {
            return false;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}
    </script>
    <script language="javascript" type="text/javascript">
     
        
    </script>
     <b>Customer Contract Master - Edit Existing Contract </b>
        <br />
        <br />
        <b>STEP 3B: Freight Matrix - Multi Slab Detailed Contract</b>
        <br />
        <br />
    <div id="trnas" runat="server" style="position:absolute;display:none; background-color:Transparent;"></div>
    <div style="width: 10in; vertical-align: top;" align="center" class="blackfnt">
       
        <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
            <tr style="background-color: White">
                <td align="right" style="height: 24px">
                    <label class="blackfnt">
                        Select Rate Type:&nbsp;
                    </label>
                </td>
                <td align="left" style="height: 24px">
                    <label style="margin-left: 5px;">
                    </label>
                    <asp:DropDownList ID="cmbratetype"  OnTextChanged="cmbratetype_TextChanged" AutoPostBack="true" runat="server" CssClass="blackfnt">
                        <asp:ListItem Selected="True" Value="0" Text="Select"></asp:ListItem>
                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
                        <asp:ListItem Value="B" Text="Both"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="0" style="width: 100%" cellspacing="1" align="center"
            class="boxbg">
            <tr style="background-color: White">
                <td align="center" colspan="12">
                    <label class="bluefnt">
                        <b>Define Slab </b>
                    </label>
                </td>
            </tr>
            <tr style="background-color: White">
                <td align="center" colspan="2">Slab 1</td>
                <td align="center" colspan="2">Slab 2</td>
                <td align="center" colspan="2">Slab 3</td>
                <td align="center" colspan="2">Slab 4</td>
                <td align="center" colspan="2">Slab 5</td>
                <td align="center" colspan="2">Slab 6</td>
            </tr>
            <tr style="background-color: White">
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">From</td>
                <td align="center">To</td>
                <td align="center">From</td>
                <td align="center">To</td>
            </tr>
            <tr style="background-color: White">
                <td align="center">
                    <asp:TextBox ID="txtFromSlab1" Width="50px" MaxLength="6" CssClass="blackfnt"  onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab1" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                
                
                <td align="center">
                    <asp:TextBox ID="txtFromSlab2" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab2" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                
                
                <td align="center">
                    <asp:TextBox ID="txtFromSlab3" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab3" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                
                
                <td align="center">
                    <asp:TextBox ID="txtFromSlab4" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab4" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                
                
                <td align="center">
                    <asp:TextBox ID="txtFromSlab5" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab5" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                
                <td align="center">
                    <asp:TextBox ID="txtFromSlab6" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="txtToSlab6" Width="50px" MaxLength="6" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" style="margin-left: 5px; text-align:right;" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div id="progressArea">
                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
               
        
       <%-- <table id="tblenablematrices" runat="server" class="boxbg" style="width:100%;" cellspacing="1">
            <tr class="bgbluegrey">
                <td align="center">
                    <input type="button" class="blackfnt" id="btnshowgrids" value="Enable Matrices" onclick="javascript:return validateUpperSlabs()" />
                </td>
            </tr>
        </table>--%>
        <br />
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                                <%--BRANCH DESIGN STARTS HERE--%>
        






<div id="divgrids">


        
        
        <%--     TABLE OF FREIGHT RATE   --%>
        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadbranch" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b>Matrices for Road - Freight Rate - Branch Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            Branch : <asp:TextBox ID="txtroadfreightbranch" onblur="javascript:return locCodeHeadTest('ctl00_MyCPH1_txtroadfreightbranch','ctl00_MyCPH1_grvroadfreightbranch')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txtroadfreightbranch','grvroadfreightbranch','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowsroadfreightbranch" AutoPostBack="true" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsroadfreightbranch" CssClass="blackfnt" Text="Add Rows" OnClick="txtrowsroadfreightbranch_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightbranch" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvroadfreightbranch_RowDataBound">
                                <Columns>
                                 
                                 <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('branch','txtfrom','grvroadfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('branch','txtto','grvroadfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers> 
            <asp:AsyncPostBackTrigger ControlID="txtrowsroadfreightbranch" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
     <br />
            
        
        
        
                 <%--                TABLE OF EXPRESS FREIGHT RATE                --%>
         
         
        
        <asp:UpdatePanel ID="UpdatePanel9" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpressbranch" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Express - Freight Rate - Branch Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            Branch : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtexpressfreightbranch" onblur="javascript:return locCodeHeadTest('ctl00_MyCPH1_txtexpressfreightbranch','ctl00_MyCPH1_grvexpressfreightbranch')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txtexpressfreightbranch','grvexpressfreightbranch','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsexpressfreightbranch" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsexpressfreightbranch" CssClass="blackfnt" Text="Add Rows" OnClick="txtrowsexpressfreightbranch_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightbranch" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvexpressfreightbranch_RowDataBound">
                                <Columns>
                                  
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('branch','txtfrom','grvexpressfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('branch','txtto','grvexpressfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        
         <%--                TABLE OF AIR FREIGHT RATE                --%>
         
         
         
      
      
      
        
        <asp:UpdatePanel ID="UpdatePanel10" runat="server">
            <ContentTemplate>
                <table border="0" id="tblairbranch" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Air - Freight Rate - Branch Matrix </b></font>               
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            Branch : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtairfreightbranch" Width="50px" onblur="javascript:return locCodeHeadTest('ctl00_MyCPH1_txtairfreightbranch','ctl00_MyCPH1_grvairfreightbranch')" runat="server"></asp:TextBox>
                            <asp:Button ID="btnairfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txtairfreightbranch','grvairfreightbranch','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsairfreightbranch" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowsairfreightbranch" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsairfreightbranch_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightbranch" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvairfreightbranch_RowDataBound">
                                <Columns>
                                  
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('branch','txtfrom','grvairfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('branch','txtto','grvairfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'  onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
                                <%--TABLE OF TRAIN  FREIGHT RATE--%>
        
        
            
            <asp:UpdatePanel ID="UpdatePanel11" runat="server">
            <ContentTemplate>
                <table border="0" id="tbltrainbranch" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Train - Freight Rate - Branch Matrix </b></font>          
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            Branch : <asp:TextBox ID="txttrainfreightbranch" onblur="javascript:return locCodeHeadTest('ctl00_MyCPH1_txttrainfreightbranch','ctl00_MyCPH1_grvtrainfreightbranch')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btntrainfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txttrainfreightbranch','grvtrainfreightbranch','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowstrainfreightbranch" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowstrainfreightbranch" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowstrainfreightbranch_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightbranch" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvtrainfreightbranch_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('branch','txtfrom','grvtrainfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('branch','txtto','grvtrainfreightbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'  onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
     <br /><br />
        
        
        
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
                                <%--zone DESIGN STARTS HERE--%>
        







        
        
        <%--     TABLE OF FREIGHT RATE   --%>
        
        <asp:UpdatePanel ID="updfreight" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadzone" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                             <font class="bluefnt"><b>Matrices for Road - Freight Rate - Zone Matrix </b></font>               
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            zone : <asp:TextBox ID="txtroadfreightzone" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtroadfreightzone','ctl00_MyCPH1_grvroadfreightzone')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txtroadfreightzone','grvroadfreightzone','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowsroadfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowsroadfreightzone" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsroadfreightzone_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightzone" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvroadfreightzone_RowDataBound">
                                <Columns>
                                  
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('zone','txtfrom','grvroadfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('zone','txtto','grvroadfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
     <br />
        
        
        
        
        
        
        
                 <%--                TABLE OF EXPRESS FREIGHT RATE                --%>
         
         
         
      
      
      
        
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpresszone" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Express - Freight Rate - zone Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            Zone : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtexpressfreightzone" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtexpressfreightzone','ctl00_MyCPH1_grvexpressfreightzone')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txtexpressfreightzone','grvexpressfreightzone','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsexpressfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                       <asp:Button ID="btnrowsexpressfreightzone" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsexpressfreightzone_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightzone" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvexpressfreightzone_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('zone','txtfrom','grvexpressfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('zone','txtto','grvexpressfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        
        
         <%--                TABLE OF AIR FREIGHT RATE                --%>
         
         
         
      
      
      
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table border="0" id="tblairzone" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                        <font class="bluefnt"><b> Matrices for Air - Freight Rate - zone Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            Zone : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtairfreightzone" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtairfreightzone','ctl00_MyCPH1_grvairfreightzone')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnairfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txtairfreightzone','grvairfreightzone','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsairfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowsairfreightzone" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsairfreightzone_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightzone" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvairfreightzone_RowDataBound">
                                <Columns>
                                   <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('zone','txtfrom','grvairfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('zone','txtto','grvairfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
                                <%--TABLE OF TRAIN  FREIGHT RATE--%>
        
        
            
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table border="0" id="tbltrainzone" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Train - Freight Rate - zone Matrix </b></font>            
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            Zone : <asp:TextBox ID="txttrainfreightzone" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txttrainfreightzone','ctl00_MyCPH1_grvtrainfreightzone')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btntrainfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txttrainfreightzone','grvtrainfreightzone','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowstrainfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowstrainfreightzone" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowstrainfreightzone_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightzone" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvtrainfreightzone_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('zone','txtfrom','grvtrainfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('zone','txtto','grvtrainfreightzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
     <br /><br />
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                                <%--CITY DESIGN STARTS HERE--%>
        







        
        
        <%--     TABLE OF FREIGHT RATE   --%>
        
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadcity" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                             <font class="bluefnt"><b>Matrices for Road - Freight Rate - City Matrix </b></font>              
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            City : <asp:TextBox ID="txtroadfreightcity" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtroadfreightcity','ctl00_MyCPH1_grvroadfreightcity')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txtroadfreightcity','grvroadfreightcity','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowsroadfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowsroadfreightcity" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsroadfreightcity_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightcity" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvroadfreightcity_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtfrom','grvroadfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('city','txtto','grvroadfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
     <br />
        
        
        
        
        
        
        
                 <%--                TABLE OF EXPRESS FREIGHT RATE                --%>
         
         
         
      
      
      
        
        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpresscity" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Express - Freight Rate - city Matrix </b></font>            
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            City : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtexpressfreightcity" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtexpressfreightcity','ctl00_MyCPH1_grvexpressfreightcity')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txtexpressfreightcity','grvexpressfreightcity','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsexpressfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowexpressfreightcity" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsexpressfreightcity_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightcity" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvexpressfreightcity_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtfrom','grvexpressfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('city','txtto','grvexpressfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        
        
         <%--                TABLE OF AIR FREIGHT RATE                --%>
         
         
         
      
      
      
        
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <table border="0" id="tblaircity" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Air - Freight Rate - city Matrix </b></font>              
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" style="width: 25%">
                            City : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtairfreightcity" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtairfreightcity','ctl00_MyCPH1_grvairfreightcity')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnairfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txtairfreightcity','grvairfreightcity','head')" runat="server" Text="...." />
                        </td>
                        <td align="right" style="width: 25%">
                            No of Rows : </td>
                        <td align="left" style="width: 25%">
                            <asp:TextBox ID="txtrowsairfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowairfreightcity" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowsairfreightcity_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightcity" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvairfreightcity_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtfrom','grvairfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btntofrom" OnClientClick="javascript:return popuplist('city','txtto','grvairfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        
        
        
                                <%--TABLE OF TRAIN  FREIGHT RATE--%>
        
        
            
            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
            <ContentTemplate>
                <table border="0" id="tbltraincity" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b> Matrices for Train - Freight Rate - city Matrix </b></font>           
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            City : <asp:TextBox ID="txttrainfreightcity" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txttrainfreightcity','ctl00_MyCPH1_grvtrainfreightcity')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btntrainfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txttrainfreightcity','grvtrainfreightcity','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowstrainfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                        <asp:Button ID="btnrowtrainfreightcity" Text="Add Rows" CssClass="blackfnt" OnClick="txtrowstrainfreightcity_TextChanged" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightcity" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvtrainfreightcity_RowDataBound">
                                <Columns>
                                  <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            From
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtfrom','grvtrainfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btntofrom" OnClientClick="javascript:return popuplist('city','txtto','grvtrainfreightcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" runat="server" class="blackfnt"  value="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Rate Type
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype"  runat="server">
                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                                                <asp:ListItem Value="P">Per Package</asp:ListItem>
                                                <asp:ListItem Value="B">Both</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 1
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 2
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 3
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 4
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 5
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Slab 6
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>' Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
     <br />

           
        
        <table id="Table1" runat="server" class="boxbg" style="width:100%;" cellspacing="1">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button CssClass="blackfnt" ID="btnsubmit" Text="Submit" runat="server" OnClick="btnsubmit_Click" />
                </td>
            </tr>
        </table>
        <br /><br />

    
      </div>  <%--DIV OF GRIDS ENDS HERE--%>
    </div> <%-- FORMATTING GRID --%>
</asp:Content>
