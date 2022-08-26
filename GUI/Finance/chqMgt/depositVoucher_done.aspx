<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="depositVoucher_done.aspx.cs" Inherits="GUI_finance_chqMgt_depositVoucher_done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
    function nwOpenPopup(url, height) {
        window.open(url,'myWindow','height='+height+',width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
</script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Cheque Management : Cheque Deposit Entry</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <center>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully updated:" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Code" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            
            
        </tr>

        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <%
                    string strVoucherNo = Request.QueryString["voucherNo"].ToString();
                    string strViewURL = "";
                    string strPrintURL = "";

                    strViewURL = "Print/DepositeVoucherView.aspx?voucherNo=" + strVoucherNo;
                    strPrintURL = "Print/DepositeVoucherPrint.aspx?voucherNo=" + strVoucherNo;
                %>

                <a href="javascript:nwOpenPopup('<%= strViewURL %>', 400);"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:nwOpenPopup('<%= strPrintURL %>', 300);"><font class="blackfnt">Print</font></a>
                <asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
            </td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GUI/finance/chqMgt/onAccount.aspx" CssClass="blackfnt">Preapare More On Account Cheque Entry</asp:HyperLink> 
                  </td>
        </tr>
         <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px"><asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/GUI/finance/chqMgt/onAccount.aspx" CssClass="blackfnt">Preapare Cheque Deposit Voucher</asp:HyperLink> </td>
        </tr>
        
        
    </table>
    </center>
</asp:Content>

