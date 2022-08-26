<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmDriverSettlementIssueSlipViewVer1.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipViewVer1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link id="Link3" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script language="javascript" type="text/javascript">
        function DriverSettlementTripsheetAmountView(ctrl) {

            if (parseFloat(ctrl.innerHTML) > 0) {
                var TripsheetNo = document.getElementById('lblTripsheetNo').innerHTML;
                window.open('./New_TripSheet_Validation/DriverSettlementTripsheetAmountView.aspx?id=' + TripsheetNo + '&PrintMode=0', '_blank'
                    , 'top=0, left=0, width=550, height=200, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td style="vertical-align: top !important;">
                        <table cellspacing="1">
                            <tr align="left">
                                <td>
                                    <asp:GridView ID="gvEnroute" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                                        SelectedIndex="1" OnRowDataBound="gvEnroute_RowDataBound"
                                        HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="True">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No.(क्रमिक संख्या)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="20px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nature of Expense  (खर्चे का नाम)">
                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNExpense" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"HindiHeaderCaption") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidNExpenseTitle" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Expense") %>'></asp:HiddenField>
                                                    <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="100px" VerticalAlign="Top" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total (कुल)"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approval Amount (पास किया गया खर्चा)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="true" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="txtApprovalAmount" Width="50px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="txtApprovalTotal" runat="server" Width="50px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approval Remarks (खर्चा पास करने वाले की टिप्पणी)">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="true" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="txtApprovalRemark" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedRemarks") %>'
                                                        runat="server" Width="100px" MaxLength="500"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top !important;">
                        <table cellspacing="1" cellpadding="2" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="8" align="center">
                                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Settlement  (सारथी समझौता) </asp:Label>
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td align="left">
                                    <b>Truck No (ट्रक न.)</b>
                                </td>
                                <td align="left">
                                    <b>Driver Name  (सारथी नाम)</b>
                                </td>
                                <td align="left">
                                    <b>Tripsheet No (ट्रिपशीट न.)</b>
                                </td>
                                <td align="left">
                                    <b>Tripsheet Open Date (ट्रिपशीट शुरू करने की तारिख)</b>
                                </td>
                                <td align="left">
                                    <b>Submission Date  (हिसाब भेजने की तारीख)</b>
                                </td>
                                <td align="left">
                                    <b>Approved Date  (हिसाब पास करने की तारिख)</b>
                                </td>
                                <td align="left">
                                    <b>Financial Closure Date  (हिसाब बंद होने की तारिख)</b>
                                </td>
                                <td align="left">
                                    <b>Settlement Date  (समझौता तारिख)</b>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server" />
                                </td>

                                <td align="left">
                                    <asp:Label ID="lblDriverName" CssClass="blackfnt" runat="server" />
                                </td>

                                <td align="left">
                                    <asp:Label ID="lblTripsheetNo" CssClass="blackfnt" runat="server" onclick="TripsheetView(this)" />
                                </td>

                                <td align="left">
                                    <asp:Label ID="lblTripsheetDate" CssClass="blackfnt" runat="server" />
                                </td>

                                <td align="left">
                                    <asp:Label ID="lblSubmissionDate" CssClass="blackfnt" runat="server" />
                                </td>

                                <td align="left">
                                    <asp:Label ID="lblApprovedDate" CssClass="blackfnt" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblFinancialClosureDate" CssClass="blackfnt" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblSettlementDate" CssClass="blackfnt" runat="server" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4" style="vertical-align: top !important;">
                                    <b>Fuel Details (डीज़ल विवरण)</b>
                                    <asp:GridView ID="grdFuel" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                                        SelectedIndex="1" Width="100%"
                                        HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="True">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No.  (क्रमिक संख्या)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="20px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Filling Date (डीज़ल लेने की तारीख)">
                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFillingDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FillingDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="100px" VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fuel Type (डीज़ल प्रकार)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFuelType" Width="50px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City (शहर)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCity" Width="50px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VendorCity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Ltr.(लीटर)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" Width="50px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </td>
                                <td colspan="4" style="vertical-align: top !important;">
                                    <b>Advance Details (पेशगी राशि)</b>
                                    <asp:GridView ID="grdAdvance" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                                        SelectedIndex="1" Width="100%"
                                        HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="True">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No. (क्रमिक संख्या)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="20px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date  (तारिख)">
                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAdvDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AdvDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="100px" VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount  (राशि)">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" Width="50px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverAdvance") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </td>

                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4" style="vertical-align: top !important;">
                                    <table id="tblFuelEconomy" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="100%" style="display:none;">
                                        <thead>
                                            <tr class="bgbluegrey">
                                                <th colspan="2">Fuel Economy</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="bgwhite">
                                                <td>DISTANCE (kms)</td>
                                                <td>
                                                    <asp:Label ID="lblDistanceKM" runat="server" Text="0.0" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Total Fuel (Ltrs)</td>
                                                <td>
                                                    <asp:Label ID="lblTotalFuelLtrs" runat="server" Text="0.0" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Fuel Economy (KMPL)</td>
                                                <td>
                                                    <asp:Label ID="lblFuelEconomy_KMPL" runat="server" Text="0.0" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Add Blue Ratio</td>
                                                <td>
                                                    <asp:Label ID="lblAddBlueRatio" runat="server" Text="0.0" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Per KM Expense</td>
                                                <td>
                                                    <asp:Label ID="lblPerKMExpense" runat="server" Text="0.0" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td colspan="4" style="vertical-align: top !important;">
                                    <table id="tbl3" class="boxbg" border="0" cellpadding="1" cellspacing="1" style="float: right;" width="100%">
                                        <tbody>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">Driver Advance (सारथी पेशगी)</td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblDriverAdvance" Text="0.00" runat="server" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">Approved Amt (पास की गई राशि)</td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="lblApprovedAmount" Text="0.00" runat="server" Style="text-align: right;" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">
                                                    <asp:Label ID="lblBalanceAmount_CrDr" runat="server" Text="Balance Amt Cr/Dr (बकाया राशि लेना/देना )"></asp:Label></td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="txtBalanceAmount_CrDr" Text="0.00" runat="server" Style="text-align: right;" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">Paid Amt (भुगतान राशि)</td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="txtPaidAmt" Text="0.00" onclick="DriverSettlementTripsheetAmountView(this)" runat="server" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">Receive Amt  (प्राप्त राशि)</td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="txtReceivedAmt" Text="0.00" onclick="DriverSettlementTripsheetAmountView(this)" runat="server" Style="text-align: right;" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td style="font-weight: bold">
                                                    <asp:Label ID="LblDriverLedger" runat="server" Text="Net Balance Amt Cr/Dr (शुद्ध बकाया राशि लेना/देना )"></asp:Label></td>
                                                <td style="text-align: right;">
                                                    <asp:Label ID="txtBalToDriverLedger" Text="0.00" runat="server" Style="text-align: right;" ReadOnly="true" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <div id="ProtsahanRashiPopup" title="Protsahan Rashi">
                                    <asp:GridView ID="grdProtsahanRashi" runat="server" AutoGenerateColumns="false"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false"
                                        EmptyDataText="No Records Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No. (क्रमिक संख्या)">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ETHC No (चालान संख्या)">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtETHCNo" runat="server" MaxLength="10" Width="150"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"ExternalTHCNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From (कहाँ से)">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtFrom" runat="server" MaxLength="10" Width="65"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To (कहाँ तक)">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtTo" runat="server" MaxLength="10" Width="65"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Loading Date  (लोड करने की तारीख)">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtLoadingDate" runat="server" MaxLength="10" Width="65"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"LoadingDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Unloading Date (खाली करने की तारीख)">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtUnloadingDate" runat="server" MaxLength="10" Width="65"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transit Days (रास्ता तय करने के दिन)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTransitDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                                                        value='<%# DataBinder.Eval(Container.DataItem,"TransitDays") %>' Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Save Days (दिन बचाये गए)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSaveDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                                                        value='<%# DataBinder.Eval(Container.DataItem,"SaveDays") %>' Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount  (राशि)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                        onkeypress="javascript:validFloat(event,this.id)" CssClass="input"
                                                        value='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approval Amount (पास की गई प्रोत्साहन राशि)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtApprovalAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                        onkeypress="javascript:validFloat(event,this.id)"
                                                        value='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>' CssClass="input" Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks (टिप्पणी)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" Width="65" BorderStyle="groove" CssClass="input"
                                                        value='<%# DataBinder.Eval(Container.DataItem,"Remark") %>' Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
