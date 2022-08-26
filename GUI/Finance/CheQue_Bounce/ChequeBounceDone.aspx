<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChequeBounceDone.aspx.cs" Inherits="GUI_Finance_CheQue_Bounce_ChequeBounceDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function nwOpen() {
            
            var lblVoucherNo = $("#" + '<%=lblVoucherNo.ClientID%>').text();
            var typ = $("#" + '<%=hdnTramsType.ClientID%>').val();

            if (typ == "CASH RECEIPT" || typ == "BANK RECEIPT" || typ == "BOTH RECEIPT") {
                //  credit     
                //window.open("Print/CreditVoucherView.aspx?voucherno=" + voucherId + "&printyn=N,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
                window.open("../ViewPrint/Voucher Register/Print/CreditVoucherView.aspx?voucherno=" + lblVoucherNo + "&printyn=N", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
            }
            else if (typ == "CASH PAYMENT" || typ == "BANK PAYMENT" || typ == "BOTH PAYMENT") {            //debit            
                window.open("../ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + lblVoucherNo + "&printyn=N", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
            }
        }
    </script>
    <table class="boxbg" id="tblMain" runat="server" cellpadding="1" cellspacing="1">
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <b>Cheque Bounce Successfully</b>
            </td>
        </tr>
        <tr class="bgwhite">
            <td style="width: 50%; text-align: center;">Voucher No</td>
            <td style="width: 50%; text-align: center;">View</td>
        </tr>
        <tr class="bgwhite">
            <td style="width: 50%; text-align: center;">
                <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></td>
            <td style="width: 50%; text-align: center;">
            <a href="JavaScript:nwOpen()" style="text-decoration: underline">View</a>
                <asp:HiddenField ID="hdnTramsType" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>

