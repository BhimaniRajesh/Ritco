<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <%--<asp:Label ID="Label1" Font-Underline="true" Font-Bold ="true" runat="server" Text="Reports/Operations/DCR Register Report"></asp:Label>--%>
    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>DCR Register</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table align="left" border="0" cellpadding="5" cellspacing="1" class="boxbg" style="width: 398px;
        height: 1px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 23px">
                Your Query
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 91px; height: 16px;">
                Docket Range</td>
            <td style="width: 136px; height: 16px;">
                <div align="left">
                    <asp:Label ID="lbldaterange" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
            </td>
        </tr>
    </table>
    <br />
    <asp:TextBox ID="TxtRO" runat="server" Width="66px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
        ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
            ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
                ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
                    ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
    <br />
    <div align="left">
        <asp:GridView ID="GrdPaidFollow" AllowPaging="true" OnRowDataBound="GrdToPayFollow_RowDataBound1"
            OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
            runat="server" SelectedIndex="1" EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-CssClass="blackfnt"
            EmptyDataText="No Records Found ....!!" CellPadding="5" CellSpacing="1" BorderWidth="0">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="LblSrNo" CssClass="blackfnt" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" BackColor="white"  CssClass="bgbluegrey" />
            <HeaderStyle  HorizontalAlign="Center" BackColor="white" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle HorizontalAlign="Center" BackColor="white" CssClass="boxbg" />
        </asp:GridView>
    </div>
    <br />
    <br />
    <div align="center" style="width: 10.5in">
        &nbsp;<asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel"
            Width="54px" />
    </div>
</asp:Content>
