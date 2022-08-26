<%@ Page Language="C#" AutoEventWireup="true" Trace="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ReAssignVoucherDate.aspx.cs" Inherits="GUI_Finance_Accounts_ReAssignVoucherDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript" src="AJAX.js"></script>
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


function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
    var non=0;
   for(var i=2;i<r;i++)
   {
        var txtvoucherno,txtdate;
        if(i<10)
            {
                txtvoucherno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtvoucherno");
                txtdate=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtnewdate");
            }
        else
            {
                txtvoucherno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtvoucherno");
                txtdate=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtnewdate");
            }
            
            if(!isValidDate(txtdate.value,"Voucher"))
                {
                    txtdate.focus();
                    return false;
                }
            if(txtvoucherno.value=="")
            {
                non=1;
            }
    } /// end for

    if(non==0)
    {
        alert("There is no Docket Number to Update.........");
        return false;
    }
    
}

function addRows()
{
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}

function voucherBlur(id)
{
    var str="";
    for(var i=0;i<id.length-12;i++)
    {
        str+=id.charAt(i);
    }
    var s1=str+"txtolddate"
    var txtvoucherno=document.getElementById(id);
    var txtolddate=document.getElementById(s1);
       
    var voucherno=txtvoucherno.value;
    if(voucherno=="")
    {
        return false;
    }
 
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
   for(var i=2;i<r;i++)
   {
        var txtno;
        if(i<10)
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtvoucherno");
        else
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtvoucherno");

         if(txtvoucherno.value==txtno.value)
           {
                if(txtvoucherno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate Document Number....Enter another Document Number....");
                    txtvoucherno.value="";
                    txtvoucherno.focus();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringVoucherDetails.aspx?mode=date&code=" + voucherno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                        txtolddate.value=res[1];
                    else if(res[0]=="false")
                        {
                            alert("InValid Voucher No....");
                            txtolddate.focus();
                            return false;
                        }
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
            <td class="blackfnt" align="center">Re-Assign Voucher Date </td>
        </tr>
    </table>

<br />

    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
        
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
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
        
                <asp:TemplateField HeaderText="Voucher Number">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtvoucherno"></asp:TextBox>
                            </ItemTemplate>
                </asp:TemplateField>
            
                 <asp:TemplateField HeaderText="Voucher Date">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                 <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:TextBox ID="txtolddate" runat="server"></asp:TextBox>
                    </ItemTemplate>
                 </asp:TemplateField>
                 
                 <asp:TemplateField HeaderText="New Voucher Date">
                 <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                 <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:TextBox ID="txtnewdate" runat="Server" Width="80"></asp:TextBox>
                        
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
<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
<asp:HiddenField ID="hdnrows" runat="server" Value="5" />


</asp:Content>
