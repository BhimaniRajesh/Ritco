<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmSalesDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
        <br />
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Sales Summary Report</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table style="width: 306px; height: 19px" border="0" class="boxbg" cellpadding="0"
            cellspacing="1" id="TABLE1">
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 23px">
                    Your Query Here
                </td>
            </tr>
            <%--<table align="center" style="width: 282px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing="1">
        <tr class="bgbluegrey" > <td colspan="3"  align="center" style="height: 23px">  Your Query Here
     </td></tr>--%>
            <%--<tr bgcolor="white">
            <td class="blackfnt" style="width: 25px; height: 23px;">
                Location</td>
            <td class="blackfnt" style="width: 150px; height: 23px;">
                <div align="left"><asp:Label ID="lblLocation" runat="server" Text="" Width="233px"></asp:Label></div> 
            </td>
        </tr>--%>
            <tr bgcolor="white">
                <td class="blackfnt" style="width: 25px; height: 20px">
                    Date
                </td>
                <td class="blackfnt" style="width: 150px; height: 20px">
                    <div align="left">
                        <asp:Label ID="lblDateRange" runat="server" Text="" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:GridView ID="GrdToPayFollow" OnPageIndexChanging="PageIndexChanged_Click" AllowPaging="true"
            PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
            CssClass="boxbg" CellPadding="5" CellSpacing="1" BorderWidth="0" runat="server" Width="762px" OnRowCreated="GrdToPayFollow_RowCreated"
            EmptyDataRowStyle-CssClass="blackfnt" EmptyDataText="No Records Found !!!">
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center"/>
            <PagerStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblid" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Docket"
                    DataField="Docket" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Booking Date"
                    DataField="dockdt" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Origin"
                    DataField="orgncd" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Consignee"
                    DataField="consignee" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Docket Date"
                    DataField="dockdt" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Consignor"
                    DataField="consignor" />
                <asp:BoundField  ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="DestCd"
                    DataField="destcd" />
            </Columns>
        </asp:GridView>
        <br />
        <div align="center" style="width:762px">
            <asp:Button ID="cmdexcel" OnClick="cmdexcel_Click" runat="server" Text="Excel" BackColor="White"
                Width="54px"></asp:Button></div>
    </div>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
</asp:Content>
