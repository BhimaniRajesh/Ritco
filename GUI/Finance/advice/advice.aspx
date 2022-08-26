<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="advice.aspx.cs" Inherits="GUI_finance_advice_advice" Title="Untitled Page" %>
<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl_1.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
 <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript">
 var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
		
    function myFunc(obj)
    {
        
        var temp  = obj.value.toUpperCase()
        
        document.getElementById(obj.name).value = temp;
    }
    
    function test()
        {
            
            window.open("popup-branch.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")

        }
        function check()
        {
        
        
                         Frmnae="ctl00$MyCPH1$"
                           var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                        //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
                            // return false;
				            if(document.getElementById(Frmnae+"txtAdviceDate").value=="")
				            {
				              alert("Please enter the Advice Date")
				              document.getElementById(Frmnae+"txtAdviceDate").focus();
				              return false;
				            }
						 
				        	  var dt =document.getElementById(Frmnae+"txtAdviceDate").value
				
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
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
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Advice Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(Frmnae+"txtAdviceDate").focus();
						return false;
				}
				                if (dt>server_dt)
				                {
						                alert( "Advice Date  should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtAdviceDate").focus();
						                return false;
				                }
				                
				            if(document.getElementById(Frmnae+"txtRaisedOn").value=="")
				            {
				              alert("Please enter the Raised On Barnch")
				              document.getElementById(Frmnae+"txtRaisedOn").focus();
				              return false;
				            }
				             if(document.getElementById(Frmnae+"txtReason").value=="")
				            {
				              alert("Please enter the Reason")
				              document.getElementById(Frmnae+"txtReason").focus();
				              return false;
				            }
				             if(document.getElementById("ctl00$MyCPH1$UCPayment$dlstTransType").value=="")
				            {
				              alert("Please Select Mode OF Transaction")
				              document.getElementById("ctl00$MyCPH1$UCPayment$dlstTransType").focus();
				              return false;
				            }
				              if(document.getElementById("ctl00$MyCPH1$UCPayment$dlstAcccode").value=="")
				            {
				              alert("Please Select Account")
				              document.getElementById("ctl00$MyCPH1$UCPayment$dlstAcccode").focus();
				              return false;
				            }
				            
				            if(document.getElementById("ctl00$MyCPH1$UCPayment$dlstTransType").value!="CASH")
				            {
				                if(document.getElementById("ctl00$MyCPH1$UCPayment$txtChqNo").value=="")
				                {
				                  alert("Please Enter Cheque NUmber")
				                  document.getElementById("ctl00$MyCPH1$UCPayment$txtChqNo").focus();
				                  return false;
				                }
				            
				                if(document.getElementById("ctl00$MyCPH1$UCPayment$txtChqDate").value=="")
				                {
				                  alert("Please Enter Cheque Date")
				                  document.getElementById("ctl00$MyCPH1$UCPayment$txtChqDate").focus();
				                  return false;
				                }
				                
				            }
				            
				                if(parseFloat(document.getElementById("ctl00$MyCPH1$UCPayment$txtAmount").value)<=0)
				                {
				                  alert("Please Enter Amount Greater Then Zero")
				                  document.getElementById("ctl00$MyCPH1$UCPayment$txtAmount").focus();
				                  return false;
				                }
				                
			click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00_MyCPH1_click_count").value=click_count
					return true;
				} 
        }
</script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
            <asp:HiddenField ID="click_count" runat="server" Value="0" />
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fund Transfer</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
                </td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 75%"
        align="center">
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Advice No </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt" color="red">System Generated...</font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Advice Type</font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">
                    <asp:DropDownList ID="dlstAdviceType" runat="server">
                        <asp:ListItem Selected="True" Value="D">Debit Advice</asp:ListItem>
                        <asp:ListItem  Value="C">Credit Advice</asp:ListItem>
                    </asp:DropDownList></font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Advice Date </font><font class="blackfnt" color="red">*</font></td>
            <td align="left" class="blackfnt" width="40%">
                <asp:TextBox ID="txtAdviceDate" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="10" Width="60px" ></asp:TextBox><font class="blackfnt">dd/mm/yyyy</font>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldAdviceDate" runat="server" ErrorMessage="Please Enter Advice Date!!!"
                    ControlToValidate="txtAdviceDate" Display="Dynamic" ValidationGroup="SYS"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionVoucherDate" runat="server" ValidationGroup="SYS"
                    ControlToValidate="txtAdviceDate" ErrorMessage="Please Enter Valid Date!!!" Display="Dynamic"
                    ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                <%--<asp:RangeValidator ID="RangeVoucherDate"  Type="Date" runat="server" ErrorMessage="Please Enter Valid Date!!!" ControlToValidate="txtVoucherDate" Display="Dynamic"></asp:RangeValidator>
            --%>
            </td>
            <td bgcolor="#FFFFFF">
                <font class="blackfnt">Generated by</font></td>
            <td bgcolor="#FFFFFF" style="text-align: left">
                <font class="blackfnt">
                    <asp:Label ID="lblGenerateBy" runat="server" Text="Label"></asp:Label></font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td bgcolor="#FFFFFF">
                <font class="blackfnt">Raised by</font></td>
            <td bgcolor="#FFFFFF" style="text-align: left">
                <font class="blackfnt">
                    <asp:Label ID="lblRaisedBy" runat="server" Text="Label"></asp:Label>
                </font>
            </td>
            <td bgcolor="#FFFFFF">
                <font class="blackfnt">Raised on Branch</font></td>
            <td bgcolor="#FFFFFF" style="text-align: left">
                <font class="blackfnt">
                    <asp:UpdatePanel ID="up1"   UpdateMode="Always" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:TextBox ID="txtRaisedOn" AutoPostBack="true" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="4" Width="60px" OnTextChanged="Valid_Location"></asp:TextBox>
                            <asp:Label ID="error" runat="server" CssClass="redfnt"></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    
                    <input type="button" onclick="test()" Value="..." style="width: 18px; height: 21px" size="" />
                    <%--<asp:LinkButton ID="cmdctrpopup" runat="server" Text="..." ></asp:LinkButton>--%>
                    <%--<asp:Button ID="cmdctrpopup" runat="server" Text="..."   />--%></font></td>
        </tr>
        <tr bgcolor="white">
            <td bgcolor="#FFFFFF" valign="top">
                <font class="blackfnt">Reason <span style="color: #ff0000">*</span></font></td>
            <td bgcolor="#FFFFFF" colspan="3" style="text-align: left">
                <font class="blackfnt">
                    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="3" Columns="25" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Reason!!!"
                    ControlToValidate="txtReason" Display="Dynamic" ValidationGroup="SYS"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr>
            <td bgcolor="#FFFFFF">
                <font class="blackfnt">Enclosed Documents</font></td>
            <td bgcolor="#FFFFFF" colspan="3" style="text-align: left">
                <font class="blackfnt">
                    <asp:TextBox ID="txtEnclosedDoc" runat="server"  TextMode="MultiLine" Rows="3" Columns="25"></asp:TextBox>
                </font>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="1" cellspacing="1" style="width: 75%"
        align="center">
        <tr bgcolor="white">
        <td>
         <asp:UpdatePanel ID="UpdatePanePayment"  UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
               <UC2:UCPaymentControl ID="UCPayment" runat="server" ></UC2:UCPaymentControl>
               </ContentTemplate> 
                </asp:UpdatePanel> 
    
    </td></tr>
    </table>
    <br />
   <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 75%" align="center"
        >
        <tr bgcolor="white">
        <td align="center">
     <asp:Button ID="cmdSubmit"  runat="server" Text="Submit" OnClick="cmdSubmit_Click" />
              </td></tr>
    </table>
    <br />
</asp:Content>
