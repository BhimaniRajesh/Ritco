<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EditCCMStep3ASSC.aspx.cs" Inherits="EditCCMStep3ASSC" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

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
           if(!grid)
                return false;
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
           if(!grid)
                return false;
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
           if(!grid)
                return false;
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


var chkbranchtot=0;
var chkzonetot=0;
var chkcitytot=0;


function submitValidation()
{
    var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");
    if(cmbratetype.value=="0")
    {
        alert("Please Select Rate type.....");
        return false;
    }
   
    if(!gridValidate('ctl00_MyCPH1_grvbranch','Branch'))
        return false;
    
    if(!gridValidate('ctl00_MyCPH1_grvzone','Zone'))
        return false;
        
    if(!gridValidate('ctl00_MyCPH1_grvcity','City'))
        return false;
  
  if(chkbranchtot==0 && chkzonetot==0 && chkcitytot==0)
    {
        alert("Please Enter Atleast one row in any Matrix...");
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
               var cmbJratetype=document.getElementById(Jref+"cmbratetype");
               
                    if(chkJyes.checked==true)
                    {
                        if(gridname=="Branch")
                            chkbranchtot++;
                        if(gridname=="Zone")
                            chkzonetot++;
                        if(gridname=="City")
                            chkcitytot++;
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
        <br />
         <asp:Table ID="Table1" runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>  
        <br />
  <div style="width:10in;">
    <%--     TABLE OF BRANCH RATE   --%>
     <table id="tblratetpe" runat="server" class="boxbg" style="width:100%;" cellspacing="1">
        <tr class="bgbluegrey">
            <td colspan="2" align="center"><b>Single Slab Sundry Contract</b></td>
        </tr>
        <tr bgcolor="white">
            <td style="width:50%;">
                Rate Type
            </td>
            <td align="left">
            <asp:DropDownList ID="cmbratetype" BackColor="White" CssClass="blackfnt" runat="server">
                    <asp:ListItem Value="0" Selected="True">Select</asp:ListItem>
                    <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
                    <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
                    <asp:ListItem Value="T" Text="Per Ton"></asp:ListItem>
                    <asp:ListItem Value="F" Text="Flat Rs"></asp:ListItem>
            </asp:DropDownList>
            </td>
        </tr>
    </table>
    <br />            
        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
            <ContentTemplate>
                <table border="0" id="tblbranch" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b>Branch Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            Branch : <asp:TextBox ID="txtbranch" MaxLength="5" onblur="javascript:return locCodeHeadTest('ctl00_MyCPH1_txtbranch','ctl00_MyCPH1_grvbranch')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnbranch" OnClientClick="javascript:return popuplisthead('branch','txtbranch','grvbranch','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowsbranch" BorderStyle="Groove" MaxLength="3" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsbranch" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsbranch_Click" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvbranch" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvbranch_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('branch','txtfrom','grvbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"fromlocode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('branch','txtto','grvbranch')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"tolocode") %>' onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                             <input type="button" id="btnto" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Air
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Road
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Train
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrainrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttraintransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Express
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpressrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpresstransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
           </ContentTemplate>
            <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnrowsbranch" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
     <br /><br />
          
      
          
          
<%--     TABLE OF ZONE RATE   --%>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table border="0" id="tblzone" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b>Zone Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            Zone : <asp:TextBox ID="txtzone" MaxLength="15" onblur="javascript:return zoneCodeHeadTest('ctl00_MyCPH1_txtzone','ctl00_MyCPH1_grvzone')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnzone" OnClientClick="javascript:return popuplisthead('zone','txtzone','grvzone','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowszone" MaxLength="3" Width="50px" Style="text-align: right;"
                                BorderStyle="Groove" onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowszone" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowszone_Click" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvzone" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvzone_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('zone','txtfrom','grvzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"fromregion") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('zone','txtto','grvzone')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"toregion") %>' onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                             <input type="button" id="btnto" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Air
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Road
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Train
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrainrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttraintransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Express
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpressrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpresstransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
           </ContentTemplate>
            <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnrowszone" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
     <br /><br />
          
    
    
     <%--     TABLE OF CITY RATE   --%>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table border="0" id="tblcity" runat="server" cellpadding="0" style="width: 100%" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b>city Matrix </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="center" style="width: 25%">
                            city : <asp:TextBox ID="txtcity" MaxLength="25" onblur="javascript:return cityCodeHeadTest('ctl00_MyCPH1_txtcity','ctl00_MyCPH1_grvcity')" Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btncity" OnClientClick="javascript:return popuplisthead('city','txtcity','grvcity','head')" runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%">
                            No of Rows : <asp:TextBox ID="txtrowscity" MaxLength="3" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" BorderStyle="Groove" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowscity" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowscity_Click" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2"><br />
                             <asp:GridView CssClass="boxbg" runat="server" ID="grvcity" 
                                CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                OnRowDataBound="grvcity_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtfrom','grvcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"fromcity") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplist('city','txtto','grvcity')" Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"tocity") %>' onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                             <input type="button" id="btnto" runat="server" value="..." class="blackfnt" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Air
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtairtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Road
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtroadtransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Train
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrainrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttraintransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Express
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpressrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexpresstransit" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" MaxLength="3" onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
           </ContentTemplate>
            <Triggers> 
                    <asp:AsyncPostBackTrigger ControlID="btnrowscity" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
     <br /><br />
     
     
        <table id="tblsubmit" runat="server" class="boxbg" style="width:100%;" cellspacing="1">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Button CssClass="blackfnt" ID="btnsubmit" Text="Submit" runat="server" OnClick="btnsubmit_Click" />
            </td>
        </tr>
    </table>
    <br /><br />      
                                                                   
</div>
</asp:Content>
