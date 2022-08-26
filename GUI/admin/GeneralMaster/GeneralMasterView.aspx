<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralMasterView.aspx.cs"
    Inherits="GUI_admin_GeneralMaster_GeneralMasterView" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>General Master</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">

        function printPage() {
            var hdnflagprint = document.getElementById("hdnflagprint");
            if (hdnflagprint.value == "Y")
                window.print();

            return false;
        }

        function popupPrint() {
            var hdnCode = document.getElementById("hdnCode");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("GeneralMasterView.aspx?mastercode=" + hdnCode.value + "&print=Y", "", winOpts);
            return false;
        }
    </script>

</head>
<body onload="javascript:return printPage()">
    <form id="frmmain" runat="server">
    <table width="6in">
        <tr>
            <td align="right">
                <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print"
                    OnClientClick="javascript:return popupPrint();">
                </asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Table ID="tblmain" runat="server" Width="6in" HorizontalAlign="center" CssClass="ftbl">
                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell HorizontalAlign="Right" runat="server">
                            <asp:GridView CssClass="ftbl" AutoGenerateColumns="false" RowStyle-CssClass="nrow"
                                CellSpacing="1" HorizontalAlign="center" ID="grvgeneral" runat="server" BorderWidth="0"
                                OnRowDataBound="grvgeneral_RowDataBound" HeaderStyle-CssClass="bgbluegrey" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="No.">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblcodeid" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblcodedesc" runat="server" Width="250px"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblActiveFlag" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnflagprint" runat="server" />
    <asp:HiddenField ID="hdnCode" runat="server" />
    
    </form>
</body>
</html>
