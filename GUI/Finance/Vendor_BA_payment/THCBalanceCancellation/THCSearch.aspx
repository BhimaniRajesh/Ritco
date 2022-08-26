<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCSearch.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_THCBalanceCancellation_THCSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
        var Form_name="ctl00$MyCPH1$"
        
        function check()
        {
           
                   if (document.getElementById("ctl00_MyCPH1_txtDocNo").value=="" && document.getElementById("ctl00_MyCPH1_txtTHCNO").value == "" )
					    {
							alert("Please Enter Voucher No or THC No.")
							return false;
					    }
				   else
				        {
				            return true;
				        }
	    }
							
        
    </script>

    <br />
    <div align="left">
        <table style="width: 7.5in" border="0" align="left" cellpadding="3" cellspacing="1"
            bgcolor="#808080" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <font class="blackfnt"><b>THC Balance Cancellation </b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td valign="top">
                    <font class="blackfnt">
                        <asp:Label ID="lblDocument" runat="server" Text="Enter System Generated Voucher No"></asp:Label>
                    </font>
                </td>
                <td valign="top" align="left">
                    <asp:TextBox ID="txtDocNo" runat="server" Width="164px"></asp:TextBox><font class="blackfnt"></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td valign="top" colspan="3">
                    <font class="blackfnt"><b>OR</b> </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td valign="top">
                    <font class="blackfnt">
                        <asp:Label ID="lblthcno" runat="server" Text="THC NO"></asp:Label>
                    </font>
                </td>
                <td valign="top" align="left">
                    <asp:TextBox ID="txtTHCNO" runat="server" Width="164px"></asp:TextBox><font class="blackfnt"></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="2" align="center">
                    <asp:Button ID="btnsubmit1" runat="server" Text="Submit" CssClass="blackfnt" OnClientClick="javascript:return check()" OnClick="btnsubmit1_Click" /></td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
