<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmAdviceList.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <%--<table style="width: 319px;height: 173px; z-index: 103; left: 228px; position: absolute; top: 159px;" title="Your Query Here" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Your Query Here</label></p>
     </td></tr>
            <tr>
                <td style="width: 319px; text-align: left; height: 25px;" colspan="2">
                    Date Ranges :&nbsp;
                    <asp:Label ID="lbldaterange" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 40px" Text="Label" Width="197px"></asp:Label>
                    <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False" style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px; height: 22px;">
                    RO :
                    <asp:Label ID="lblRO" runat="server" Style="z-index: 100; left: 114px; position: absolute;
                        top: 70px" Text="Label" Width="172px"></asp:Label>
                    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px; height: 16px;">
                    Location :
                    <asp:Label ID="lblLocation" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 100px" Text="Label" Width="173px"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Status :&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Lblstatus" runat="server" Style="z-index: 100; left: 114px; position: absolute;
                        top: 125px" Text="Label" Width="173px"></asp:Label>
                    <asp:Label ID="LblAdviceNO" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 150px" Text="Label" Width="173px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Advice No:</td>
            </tr>
        </table>--%>
    <br />
    <%--<asp:Label ID="Label1" Font-Underline="true" Font-Bold ="true" runat="server" Text="Reports/Finance & Accounts/ Advice Register Report"></asp:Label>--%>
    <div align="left">
        <table style="width: 935px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_finance.aspx"><font class="blklnkund">
                            <b>Finance & Accounts</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Advice Register</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table cellpadding="5" cellspacing="1" style="width: 362px; height: 19px" border="0"
            class="boxbg">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center" colspan="3" style="height: 19px">
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
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Status</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="Lblstatus" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Advice No.</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="LblAdviceNO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
        <br />
        <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
        <asp:DataGrid ID="GrdPaidFollow" OnItemDataBound="eventhandler" runat="server" PagerStyle-Mode="NumericPages"
            PagerStyle-Position="Top" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="pageLinks"
            AllowPaging="True" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="boxbg"
            AllowSorting="True" CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click"
            CellPadding="5" CellSpacing="1" BorderWidth="0" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" PagerSettings-FirstPageText="[First]">
            <FooterStyle CssClass="boxbg" BackColor="white" />
            <PagerStyle CssClass="pageLinks" BackColor="white" Position="Bottom" HorizontalAlign="Center" />
            <HeaderStyle CssClass="bgbluegrey" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblloccode" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Type">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Advtype") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Transaction">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.credit_account") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Status">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblArrivedDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advicestatus") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised By">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.raisedbybranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised On">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.RaisedOnbranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Amount">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Right" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRClosedMoney" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advice_amount") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="AdviceDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Generation Date"></asp:BoundColumn>
                    
                <asp:BoundColumn DataField="AdvAccDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Accepted Date"></asp:BoundColumn>
                    
                <asp:TemplateColumn HeaderText="Advice Received">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblAdvRecByName" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdvRecvByName") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                    
                <asp:TemplateColumn HeaderText="Print">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblMROutstandingAmt" Font-Underline="true" CssClass="blackfnt"
                            Text='Print' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        <asp:LinkButton ID="LinkButton1" runat="server" Visible="false" Font-Bold="True"
            Font-Underline="True" ForeColor="Blue" OnClick="linkexcel" Style="z-index: 101;
            left: 391px; position: absolute; top: 1088px">Excel old</asp:LinkButton>
        &nbsp;&nbsp;&nbsp;<br />
        <br />
        <div align="center" style="width: 11in">
            <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
        </div>
        <asp:HyperLink ID="HyperLink1" Visible="false" runat="server" Font-Bold="True" Font-Underline="True"
            ForeColor="Blue" NavigateUrl="~/GUI/UNI_MIS/Advice Register/Excel1.csv" Style="z-index: 104;
            left: 461px; position: absolute; top: 1085px">Excel Hyp</asp:HyperLink>
    </div>
</asp:Content>
