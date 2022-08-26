<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="voucher_done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>
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
            <td width="10%">
            </td>
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
                        case "Journal":
                            strViewURL = "../ViewPrint/Voucher Register/Print/JournalVoucherView.aspx?voucherno=" + voucherId + "&printyn=N";
                            strPrintURL = "../ViewPrint/Voucher Register/Print/JournalVoucherView.aspx?voucherno=" + voucherId + "&printyn=Y";
                            break;

                        case "Debit":
                            strViewURL = "../ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + voucherId + "&printyn=N";
                            strPrintURL = "../ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + voucherId + "&printyn=Y";
                            //strPrintURL = "../Voucher/Print/DebitVoucherPrint.aspx?voucherno=" + voucherId;
                            break;

                        case "Credit":
                            strViewURL = "../ViewPrint/Voucher Register/Print/CreditVoucherView.aspx?voucherno=" + voucherId + "&printyn=N";
                            strPrintURL = "../ViewPrint/Voucher Register/Print/CreditVoucherView.aspx?voucherno=" + voucherId + "&printyn=Y";
                            break;

                        case "Contra":
                            strViewURL = "../ViewPrint/Voucher Register/Print/ContraVoucherView.aspx?voucherno=" + voucherId + "&printyn=N";
                            strPrintURL = "../ViewPrint/Voucher Register/Print/ContraVoucherView.aspx?voucherno=" + voucherId + "&printyn=Y";
                            break;
                    }
                %>
                <a href="javascript:nwOpenViewWindow('<%= strViewURL %>');"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:nwOpenPrintWindow('<%= strPrintURL %>');"><font class="blackfnt">Print</font></a>
                <%--<asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>--%>
            </td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <%--<tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
                <span style="font-size: 8pt; font-family: Verdana"><strong>
                    </strong></span>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GUI/finance/voucher/JournalVoucher_OnetoMany.aspx">Preapare More Journal Voucher</asp:HyperLink></td>
        </tr>--%>   
         <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="JournalVoucher.aspx?Defaultdate=today"><font class="blackfnt"> Prepare Journal Voucher (With New Date)</font> </a>
              <%--  &nbsp;<asp:LinkButton ID="lnkStep2" runat="server" Text="Prepare Debit Voucher (With New Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate='today'" />--%></td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="JournalVoucher.aspx?Defaultdate=<%=Defaultdate %>"><font class="blackfnt"> Prepare Journal Voucher (With Same Date)</font> </a>
                <%--&nbsp;<asp:LinkButton ID="LinkButton4" runat="server" Text="Prepare Debit Voucher (With Same Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate=<%=Defaultdate %>" />--%></td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="../Debit Voucher/DebitVoucher.aspx?Defaultdate=today"><font class="blackfnt"> Prepare Debit Voucher</font> </a>
                <%--&nbsp;<asp:LinkButton ID="LinkButton4" runat="server" Text="Prepare Debit Voucher (With Same Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate=<%=Defaultdate %>" />--%></td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="../Credit Voucher/CreditVoucher.aspx?Defaultdate=today"><font class="blackfnt"> Prepare Credit Voucher</font> </a>
                <%--&nbsp;<asp:LinkButton ID="LinkButton4" runat="server" Text="Prepare Debit Voucher (With Same Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate=<%=Defaultdate %>" />--%></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="3" style="height: 18px">
                &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" Text="Prepare Contra Voucher" CssClass="blackfnt" PostBackUrl="~/GUI/Finance/voucher/ContraVoucher.aspx" /></td>
        </tr>
          <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
            <a href="../ViewPrint/Voucher Register/FrmCriteria.aspx" ><font class="blackfnt"> View & Print Voucher </font> </a>
                <%--&nbsp;<asp:LinkButton ID="LinkButton4" runat="server" Text="Prepare Debit Voucher (With Same Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate=<%=Defaultdate %>" />--%></td>
        </tr>
        <%--<tr style="background-color: white">
            <td align="left" colspan="3">
                &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Text="View & Print Voucher" CssClass="blackfnt" PostBackUrl ="#" /></td>
        </tr>--%>
    </table>
            </td>
        </tr>
 </table>
    
    
</asp:Content>

