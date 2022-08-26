<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripsheetViewPrint.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripsheetViewPrint" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=11" />
    <script lang="javascript" type="text/javascript">
        function printme() {
            var qs = new Querystring()
            var mPrintMode = qs.get("PrintMode");
            if (mPrintMode == "1") {
                window.print();
            }
        }
        function popupCheckList(ctrl) {
			var url = window.location.href.split('/');
			var baseUrl = url[0] + '//' + url[2]+ '//' + url[3];
            var mstrFile = document.getElementById(ctrl).innerText;
			baseUrl = baseUrl+"/GUI/Fleet/Operations/Issue/UploadedImages/" + mstrFile;
            window.open(baseUrl, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }
        function ViewPrintVer1() {
            var TripSheetNo = document.getElementById("lblTripSheetNo").innerHTML;
            
			var url = window.location.href.split('/');
			var baseUrl = url[0] + '//' + url[2]+ '//' + url[3];
			
            var strurl = baseUrl+"/GUI/Fleet/Operations/Issue/frmDriverSettlementIssueSlipViewVer1.aspx?id=" + TripSheetNo + "&PrintMode=0";
            popup = window.open(strurl, "", "height=475,width=1150,resizable=yes,scrollbars=yes,left=100,top=125");
        }

        // When the user clicks the link, open the modal 
        function onShowTollDetails() {
            // Get the modal
            var modal = document.getElementById("myModal");
            modal.style.display = "block";

            // When the user clicks on <span> (x), close the modal
            modal.onclick = function () {
                modal.style.display = "none";
            }
            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }

        // When the user clicks the link, open the modal 
        function onShowCashFuel(ctrl) {
			
			var url = window.location.href.split('/');
			var baseUrl = url[0] + '//' + url[2]+ '//' + url[3];
			
            var mstrFile = document.getElementById("hdnTollDocument").value;
            var mFilePath = baseUrl+"/GUI/Fleet/Operations/Issue/UploadedImages/Ritco/" + mstrFile;
            
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
            //// Get the modal
            //var modal = document.getElementById("dvCashFuel");
            //modal.style.display = "block";

            //// When the user clicks on <span> (x), close the modal
            //modal.onclick = function () {
            //    modal.style.display = "none";
            //}
            //// When the user clicks anywhere outside of the modal, close it
            //window.onclick = function (event) {
            //    if (event.target == modal) {
            //        modal.style.display = "none";
            //    }
            //}
        }
    </script>
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

</head>
<body onload="printme()">
    
    <form id="form1" runat="server">

        <div align="left" style="width: 75%">
            <table cellspacing="1" border="0" style="width: 100%">
                <tr align="left">
                    <td colspan="3">
                        <table cellspacing="1" style="width: 100%" class="boxbg" border="0">
                            <tr class="bgbluegrey">
                                <td align="center" rowspan="3" style="background-color: white">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="../../../../images/WebXpress_logo.gif" /></td>
                                <td colspan="5" align="center">
                                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Trip Sheet View"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td>
                                    <font class="bluefnt">Trip Sheet No</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTripSheetNo" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Controlling Branch</font>
                                </td>
                                <td colspan="3">
                                    <asp:Label ID="lblControlBranch" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Route Type</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblRouteTp" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                    :
                                    <asp:Label ID="lblRouteTypeDetail" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Manual Trip Sheet No</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblManualTripSheetNo" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white" height="20">
                                <td colspan="6" align="center"></td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Trip Start Date & Time</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTripSheetDate" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Vehicle No.</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblVehicleNo" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Driver Name</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblDriverName1" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>

                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Trip End Date & Time</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTripEndDate" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Vehicle Type</font></td>
                                <td>
                                    <asp:Label ID="lblVehicleType" runat="server" CssClass="blackfnt" Text=''></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Trip End KM</font></td>
                                <td>
                                    <asp:Label ID="txtTripEndKm" runat="server" CssClass="blackfnt" Text=''>
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="row_FTCity" style="background-color: white">
                                <td>
                                    <font class="bluefnt">Trip Start KM</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTripStartKm" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Vehicle Capacity</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblVehicleCapacity" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Total Trip KM</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalTripKm" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Entry By</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblEntryBy" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Entry Date & Time</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblEntryDateTime" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>

                        </table>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="6" align="left" style="height: 21px">
                        <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                  Credit Fuel
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">

                        <asp:GridView ID="grdCreditFuel" runat="server" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                            PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnSrNo" runat="server"
                                            Value='<%# DataBinder.Eval(Container.DataItem,"srno") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="VENDORNAME" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="FuelMode" ItemStyle-HorizontalAlign="Left" HeaderText="FuelMode" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="FuelType" ItemStyle-HorizontalAlign="Left" HeaderText="FuelType" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="VendorCity" ItemStyle-HorizontalAlign="Left" HeaderText="City" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="UserSlipNo" ItemStyle-HorizontalAlign="Left" HeaderText="Reference No" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" />
                                <asp:BoundField DataField="FuelSlipDate" ItemStyle-HorizontalAlign="Left" HeaderText="Reference Date" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" />
                                <asp:BoundField DataField="Quantity" ItemStyle-HorizontalAlign="Left" HeaderText="Odometer Reading" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Quantity" ItemStyle-HorizontalAlign="Left" HeaderText="Diesel(Qty In Ltr)" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Rate" ItemStyle-HorizontalAlign="Left" HeaderText="Diesel as per Slip date Rate/Ltr" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Amount" ItemStyle-HorizontalAlign="Left" HeaderText="Amount" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="FillingDate" HeaderText="Filling Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                <asp:BoundField DataField="RateAsPerFillingDate" ItemStyle-HorizontalAlign="Left" HeaderText="Rate As per Filling Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="AmountAsPerFillingDate" ItemStyle-HorizontalAlign="Left" HeaderText="Final Amount" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="6" align="left" style="height: 21px">
                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                  Fuel Card
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="grdFuelCardDetails" runat="server" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                            PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Supplier" ItemStyle-HorizontalAlign="Left" HeaderText="Supplier" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="FuelType" ItemStyle-HorizontalAlign="Left" HeaderText="FuelType" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="FuelCardNo" ItemStyle-HorizontalAlign="Left" HeaderText="CardNo" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="City" ItemStyle-HorizontalAlign="Left" HeaderText="City" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="TransactionID" ItemStyle-HorizontalAlign="Left" HeaderText="TransactionID" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="TransactionDate" ItemStyle-HorizontalAlign="Left" HeaderText="TransactionDate" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="DieselQty" ItemStyle-HorizontalAlign="Left" HeaderText="Diesel ( Qty in Litre )" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="AddFuelQty" ItemStyle-HorizontalAlign="Left" HeaderText="Add Blue ( Qty in Litre )" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="SwappingDate" ItemStyle-HorizontalAlign="Left" HeaderText="SwappingDate" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Amount" ItemStyle-HorizontalAlign="Left" HeaderText="Amount" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table cellspacing="1" style="width: 50%" class="boxbg" border="0">
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Total Cash</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblTotalCash" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Total Diesel</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalDiesel" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Ltr</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalDieselLtr" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Total Add Blue</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalAddBlue" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Ltr</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalAddBlueLtr" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Total CNG</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalCNG" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Ltr</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTotalCNGLtr" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Total Driver Advance</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblTotalAdvance" Text='' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                             <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">CheckList</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblCheckList" Text='' onclick="popupCheckList(this.id);" runat="server" CssClass="blackfnt" style="text-decoration:underline;"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <div id="footer">
                            <table cellspacing="0" cellpadding="0" width="100%" align="left" class="boxbg" border="0"
                                style="font-size: 8pt; font-family: Verdana">
                                <tr style="background-color: white;">
                                    <td style="font-weight: bold; width: 10%; height: 18px"><a id="aModel">Toll Card:</a>
                                    </td>
                                    <td style="width: 20%; text-align: left">
                                        <asp:Label ID="lblByCard" Text='' onclick="onShowTollDetails();" runat="server" CssClass="blackfnt" Style="text-decoration: underline;"></asp:Label></td>
                                    <td style="font-weight: bold; width: 10%; height: 18px">Cash Toll:
                                    </td>
                                    <td style="width: 20%; text-align: left">
									     <input type="hidden" id="hdnTollDocument" runat="server" />
                                        <asp:Label ID="lblByCash" Text='' onclick="onShowCashFuel(this);" runat="server" CssClass="blackfnt" Style="text-decoration: underline;"></asp:Label>
                                    </td>
                                    <td style="font-weight: bold; width: 20%; height: 18px">Driver Sattlement Status:
                                    </td>
                                    <td style="width: 20%; text-align: left">
                                        <asp:Label ID="lblDriverSettle" Text='fgfgfg' onclick="ViewPrintVer1();" runat="server" CssClass="blackfnt" Style="text-decoration: underline;"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="6" align="left" style="height: 21px">
                        <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                  Advance Paid To Driver
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="grdDriverAdvance" runat="server" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                            PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BranchCode" ItemStyle-HorizontalAlign="Left" HeaderText="Branch Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="AdvDate" ItemStyle-HorizontalAlign="Left" HeaderText="Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="VoucherRefNo" ItemStyle-HorizontalAlign="Left" HeaderText="Voucher No" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                                <asp:BoundField DataField="AdvAmt" ItemStyle-HorizontalAlign="Left" HeaderText="Amount" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Remark" ItemStyle-HorizontalAlign="Left" HeaderText="Remark" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="6" align="left" style="height: 21px">
                        <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                  Journey Details
                        </asp:Label>
                        <UserControl:UserMessage runat="server" ID="umsg" />
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
                                <asp:BoundField DataField="TripDetentionRemark" HeaderText="Detention Remarks">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TripRecoverableRemark" HeaderText="Recoverable Remarks">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Remarks" HeaderText="POD Remark">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField ItemStyle-BackColor="white">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" Text="POD View" CommandArgument='<%# Eval("UploadFileName") %>' runat="server" OnClick="DownloadFile"></asp:LinkButton>
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
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <div id="footer">
                            <table cellspacing="0" cellpadding="0" width="100%" align="left" class="boxbg" border="0"
                                style="font-size: 8pt; font-family: Verdana">
                                <tr style="background-color: white">
                                    <td style="font-weight: bold; width: 33%; height: 18px">Sign of Driver:
                                    </td>
                                    <td style="font-weight: bold; width: 33%; height: 18px">Sign of Fleet Supervisor:
                                    </td>
                                    <td style="font-weight: bold; width: 34%; height: 18px">Sign of Fleet In-Charge:
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr style="background-color: white" height="20">
                    <td colspan="6" align="center"></td>
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
        <div>
            <!-- Modal content -->
            <div class="modal-content" id="myModal" runat="server">
                <table id="tblTollList" cellpadding="1" cellspacing="1" border="0" style="width: 100%" class="boxbg">
                    <tr class="bgbluegrey">
                        <th align="left">Card No</th>
                        <td>
                            <asp:Label ID="lblFuelCardNo" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <th align="left">Last RefNo</th>
                        <td>
                            <asp:Label ID="lblLastRefNo" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                        <th align="left">Last Ref Date</th>
                        <td>
                            <asp:Label ID="lblLastDate" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <th align="left">This RefNo</th>
                        <td>
                            <asp:Label ID="lblThisRefNo" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                        <th align="left">This Ref Date</th>
                        <td>
                            <asp:Label ID="lblThisDate" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <th align="left">By Card</th>
                        <td align="right">
                            <asp:Label ID="lblToll_ByCard" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                        <th align="left">By Cash</th>
                        <td align="right">
                            <asp:Label ID="lblToll_ByCash" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <th align="left">Total</th>
                        <td align="right">
                            <asp:Label ID="lblToll_Total" Text='' runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <input type="button" value="Close" class="close btn btn-primary" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
            <!-- Modal content -->
            <div class="modal-content" id="dvCashFuel" runat="server">
                <table id="tblCashFuel" cellpadding="1" cellspacing="1" border="0" style="width: 100%" class="boxbg">
                    <tr>
                        <td colspan="6">
                            <asp:GridView ID="gvCashFuel" runat="server" AutoGenerateColumns="False"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Place" ItemStyle-HorizontalAlign="Left" HeaderText="Place" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Date" ItemStyle-HorizontalAlign="Center" HeaderText="Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Fuel" ItemStyle-HorizontalAlign="Right" HeaderText="Fuel" HeaderStyle-HorizontalAlign="Center" ReadOnly="True" SortExpression="vslipdt" />
                                    <asp:BoundField DataField="Rate" ItemStyle-HorizontalAlign="Right" HeaderText="Rate" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Amount" ItemStyle-HorizontalAlign="Right" HeaderText="Amount" HeaderStyle-HorizontalAlign="Center" ReadOnly="True" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <input type="button" value="Close" class="close btn btn-primary" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
