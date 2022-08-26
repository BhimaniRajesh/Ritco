<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ClosedTripsheetView_Details_Ver1.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_ClosedTripsheetView_Details_Ver1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript">
        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
        var TripDetentionPopup;
        $(document).ready(function () {
            TripDetentionPopup = $("#DivTripDetention").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true
            });

        });
        function ViewDetentionPopup() {
            TripDetentionPopup.dialog("open");
        }

        function TripsheetView(ctrl) {
            window.open('./TripsheetViewPrint.aspx?VSlipNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }

        function VehicleView(ctrl) {

            window.open('./../../../../admin/VehicleMaster/VehicleViewPrint.aspx?VehicleNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                  , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }

    </script>
    <div align="left" style="width: 75%">
        <UserControl:UserMessage ID="umsg" runat="server" />
        <table cellspacing="1" border="0" style="width: 100%">

            <tr align="left">
                <td colspan="3">
                    <table cellspacing="1" style="width: 100%" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td colspan="6" align="center" style="height: 21px">
                                <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                   Closed Tripsheet View
                                </asp:Label>
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label21" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Vehicle No."></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server" Font-Underline="true" onclick="VehicleView(this);"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label19" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Diesel Approved"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDieselApproved" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label7" Style="display: none;" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Total Diesel(Credit)"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotDiesel" Style="display: none;" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tripsheet No."></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTripsheetNo" CssClass="blackfnt" Font-Underline="true" onclick="TripsheetView(this);" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Fuel Economy"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFuelEconomy" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left" colspan="2"></td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tripsheet Open Date"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblOpenDate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="true" Text="AddBlue Ratio"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblAddBlueRatio" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label13" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tripheet Close Date"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblOperCloseDate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Diesel Amount"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDieselAmount" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label9" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tripheet Submitted Date"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblSubmittedDate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label10" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Enroute Amount"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblEnrouteAmount" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label17" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tripsheet Approval Date"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblApprovedDt" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label11" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Per KM Expense"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblPerKMExpense" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left" colspan="2"></td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Financial Close Date"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFinCloseDate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label14" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Cash B/F"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblCashBF" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label15" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Cash C/F"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblCashCF" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label29" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Controlling Branch"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblControllingBranch" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label16" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Diesel B/F"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDieselBF" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label20" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Diesel C/F"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDieselCF" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label33" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Route Operated"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblRouteOperated" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left">
                                <asp:Label ID="Label18" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Driver Settlement"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDriverSettelement" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>

                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label37" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Driver Name"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDriverName" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label39" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Open KMs"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblOpenKms" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label41" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Close KMs"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblCloseKms" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label49" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Distance"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblDistance" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label35" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Trip Detention"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTripDetentionView" onclick="ViewDetentionPopup();" Text="View" Style="text-decoration: underline;" runat="server">
                                </asp:Label>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td valign="top" align="left" colspan="6" style="text-align: center">
                                <b>
                                    <asp:Label ID="Label22" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Fixed Expense"></asp:Label></b>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label23" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Tyre"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFixedExpenseTypre" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label24" CssClass="blackfnt" runat="server" Font-Bold="true" Text="AMC"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFixedExpenseAMC" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label25" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Document"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFixedExpenseDocument" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label27" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Other I"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFixedExpenseOtherI" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label26" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Other II"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblFixedExpenseOtherII" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td valign="top" align="left" colspan="6" style="text-align: center">
                                <b>
                                    <asp:Label ID="Label38" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Summary"></asp:Label></b>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label28" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Total Expense"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalExpense" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label31" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Per Km"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalExpensePerKM" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label30" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Total Revenue"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalRevenue" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label34" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Per Km"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalRevenuePerKM" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label32" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Total Income"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalIncome" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="Label36" CssClass="blackfnt" runat="server" Font-Bold="true" Text="Per Km"></asp:Label>
                            </td>
                            <td valign="top" align="left">
                                <asp:Label ID="lblTotalIncomePerKm" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td valign="top" align="left" colspan="2"></td>
                        </tr>

                    </table>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td colspan="6" align="left" style="height: 21px">
                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                  Journey Details
                    </asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <asp:GridView ID="dgExternalThc" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                        CssClass="dgRowStyle" Width="100%" PagerStyle-CssClass="pager" AllowSorting="true" AllowPaging="true"
                        PageSize="25" AutoGenerateColumns="false"
                        EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:BoundField DataField="ExternalTHCNo" HeaderText="ExternalTHC No.">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EntryDate" HeaderText="THC Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FromCity" HeaderText="From City">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ToCity" HeaderText="To City">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LoadingDate" HeaderText="Loaded Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="UnloadingDate" HeaderText="Unloaded Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Weight" HeaderText="Weight">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Commodity" HeaderText="Product">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Nug" HeaderText="Nug">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ContractAmount" HeaderText="Freight">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AdvanceAmount" HeaderText="Advance">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Customer" HeaderText="Customer">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remark">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownload" Text="Download" CommandArgument='<%# Eval("UploadFileName") %>' runat="server" OnClick="DownloadFile"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" Position="TopAndBottom" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <div id="DivTripDetention" title="Trip Detention ">
            <asp:GridView ID="grdDetention" runat="server" PageSize="1000" AutoGenerateColumns="False"
                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                CssClass="dgRowStyle" Width="100%" AllowPaging="false"
                EmptyDataText="No Records Found">
                <Columns>
                    <asp:BoundField DataField="FromDate" HeaderText="FromDate">
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ToDate" HeaderText="ToDate">
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
