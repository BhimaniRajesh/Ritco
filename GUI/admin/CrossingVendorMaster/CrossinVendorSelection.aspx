<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossinVendorSelection.aspx.cs" Inherits="GUI_admin_CrossingVendorMaster_CrossinVendorSelection" %>

<asp:Content ContentPlaceHolderID="MyCPH1" runat="server" ID="cntone">

    <script type="text/javascript" language="javascript">
    </script>

    <br />
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
                BorderWidth="0">
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="left">
           Select Vendor Type
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:DropDownList ID="cboVendorType" runat="server" CssClass = "input" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="left">
           Select Vendor
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:DropDownList ID="cboVendor" runat="server" AutoPostBack="true">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="left">
           Select for
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:DropDownList ID="cboAddEdit" runat="server" AutoPostBack="true">
                        <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                        <asp:ListItem Value="A" Text="Add Contract"></asp:ListItem>
                        <asp:ListItem Value="E" Text="Edit/Delete Contract"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Table ID="Table2" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
                BorderWidth="0">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                        <asp:Button ID="btnsubmit" Text="Submit" BorderStyle="Groove" runat="server" CssClass="blackfnt" OnClick="btn_Submit" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
