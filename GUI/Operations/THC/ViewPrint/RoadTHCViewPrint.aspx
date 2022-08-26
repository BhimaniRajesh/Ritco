<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoadTHCViewPrint.aspx.cs"
    Inherits="GUI_Operations_THC_ViewPrint_RoadTHCViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link id="Link1" href="../../../images/style.css" rel="stylesheet" type="text/css"
        runat="server" />
    <title>Trip Hire Contract</title>

    <script language="javascript" type="text/jscript">
        function printPage() {
            var hdnflagprint = document.getElementById("hdnflagprint");
            if (hdnflagprint.value == "Y")
                window.print();



            return false;
        }
        function AdvanceVoucherView(voucherno) {
            voucherno = voucherno
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../../Finance/VendorPayment_Ver1/Advance_Balance_Payment/AdvanceVoucher.aspx?Voucherno=" + voucherno +"&VoucherType=ADV"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function BalanceVoucherView(voucherno) {
            voucherno = voucherno
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../../Finance/VendorPayment_Ver1/Advance_Balance_Payment/AdvanceVoucher.aspx?Voucherno=" + voucherno +"&VoucherType=BAL"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function VendorBillView(billno) {
            voucherno = voucherno
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../../Finance/VendorPayment_Ver1/Advance_Balance_Payment/AdvanceVoucher.aspx?Voucherno=" + voucherno + "&VoucherType=BE"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

</head>
<body style="margin-top: 0; margin-left: 0;" onload="javascript:return printPage()">
    <form id="form1" runat="server">
    <br />
    <asp:Panel runat="server" HorizontalAlign="Center" Style="width: 10in" ID="pnlMain">
        <asp:Table ID="tblMain" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left" VerticalAlign="Top" Width="4.2in">
                    <asp:Image ID="imgLogo" runat="server" Height="50" /><br />
                    <asp:Label ID="lblClientName" runat="server"></asp:Label><br />
                    <asp:Label ID="lblClientAddress" runat="server"></asp:Label><br />
                    <br />
                    <asp:Label ID="lblDocName" runat="server" Font-Bold="true" Font-Size="Medium"></asp:Label>
                </asp:TableCell>
                <asp:TableCell VerticalAlign="Top" HorizontalAlign="Left">
                    <asp:Table runat="server" ID="tbl2" BorderWidth="0" CellPadding="0" CellSpacing="0"
                        Width="2.7in" CssClass="stbl">
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                        <b> <%=Session["THCCalledAs"].ToString()%>
                                No</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="LblTHCNo" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                        <b> <%=Session["THCCalledAs"].ToString()%>
                    Date</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="LblTHCDt" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                         <b>Manual
                    <%=Session["THCCalledAs"].ToString()%>
                    No</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="LblMTHCNo" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                         <b>Route</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="lblRoute" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                         <b>From-To</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="lblFromTo" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                         <b>Mode</b>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" BorderStyle="None">
                                <asp:Label ID="lblMode" runat="server" Text="ROAD"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table ID="tblopesummary" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="6" HorizontalAlign="Center">
        <b>Operations Summary</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        <b>Vendor Type</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblVendorType" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Vendor Name</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                    <asp:Label ID="lblVendorName" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        <b>Vehicle Number</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblVehicleName" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Address</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                    <asp:Label ID="lblAddress" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        <b>Vehicle Type</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblVehicleType" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Engine No</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblEngineNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Insurance exp date</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblInsurance" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        <b>Registration date</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblRegistrationDate" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Chassis No</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblChassisNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        <b>Fitness exp date</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblFitnessDate" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        <b>TripSheet No</b>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="5">
                    <asp:Label ID="lblTripSheetNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table ID="tblArrival" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left" CssClass="nrow" VerticalAlign="Top">
                    <asp:Table ID="tblMFDKT" BorderWidth="0" runat="server" Width="100%">
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left" CssClass="nrow">
                    <asp:Table ID="tblDriverDetail" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
                        Width="100%" CssClass="stbl">
                        <asp:TableRow CssClass="hrow">
                            <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                                <asp:Label ID="Label1" runat="server" Text="Driver Details" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label7" runat="server" Text="Driver 1"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label9" runat="server" Text="Driver 2"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lbldriver1" runat="server"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lbldriver2" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label5" runat="server" Text="License No | RTO"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lldriver1lic" runat="server"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lbldriver2lic" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="Label6" runat="server" Text="Validity date"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lbldriver1RTO" runat="server"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:Label ID="lbldriver2RTO" runat="server" Text="Driver Details"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table ID="tblFinInfo" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="6" HorizontalAlign="Center">
        <b>Financial Information</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
        <b>Contract Detail</b>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
        <b>Advance Payment</b>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
        <b>Balance Payment</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        Contract Type
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblConType" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Location
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblAdvLoc" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Location
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblBalLoc" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
        Contract Amount
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblConAmt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Amount
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblAvdAmt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Amount
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblBalAmt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Mode of payment
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblAdvPayMode" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Mode of payment
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblBalPayMode" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
       Cheque Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblAdvChqNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Cheque Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblBalChqNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Bank
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblAdvBank" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
         Bank
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblBalBank" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Voucher Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblAdvVoucherNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
         Voucher Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblBalVoucherNo" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
        Bill Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblVendorBill" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
         Bill Payment Voucher
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblVendorBillPayment" CssClass="blackfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            
        </asp:Table>
        <asp:Table ID="tblAdvanceBalance" BorderWidth="0" CellSpacing="1" Style="width: 7.0in"
            runat="server" CellPadding="1" CssClass="stbl">
        </asp:Table>
        <asp:Table ID="tblBalenceCharge" border="0" CellSpacing="1" Style="width: 7.0in"
            runat="server" CellPadding="1" class="stbl">
        </asp:Table>
        <asp:Table ID="tblMFSummary" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center">
        <b>Manifest Information - Movement</b>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
        <b>Capacity Utilization</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center" RowSpan="3">
                    <asp:GridView ID="GrdManifest" CssClass="stbl" Style="width: 100%" EmptyDataText="No Records Found....."
                        AllowPaging="false" AutoGenerateColumns="false" HeaderStyle-CssClass="nrow" CellPadding="1"
                        CellSpacing="1" BorderWidth="0" runat="server" SelectedIndex="1">
                        <Columns>
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="From-To" DataField="frm_to" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="Manifests" DataField="TCCNT" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:TemplateField>
                                <HeaderStyle Font-Bold="true" />
                                <HeaderTemplate>
                                    <%=SessionUtilities.DocketCalledAs.ToString()%>
                                </HeaderTemplate>
                                <HeaderStyle />
                                <ItemStyle CssClass="nrow" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDockets" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"tot_DKT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="Packages" DataField="tot_pkg" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="Weight" DataField="tot_Wt" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" />
                        <HeaderStyle CssClass="nrow" />
                    </asp:GridView>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="Label52" runat="server" Text="Vehicle Capacity Kg"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblVehicleCapacity" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="Label4" runat="server" Text="Total MF weight"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblTotalMFWeight" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="Label8" runat="server" Text="Utilization"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Label ID="lblUtilization" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
              <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                   <asp:GridView ID="GridMF" Style="width: 100%" EmptyDataText="No Records Found....."
                        AllowPaging="false" AutoGenerateColumns="false" HeaderStyle-CssClass="nrow" CellPadding="1"
                        CellSpacing="0" BorderWidth="0" runat="server" SelectedIndex="1">
                        <Columns>
                            <asp:TemplateField HeaderText="Manifest No" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <label class="blackfnt">
                                        <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"../../TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" +DataBinder.Eval(Container.DataItem, "TCNO")+",0" %>'
                                            Text='<%#DataBinder.Eval(Container.DataItem, "TCNO")%>' ID="Hyperlink1">
                                        </asp:HyperLink>
                                    </label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="MF Date." DataField="tcdt" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="From-To" DataField="fromto" ItemStyle-Font-Size="11 px"
                                ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-CssClass="blackfnt" HeaderText="No. of Dockets" DataField="TOT_DKT"
                                ItemStyle-Font-Size="11 px" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                            <asp:TemplateField HeaderText="Package L/B" ControlStyle-CssClass="blackfnt">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblPkgs11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_PKGS") %>'
                                        runat="server"></asp:Label>/<asp:Label ID="lblPkgs1" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_PKGS") %>'
                                            runat="server">
                                        </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Weight L/B" ControlStyle-CssClass="blackfnt">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblWeight11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_ACTWT") %>'
                                        runat="server"></asp:Label>/<asp:Label ID="lblWeight111" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_ACTUWT") %>'
                                            runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="hrow" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="stbl" />
                    </asp:GridView>
                </asp:TableCell>
               
            </asp:TableRow>
        </asp:Table>
        
        <asp:Table ID="tblLast" runat="server" BorderWidth="0" CellPadding="1" CellSpacing="1"
            Width="7.0in" CssClass="stbl">
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblEnteredBy" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblAt" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblDateTime" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                
                
            </asp:TableRow>
               <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center" Width="20%">
                Staff Name 
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" Width="20%">
                Sign
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" Width="20%">
                    Prepared By 
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" Width="20%">
                    At 
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" Width="20%">
                 Date &amp; Time 
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
       
       
    </asp:Panel>
    <asp:HiddenField ID="hdnflagprint" runat="server" />
    </form>
</body>
</html>
