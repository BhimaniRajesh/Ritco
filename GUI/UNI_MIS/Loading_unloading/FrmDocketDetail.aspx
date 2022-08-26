<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />
    <table style="width: 1000px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Loading Unloading
                            Report</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="left">
        <table align="left" style="width: 362px; height: 19px" border="0" class="boxbg" cellpadding="5"
            cellspacing="1">
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 19px">
                    Your Query Here
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Location</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblLocation" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <%--<asp:datagrid ID="GrdToPayFollow" OnItemCommand="gotolink" OnItemDataBound="eventhandler" runat="server"  PagerStyle-Position="Bottom" PagerStyle-Mode="NumericPages"
              PagerStyle-HorizontalAlign="left"
              PagerStyle-CssClass="pageLinks" CssClass="boxbg" BackColor="white" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="boxbg" AllowPaging ="True" BorderWidth="1" CellPadding="2" AllowSorting ="True" PagerSettings-FirstPageText="[First]" OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand = "SortCommand_Click" AutoGenerateColumns="False" style="z-index: 103; left: 40px; position: absolute; top: 325px">
              --%>
    <%-- <asp:GridView align="center" ID="GridView2" runat="server"
                                                            BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"

                                                            PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                             AutoGenerateColumns="false"                    
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            
                                                            PagerSettings-FirstPageText="[First]" Pag
--%>
    <div align="left">
        <asp:GridView ID="GrdToPayFollow" OnPageIndexChanging="PageIndexChanged_Click" AllowPaging="true"
            PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
            runat="server" CellPadding="5" CellSpacing="1" BorderWidth="0" CssClass="boxbg" Width="762px">
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerStyle HorizontalAlign="Center" BackColor="white" />
        </asp:GridView>
    </div>
    <br />
    <div align="center" style="width: 8in">
        <asp:Button ID="cmdexcel" OnClick="cmdexcel_Click" runat="server" Text="Excel" Width="54px">
        </asp:Button>
    </div>
</asp:Content>
