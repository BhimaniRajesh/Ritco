<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DriverSettlementQuery.aspx.cs" Inherits="Issue_DriverSettlementQuery" %>

<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/LED/DateSelector.ascx" %>
<%@ Register TagPrefix="SControlsTo" TagName="DateSelectorTo" Src="~/LED/DateSelectorTo.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="AutoComplete1" TagPrefix="xac" Src="~/GUI/Fleet/Operations/Issue/AutoComplete1/AMAC.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="auc" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MAC.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function DriverView(ctrl) {
            
             var TripsheetNo = $("#" + $(ctrl).attr("id").replace("lblView", "hdnTripsheetNo")).val();
            window.open('./frmDriverSettlementIssueSlipViewVer1.aspx?id=' + TripsheetNo + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

            //window.open('./New_TripSheet_Validation/TripsheetViewPrint.aspx?VSlipNo=' + id + '&PrintMode=0', '_blank'
            //   , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');
        }

    </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../../gui/images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Settlement  >> Query</asp:Label>
            </td>
            <td align="right"></td>
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
                            <%--  <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Trip Sheet No.:</asp:Label>--%>
                            <asp:DropDownList ID="ddlTripsheet" runat="server">
                                <asp:ListItem Value="M" Text="Enter Manual TripSheet No.:" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="T" Text="Enter Trip Sheet No.:"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
                                ErrorMessage="*" ValidationGroup="VGRequestID" />
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
                            <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Vehicle No.:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtVehno" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10"
                                        Width="75px"></asp:TextBox>
                                    <asp:TextBox ID="txtVehno_Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                        Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                    <xac:AutoComplete1 ID="xacVehicle" runat="server" webxentity="Vehicle"
                                        CodeTarget="txtVehno" MinPrefixLength="2" NameTarget="txtVehno_Name" />
                                    <asp:HiddenField ID="hfVehicleLocation" runat="server" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" colspan="3">
                            <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Font-Bold="True">Driver Name:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtDriver1" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                        Width="75px"></asp:TextBox>
                                    <asp:TextBox ID="txtDriver1Name" runat="server" CssClass="bgwhite"
                                        Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                    <auc:AutoComplete ID="aucDriver" MinPrefixLength="1" runat="server" webxentity="Driver"
                                        CodeTarget="txtDriver1" NameTarget="txtDriver1Name" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" colspan="3">
                            <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                            </asp:Label>
                        </td>
                    </tr>

                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Status:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Value="All" Text="ALL" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="Pending" Text="Pending"></asp:ListItem>
                                <asp:ListItem Value="Settled" Text="Settled"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>


                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Trip Sheet Date Range:</asp:Label>
                        </td>
                        <td align="left">
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" OnClick="btnShowMultipleRequest_Click" />
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

                        <asp:GridView ID="grdList" runat="server" PageSize="1000" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" OnRowDataBound="grdList_RowDataBound"
                            EmptyDataText="No Records Found">
                            <Columns>
                                <asp:BoundField DataField="Rowid" HeaderText="Sr. No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VehicleNo" HeaderText="Truck No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VSlipNo" HeaderText="Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VSlipDt" HeaderText="Open Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripSubmissionDate" HeaderText="TripSubmission Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="isApprovedDate" HeaderText="Approved Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripFinacialCloseEntryDt" HeaderText="FinacialClosure Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Fuel_CF" HeaderText="Diesel C/F">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CashBalance" HeaderText="Cash Balance">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DriverSettleDt" HeaderText="Driver Settlement Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblView" Text="View" runat="server" onclick='DriverView(this)'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Next Step">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkNextStep" runat="server" Text="Driver Settlement" OnClick="lnkNextStep_Click"></asp:LinkButton>
                                        <asp:HiddenField runat="server" ID="hdnTripsheetNo" Value='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>' />
                                        <asp:HiddenField runat="server" ID="hdnStatus" Value='<%# DataBinder.Eval(Container.DataItem,"Status") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
