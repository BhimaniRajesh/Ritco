<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmLoadUnload.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <div align="left">
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
        <%--<table style="width: 319px;height: 142px; z-index: 103; left: 232px; position: absolute; top: 159px;" title="Your Query Here" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Your Query Here</label></p>
     </td></tr>
            <tr>
                <td style="width: 319px; text-align: left; height: 33px;" colspan="2">
                    Date Ranges :&nbsp;
                    <asp:Label ID="lbldaterange" runat="server" Style="z-index: 100; left: 117px; position: absolute;
                        top: 50px" Text="Label" Width="197px"></asp:Label>
                    <asp:TextBox ID="TxtDateRange" runat="server" Width="170px" ReadOnly="True" Visible="False" style="z-index: 102; left: 94px; position: absolute; top: 191px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    RO :
                    <asp:Label ID="lblRO" runat="server" Style="z-index: 100; left: 116px; position: absolute;
                        top: 84px" Text="Label" Width="172px"></asp:Label>
                    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 97px; position: absolute; top: 192px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px; height: 16px;">
                    Location :
                    <asp:Label ID="lblLocation" runat="server" Style="z-index: 100; left: 116px; position: absolute;
                        top: 117px" Text="Label" Width="173px"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 96px; position: absolute; top: 192px"></asp:TextBox>
                </td>
            </tr>
        </table>--%>
        <table style="width: 362px; height: 19px" border="0" class="boxbg" cellpadding="5"
            cellspacing="1">
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 19px">
                    Your Query Here
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date Range
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    RO
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblRO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
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
        </table>
    </div>
    <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><asp:TextBox
        ID="TxtDateRange" runat="server" Width="170px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
            ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox
                ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox>
    <br />
    <br />
    <%-- <form id="form1">--%>
    <asp:GridView ID="GrdLoadUnload" OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages"
        OnRowCommand="GridView1_RowCommand" PageSize="10" AutoGenerateColumns="false"
        HeaderStyle-CssClass="bgbluegrey" runat="server" AllowPaging="false" OnRowCreated="GrdLoadUnload_RowCreated"
        OnRowDataBound="GrdLoadUnload_RowDataBound" EmptyDataText="No Records Found !!"
        EmptyDataRowStyle-CssClass="blackfnt" CellPadding="5" CellSpacing="1" BorderWidth="0"
        CssClass="boxbg">
        <Columns>
            <asp:TemplateField HeaderText="SR.NO.">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="loccode" Visible="False">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblloccode" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"loccode") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="report_loc" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-CssClass="blackfnt" Visible="False" ItemStyle-CssClass="blackfnt"
                HeaderText="report_loc" SortExpression="report_loc" />
            <asp:TemplateField HeaderText="Location">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"loccode") +" : "+ DataBinder.Eval( Container.DataItem,"locname") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CN No(Booked)">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="LnkCNNo" CommandArgument='<%# Eval("loccode") %>' CssClass="blackfnt"
                        CommandName="CNNo" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"Total_CN") %>'
                        runat="server"></asp:LinkButton><br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CN_Wt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText="Wt"
                SortExpression="CN_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="MF No(In)">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="LnkInMF" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                        CssClass="blackfnt" CommandName="MFIn" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"Total_In_MF") %>'
                        runat="server"></asp:LinkButton><br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MF_In_Wt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Wt"
                ItemStyle-CssClass="blackfnt" SortExpression="MF_In_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:BoundField DataField="Loading_Total_Wt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="blackfnt" HeaderText="Total WT (Ton)"
                HeaderStyle-CssClass="blackfnt" SortExpression="Loading_Total_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="MF No(Out)">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="LnkOutMF" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                        CssClass="blackfnt" CommandName="MFOut" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"Total_Out_MF") %>'
                        runat="server"></asp:LinkButton><br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField ItemStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center" DataField="MF_Out_Wt" HeaderStyle-CssClass="blackfnt"
                HeaderText="Wt" SortExpression="MF_Out_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="DRS No">
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle BackColor="white" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="LnkDRSNo" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                        CssClass="blackfnt" CommandName="DRS" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"Total_DRS") %>'
                        runat="server"></asp:LinkButton><br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DRS_Wt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="blackfnt" HeaderStyle-CssClass="blackfnt"
                HeaderText="Wt" SortExpression="DRS_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:BoundField DataField="UnLoading_Total_Wt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="blackfnt" HeaderStyle-CssClass="blackfnt"
                HeaderText="Total WT (Ton)" SortExpression="UnLoading_Total_Wt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:BoundField DataField="Grand_Total" HeaderStyle-HorizontalAlign="Right" ItemStyle-BackColor="white"
                ItemStyle-HorizontalAlign="Right" ItemStyle-CssClass="blackfnt" HeaderText="Grand Total"
                HeaderStyle-CssClass="blackfnt" SortExpression="Grand_Total">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:BoundField DataField="Rate" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                ItemStyle-BackColor="white" HeaderText="Rate" HeaderStyle-CssClass="blackfnt"
                SortExpression="Rate" ItemStyle-CssClass="blackfnt">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
            <asp:BoundField DataField="NetDue" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Right"
                ItemStyle-HorizontalAlign="Right" HeaderText="Net Due" HeaderStyle-CssClass="blackfnt"
                ItemStyle-CssClass="blackfnt" SortExpression="NetDue">
                <ControlStyle CssClass="blackfnt" />
            </asp:BoundField>
        </Columns>
        <SelectedRowStyle BackColor="Yellow" />
        <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
    </asp:GridView>
    <br />
    <br />
    <div align="center" style="width: 11in">
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text=" Excel " />&nbsp;</div>
    <%--</form>--%>
</asp:Content>
