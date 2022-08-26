<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmVoucherCriteria.aspx.cs" Inherits="GUI_Finance_voucher_FrmVoucherCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
    
    </script>

    <br />
    <br />
    <div align="left">
        <table style="width: 10in">
            <tr>
                <td align="left" style="width: 779px">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Finance</b></font></a> <b>&gt; </b><a href="../voucher.aspx"><font class="blklnkund">
                            <b>Payment</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Voucher View & Print</b></font>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div align="left">
        <table border="0" cellpadding="0" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" class="blackfnt" colspan="2">
                    Select Voucher Criteria
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt" valign="top">
                    Select Voucher Document Type</td>
                <td align="left" valign="top">
                    <asp:DropDownList ID="cboDocType" runat="server">
                        <asp:ListItem Text="THC" Value="T"></asp:ListItem>
                        <asp:ListItem Text="PRS/DRS" Value="P"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt">
                    Enter System Voucher No.</td>
                <td align="left" class="blackfnt">
                    <asp:TextBox ID="txtVoucherNo" runat="server" Width="204px"></asp:TextBox></td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt" valign="top">
                    Select Voucher Payment Type</td>
                <td align="left" valign="top">
                    <asp:DropDownList ID="cboPaymentType" runat="server">
                        <asp:ListItem Text="Advance" Value="A"></asp:ListItem>
                        <asp:ListItem Text="Balance" Value="B"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center" class="blackfnt" colspan="2">
                    <asp:Button ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Submit"
                        ForeColor="Black" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
