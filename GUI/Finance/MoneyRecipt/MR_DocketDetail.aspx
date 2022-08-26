<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_DocketDetail.aspx.cs"
    Inherits="GUI_Finance_MoneyRecipt_MR_DocketDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Docket Detail</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <table border="1" class="bgbluegrey">
                <tr bgcolor="white" class="bgbluegrey">
                    <td bgcolor="white">
                        <font class="blackfnt"><asp:Label ID="Lbl_Title" CssClass="blackfnt" runat="server" Text=""></asp:Label></font>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GrdPaidFollow"  EmptyDataText="No Records Found....."
                AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="true" ShowFooter="false"
                HeaderStyle-CssClass="bgbluegrey" BackColor="white" runat="server" SelectedIndex="1" FooterStyle-BackColor="white"
                OnRowDataBound="GrdPaidFollow_RowDataBound" Width="100%">
                <Columns>
                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
            </asp:GridView>
        </div>
    </form>
</body>
</html>
