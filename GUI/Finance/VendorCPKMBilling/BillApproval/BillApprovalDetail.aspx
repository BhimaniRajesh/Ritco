<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillApprovalDetail.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillApproval_BillApprovalDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <style>
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 0px; /* Location of the box */
            left: 0;
            top: 10px;
            width: 50%; /* Full width */
            height: 50%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: white; /* Fallback color */
            opacity: 0.9;
            filter: alpha(opacity=50);
        }

        /* Modal Content */
        .modal-content {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 0px; /* Location of the box */
            left: 30%;
            top: 30%;
            padding: 10px;
            overflow: auto; /* Enable scroll if needed */
            background-color: #fefefe;
            margin: auto;
            width: 30%;
            border: 1px solid #888;
        }

        /* The Close Button */
        .close {
        }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
    </style>

    <UserControl:UserMessage runat="server" ID="umsg" />
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td height="30">
                            <font class="bluefnt">
                                <strong>Bill Approval of CPKM</strong> </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                    </tr>

                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table cellpadding="1" cellspacing="1" border="0" style="width: 80%" class="boxbg">
                    <thead>
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center">
                                <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CPKM Bill Approval"></asp:Label></td>
                        </tr>
                        <tr class="nrow">

                            <td colspan="4">
                                <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMBillDT" AutoGenerateColumns="False" CellSpacing="1"
                                    HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0" OnRowDataBound="gvCPKMBillDT_OnRowDataBound" EmptyDataText="No Record Data">

                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkVehicleNo" onclick="return AmontCalculation(this);" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("SrNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vehicle No.">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblVehicleNo" Text='<%# Eval("VehicleNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. Tyre">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTyreNo" Text='<%# Eval("Tyre") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnNoofTyre" Value='<%# Eval("Tyre") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Previous Trip sheet No.">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblPreviousTripNo" Text='<%# Eval("PreviousTripNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Opening KM">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblOpeningKM" Text='<%# Eval("OpeningKM") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Previous Tipsheet Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblPreviouTripDT" Text='<%# Eval("PreviousTripDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Closing Tripsheet No.">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblClosingTripNo" Text='<%# Eval("ClosingTripNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Closing Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblClosingDate" Text='<%# Eval("ClosingDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Closing KM">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblClosingKM" Text='<%# Eval("ClosingKm") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Select +,-">
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlOperation" onchange="AmontCalculation(this);">
                                                    <asp:ListItem Text="+" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="-" Value="2"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:HiddenField runat="server" ID="hdnOPType" Value='<%# Eval("OPType") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Add/Subtract Kms">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtAddSubtractKms" Text='<%# Eval("KMs") %>' CssClass="ltxt" onchange="return AmontCalculation(this);"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Actual Closing Km">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblActualClosingKm" Text='<%# Eval("ActualClosingKm") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnActualClosingKm" Value='<%# Eval("ActualClosingKm") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Net Distance">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblNetDistance" Text='<%# Eval("NetDistance") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnNetDistance" Value='<%# Eval("NetDistance") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Credit Kms">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCreditKms" Text='<%# Eval("CreditKms") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnCreditKms" Value='<%# Eval("CreditKms") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Balance Kms">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblBalanceKms" Text='<%# Eval("BalanceKms") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnBalanceKms" Value='<%# Eval("BalanceKms") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Base Rate">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblBaseRate" Text='<%# Eval("BaseRate") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnBaseRate" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblAmount" Text='<%# Eval("Amount") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnAmount" Value='<%# Eval("Amount") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rebate">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtRebate" Text='<%# Eval("Rebate") %>' CssClass="ltxt" onchange="return AmontCalculation(this);"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Net Amount">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblNetAmount" Text='<%# Eval("NetAmount") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnNetAmount" Value='<%# Eval("NetAmount") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblIGST" Text='<%# Eval("IGST") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnIGST" Value='<%# Eval("IGST") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCGST" Text='<%# Eval("CGST") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnCGST" Value='<%# Eval("CGST") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SGST">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSGST" Text='<%# Eval("SGST") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnSGST" Value='<%# Eval("SGST") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Final Amount">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblFinalAmount" Text='<%# Eval("FinalAmount") %>'></asp:Label>
                                                <asp:HiddenField runat="server" ID="hdnFinalAmount" Value='<%# Eval("FinalAmount") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reject Remark">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtRejectRemark" disabled Text='<%# Eval("RejectRemark") %>' CssClass="ltxt" onblur="return AmontCalculation(this)"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr class="nrow" runat="server" id="trTotal">
                            <td colspan="4">
                                <table cellpadding="1" cellspacing="1" border="0" style="width: 30%" class="boxbg">
                                    <tr class="nrow">
                                        <td><b>Sub Total Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server" Enabled="False" Text="0.0" ID="txtSubTotal" CssClass="ltxt" Width="100PX"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnSubTotal" />
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td><b>Misc. Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server" Enabled="False" Text="0.0" ID="txtMiscAmount" CssClass="ltxt" Width="100PX"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnMiscAmount" />
                                            <a id="aModel">View</a>
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td><b>Total Bill Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server" Enabled="False" Text="0.0" ID="txtTotalbillAmount" CssClass="ltxt" Width="100PX"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnTotalbillAmount" />
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td><b>Total Rejected Vehicle Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server" Enabled="False" Text="0.0" ID="txtTotalRejected" CssClass="ltxt" Width="100PX"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnTotalRejected" />
                                        </td>
                                    </tr>
                                    <%--Add By Minesh--%>
                                    <tr class="nrow">
                                        <td><b>TDS Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server"   Text="0.0" ID="txtTDSAmount" CssClass="ltxt" Width="100PX" onblur="Subtotal();"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnTDSAmount" />
                                        </td>
                                    </tr>
                                    <%--Add By Minesh--%>
                                    <tr class="nrow">
                                        <td><b>Net Bill Amount</b></td>
                                        <td>
                                            <asp:TextBox runat="server" Enabled="False" Text="0.0" ID="txtTotalNetBillAmount" CssClass="ltxt" Width="100PX"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnTotalNetBillAmount" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server" id="trsubbtn" class="bgbluegrey">
                            <td align="center" colspan="4">
                                <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_OnClick" />
                            </td>
                        </tr>
                    </thead>
                </table>

            </td>
        </tr>
    </table>
    <div>
        <!-- Modal content -->
        <div class="modal-content" id="myModal">

            <table cellpadding="1" cellspacing="1" border="0" style="width: 100%" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center">
                        <b>Misc. Charges Amount</b>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td>
                        <asp:GridView runat="server" CssClass="boxbg" ID="gvMiscCharge" AutoGenerateColumns="False" CellSpacing="1"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0" OnRowDataBound="gvMiscCharge_OnRowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMiscChargeCheckNo" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Particular">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblParticular" Text='<%# Eval("ChargeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblAmount" Text='<%# Eval("Amount") %>'></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnMiscDetailAmount" Value='<%# Eval("Amount") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </td>

                </tr>
                <asp:HiddenField runat="server" ID="hdnMiscXML" />
                <tr class="bgbluegrey">
                    <td align="center">
                        <input type="button" id="Close" value="Submit" class="close btn btn-primary" />
                    </td>
                </tr>
            </table>


        </div>

    </div>
    <script type="text/javascript">
        // Get the modal
        var hdnMiscXML = $("#<%=hdnMiscXML.ClientID%>");
        var modal = document.getElementById('myModal');
        var modalClose = document.getElementById('Close');

        // Get the button that opens the modal
        var btn = document.getElementById("aModel");

        // Get the <span> element that closes the modal
        //var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal 
        btn.onclick = function () {

            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        modalClose.onclick = function () {
            try {
                miscAmontCalculation();
                hdnMiscXML.val("");
                var miscnetAMount = 0
                var miscXML = "<Root>";
                $("input[id*='hdnMiscDetailAmount']").each(function (data) {
                    var lblFinalAmount = $(this);
                    var chkVehicleNo = $('#' + $(this).attr('id').replace("hdnMiscDetailAmount", "chkMiscChargeCheckNo"));
                    var txtParticular = $('#' + $(this).attr('id').replace("hdnMiscDetailAmount", "lblParticular"));
                    if (chkVehicleNo.prop("checked")) {
                        miscXML += "<Detail><Perticular>" + txtParticular.html() + "</Perticular>";
                        miscXML += "<Amount>" + lblFinalAmount.val() + "</Amount></Detail>";
                    }
                });
                miscXML += "</Root>";
                hdnMiscXML.val(miscXML);
                modal.style.display = "none";
            } catch (e) {
                alert(e);
                return false;
            }

        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        function miscAmontCalculation() {
            var txtMiscAmount = $('#<%=txtMiscAmount.ClientID%>');
            var hdnMiscAmount = $('#<%=hdnMiscAmount.ClientID%>');
            var TotalAmt = parseFloat(hdnMiscAmount.val());
            var amt = 0.00;
            var amt1 = 0.00;
            var all = new Array();
            $("input[id*='hdnMiscDetailAmount']").each(function (data) {
                var lblFinalAmount = $(this);
                var chkVehicleNo = $('#' + $(this).attr('id').replace("hdnMiscDetailAmount", "chkMiscChargeCheckNo"));
                if (!chkVehicleNo.prop("checked")) {
                    amt1 = parseFloat(amt1) + parseFloat(lblFinalAmount.val());
                    // all.push('-' + lblFinalAmount.val());
                }
                //else {
                //   // TotalAmt = parseFloat(TotalAmt) + parseFloat(lblFinalAmount.val());
                //    all.push('+' + lblFinalAmount.val());
                //}


            });

            //var arrayLength = all.length;
            //for (var i = 0; i < arrayLength; i++) {
            //   // console.log(all[i]);
            //    amt1 = parseFloat(amt1) + parseFloat(all[i]);
            //    //Do something
            //}

            hdnMiscAmount.val(amt1);
            txtMiscAmount.val(amt1);
            Subtotal();
        }
        function AmontCalculation(e) {
            var CurrentRow = $(e).closest('tr');

            var ddlOperation = $(e).closest('tr').find('select[id*="ddlOperation"]');
            var lblOpeningKM = $(e).closest('tr').find('span[id*="lblOpeningKM"]');
            var lblClosingKM = $(e).closest('tr').find('span[id*="lblClosingKM"]');
            var txtAddSubtractKms = $(e).closest('tr').find('input[id*="txtAddSubtractKms"]');
            var lblActualClosingKm = $(e).closest('tr').find('span[id*="lblActualClosingKm"]');
            var hdnActualClosingKm = $(e).closest('tr').find('input[id*="hdnActualClosingKm"]');
            var lblNetDistance = $(e).closest('tr').find('span[id*="lblNetDistance"]');
            var hdnNetDistance = $(e).closest('tr').find('input[id*="hdnNetDistance"]');
            var lblBaseRate = $(e).closest('tr').find('span[id*="lblBaseRate"]');
            var hdnBaseRate = $(e).closest('tr').find('input[id*="hdnBaseRate"]');

            var lblAmount = $(e).closest('tr').find('span[id*="lblAmount"]');
            var hdnAmount = $(e).closest('tr').find('input[id*="hdnAmount"]');
            var txtRebate = $(e).closest('tr').find('input[id*="txtRebate"]');
            var lblNetAmount = $(e).closest('tr').find('span[id*="lblNetAmount"]');
            var hdnNetAmount = $(e).closest('tr').find('input[id*="hdnNetAmount"]');
            var ddlGST = $(e).closest('tr').find('select[id*="ddlGST"]');
            var hdnGSTPercantage = $(e).closest('tr').find('input[id*="hdnGSTPercantage"]');
            var hdnGSTCredit = $(e).closest('tr').find('input[id*="hdnGSTCredit"]');

            var lblCreditKms = $(e).closest('tr').find('span[id*="lblCreditKms"]');
            var hdnCreditKms = $(e).closest('tr').find('input[id*="hdnCreditKms"]');

            var lblBalanceKms = $(e).closest('tr').find('span[id*="lblBalanceKms"]');
            var hdnBalanceKms = $(e).closest('tr').find('input[id*="hdnBalanceKms"]');

            var lblIGST = $(e).closest('tr').find('span[id*="lblIGST"]');
            var hdnIGST = $(e).closest('tr').find('input[id*="hdnIGST"]');
            var lblCGST = $(e).closest('tr').find('span[id*="lblCGST"]');
            var hdnCGST = $(e).closest('tr').find('input[id*="hdnCGST"]');
            var lblSGST = $(e).closest('tr').find('span[id*="lblSGST"]');
            var hdnSGST = $(e).closest('tr').find('input[id*="hdnSGST"]');
            var lblFinalAmount = $(e).closest('tr').find('span[id*="lblFinalAmount"]');
            var hdnFinalAmount = $(e).closest('tr').find('input[id*="hdnFinalAmount"]');
            var txtRejectRemark = $(e).closest('tr').find('input[id*="txtRejectRemark"]');
            var hdnNoofTyre = $(e).closest('tr').find('input[id*="hdnNoofTyre"]');

            if ($(e).closest('tr').find('input[type=checkbox]:checked').prop("checked")) {
                txtRejectRemark.prop('disabled', false);
            }
            else {
                txtRejectRemark.val('');
                txtRejectRemark.prop('disabled', true);
            }

            if (txtAddSubtractKms.val() != '') {
                var KMS = 0, NetKMS = 0, Amount = 0, NetAmount = 0, RebateAmt = 0, IGST = 0, CGST = 0, SGST = 0
                if (ddlOperation.val() == "1") {
                    lblActualClosingKm.html(parseFloat(txtAddSubtractKms.val()) + parseFloat(lblClosingKM.html()));
                }
                else if (ddlOperation.val() == "2") {
                    lblActualClosingKm.html(parseFloat(lblClosingKM.html()) - parseFloat(txtAddSubtractKms.val()));
                }
                KMS = lblActualClosingKm.html();
                hdnActualClosingKm.val(KMS);
                NetKMS = parseFloat(KMS) - parseFloat(lblOpeningKM.html() || 0);
                lblNetDistance.html(NetKMS);
                hdnNetDistance.val(NetKMS);
                //BalanceKms = parseFloat(hdnNetDistance.val()) - parseFloat(hdnCreditKms.val());
		BalanceKms = parseFloat(parseFloat(hdnCreditKms.val() - hdnNetDistance.val()));
                hdnBaseRate.val(lblBaseRate.html());
                //Amount = parseFloat(lblBaseRate.html()) * BalanceKms;
                Amount = (parseFloat(lblBaseRate.html()) * BalanceKms) * (parseFloat(hdnNoofTyre.val()) - 1);
                lblAmount.html(Amount);
                hdnAmount.val(Amount);
                lblBalanceKms.html(BalanceKms);
                hdnBalanceKms.val(BalanceKms);
                if (txtRebate.val() != '') {
                    RebateAmt = Amount - parseFloat(txtRebate.val());
                    lblNetAmount.html(RebateAmt);
                    hdnNetAmount.val(RebateAmt);
                    NetAmount = RebateAmt;
                }
                //if (hdnGSTCredit.val() == "Y") {
                //    //if (ddlGST.val() == "1") {
                //    //    IGST = NetAmount * parseFloat(hdnGSTPercantage.val()) / 100
                //    //    CGST = 0;
                //    //    SGST = 0;
                //    //}
                //    //else if (ddlGST.val() == "2") {
                //    //    var TotAmt = 0
                //    //    TotAmt = NetAmount * (parseFloat(hdnGSTPercantage.val())) / 100
                //    //    CGST = TotAmt / 2;
                //    //    SGST = TotAmt / 2;

                //    //    IGST = 0;

                //    //}
                //    lblIGST.html(IGST);
                //    hdnIGST.val(IGST);
                //    lblCGST.html(CGST);
                //    hdnCGST.val(CGST);
                //    lblSGST.html(SGST);
                //    hdnSGST.val(SGST);

                //}
                IGST = parseFloat(hdnIGST.val());
                CGST = parseFloat(hdnCGST.val());
                SGST = parseFloat(hdnSGST.val());
                lblFinalAmount.html(parseFloat(parseFloat(NetAmount) + parseFloat(IGST) + parseFloat(CGST) + parseFloat(SGST)).toFixed(2));
                hdnFinalAmount.val(parseFloat(parseFloat(NetAmount) + parseFloat(IGST) + parseFloat(CGST) + parseFloat(SGST)).toFixed(2));
            }
            if (parseFloat(hdnBalanceKms.val()) <= 0) {
                txtAddSubtractKms.attr("disabled", true);
                txtRebate.attr("disabled", true);
                ddlGST.attr("disabled", true);
            }
            // } 
            //else {
            //     lblFinalAmount.html("0");
            //    hdnFinalAmount.val("0");
            //}
            Subtotal();
            //// var hdnNetAmount = $(e).closest('tr').find('input[id*="hdnNetAmount"]');
            //if (txtBaseRate.val() != '' && txtGSTper.val() != '') {
            //    var GAmount = (parseFloat(txtBaseRate.val()) * parseFloat(txtGSTper.val())) / 100
            //    txtGSTAmount.val(GAmount);
            //    hdnGSTAmount.val(GAmount);
            //    txtNetAmount.val(GAmount + parseFloat(txtBaseRate.val()));
            //    hdnNetAmount.val(GAmount + parseFloat(txtBaseRate.val()));
            //}
        }
        function Subtotal() {
            var txtSubTotal = $('#<%=txtSubTotal.ClientID%>');
            var hdnSubTotal = $('#<%=hdnSubTotal.ClientID%>');
            var txtMiscAmount = $('#<%=txtMiscAmount.ClientID%>');
            var hdnMiscAmount = $('#<%=hdnMiscAmount.ClientID%>');
            var txtTotalbillAmount = $('#<%=txtTotalbillAmount.ClientID%>');
            var hdnTotalbillAmount = $('#<%=hdnTotalbillAmount.ClientID%>');
            var txtTotalRejected = $('#<%=txtTotalRejected.ClientID%>');
            var hdnTotalRejected = $('#<%=hdnTotalRejected.ClientID%>');
            var hdnTotalNetBillAmount = $('#<%=hdnTotalNetBillAmount.ClientID%>');
            var txtTotalNetBillAmount = $('#<%=txtTotalNetBillAmount.ClientID%>');
            //Add By Minesh
            var txtTDSAmount = $('#<%=txtTDSAmount.ClientID%>');
            var hdnTDSAmount = $('#<%=hdnTDSAmount.ClientID%>');

            var SubTotal = 0, MiscTotal = 0, TotalBill = 0, TotalRejected = 0, TDS = 0;
            if (txtTDSAmount.val() == "") {
                TDS = 0;
            }
            else {
                TDS = parseFloat(txtTDSAmount.val());
            }
            MiscTotal = hdnMiscAmount.val();
            $("span[id*='lblFinalAmount']").each(function (data) {
                var lblFinalAmount = $(this);
                var chkVehicleNo = $('#' + $(this).attr('id').replace("lblFinalAmount", "chkVehicleNo"));
                var txtRejectRemark = $('#' + $(this).attr('id').replace("lblFinalAmount", "txtRejectRemark"));
                SubTotal = parseFloat(SubTotal) + parseFloat(lblFinalAmount.html());
                if (chkVehicleNo.prop("checked")) {

                    //if (txtRejectRemark.val() != "") {
                    TotalRejected = parseFloat(TotalRejected) + parseFloat(lblFinalAmount.html());
                    //}
                }
                //else {
                //    SubTotal = parseFloat(SubTotal) + 0;
                //}
            });
            SubTotal = parseFloat(SubTotal);// - parseFloat(TotalRejected);
            txtSubTotal.val(SubTotal);
            hdnSubTotal.val(SubTotal);
            //Add by Minesh
            txtTotalbillAmount.val(parseFloat(MiscTotal) + SubTotal - TDS);
            hdnTotalbillAmount.val(parseFloat(MiscTotal) + SubTotal - TDS);
            txtTotalRejected.val(TotalRejected);
            hdnTotalRejected.val(TotalRejected);

            txtTotalNetBillAmount.val(parseFloat(txtTotalbillAmount.val()) - parseFloat(TotalRejected));
            hdnTotalNetBillAmount.val(parseFloat(hdnTotalbillAmount.val()) - parseFloat(TotalRejected));
        }
    </script>
</asp:Content>

