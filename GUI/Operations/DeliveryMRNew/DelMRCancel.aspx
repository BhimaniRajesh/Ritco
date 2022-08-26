<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DelMRCancel.aspx.cs" Inherits="GUI_Operations_DeliveryMR_DelMRCancel" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="pgr" TagName="ProgressBar" %>
<asp:Content runat="server" ContentPlaceHolderID="MyCPH1">
    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Table Width="8in" ID="tblmain" runat="server" CssClass="boxbg" CellSpacing="1">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">Delivery MR Cancellation</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>Document Type</asp:TableCell>
                    <asp:TableCell>
                        <asp:RadioButtonList ID="optdoctype" RepeatDirection="Horizontal" runat="server"
                            CssClass="blackfnt">
                            <asp:ListItem Selected="True" Text='MR' Value="MR"></asp:ListItem>
                            <asp:ListItem Text='Gatepass' Value="GP"></asp:ListItem>
                        </asp:RadioButtonList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>Document Number</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtmrno" MaxLength="30" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="trmessage" runat="server" CssClass="bgwhite" Visible="false">
                    <asp:TableCell ColumnSpan="2">
                        <asp:Label runat="server" ID="lblmessage" CssClass="redfnt" Font-Bold="false"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnsubmit_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgr:ProgressBar runat="server" ID="pgrone" />
    <asp:HiddenField ID="hdndockname" runat="server" />
    <asp:HiddenField ID="hdndocksf" runat="server" />
</asp:Content>
