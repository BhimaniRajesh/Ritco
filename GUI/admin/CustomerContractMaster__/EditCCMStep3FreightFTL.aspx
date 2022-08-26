<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditCCMStep3FreightFTL.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_EditCCMStep3FreightFTL"
    Title="Customer Contract Master - FTL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
    
    
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
function locCodeTest(txtid)
{
    var txt=document.getElementById(txtid)
    txt.value=txt.value.toUpperCase();
    var val=txt.value + ",";
    if(txt.value=="")    
        return false;
        
        var branchstr="<%=strbranches %>";
        
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
    var val=txt.value + ",";
    if(txt.value=="")    
        return false;
        
        
         var zonestr="<%=strzones %>";
        
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
    
    var val=txt.value + ",";
    var citystr="<%=strcities %>";
        
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
            {
                alert("Please Select Rows.....");
                return false;
            }
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
            {
                alert("Please Select Rows.....");
                return false;
            }
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
            {
                alert("Please Select Rows.....");
                return false;
            }
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




function ftlDuplicateCheck(id,hdnid,tp)
{
    var cmb=document.getElementById(id);
    var val=cmb.value;
    
    
    var hdn=document.getElementById("ctl00_MyCPH1_hdn" + hdnid);
    var tmp = hdn.value.split(',');
    for(var a=0;a<5;a++)
    {
        if((a+1)==tp)
        {
            tmp[a]=val;
        }
    }
    
    hdn.value=tmp;
    
    for(var i=1;i<6;i++)
    {
        var id1=id.substring(0,id.length-1);
        id1=id1+i;
        var cmb1=document.getElementById(id1);
        if(id!=id1)
        {
            if(cmb.value==cmb1.value)
            {
                if(cmb.value!="0")
                    alert("No two FTL Types should be Same....");
                    
                cmb.value="0";
                return false;
            }
        }
    }
    
    
}












var chkroadtot=0;
var chkexpresstot=0;


function submitValidation()
{
   
    if(!gridValidate('ctl00_MyCPH1_grvroadfreightbranch','Road - Branch','cmbroadbranchftl'))
        return false;
    
    if(!gridValidate('ctl00_MyCPH1_grvroadfreightzone','Road - Zone','cmbroadzoneftl'))
        return false;
        
    if(!gridValidate('ctl00_MyCPH1_grvroadfreightcity','Road - City','cmbroadcityftl'))
        return false;
        
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightbranch','express - Branch','cmbexpressbranchftl'))
        return false;
    
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightzone','express - Zone','cmbexpresszoneftl'))
        return false;
        
    if(!gridValidate('ctl00_MyCPH1_grvexpressfreightcity','express - City','cmbexpresscityftl'))
        return false;
        
   if(chkroadtot==0 && chkexpresstot==0)
   {
    alert("Please Select Atlease row in any Matrix....");
    return false;
   }

    
   
         
    return true;
}


// THIS IS INNER FUNCTION TO USED IN SUBMIT VALIDATION FUNCTION PURPOSE OF THIS FUNCTION IS TO 
// CHECK DUPLICATION OF FROM AND TO BOXES
function gridValidate(gridid,gridname,cmbid)
{
    var grid=document.getElementById(gridid);
    if(!grid)
        return true;
    
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
               
              
                
                    if(chkJyes.checked==true)
                    {
                       if(gridid.indexOf('road')!=-1 && grid.style.display!='none')
                            chkroadtot++;
                       if(gridid.indexOf('express')!=-1 && grid.style.display!='none')
                            chkexpresstot++;
                    }
               
               
                   if(chkJyes.checked==true)
                   {
                           
                             for(var k=1;k<6;k++)
                               {
                                    var cmbftl=document.getElementById("ctl00_MyCPH1_" + cmbid + k);
                                    var txtrate=document.getElementById(pref+"txtrate" + k);
                                    var txttrans=document.getElementById(pref+"txttrans" + k);
                                    if(cmbftl.value!="0")
                                    {
                                        if(txtrate.value=="")
                                        {
                                            alert("Please Enter FTL rate ");
                                            txtrate.select();
                                            return false;
                                        }
                                        
                                        if(txttrans.value=="")
                                        {
                                            alert("Please Enter Transition Days ");
                                            txttrans.select();
                                            return false;
                                        }
                                    }
                               }
                           
                           
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
                               if(gridid.substring(gridid.length-6,gridid.length)!="zone")
                                    {
                                        if(txtJfrom.value == txtfrom.value && txtJto.value == txtto.value)
                                        {
                                            
                                            alert("Source to Destination Already Exists in " + gridname + " .....");
                                            txtJfrom.select();
                                            return false;
                                        }
                                    }
                           }
                            
                       } // two check condition
                } // one check condition
      
    }   // i for loop  ENDS HERE
    
    return true;
}


// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
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
 &nbsp;&nbsp;<font class="blackfnt"><b><u>Customer Contract</u> >> <font class="bluefnt"><b> FTL Matrices - Edit</b></font></b></font>
  <br /><br />

    <div id="divgrids" style="width: 10.3in; vertical-align: top;" align="center">
        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadbranch" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for ROAD - FTL Types - BRANCH Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            Branch :
                            <asp:TextBox ID="txtroadfreightbranch" onblur="javascript:return locCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvroadfreightbranch')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txtroadfreightbranch','grvroadfreightbranch','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsroadfreightbranch" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsroadfreightbranch" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsroadfreightbranch_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadbranchftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadbranchftl1','roadbranch','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadbranchftl2','roadbranch','2')" ID="cmbroadbranchftl2" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadbranchftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadbranchftl3','roadbranch','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadbranchftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadbranchftl4','roadbranch','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadbranchftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadbranchftl5','roadbranch','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightbranch" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvroadfreightbranch_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('branch','txtfrom','grvroadfreightbranch','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('branch','txtto','grvroadfreightbranch','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
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
        
        
        <asp:UpdatePanel ID="UpdatePane2" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadzone" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for ROAD - FTL Types - ZONE Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            Zone :
                            <asp:TextBox ID="txtroadfreightzone" onblur="javascript:return zoneCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvroadfreightzone')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txtroadfreightzone','grvroadfreightzone','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsroadfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsroadfreightzone" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsroadfreightzone_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadzoneftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadzoneftl1','roadzone','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadzoneftl2" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadzoneftl2','roadzone','2')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadzoneftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadzoneftl3','roadzone','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadzoneftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadzoneftl4','roadzone','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadzoneftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadzoneftl5','roadzone','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightzone" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvroadfreightzone_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('zone','txtfrom','grvroadfreightzone','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('zone','txtto','grvroadfreightzone','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtrowsroadfreightzone" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        
        
        
        <asp:UpdatePanel ID="UpdatePane3" runat="server">
            <ContentTemplate>
                <table border="0" id="tblroadcity" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for ROAD - FTL Types - CITY Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            city :
                            <asp:TextBox ID="txtroadfreightcity" onblur="javascript:return cityCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvroadfreightcity')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnroadfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txtroadfreightcity','grvroadfreightcity','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsroadfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsroadfreightcity" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsroadfreightcity_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadcityftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadcityftl1','roadcity','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadcityftl2" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadcityftl2','roadcity','2')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadcityftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadcityftl3','roadcity','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadcityftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadcityftl4','roadcity','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbroadcityftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbroadcityftl5','roadcity','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightcity" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvroadfreightcity_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('city','txtfrom','grvroadfreightcity','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('city','txtto','grvroadfreightcity','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtrowsroadfreightcity" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        <asp:UpdatePanel ID="UpdatePane4" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpressbranch" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for EXPRESS - FTL Types - BRANCH Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            Branch :
                            <asp:TextBox ID="txtexpressfreightbranch" onblur="javascript:return locCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvexpressfreightbranch')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightbranch" OnClientClick="javascript:return popuplisthead('branch','ctl00_MyCPH1_txtexpressfreightbranch','grvexpressfreightbranch','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsexpressfreightbranch" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsexpressfreightbranch" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsexpressfreightbranch_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpressbranchftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpressbranchftl1','expressbranch','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpressbranchftl2" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpressbranchftl2','expressbranch','2')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpressbranchftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpressbranchftl3','expressbranch','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpressbranchftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpressbranchftl4','expressbranch','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpressbranchftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpressbranchftl5','expressbranch','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightbranch" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvexpressfreightbranch_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('branch','txtfrom','grvexpressfreightbranch','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('branch','txtto','grvexpressfreightbranch','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return locCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtrowsexpressfreightbranch" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        
        
        <asp:UpdatePanel ID="UpdatePane5" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpresszone" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for EXPRESS - FTL Types - ZONE Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            Zone :
                            <asp:TextBox ID="txtexpressfreightzone" onblur="javascript:return zoneCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvexpressfreightzone')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightzone" OnClientClick="javascript:return popuplisthead('zone','ctl00_MyCPH1_txtroadfreightzone','grvroadfreightzone','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsexpressfreightzone" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsexpressfreightzone" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsexpressfreightzone_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresszoneftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresszoneftl1','expresszone','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresszoneftl2" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresszoneftl2','expresszone','2')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresszoneftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresszoneftl3','expresszone','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresszoneftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresszoneftl4','expresszone','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresszoneftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresszoneftl5','expresszone','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightzone" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvexpressfreightzone_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('zone','txtfrom','grvexpressfreightzone','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('zone','txtto','grvexpressfreightzone','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return zoneCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtrowsexpressfreightzone" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        
        
        
        
        
        
        
        <asp:UpdatePanel ID="UpdatePane6" runat="server">
            <ContentTemplate>
                <table border="0" id="tblexpresscity" runat="server" cellpadding="0" style="width: 10in;"
                    cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="13" style="height: 24px;">
                            <b><font class="bluefnt">Matrix for EXPRESS - FTL Types - CITY Matrix</font> </b>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" class="blackfnt">
                        <td align="center" style="width: 25%" colspan="6">
                            city :
                            <asp:TextBox ID="txtexpressfreightcity" onblur="javascript:return cityCodeHeadTest(this.getAttribute('id'),'ctl00_MyCPH1_grvexpressfreightcity')"
                                Width="50px" runat="server"></asp:TextBox>
                            <asp:Button ID="btnexpressfreightcity" OnClientClick="javascript:return popuplisthead('city','ctl00_MyCPH1_txtexpressfreightcity','grvexpressfreightcity','4head')"
                                runat="server" Text="...." />
                        </td>
                        <td align="center" style="width: 25%" colspan="7">
                            No of Rows :
                            <asp:TextBox ID="txtrowsexpressfreightcity" Width="50px" Style="text-align: right;"
                                onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                            <asp:Button ID="btnrowsexpressfreightcity" CssClass="blackfnt" Text="Add Rows" OnClick="btnrowsexpressfreightcity_OnClick"
                                runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <table style="width:100%" class="boxbg">
                                <tr bgcolor="white">
                                    <td  width ="15">&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td width ="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresscityftl1" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresscityftl1','expresscity','1')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresscityftl2" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresscityftl2','expresscity','2')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresscityftl3" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresscityftl3','expresscity','3')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresscityftl4" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresscityftl4','expresscity','4')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbexpresscityftl5" onchange="javascript:return ftlDuplicateCheck('ctl00_MyCPH1_cmbexpresscityftl5','expresscity','5')" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="13">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightcity" CellSpacing="1"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvexpressfreightcity_RowDataBound">
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
                                            <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplisthead('city','txtfrom','grvexpressfreightcity','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnfrom" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            To
                                            <asp:Button ID="btnheadto" OnClientClick="javascript:return popuplisthead('city','txtto','grvexpressfreightcity','4row')"
                                                Text="...." runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                onblur="javascript:return cityCodeTest(this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                            <input type="button" id="btnto" value="...." runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate1" Text='<%# DataBinder.Eval( Container.DataItem,"rate1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans1" Text='<%# DataBinder.Eval( Container.DataItem,"trans1") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate2" Text='<%# DataBinder.Eval( Container.DataItem,"rate2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans2" Text='<%# DataBinder.Eval( Container.DataItem,"trans2") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate3" Text='<%# DataBinder.Eval( Container.DataItem,"rate3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans3" Text='<%# DataBinder.Eval( Container.DataItem,"trans3") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate4" Text='<%# DataBinder.Eval( Container.DataItem,"rate4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans4" Text='<%# DataBinder.Eval( Container.DataItem,"trans4") %>'
                                                Style="text-align: right;" onkeypress="javascript:return validInt(event)" onblur="javascript:return validInt(event)"
                                                Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            FTL Rate
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"rate5") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="50px"
                                                runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="True" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Transit Days
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttrans5" Style="text-align: right;" Text='<%# DataBinder.Eval( Container.DataItem,"trans5") %>'
                                                onkeypress="javascript:return validInt(event)" Width="50px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtrowsexpressfreightcity" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        
         <table border="0" id="tblsubmit" runat="server" cellpadding="0" style="width:10in;" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click" OnClientClick="javascript:return submitValidation()" />
                </td>
            </tr>
        </table>
        
        
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnroadbranch" runat="server" />
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnroadzone" runat="server" />
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnroadcity" runat="server" />
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnexpressbranch" runat="server" />
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnexpresszone" runat="server" />
        <asp:HiddenField Value="0,0,0,0,0" ID="hdnexpresscity" runat="server" />
    </div>
</asp:Content>
