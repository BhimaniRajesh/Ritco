<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EMP_DOWNLOAD.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div style="width: 10in">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Delivery Location
                                Stock Report</b></font>
                </td>
            </tr>
        </table>
        <table align="center" style="width: 3.5in">
            <tr>
                <br />
                <br />
                <br />
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Dtl" runat="server" align="center" BorderWidth="1" CellSpacing="1"
                    CellPadding="5" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="true"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                </asp:GridView>
                <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
    </div>
</asp:Content>
