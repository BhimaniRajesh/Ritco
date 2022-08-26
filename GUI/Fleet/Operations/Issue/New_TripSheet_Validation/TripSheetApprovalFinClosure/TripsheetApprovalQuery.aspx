<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TripsheetApprovalQuery.aspx.cs" Inherits="Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalQuery" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function Validate() {

        }

        function TripsheetView(ctrl) {
            window.open('./../TripsheetViewPrint.aspx?VSlipNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet Approval >> Query</asp:Label>
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
                            <asp:DropDownList ID="ddlTripsheet" runat="server">
                                <asp:ListItem Value="T" Text="Enter Trip Sheet No.:" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="V" Text="Enter Vehicle No.:"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID"
                                BorderStyle="Groove"></asp:TextBox>
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
                        <td align="left">
                            <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Fleet Center</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlFleetCenter" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
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
                            <%-- <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>--%>
                            <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" OnClientClick="javacript:Validate();"
                                OnClick="btnShowMultipleRequest_Click" />
                            <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
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
                <asp:UpdatePanel ID="u1" UpdateMode="Always" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grdList" runat="server" PageSize="1000" AutoGenerateColumns="False"
                            CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                            CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left" OnRowDataBound="grdList_RowDataBound">
                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False"
                                Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            <Columns>
                                <asp:TemplateField HeaderText="Trip Sheet No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTripsheetNo" onclick="TripsheetView(this);"
                                            runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>' Style="text-decoration: underline"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               <%-- <asp:BoundField DataField="VSlipNo" HeaderText="Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="VSlipDt" HeaderText="Trip Sheet date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VehicleNo" HeaderText="Truck No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripSheet_StartLoc" HeaderText="Fleet Centre Code.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="BranchName" HeaderText="Branch Name">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Oper_Close_Dt" HeaderText="Operational Close Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripSubmissionDate" HeaderText="TripSubmission Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ApprovedDate" HeaderText="Approval Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReconsiderationDate" HeaderText="Reconsideration Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReconsiderationRemark" HeaderText="Reconsideration Remark">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkApproval" runat="server" Text="Approval" OnClick="lnkApproval_Click"></asp:LinkButton>
                                        <asp:HiddenField ID="hdnVSlipNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>' />
                                    </ItemTemplate>
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
