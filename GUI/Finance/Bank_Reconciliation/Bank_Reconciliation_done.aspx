<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Bank_Reconciliation_done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
    function nwOpenPopup(url, height) {
        window.open(url,'myWindow','height='+height+',width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
</script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">BRS Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br /><br />
 <table border="0" width="100%">
        <tr>
            <td style="width: 10%">
            </td>
            <td width="90%" align="left">
            <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="True" Text="Number of document has been successfully Updated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center" colspan="3">
            <%
                string number = Request.QueryString["number"].ToString();
            %>
            <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Number of document has been successfully Updated"></asp:Label> : <%=number %></td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label></td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
                <span style="font-size: 8pt; font-family: Verdana"><strong>
                    </strong></span>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GUI/Finance/Bank_Reconciliation/prestart.aspx">Preapare More Bank Reconcilation</asp:HyperLink></td>
        </tr>
    </table>
            </td>
        </tr>
 </table>
    
    
</asp:Content>

