<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChequeDeposit_Done.aspx.cs" Inherits="GUI_Finance_Cheque_Deposit_ChequeDeposit_Done" Title="Untitled Page" %>
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Voucher Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br /><br />
 <table border="0" width="100%">
        <tr>
            <td width="10%"></td>
            <td width="90%" align="left">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully Generated:" CssClass="blackfnt"></asp:Label>
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
                                string voucherId = Request.QueryString["VoucherNo"].ToString();
                                string voucherType = Request.QueryString["VoucherType"].ToString();
                                string strViewURL = "";
                                string strPrintURL = "";

                                switch (voucherType)
                                {
                                    case "Cheque":
                                        strViewURL = "Print/DepositeVoucherView.aspx?voucherno=" + voucherId + "&printyn=N";
                                        strPrintURL = "Print/DepositeVoucherView.aspx?voucherno=" + voucherId + "&printyn=Y";
                                        break;
                                }
                            %>
                            <a href="javascript:nwOpenViewWindow('<%= strViewURL %>');"><font class="blackfnt">View</font></a>
                            <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                            <a href="javascript:nwOpenPrintWindow('<%= strPrintURL %>');"><font class="blackfnt">Print</font></a>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="3">
                            <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color:White">
                        <td align="left" colspan="3" style="height: 21px">
                            <span style="font-size: 8pt; font-family: Verdana"><strong>
                                </strong></span>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GUI/finance/Cheque_Deposit/ChqDepositVoucher_step1.aspx">Preapare More Cheque Deposit Voucher</asp:HyperLink></td>
                    </tr>   
                    
                </table>
            </td>
        </tr>
 </table>
</asp:Content>

