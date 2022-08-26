<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewFTL.ascx.cs" Inherits="GUI_admin_CustomerContractMaster_Views_ViewFTL" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/CCMFilter.ascx" TagName="Filter"
    TagPrefix="ccm" %>
<asp:Table ID="tblone" runat="server" Width="10in">
    <asp:TableRow>
        <asp:TableCell>
            <ccm:Filter ID="ucfilter" runat="server" />
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:Table ID="Table1" runat="server" Width="100%" CellSpacing="1" CssClass="boxbg">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:LinkButton ID="lnksearch" runat="server" Text="Search" Font-Bold="true" OnClick="lnksubmit_Click"></asp:LinkButton>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow ID="trheader" runat="server" Visible="false">  
        <asp:TableCell>
            <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell Font-Bold="true">FTL Matrix</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                Width="10in" CellSpacing="1" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" OnRowDataBound="grvcharges_RowDataBound" HeaderStyle-CssClass="bgbluegrey"
                PagerSettings-Position="TopAndBottom" PagerSettings-Mode="NumericFirstLast" AllowPaging="true"
                FooterStyle-CssClass="bgbluegrey" AutoGenerateColumns="true" PageSize="20" RowStyle-HorizontalAlign="Right"
                OnPageIndexChanging="grvcharges_PageIndexChanged" RowStyle-CssClass="bgwhite"
                HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="bgwhite">
                <Columns>
                </Columns>
            </asp:GridView>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
