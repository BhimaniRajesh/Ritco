<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ChangeManualPayBase.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_ReAssignBillSumissionnCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="../AJAX.js"></script>

                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>
                      <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="../../Octroi/ViewnPrint/JS/ViewPrint.js"></script>
<script type="text/javascript" language="javascript">
function docBlur(id)
{
    var str="";
  
    for(var i=0;i<id.length-9;i++)
    {
        str+=id.charAt(i);
    }
      debugger
    var s1=str+"_txtexpaybase";
    var s2=str + "_cmbpaybas";
    
    var txtdocno=document.getElementById(id);
    var txtpaybase=document.getElementById(s1);
    var cmbpaybase=document.getElementById(s2);   
    
    var docno=txtdocno.value;
    if(docno=="")
    {
        return false;
    }
 
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
   for(var i=2;i<r;i++)
   {
        var txtno;
        if(i<10)
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtdocno");
        else
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtdocno");

         if(txtdocno.value==txtno.value)
           {
                if(txtdocno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate Document Number....Enter another Document Number....");
                    txtdocno.value="";
                    txtdocno.focus();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {   
     var strpg="BringPayBase.aspx?mode=paybase&code=" + docno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         { 
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                    {
                        if(res[1]=="N")
                            {
                                txtpaybase.value="To Pay";
                                cmbpaybase.value="To Pay";
                                cmbpaybase.disabled=true;
                            }
                        else
                            {
                                txtpaybase.value="Paid";
                                cmbpaybase.value="Paid";
                                cmbpaybase.disabled=false;
                            }
                    }
                    else if(res[0]=="false")
                    {
                        alert(res[1]);
                    }
                }
         }
      findobj.send(null);
    }
    return false;
}




function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
    var non=0;
   for(var i=2;i<r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtsubloc
        var txtbillno,txtsubloc,txtcolloc;
        if(i<10)
            {
                txtbillno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillno");
                txtsubloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtsubloc");
                txtcolloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcolloc");
            }
        else
            {
                txtbillno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillno");
                txtsubloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtsubloc");
                txtcolloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcolloc");
            }
            
            if(txtbillno.value!="")
                {
                    non=1;
                    if(txtsubloc.value=="")
                    {
                        alert("Enter Submission Location Proprly.....");
                        txtsubloc.focus();
                        return false;
                    }
                    else if(txtcolloc.value=="")
                    {
                        alert("Enter Collection Location Proprly.....");
                        txtcolloc.focus();
                        return false;
                    }
                }
    } /// end for
    if(non==0)
    {
        alert("There is no Docket Number to Update.........");
        return false;
    }
}

function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
 }

function addRows()
{
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}

function billBlur(id)
{
    var str="";
    for(var i=0;i<id.length-9;i++)
    {
        str+=id.charAt(i);
    }
    
    var txtbillno=document.getElementById(id);
    var str1=str + "txtexsubloc";
    var txtsubloc=document.getElementById(str1);
    var txtcolloc=document.getElementById(str + "txtexcolloc");
    
    var billno=txtbillno.value;
    if(billno=="")
    {
        return false;
    }
 
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
   for(var i=2;i<r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtsubloc
        var txtno;
        if(i<10)
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillno");
        else
            txtbillno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillno");

         if(txtbillno.value==txtno.value)
           {
                if(txtbillno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate Document Number....Enter another Document Number....");
                    txtbillno.value="";
                    txtbillno.focus();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=bill&billno=" + billno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txtbillno.value="";
                        txtbillno.focus();
                        return false;
                    }
                    txtsubloc.value=res[1];
                    txtcolloc.value=res[2];
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}

</script>

<div align="center">

<br /><br />

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="center">Re-Assign Submission Location and Collection Location </td>
        </tr>
    </table>

<br />

    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
        
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="60%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" width="50%">Enter No. of Rows</td>
            <td class="blackfnt" align="left" width="50%">
                <asp:TextBox runat="server" ID="txtnorows"></asp:TextBox>
                <asp:Button runat="server" Text="Add Rows" OnClick="btnrows_Click" ID="btnrows" />
            </td>
        </tr>
    </table>

<br />

  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Document Details</td>
        </tr>

<tr bgcolor="#ffffff">
    <td class="blackfnt" align="left">
        <asp:GridView CssClass="boxbg" runat="server" ID="grvcontrols" AllowPaging="true" Width="100%"
                AllowSorting="true" PagerStyle-HorizontalAlign="left"
                BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnRowDataBound="grvcontrols_RowDataBound">
             <Columns>
  
                <asp:TemplateField HeaderText="Sr. No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                            </ItemTemplate>
                </asp:TemplateField>
        
                <asp:TemplateField HeaderText="Document Number">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtdocno"></asp:TextBox>
                            </ItemTemplate>
                </asp:TemplateField>
            
                 <asp:TemplateField HeaderText="Existing Pay Base">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox Enabled="false" runat="server" ID="txtexpaybase"></asp:TextBox>
                            </ItemTemplate>
                </asp:TemplateField>
            
                <asp:TemplateField HeaderText="New Pay Base">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:DropDownList ID="cmbpaybas" runat="server">
                                    <asp:ListItem Selected="True">To Pay</asp:ListItem>
                                    <asp:ListItem>Paid</asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                </asp:TemplateField>
            
            
                <asp:TemplateField HeaderText="Today Mr Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtdate"></asp:TextBox>
 <%--            THIS LINK IS USED TO ASSIGN DATE TO TEXT BOX NEAR IT
                FUNCTIONS FROM JS ARE USED TO DO IT
                FOR THIS TEXTBOX'S CLIENT ID IS NEEDED AND LINK'S ID IS NEEDED AS FIRST AND SECOND PARAMETER
                RESPECTIVELY
--%>                       
                                <asp:LinkButton ID="lnkdate" runat="server">
                                    <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                </asp:LinkButton>
                            </ItemTemplate>
                </asp:TemplateField>
            
                 
            </Columns>
        </asp:GridView>
      </td>
</tr>     
<tr bgcolor="#ffffff">
    <td class="blackfnt">
        <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" ID="btnsubmit"></asp:Button>
    </td>
</tr>     
</table>

        </ContentTemplate>
    </asp:UpdatePanel>

</div>
<asp:HiddenField ID="hdnrows" runat="server" Value="5" />
<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
