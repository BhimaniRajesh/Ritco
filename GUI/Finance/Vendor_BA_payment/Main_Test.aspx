<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Main_Test.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_Main_Test" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<br />
<div align="left">
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" style="width:9.5in">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Vendor Payment</b> </font>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="35%">
                <font class="blackfnt">Vendor Bill Entry</font>
            </td>
         <td align="left">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="THC" PostBackUrl="./PaymentAgainstBillEntry/Vendor/THCSearch.aspx"/><%--../chequemgt/DepositVoucher_Done.aspx--%>
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-Staff" PostBackUrl="./PaymentAgainstBillEntry/PDc/PDCSearch.aspx" /><%--../Advice/AdviceViewPrintstep1.aspx--%>
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-BA" PostBackUrl="~/GUI/Finance/Vendor_BA_payment/BA_Payment/BAPayment_BillEntry_step1.aspx" />
                 <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Others(New)" PostBackUrl="~/GUI/Finance/Vendor_BA_payment/ExpenseEntry/OtherBillentry.aspx" />
            </td>
           
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="35%">
                <font class="blackfnt">Payments Against Bill Entry</font>
            </td>

             <td align="left">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="THC" PostBackUrl="./VendorBillEntry/Vendor/THCSearch.aspx?doctype=THC" /> 
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-Staff" PostBackUrl="./VendorBillEntry/Vendor/THCSearch.aspx?doctype=PDC"/>
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-BA" PostBackUrl="./VendorBillEntry/Vendor/THCSearch.aspx?doctype=BA"/>
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Others" PostBackUrl="./VendorBillEntry/Vendor/THCSearch.aspx?doctype=Others" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="35%">
                <font class="blackfnt">Prepare Voucher</font>
            </td>
             <td align="left">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false" Text="THC" PostBackUrl="./PrepareVoucher/Vendor/THCSearch.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-Staff" PostBackUrl="~/GUI/Finance/Vendor_BA_payment/PrepareVoucher/RunSheet/Runsheet_step1.aspx"/>
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false" Text="PRS/DRS-BA" PostBackUrl="~/GUI/Finance/Vendor_BA_payment/BA_Payment/BAPayment_Direct_step1.aspx" />
                <%--<font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Others" PostBackUrl="ExpenseEntry.aspx" />
     --%>       </td>
            
        </tr>

        

        

    </table>
</div>




</asp:Content>
