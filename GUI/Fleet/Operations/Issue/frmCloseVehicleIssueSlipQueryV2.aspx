<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="frmCloseVehicleIssueSlipQueryV2.aspx.cs" Inherits="Issue_frmCloseVehicleIssueSlipQueryV2" %>

<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/LED/DateSelector.ascx" %>
<%@ Register TagPrefix="SControlsTo" TagName="DateSelectorTo" Src="~/LED/DateSelectorTo.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../../gui/images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Close Trip Sheet >> Query</asp:Label>
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <table cellspacing="1" width="800px">
        <tr align="left">
            <td>
                <table cellspacing="1" cellpadding="2" class="boxbg" width="800px">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Tripsheet action</asp:Label><%--Update/Close/Driver Settlement--%>
                        </td>
                        <td align="left">
                            <asp:DropDownList CssClass="input" ID="ddlUpdClose" runat="Server" Width="180px"
                                BorderStyle="Groove">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlUpdClose"
                                ErrorMessage="*" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <%--  <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Trip Sheet No.:</asp:Label>--%>
                            <asp:DropDownList ID="ddlTripsheet" runat="server">
                                <asp:ListItem Value="M" Text="Enter Manual TripSheet No.:" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="T" Text="Enter Trip Sheet No.:"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID"
                                BorderStyle="Groove"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
                                ErrorMessage="*" ValidationGroup="VGRequestID" />
                            <%-- <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                       
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID"
                                        OnClick="btnShowMultipleRequest_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" colspan="3">
                            <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Trip Sheet Date Range:</asp:Label>
                        </td>
                        <td align="left">
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                            <%--  <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtVIssueID" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>--%>
                        </td>
                        <%--<TD  valign="top"   align="left" nowrap >
              <asp:UpdatePanel ID="UpdatePanel7" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                            <table  border=0 cellpadding=2 cellspacing=2>
                                            <tr>
                                             <td valign=top><asp:Label ID="Label7"  CssClass="blackfnt" runat="server" Text="From :"></asp:Label></td>
                                             <td valign=top><SControls:DateSelector     ID="txtDateFrom" runat="server" /></td>
                                             <td valign=top><asp:Label ID="Label4" CssClass="blackfnt" runat="server" Text="To :"></asp:Label></td>
                                             <td valign=top><SControlsTo:DateSelectorTo ID="txtDateTo" runat="server" /></td>
                                            </tr>

                                            </table>
                                            
                                        
                                            
                                            
                        
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtVIssueID" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </TD>--%>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo"
                                        OnClick="btnShowMultipleRequest_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" width="900px" border="0" align="left">
        <tr align="left">
            <td align="left">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:DataGrid ID="DataGrid1" runat="server" PageSize="1000" AutoGenerateColumns="False"
                            CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                            CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left"
                            OnItemDataBound="DataGrid1_ItemDataBound">
                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center"
                                Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White"
                                Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                            <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False"
                                Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            <Columns>
                                <asp:BoundColumn DataField="Manual_TripsheetNo" HeaderText="Manual Tripsheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VSlipNo" HeaderText="Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VSlipDt" HeaderText="Trip Sheet date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VehicleNo" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <%-- <asp:BoundColumn DataField="Category" HeaderText="Category">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                <asp:BoundColumn DataField="Trip_route_type" HeaderText="Leg Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="DriverName" HeaderText="Driver">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmTripsheetUpdate.aspx?id={0}&mode=Advance"
                                    Text="Advance Entry" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmCloseVehicleIssueSlip.aspx?id={0}&mode=Close"
                                    Text="Close - Operational" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmDriverSettlementIssueSlip.aspx?id={0}"
                                    Text="Driver Settlement" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmCloseVehicleIssueSlip.aspx?id={0}&mode=FE"
                                    Text="Financial Edit" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmNewTripDetailsUpdateV1.aspx?id={0}&mode=TD"
                                    Text="Trip Details" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmCloseVehicleIssueSlipLegWise.aspx?id={0}&mode=TLW"
                                    Text="Financial Edit Leg Wise" HeaderText="Next Step">
                                    <ItemStyle CssClass="bluefnt" HorizontalAlign="Left" />
                                    <HeaderStyle Width="90px" />
                                </asp:HyperLinkColumn>
                            </Columns>
                        </asp:DataGrid>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnShowSingleRequest" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
