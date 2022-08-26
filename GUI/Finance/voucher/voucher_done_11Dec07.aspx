<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="voucher_done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Voucher Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br><br>
    <center>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
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
                <asp:LinkButton ID="lnkView" runat="server" Text="View" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkPrint" runat="server" Text="Print" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
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
                <span style="font-size: 8pt; font-family: Verdana">Preapare More Journal Voucher<strong>
                    &nbsp; &nbsp;</strong></span><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GUI/finance/voucher/JournalVoucher_OnetoMany.aspx">Single</asp:HyperLink>
                <a href="#"></a>|
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/GUI/finance/voucher/JournalVoucher.aspx">Multiple</asp:HyperLink><a
                    href="#"><u></u></a></td>
        </tr>
         <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px"><asp:LinkButton ID="lnkStep2" runat="server" Text="Prepare Debit Voucher" CssClass="blackfnt" PostBackUrl="#" /></td>
        </tr>
        
        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="Prepare Credit Voucher" CssClass="blackfnt" PostBackUrl="#" /></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="3" style="height: 18px">
                <asp:LinkButton ID="LinkButton3" runat="server" Text="Prepare Contra Voucher" CssClass="blackfnt" PostBackUrl="#" /></td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="View & Print Voucher" CssClass="blackfnt" PostBackUrl ="#" /></td>
        </tr>
    </table>
    </center>
</asp:Content>

