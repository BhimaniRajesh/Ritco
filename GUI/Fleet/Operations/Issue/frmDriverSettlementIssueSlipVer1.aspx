<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="false" CodeFile="frmDriverSettlementIssueSlipVer1.aspx.cs"
    Inherits="GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipVer1" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControlEXP" Src="~/UserControls/MyPaymentControlEXP.ascx" %>
<%@ Register TagPrefix="UC6" TagName="MyReceiptControlDS" Src="~/UserControls/MyReceiptControlDS.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("Div1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        $(document).ready(function () {

        });
        
        function TripsheetView(ctrl) {
            window.open('./New_TripSheet_Validation/TripsheetViewPrint.aspx?VSlipNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }
        function ValidatePaidReceivedAmt() {
            debugger;   
            var PaidAmount = parseFloat($('#ctl00_MyCPH1_txtPaidAmt').val() == "" ? "0" : $('#ctl00_MyCPH1_txtPaidAmt').val());
            var ReceivedAmount = parseFloat($('#ctl00_MyCPH1_txtReceivedAmt').val() == "" ? "0" : $('#ctl00_MyCPH1_txtReceivedAmt').val());
            var BalanceAmount = parseFloat($('#ctl00_MyCPH1_txtBalanceAmount_CrDr').text() == "" ? "0" : $('#ctl00_MyCPH1_txtBalanceAmount_CrDr').text());

            if (PaidAmount > BalanceAmount) {
                alert("Paid Amount Can not be greater then balance amount!! ");
                $('#ctl00_MyCPH1_txtPaidAmt').val("0.00");
                $('#ctl00_MyCPH1_txtPaidAmt').focus();
                return false;
            }
            if (ReceivedAmount > BalanceAmount) {
                alert("Receive Amount Can not be greater then balance amount!! ");
                $('#ctl00_MyCPH1_txtReceivedAmt').val("0.00");
                $('#ctl00_MyCPH1_txtReceivedAmt').focus();
                return false;
            }
            return true;
        }

    </script>

    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Settlement</asp:Label>
            </td>
            <td align="right"></td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>


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
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="20px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nature of Expense">
                                        <HeaderStyle HorizontalAlign="Center" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblNExpense" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Expense") %>'></asp:Label>
                                            <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="100px" VerticalAlign="Top" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtApprovalAmount" Width="50px" Style="text-align: right"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>'></asp:Label>
                                            <asp:HiddenField ID="hfPolarity" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Polarity") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtApprovalTotal" runat="server" Width="50px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
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
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Settlement </asp:Label>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left">
                            <b>Truck No</b>
                        </td>
                        <td align="left">
                            <b>Driver Name</b>
                        </td>
                        <td align="left">
                            <b>Tripsheet No</b>
                        </td>
                        <td align="left">
                            <b>Tripsheet Open Date</b>
                        </td>
                        <td align="left">
                            <b>Submission Date</b>
                        </td>
                        <td align="left">
                            <b>Approved Date</b>
                        </td>
                        <td align="left">
                            <b>Financial Closure Date</b>
                        </td>
                        <td align="left">
                            <b>Settlement Date</b>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server"  />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblDriverName" CssClass="blackfnt" runat="server" />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblTripsheetNo" CssClass="blackfnt" runat="server"  Font-Underline="true" onclick="TripsheetView(this)" />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblTripsheetDate" CssClass="blackfnt" runat="server"  />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblSubmissionDate" CssClass="blackfnt" runat="server"  />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblApprovedDate" CssClass="blackfnt" runat="server"  />
                        </td>

                        <td align="left">
                            <asp:Label ID="lblFinancialClosureDate" CssClass="blackfnt" runat="server"  />
                        </td>

                        <td align="left">
                            <asp:TextBox ID="txtSettlementDate" BorderStyle="Groove" CssClass="input" Width="75px" runat="server"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtSettlementDate" runat="server" />
                            <asp:HiddenField ID="hidStartLoc" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="hidEndLoc" runat="server"></asp:HiddenField>

                        </td>

                    </tr>
                    <tr style="background-color: white">
                        <td colspan="3" style="vertical-align: top !important;">
                            <table id="tblFuelEconomy" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="100%">
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
                        <td colspan="2" style="vertical-align: top !important;" >
                            <table id="tbl2" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="100%">
                                <tbody>
                                    <tr class="bgwhite">
                                        <td>Slip Fuel</td>
                                        <td>
                                            <asp:Label ID="lblSlipFuel" runat="server" Text="0.0" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td>Card Fuel</td>
                                        <td>
                                            <asp:Label ID="lblCardFuel" runat="server"  Text="0.0"/>
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td>Cash Fuel</td>
                                        <td>
                                            <asp:Label ID="lblCashFuel" runat="server" Text="0.0" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td>Total Fuel</td>
                                        <td>
                                            <asp:Label ID="lblTotalFuel" runat="server" Text="0.0" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td>Balance C/F</td>
                                        <td>
                                            <asp:Label ID="lblBalanceCF" runat="server" Text="0.0" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                        <td colspan="3" style="vertical-align: top !important;">
                            <table id="tbl3" class="boxbg" border="0" cellpadding="1" cellspacing="1" style="float: right;">
                                <tbody>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">Driver Advance</td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblDriverAdvance" Text="0.00" runat="server" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">Approved Amt</td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblApprovedAmount" Text="0.00" runat="server" Style="text-align: right;" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">
                                            <asp:Label ID="lblBalanceAmount_CrDr" runat="server" Text="Balance Amt Cr/Dr"></asp:Label></td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="txtBalanceAmount_CrDr" Text="0.00" runat="server" Style="text-align: right;" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">Paid Amt</td>
                                        <td>
                                            <asp:TextBox ID="txtPaidAmt" Text="0.00" runat="server" OnTextChanged="Payment_Receipt" AutoPostBack="true" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Style="text-align: right;"
                                                onblur="return ValidatePaidReceivedAmt()" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">Receive Amt</td>
                                        <td>
                                            <asp:TextBox ID="txtReceivedAmt" Text="0.00" runat="server" OnTextChanged="Payment_Receipt" AutoPostBack="true" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Style="text-align: right;"
                                                onblur="return ValidatePaidReceivedAmt()" />
                                        </td>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="font-weight: bold">
                                            <asp:Label ID="LblDriverLedger" runat="server" Text="Net Balance Amt Cr/Dr"></asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="txtBalToDriverLedger" Text="0.00" runat="server" Style="text-align: right;" ReadOnly="true" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="8"><b>Payment Details</b>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="8">
                            <table cellspacing="1" cellpadding="3" style="width: 100%" align="center" class="boxbg" border="0">
                                <tr style="background-color: white">
                                    <td align="Left" colspan="5">
                                        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server" Visible="false">
                                            <ContentTemplate>
                                                <UC5:UCMyPaymentControlEXP ID="UCMyPaymentControl1" runat="server"></UC5:UCMyPaymentControlEXP>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <asp:UpdatePanel ID="UpdatePaneReceipt" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server" Visible="false">
                                            <ContentTemplate>
                                                <UC6:MyReceiptControlDS ID="UCMyReceiptControl1" runat="server"></UC6:MyReceiptControlDS>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="8" align="right">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnAutoSettlement" runat="server" Text="Auto Settlement" OnClick="btnAutoSettlement_Click" Visible="false" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <div id="ProtsahanRashiPopup" title="Protsahan Rashi">
                            <asp:GridView ID="grdProtsahanRashi" runat="server" AutoGenerateColumns="false"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false"
                                EmptyDataText="No Records Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ETHC No">
                                        <ItemTemplate>
                                            <asp:Label ID="txtETHCNo" runat="server" MaxLength="10" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"ExternalTHCNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <ItemTemplate>
                                            <asp:Label ID="txtFrom" runat="server" MaxLength="10" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="To">
                                        <ItemTemplate>
                                            <asp:Label ID="txtTo" runat="server" MaxLength="10" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Loading Date">
                                        <ItemTemplate>
                                            <asp:Label ID="txtLoadingDate" runat="server" MaxLength="10" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"LoadingDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Unloading Date">
                                        <ItemTemplate>
                                            <asp:Label ID="txtUnloadingDate" runat="server" MaxLength="10" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Transit Days">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTransitDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                                                value='<%# DataBinder.Eval(Container.DataItem,"TransitDays") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Save Days">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSaveDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                                                value='<%# DataBinder.Eval(Container.DataItem,"SaveDays") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                onkeypress="javascript:validFloat(event,this.id)" CssClass="input" 
                                                value='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Amount">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtApprovalAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                onkeypress="javascript:validFloat(event,this.id)" 
                                                value='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>' CssClass="input" Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks">
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
                <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
