<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmSalesDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <div align="left">
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Convert.ToString(Session["DocketCalledAs"]) + " Not Yet Delivered Report"%></b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" class="boxbg"  CellSpacing="1" CellPadding="5" id="TABLE1">
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 23px">
                    Your Query Here
                </td>
            </tr>
            <%--<table align="center" style="width: 282px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing="1">
        <tr class="bgbluegrey" > <td colspan="3"  align="center" style="height: 23px">  Your Query Here
     </td></tr>--%>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Location</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblLocation" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date Range
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Report Type
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblrpttype" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div style="width:10in">
        <asp:GridView ID="GrdToPayFollow" OnPageIndexChanging="PageIndexChanged_Click" AllowPaging="true"
            PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
            runat="server" OnRowCreated="GrdToPayFollow_RowCreated"  CssClass="boxbg"
            EmptyDataRowStyle-CssClass="blackfnt"  EmptyDataRowStyle-BackColor="white"  EmptyDataText="No Records Found !!!!"  BorderWidth="0" CellSpacing="1" CellPadding="5" Width="100%">
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center"/>
            <Columns>
                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrno" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center"   ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" HeaderText="Docket"
                    DataField="dockno" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center"   HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Delivery Loc."
                    DataField="dly_loc" />
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center"   ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" HeaderText="Consignor"
                    DataField="csgnnm" />
                <asp:BoundField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt"  ItemStyle-BackColor="white" HeaderText="Consignee"
                    DataField="csgenm" />
                <asp:BoundField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Booking Date"  ItemStyle-BackColor="white"
                    DataFormatString="{0:dd-MMM-yy}" ItemStyle-Width="80" DataField="dockdtv" />
                <asp:BoundField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" HeaderText="Comm. Dely. Date"
                    DataFormatString="{0:dd-MMM-yy}" ItemStyle-Width="80" DataField="cdeldtv" />
                <asp:BoundField ItemStyle-HorizontalAlign="Center"  HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt"  ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" HeaderText="Dep Date"
                    DataFormatString="{0:dd-MMM-yy}" ItemStyle-Width="80" DataField="dep_dtv" />
                <asp:BoundField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center"  ItemStyle-CssClass="blackfnt"  ItemStyle-BackColor="white" HeaderText="Packages No."
                    DataField="pkgsno" />
                <asp:BoundField  HeaderStyle-HorizontalAlign="Center"  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="right" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Charge Wt."
                    DataField="chrgwt" />
                <asp:BoundField  HeaderStyle-HorizontalAlign="Center"  HeaderStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center"  ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" HeaderText="Arrival Date"
                    DataFormatString="{0:dd-MMM-yy}" ItemStyle-Width="80" DataField="arrv_dtv" />
                <asp:BoundField  HeaderStyle-HorizontalAlign="Center"  ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt"  ItemStyle-BackColor="white" DataFormatString="{0:dd-MMM-yy}"
                    HeaderText="Delivery Date" ItemStyle-Width="80" DataField="dely_dtv" />
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" BackColor="white" />
        </asp:GridView>
        </div>
        <br />
        <div align="center" style="width:10.5in">
            <asp:Button ID="cmdexcel" OnClick="cmdexcel_Click" runat="server" Text="Excel" Width="54px">
            </asp:Button></div>
    </div>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
</asp:Content>
