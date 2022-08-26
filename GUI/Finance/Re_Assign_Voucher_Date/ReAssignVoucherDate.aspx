<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ReAssignVoucherDate.aspx.cs" Inherits="GUI_Finance_Accounts_ReAssignVoucherDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript" src="AJAX.js"></script>
                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	var client_name="<%=Session["Client"]%>"
	var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
		
	var FinYear="<%=Session["FinYear"]%>"
	var FinYear_to=parseInt(FinYear)+1
	
	if(FinYear_to<10)
	{
	FinYear_to="0"+FinYear_to
	}
	var FinYear_fromdate="01/04/"+FinYear
	var FinYear_todate="31/03/"+FinYear_to
	var Sle_finyear=FinYear+"-"+FinYear_to
	
	
</script>
                      <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="../../Octroi/ViewnPrint/JS/ViewPrint.js"></script>


<script type="text/javascript" language="javascript">


function validateBoxes()
{
   //debugger; 
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
            
            if(txtvoucherno.value != "")
            {
                if(!isValidDate(txtdate.value,"Voucher"))
                {
                    txtdate.focus();
                    return false;
                 }   
                var dt =txtdate.value
                var dt_dd=dt.substring(0,2)
	            var dt_mm=dt.substring(3,5)
	            var dt_yy=dt.substring(6,10)

                var sdt =server_dt
	            var sdt_dd=sdt.substring(0,2)
	            var sdt_mm=sdt.substring(3,5)
	            var sdt_yy=sdt.substring(6,10)
				
                dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                server_dt1=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
   
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						txtdate.focus();
						return false;
				}
				if (dt>server_dt1)
                {
		                alert( "Voucher Date should not be greater than today's date !!!")
		                txtdate.focus();
		                return false;
                } 
            }
            if(txtvoucherno.value != "")
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
                            alert("InValid Voucher No.........\n\n Or \n\nPlz Enter\nCredit Voucher\nDebit Voucher\nContra Entry\nJournal Voucher");
                            txtvoucherno.value="";
                            txtvoucherno.focus();
                            return false;
                        }
                }
         }
         
    findobj.send(null);
    }
    return false;
}

</script>

<div align="left" style="width: 10.5in;">

<br /><br />

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="bluefnt"><b>Re-Assign Voucher Date </b></font>
            </td>
        </tr>
    </table>
    
<br />

    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
        
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right" width="50%">Enter No. of Rows</td>
            <td class="blackfnt" align="left" width="50%">
                <asp:TextBox runat="server" ID="txtnorows" onkeypress="javascript:return validInt(event)" ></asp:TextBox>
                <asp:Button runat="server" Text="Add Rows" OnClick="btnrows_Click" ID="btnrows"  />
            </td>
        </tr>
    </table>

<br />

  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Voucher Details</td>
        </tr>

<tr bgcolor="#ffffff">
    <td class="blackfnt" align="left">
        <asp:GridView CssClass="boxbg" runat="server" ID="grvcontrols" Width="100%"
                AllowSorting="true" PagerStyle-HorizontalAlign="left"
                BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnRowDataBound="grvcontrols_RowDataBound">
             <Columns>
  
                <asp:TemplateField HeaderText="Sr. No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="center" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                            </ItemTemplate>
                </asp:TemplateField>
        
                <asp:TemplateField HeaderText="Voucher Number">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="center" />
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
                            <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                        </asp:LinkButton>
                    </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
      </td>
</tr>     
<tr bgcolor="#ffffff">
    <td class="blackfnt" align="center">
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
