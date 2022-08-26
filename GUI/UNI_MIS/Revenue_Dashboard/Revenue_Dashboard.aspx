<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Revenue_Dashboard.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 9in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Specific.aspx"><font class="blklnkund">
                            <b>Specific Reports</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Delivery Performance
                                Report</b></font>
                </td>
                <td align="center">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table cellspacing="1" style="width: 100%;" border="0">
            <tr align="center">
                <td align="center" colspan="3">
                    <table cellspacing="1" style="width: 40%" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" style="height: 24px;">
                                &nbsp;<asp:Label ID="Label6" CssClass="blackfnt" Text="Select Transport Mode" runat="server"></asp:Label></td>
                            <td align="left" colspan="2" valign="top" style="height: 24px; width: 150px;">
                                &nbsp;
                                <asp:DropDownList ID="ddltr_mode" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddltr_mode_SelectedIndexChanged">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem Value="All">All</asp:ListItem>
                                    <asp:ListItem Value="1">Air</asp:ListItem>
                                    <asp:ListItem Value="2">Road</asp:ListItem>
                                    <asp:ListItem Value="3">Train</asp:ListItem>
                                    <asp:ListItem Value="4">Express</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="True" runat="server" ForeColor="Red">
                                 Please Wait......
            </asp:Label>
        </asp:Panel>
        <%-- <asp:UpdatePanel ID="UP1" runat="Server">
                        <ContentTemplate>--%>
        <asp:Panel ID="pnl1" runat="server" Visible="false">
            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                <tr style="background-color: white">
                    <td align="Center">
                          <asp:Label ID="lblcrmon" CssClass="blackfnt" Text="Current Month" runat="server"></asp:Label>
                        <asp:GridView ID="GV_CURR" runat="server" align="center" BorderWidth="0" CellPadding="5"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg" CellSpacing="1"
                            FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                            OnRowDataBound="CustomersGridView_RowDataBound_Cr_Month" AllowSorting="False"
                            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <%--  <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>--%>
                                <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" HeaderText="Region">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_month1_docket" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y1" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" BackColor="white"  Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_month_2_docket" ItemStyle-Wrap="true" HeaderText="Week 2 8-14"
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150"  BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y2" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_month_3_Docket" ItemStyle-Wrap="true" HeaderText="Week 3 15-22 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y3" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_month_4_Docket" ItemStyle-Wrap="true" HeaderText="Week 4 23-31 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y4" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot" ItemStyle-Wrap="true" HeaderText="Total " HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot2" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td align="Center">
                        <asp:Label ID="lblprmon" CssClass="blackfnt" Text="Previous Month" runat="server"></asp:Label>
                        <asp:GridView ID="GV_PREV" runat="server" align="center" BorderWidth="0" CellPadding="5" CellSpacing="1"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                             FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                            OnRowDataBound="CustomersGridView_RowDataBound_Pr_Month" AllowSorting="False"
                            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <%-- <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>--%>
                                <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" HeaderText="Region">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" BackColor="white"  Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Pr_month1_docket" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150"  BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y1" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150"  BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Pr_month_2_docket" ItemStyle-Wrap="true" HeaderText="Week 2 8-14"
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150"  BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y2" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150"  BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Pr_month_3_Docket" ItemStyle-Wrap="true" HeaderText="Week 3 15-22 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y3" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Pr_month_4_Docket" ItemStyle-Wrap="true" HeaderText="Week 4 23-31 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y4" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center"   Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot2" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="center">
                        <asp:Label ID="lblcrqr" CssClass="blackfnt" Text="Current Quater" runat="server"></asp:Label>
                        <asp:GridView ID="GV_CURR_Q" runat="server" align="center" BorderWidth="0" CellPadding="5" CellSpacing="1"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                              FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                            AllowSorting="False" AutoGenerateColumns="false" OnRowDataBound="CustomersGridView_RowDataBound_Curr_quater"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <%-- <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>--%>
                                <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" HeaderText="Region">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_qua_1_docket" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y1" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_qua_2_docket" ItemStyle-Wrap="true" HeaderText="Week 2 8-14"
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y2" ItemStyle-Wrap="true" HeaderText="Week 2 8-14" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Cr_qua_3_Docket" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y3" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot" HeaderText="total" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot2" HeaderText="total" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td align="center">
                        <asp:Label ID="lblprqr" CssClass="blackfnt" Text="Previous Quater" runat="server"></asp:Label>
                        <asp:GridView ID="GV_PREV_Q" runat="server" align="center" BorderWidth="0" CellPadding="5" CellSpacing="1"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                             FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                            OnRowDataBound="CustomersGridView_RowDataBound_Pr_quater" AllowSorting="False"
                            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found..." EmptyDataRowStyle-ForeColor="red">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <%--<asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                       --%>
                                <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" HeaderText="Region">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pr_qua_1_docket" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y1" ItemStyle-Wrap="true" HeaderText="Week 1 </br> 1-7 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pr_qua_2_docket" ItemStyle-Wrap="true" HeaderText="Week 2 8-14"
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y2" ItemStyle-Wrap="true" HeaderText="Week 2 8-14" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pr_qua_3_Docket" ItemStyle-Wrap="true" HeaderText="Week 3 15-22 "
                                    HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False"  BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="y3" ItemStyle-Wrap="true" HeaderText="Week 3 15-22 " HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot" HeaderText="total" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tot2" HeaderText="total" ItemStyle-Wrap="true" HeaderStyle-Wrap="true">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white"  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #ffffff" align="center">
                        <br />
                        <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <%--</ContentTemplate>
</asp:UpdatePanel>--%>
    </div>
</asp:Content>
