<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="RE_Done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
    function nwOpenViewWindow(url) {
        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
    function nwOpenPrintWindow(url) {
        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
    
</script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Bank Reconsilation</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br /><br />
 <table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
            <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Document Has Been Successfully Updated:" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
 

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

     
         <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="Query.aspx"><font class="blackfnt"> Click Here To Bank Reconsilation </font> </a>
              <%--  &nbsp;<asp:LinkButton ID="lnkStep2" runat="server" Text="Prepare Debit Voucher (With New Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate='today'" />--%></td>
        </tr>
       
    </table>
            </td>
        </tr>
 </table>
    
    
</asp:Content>

