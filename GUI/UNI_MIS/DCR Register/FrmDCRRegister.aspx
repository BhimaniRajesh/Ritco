<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmDCRRegister.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <%--<asp:Label ID="Label1" Font-Underline="true" Font-Bold ="true" runat="server" Text="Reports/Operations/DCR Register Report"></asp:Label>--%>
    <table style="width: 1000px">
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
    <table align="left" border="0" cellpadding="5" cellspacing="1" class="boxbg" style="width: 398px;
        height: 1px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 23px">
                Your Query
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 76px">
                Date Range</td>
            <td style="width: 136px">
                <div align="left">
                    <asp:Label ID="lbldaterange" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 76px; height: 16px">
                RO</td>
            <td style="width: 136px; height: 16px">
                <div align="left">
                    <asp:Label ID="lblRO" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 76px">
                Location</td>
            <td style="width: 136px">
                <div align="left">
                    <asp:Label ID="lblLocation" runat="server" align="left" CssClass="blackfnt" Text="Label"
                        Width="267px"></asp:Label></div>
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
    <br />
    <br />
    <br />
    <br />
    <br />
    <div align="center">
        <asp:GridView ID="GrdPaidFollow" AllowPaging="true" OnPageIndexChanging="PageIndexChanged_Click"
            PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false"
            HeaderStyle-CssClass="bgbluegrey" CellPadding="5" CellSpacing="1" BorderWidth="0"
            runat="server" SelectedIndex="1" OnRowDataBound="GrdPaidFollow_RowDataBound"
            EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataText="No Records Found ....!!">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Book NO.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BookCode") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket Series" Visible="true">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketSeries") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Docket" Visible="true">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode2" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Tot_leaf") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt" HeaderText="Issued to HO"
                    DataField="HO" ControlStyle-Height="500" ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px"
                    ItemStyle-CssClass="blackfnt" />
                <asp:TemplateField HeaderText="Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation9" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"HODate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderText="Issued to RO"
                    DataField="RO" ControlStyle-Height="500" ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px"
                    ItemStyle-CssClass="blackfnt" />
                <asp:TemplateField HeaderText="Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation11" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"RODate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderText="Issued to AO"
                    DataField="AO" ControlStyle-Height="500" ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px"
                    ItemStyle-CssClass="blackfnt" />
                <asp:TemplateField HeaderText="Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation16" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"AODate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderText="Issued to Location"
                    DataField="LO" ControlStyle-Height="500" ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px"
                    ItemStyle-CssClass="blackfnt" />
                <asp:TemplateField HeaderText="Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation12" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"LODate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderText="Issued to BA/Own"
                    DataField="BA" ControlStyle-Height="500" ControlStyle-Font-Size="11 px" ItemStyle-Font-Size="11 px"
                    ItemStyle-CssClass="blackfnt" />
                <asp:TemplateField HeaderText="Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation13" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BADate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Used Leaf">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblusedleaf" Font-Underline="true" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"used_dkt") %>'
                            PostBackUrl='<%#"~/GUI/UNI_MIS/DCR Register/FrmDocketDetail.aspx?docfrom=" + DataBinder.Eval(Container.DataItem, "Doc_Sr_From") + "&docto=" + DataBinder.Eval(Container.DataItem, "Doc_Sr_To") + "&mode=used"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unused Leaf">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblunusedleaf" Font-Underline="true" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"unusedleaf") %>'
                            PostBackUrl='<%#"~/GUI/UNI_MIS/DCR Register/FrmDocketDetail.aspx?docfrom=" + DataBinder.Eval(Container.DataItem, "Doc_Sr_From") + "&docto=" + DataBinder.Eval(Container.DataItem, "Doc_Sr_To") + "&mode=unused"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Void Leaf">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation5" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"voidleaf") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cancelled Leaf">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation6" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"can_dkt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" HorizontalAlign="Center" />
        </asp:GridView>
    </div>
    <br />
    <br />
    <div align="center">
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
    </div>
</asp:Content>
