<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="OctroiBill_viewPrint.aspx.cs" Inherits="GUI_Octroi_Octroi_Bill_OctCustBill_viewPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
       var Ptrinyn="<%=Ptrinyn%>"
       if(Ptrinyn=="1")
       {
			window.print();
		}
    </script>

    <div align="center">
        <%--SUMMARY HEADER LINE--%>
        <br />
        <br />
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>"
            width="85%">
            <tr class="<%=bgbluegrey %>">
                <td align="center" class="blackfnt">
                    Octroi Bill Summary</td>
            </tr>
        </table>
        <br />
        <br />
        <%--SUMMARY TABLE--%>
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>"
            width="85%">
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left" style="width: 25%">
                    Bill Number :
                </td>
                <td class="blackfnt" style="width: 25%;" align="left">
                    <asp:Label ID="lblbillno" runat="server"></asp:Label>
                </td>
                <td class="blackfnt" align="left" style="width: 25%">
                    Bill Date :
                </td>
                <td class="blackfnt" style="width: 25%" align="left">
                    <asp:Label ID="lblbilldate" runat="server"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left" style="width: 25%">
                    Party Name :
                </td>
                <td class="blackfnt" align="left" colspan="3" style="width: 75%">
                    <asp:Label ID="lblpartyname" runat="server"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left">
                    Generated at Location :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblgenloc" runat="server"></asp:Label>
                </td>
                <td class="blackfnt" align="left">
                    Bill Submission at :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblsubloc" runat="server"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left">
                    Generated for Location :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblgenforloc" runat="server"></asp:Label>
                </td>
                <td class="blackfnt" align="left">
                    Bill Collection at :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblcollectat" runat="server"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left">
                    Bill Amount :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblbillamt" runat="server"></asp:Label>
                </td>
                <td class="blackfnt" align="left">
                    Due Date :
                </td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblduedate" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <p class="blackfnt" align="center">
            <strong>Details</strong></p>
        <%--GRID VIEW OF DATA--%>
        <asp:GridView align="center" ID="docdata" runat="server" BorderWidth="1" CellPadding="2"
            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
            AutoGenerateColumns="false" ShowFooter="true" PagerSettings-FirstPageText="[First]"
            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
            OnRowDataBound="GridView_RowDataBound" OnSelectedIndexChanged="docdata_SelectedIndexChanged"
            Width="85%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Dockno" HeaderText="Doc No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ORGNCD" HeaderText="Origin">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DESTCD" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OCTAMT" HeaderText="Octroi Amt ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="clearance_chrg" HeaderText="Clearance Charge">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="processing_per" HeaderText="Processing(%)">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="process_chrg" HeaderText="Processing Chrg.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OTCHG" HeaderText="Other Chrg.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="TOTAMT" HeaderText="Total">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RECPTNO" HeaderText="Reciept No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="RECPTDT" HeaderText="Reciept Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:HiddenField ID="grrwocnt" runat="server" />
        <br />
        <table id="tblremark" cellpadding="0" cellspacing="0" border="1" runat="server" width="85%" class="boxbg">
            <tr bgcolor="#ffffff">
                <td>
                    Remarks :</td>
                <td align="left">
                    <asp:Label Width="85%" ID="lblremark" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>
</asp:Content>
