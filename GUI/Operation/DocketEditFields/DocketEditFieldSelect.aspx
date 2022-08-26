<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DocketEditFieldSelect.aspx.cs" Inherits="GUI_Operation_DocketEditFields_DocketEditFieldSelect" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cntone" runat="server">
<br /><br />
    <asp:Panel runat="server" Width="10in" ID="divfields" HorizontalAlign="Center">
        <asp:Table runat="server" Width="30%" CssClass="boxbg" CellSPacing="1" CellPadding="0" BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
                    Select Field To Edit
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
                    <asp:RadioButtonList ID="optrequestlist" runat="server" CellSpacing="1">
                        <asp:ListItem Selected="True" Value="custinfo">Consignor/Consingee</asp:ListItem>
                        <asp:ListItem Value="spcinst">Special Instructions</asp:ListItem>
                        <asp:ListItem Value="obdno">OBD No</asp:ListItem>
                        <asp:ListItem Value="localflag">Local Flag</asp:ListItem>
                        <asp:ListItem Value="pickupdel">PickUp Delivery</asp:ListItem>
                        <asp:ListItem Value="custrefno">Customer ref. No</asp:ListItem>
                        <asp:ListItem Value="pmark">Private Mark</asp:ListItem>
                        <asp:ListItem Value="billedat">Billed At</asp:ListItem>
                    </asp:RadioButtonList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                    <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
