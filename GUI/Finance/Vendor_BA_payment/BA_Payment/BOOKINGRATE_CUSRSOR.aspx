<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="BOOKINGRATE_CUSRSOR.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_BOOKINGRATE_CUSRSOR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<asp:Label ID="totcount" runat="server"  ></asp:Label>

<table  width="60%"  align="left" class="boxbg" cellpadding="3" cellspacing="1"
        style="width: 5.5in;">

<tr  class="bgbluegrey"><td  height="30" align="center" colspan="2"></td></tr>
<tr bgcolor="white"><td  height="30"><asp:TextBox ID="DKTlist" Width="250"  runat="server" ></asp:TextBox><font class="blackfnt">(Max 50 Dockets)</font></td><td ><asp:Button runat="server" ID="Submit" Text="Submit" OnClick="Submit_Click" /></td></tr>
</table>
</asp:Content>
