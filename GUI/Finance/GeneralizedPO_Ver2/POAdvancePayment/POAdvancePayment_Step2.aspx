<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POAdvancePayment_Step2.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_SinglePO_GRN_DataList" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl_FA.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" src="../../../Images/commonJs.js" type="text/javascript"></script>

    <script language="javascript" src="../../Billing_Ver1/Billing.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
        FRM_Name = "ctl00$MyCPH1$"
        User_CTR_Frm_Name = "ctl00$MyCPH1$UCMyPaymentControl1$"
        window.onload = onPageLoad
        function onPageLoad() {
            PaymentAmountCalculation()
        }
        function PaymentAmountCalculation() {
            document.getElementById(User_CTR_Frm_Name + "txtNetPay").value = rounditn(parseFloat(document.getElementById(FRM_Name + "txtadv").value), 2)
            document.getElementById(User_CTR_Frm_Name + "txtAmtApplA").value = rounditn(parseFloat(document.getElementById(FRM_Name + "txtadv").value), 2)
        }
    </script>

    <div>
        <table width="800" border="0" cellpadding="0" cellspacing="0">
            <tr bgcolor="white">
                <td style="height: 15px">
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="height: 15px">
                    <table border="0" cellpadding="3" width="100%" bgcolor="#ffffff" cellspacing="1"
                        class="boxbg" align="left">
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Purchase Order No</b></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblPOCode" runat="server"></asp:Label></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Vendor Code & Name</b></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblVendorCode" runat="server"></asp:Label></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>PO Amount</b></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="TxtPOAmt" Enabled="false" runat="server" BorderStyle="Groove"></asp:TextBox>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Advance Amount</b></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtadv" Enabled="false" runat="server" BorderStyle="Groove"></asp:TextBox>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Balance Payment</b></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtbalamt" Enabled="false" runat="server" BorderStyle="Groove"></asp:TextBox>
                                </font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF" id="trPaymentCtrl" runat="server">
                <td colspan="4" align="center" style="height: 21px">
                    <table border="0" cellspacing="1" cellpadding="4" width="100%" align="left" class="boxbg">
                        <font class="blackfnt">Note : Please enter the payment details if Net Payable amount
                            &gt;0 . </font>
                        <br />
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Payment Details</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td align="center" colspan="4">
                                <asp:UpdatePanel ID="UpdatePanePayment" runat="server">
                                    <ContentTemplate>
                                        <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman;">
                <td align="center" colspan="3" style="height: 25px">
                    <asp:Button ID="ButSubmit" runat="server" Text="Submit" OnClick="ButSubmit_Click"
                        CssClass="BtnClass" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
