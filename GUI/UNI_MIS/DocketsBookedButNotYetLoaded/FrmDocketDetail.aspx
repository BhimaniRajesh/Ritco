<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <%--<div align="center">
    <table border="1" style="width: 468px; height: 19px">
        <tr>
            <td class="bgbluegrey" colspan="3" style="height: 23px">
                <p align="center" style="background-color: #d4e0e7">
                    <label class="blackfnt">
                        Your Query Here</label></p>
            </td>
        </tr>
        <tr>
            <td style="width: 34px; height: 23px" class="blackfnt" >
                Location</td>
            <td align="left"  style="width: 150px; height: 23px" class="blackfnt">
                <asp:Label ID="lblLocation" runat="server" Text="Label" Width="252px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="blackfnt" align="left" style="width: 34px; height: 20px">
                Date
            </td>
            <td align="left" style="width: 150px; height: 20px" class="blackfnt" >
                <asp:Label ID="lblDateRange" runat="server" Text="Label" Width="251px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 34px; height: 20px" class="blackfnt" >
                Report Type</td>
            <td align="left" style="width: 150px; height: 20px" class="blackfnt">
                <asp:Label ID="lblrpttype" runat="server" Text="Label" Width="250px"></asp:Label>
            </td>
        </tr>
    </table>--%>
    <%--<table style="width: 326px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing ="1" id="TABLE1">
        <tr class="bgbluegrey" > <td colspan="3" align="center" class="blackfnt"  style="height: 23px">  Your Query Here
     </td></tr>
   --%>
    <br />
    <div align="left">
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Convert.ToString(Session["DocketCalledAs"]) + " Booked But Not Yet Loaded Report" %></b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <table style="width: 362px; height: 19px" border="0" class="boxbg" cellpadding="5"
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
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Report Type
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblrpttype" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <div align="left">
        <asp:DataGrid ID="GrdToPayFollow" CellSpacing="1" CellPadding="5" OnItemCommand="gotolink"
            runat="server" PagerStyle-Position="Bottom" PagerStyle-HorizontalAlign="Center"
            PagerStyle-CssClass="pageLinks" CssClass="boxbg" BorderWidth="0" HeaderStyle-CssClass="bgbluegrey"
            FooterStyle-CssClass="boxbg" AllowPaging="True" AllowSorting="True" PagerSettings-FirstPageText="[First]"
            OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" Width="965px" PageSize="10">
            <FooterStyle CssClass="boxbg" />
            <PagerStyle CssClass="pageLinks" BackColor="white" HorizontalAlign="Center" Mode="NumericPages" />
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" CssClass="blackfnt"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Docket" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.docket") %>'
                            runat="server"></asp:Label>
                        <%--<asp:LinkButton ID="lblTrack" Text='Track' ForeColor="blue" Font-Underline="true" runat="server"></asp:LinkButton> &nbsp; &nbsp;
                     <asp:LinkButton ID="LinkButton1" Text='View' ForeColor="blue" Font-Underline="true" runat="server"></asp:LinkButton>--%>
                        <a><u>Track</u></a> <a><u>View</u></a>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataFormatString="{0:dd-MMM-yy}" HeaderText="Booking Date" DataField="dockdt"
                    ItemStyle-BackColor="white">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Size="11px" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:BoundColumn>
                <asp:TemplateColumn HeaderText="Origin Delivery" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Origin") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Consignee" ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.consignee") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Consignor" ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lbl1" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.consignor") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </div>
    <div align="center" style="width: 965px">
        <br />
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="61px" />
    </div>
    <br />
    &nbsp;<br />
</asp:Content>
