<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THCViewPrint.aspx.cs" Inherits="GUI_Operations_THC_ViewPrint_THCViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link id="Link1" href="../../../images/style.css" rel="stylesheet" type="text/css"
        runat="server" />
    <title>THC View</title>
    <script language="javascript" type="text/jscript">
    function popupmenu1(voucherno)
    {
        voucherno = voucherno + ',0'
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "../../../Finance/Vendor_BA_payment/PrepareVoucher/Vendor/ViewTHCAdvance.aspx?advvoucher=" + voucherno
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function popupmenu2(voucherno)
    {
        voucherno = voucherno + ',0'
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "../../../Finance/Vendor_BA_payment/PrepareVoucher/Vendor/ViewTHCBalance.aspx?advvoucher=" + voucherno
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function ViewPrint() {
        var DocumentPrint = document.getElementById('HdnTHCNo').value;
        window.open("THCAdvanceVoucherDetailsViewPrint.aspx?DocumentPrint=" + DocumentPrint, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=650,status=no,left=60,top=125");
    }
    </script>
</head>
<body>

    <form id="f2122121" runat="server">
    
    <% string tcno = Request.QueryString.Get("tcno");
           string[] Split = tcno.Split(new Char[] { ',' });
           string THCNo = Convert.ToString(Split[0]);
           string print_yn = Convert.ToString(Split[1]);
           string boxbg = "boxbg";
           string bgbluegrey = "bgbluegrey";
           string strborder = "0";
           string strspace = "1";
           if (print_yn == "1")
           {
               boxbg = "";
               bgbluegrey = "bgwhite";
               strborder = "1";
           }

        %>
    
        <div align="center">
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in; background-color: #8ba0e5;" cellpadding="2">
                            
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <%--<asp:Image ID="imgLogo" runat="server" ImageAlign="TextTop" ImageUrl="../../../images/webxpress_logo.gif" />--%>
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                        <br />
                        <%--<asp:TextBox ID="txtLocAddress" CssClass="blackfnt" runat="server" BorderStyle="None" Width="100%" Wrap="false" ></asp:TextBox><br />--%>
                        <asp:Label ID="txtLocAddress" runat="server" CssClass="blackfnt" Wrap="true"></asp:Label><br />
                        <asp:Label ID="lblPinCode" runat="server" CssClass="blackfnt"></asp:Label><br />
                        <asp:Label ID="lblPhone" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    <td width="300" valign="top">
                        <table border="0" cellspacing="0" cellpadding="0" style="width: 3.0in" class='<%=boxbg %>'>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">
                                        THC Number: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblTHCNo" CssClass="blackfnt" runat="server"></asp:Label>
                                        <asp:HiddenField ID="HdnTHCNo" runat="server" />
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">Manual THC No: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblMTHCNo" CssClass="blackfnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">
                                        THC Date: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblTHCDt" CssClass="blackfnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">Vehicle Tracking No: </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVehicleTrackNo" CssClass="blackfnt" runat="server"></asp:Label>
                                    </font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left" style="width: 561px" colspan="2">
                        <font class="blackfnt" ><b><asp:Label ID="Label1" CssClass="blackfnt" runat="server" Text="Truck Hire Contract" Font-Bold="true" Font-Size="Medium"></asp:Label></b></font>
                    </td>
                </tr>
            </table>
            <br />
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in" cellpadding="2" class='<%=boxbg %>'>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">
                           THC Mode</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblTHCMode" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Route</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="LblRoute" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr id="tdAirNo" bgcolor="#FFFFFF" visible="false" runat="server">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">AirLine No</font>
                    </td>
                    <td class="blackfnt" width="16%" align="left">
                    <asp:Label ID="lblAirLineNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label>
                    </td>
                    <td width="17%" align="left">
                        <font class="blackfnt">FlighNo</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblFlighNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                 <tr id="tdAirBill" bgcolor="#FFFFFF" visible="false" runat="server">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Bill No</font>
                    </td>
                    <td class="blackfnt" width="16%" align="left">
                    <asp:Label ID="lblAirBillNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label>
                    </td>
                    <td width="17%" align="left">
                        <font class="blackfnt"></font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">TripSheet No</font>
                    </td>
                    <td class="blackfnt" width="16%" align="left">
                    <asp:Label ID="lblTreepSheetNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label>
                    </td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Cities covered</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblCities" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vendor Type</font></td>
                    <td align="left">
                        <asp:Label ID="lblVendorType" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Vendor</font></td>
                    <td align="left">
                        <asp:Label ID="lblVendor" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vehicle No/RR No.</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">RC Book no</font></td>
                    <td align="left">
                        <asp:Label ID="lblRCBookNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Vehicle Type</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleType" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td align="left">
                        <font class="blackfnt">Vehicle Reg. date</font></td>
                    <td align="left">
                        <asp:Label ID="lblVehicleRegDt" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Engine No</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblEngineNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Insurance Policy Val date</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblInsuranceDt" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Chassis No.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblChassisNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Fitness Cert Val date</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblFitnessDt" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Seal No.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblSealNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Vehicle Free Space</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblVehicleFreeSpace" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">StartingKm-ClosingKm.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblStartKM" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">PAN No</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblPANNo" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Vehicle Capacity </font></td>
                    <td class="blackfnt" width="16%" align="left" colspan="3">
                        <asp:Label ID="lblCapacity" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
				 <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Transshipment</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblTransshipment" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Transit Location</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblTransitLocation" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                 <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Transshipment Remark</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblTransshipmentRemark" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Tentative Freight</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblTentativeFreight" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">From City</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lblFromCity" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">To City</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lblToCity" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>
				 <tr bgcolor="#FFFFFF">
                    <td class="blackfnt" width="13%" align="left">
                        <font class="blackfnt">Edited By.</font></td>
                    <td class="blackfnt" width="16%" align="left">
                        <asp:Label ID="lbThcEditDate" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                    <td width="17%" align="left">
                        <font class="blackfnt">Edited Date Time</font></td>
                    <td width="17%" align="left">
                        <asp:Label ID="lbThcEditBy" CssClass="blackfnt" runat="server" Width="142px"></asp:Label></td>
                </tr>

            </table>
            
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in"  cellpadding="2" class='<%=boxbg %>'
                visible="true">
                <tr id="driverTable" runat="server" class="bgbluegrey" align="center">
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Driver Name</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>License No.</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Validity Date</strong></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt"><strong>Issued by RTO</strong></font></div>
                    </td>
                </tr>
                <tr id="driver1" visible="true" runat="server" bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="blackfnt">&nbsp;
                                <asp:Label ID="Lbldriver1" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="Lbldriver1lic" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">&nbsp;
                                <asp:Label ID="Lbldriver1valdt" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="Lbldriver1RTO" runat="server" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                            </font>
                        </div>
                    </td>
                </tr>
                <tr id="driver2" visible="false" runat="server" bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="blackfnt">&nbsp;
                                <asp:Label ID="Lbldriver2" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="Lbldriver2lic" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font>&nbsp;</div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">&nbsp;
                                <asp:Label ID="Lbldriver2valdt" runat="server" CssClass="blackfnt" Width="142px"></asp:Label></font></div>
                    </td>
                    <td colspan="2">
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="Lbldriver2RTO" runat="server" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                            </font>
                        </div>
                    </td>
                </tr>
            </table>
           <br />
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in" cellpadding="2" class='<%=boxbg %>'>
                <tr class="bgbluegrey">
                    <td colspan="4">
                        <font class="blackfnt">&nbsp;<strong>Advance At:<asp:Label ID="lblAdvAt" CssClass="blackfnt"
                            runat="server" Width="60px"></asp:Label></strong></font></td>
                    <td colspan="2">
                        <font class="blackfnt">&nbsp;<strong>Balance At:<asp:Label ID="lblBalAt" CssClass="blackfnt"
                            runat="server" Width="60px"></asp:Label></strong></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Standard Rate</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblStandardConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS rate %</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblTDSRate" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Net bal payable</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblNetBalPayable" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Contract Amount</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblConAmt" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">TDS</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblTDS" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Incentive</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblIncentive" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Telephone</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblTelephone" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                    </td>
                    <td align="left">
                        <font class="blackfnt">Deduction</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblDeduction" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Other Amt(+)</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblOther" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Advance Paid</font></td>
                    <td align="left">
                        <font class="blackfnt">
                           <a href="Javascript:ViewPrint()"><asp:Label ID="lblAdvancePaid" runat="server" Width="142px"></asp:Label></a>
                        </font></td>
                    <td align="left">
                        <font class="blackfnt">NET balance paid</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblNetBalancePaid" runat="server" Width="142px"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lbl123" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Payment mode</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblAdvPaymentMode" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Payment mode</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblBalPaymentMode" runat="server" Width="142px"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    
                    <td align="left">
                        <font class="blackfnt">Voucher no</font></td>
                    <td align="left">
                        <font class="blackfnt">
                        
                            <asp:Label ID="lblAdvVoucherNo" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Voucher no</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">
                            <asp:Label ID="lblBalVoucherNo" runat="server" Width="142px"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    
                    <td align="left">
                        <font class="blackfnt">InComing Remarks</font>
                    </td>
                    <td align="left" colspan="5">
                        <font class="blackfnt"><asp:Label ID="lblRemarks123" runat="server"></asp:Label></font>
                    </td>
                    
                </tr>
                <tr bgcolor="#FFFFFF">
                 
                    <td align="left">
                        <font class="blackfnt">OutGoing Remarks</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lblRemarks11" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Total Actual Weight</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lblActWt" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Total Charge Weight</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lblChgWt" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            
            <%--<table style="width: 7.6in" '<%=strborder %>' cellspacing="1" cellpadding="2" class="boxbg">
                <tr class="bgbluegrey">
                <td>
                
                </td>
                    <td colspan="3">
                        <font class="blackfnt">&nbsp;<strong>Arrival</strong></font></td>
                        <td colspan="3">
                        <font class="blackfnt">&nbsp;<strong>Departure</strong></font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                <td>
                
                </td>
                    <td align="left">
                        <font class="blackfnt">Scheduled</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblSchedule1" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Actual</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblActual1" runat="server" Width="142px"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Reason</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblReason1" runat="server" Width="142px"></asp:Label></font></td>
                </tr>
                </table>--%>
            <asp:Table ID="tblMFDKT" Visible="false" BorderWidth="1" runat="server" Style="width: 7.6in">
                
            </asp:Table>
            
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in" cellpadding="2" class='<%=boxbg %>'>
                <tr class="bgbluegrey">
                    <td colspan="9">
                        <div align="center">
                            <font class="blackfnt"><strong>Manifest Summary</strong></font></div>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="2">
                        <asp:GridView ID="GrdManifest" Style="width: 100%" EmptyDataText="No Records Found....."
                            AllowPaging="false" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                            CellPadding="2" CellSpacing="1" BorderWidth="1" runat="server"
                            SelectedIndex="1">
                            <Columns>
                                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Manifest No" DataField="TCNO" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />--%>
                                    
                                    <asp:TemplateField HeaderText="Manifest No" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white">
                                        <ItemTemplate>
                                            <label class="blackfnt">
                                                <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"../../TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" +DataBinder.Eval(Container.DataItem, "TCNO")+",0" %>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "TCNO")%>' ID="Hyperlink1">
                                                </asp:HyperLink>
                                            </label>
                                        </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Manual MF No." DataField="manual_tcno"
                                    ItemStyle-Font-Size="11 px" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="From-To" DataField="fromto" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="Date" DataField="tcdt" ItemStyle-Font-Size="11 px"
                                    ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-CssClass="blackfnt" HeaderText="No. of Dockets" DataField="TOT_DKT"
                                    ItemStyle-Font-Size="11 px" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" />
                                <asp:TemplateField HeaderText="Package L/B" ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblPkgs11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_PKGS") %>'
                                            runat="server"></asp:Label>/<asp:Label ID="lblPkgs1" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_PKGS") %>'
                                                runat="server">
                                        

                                            </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Weight L/B" ControlStyle-CssClass="blackfnt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblWeight11" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_LOAD_ACTWT") %>'
                                            runat="server"></asp:Label>/<asp:Label ID="lblWeight111" Text='<%#DataBinder.Eval(Container.DataItem, "TOT_ACTUWT") %>'
                                                runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' style="width: 7.6in" cellpadding="2" class='<%=boxbg %>'>
                <tr class="bgbluegrey" align="center">
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Prepared At-Date</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Staff Name</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Approval Sign</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Driver Sign</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Entered At-Date</strong></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt"><strong>Entered by</strong></font></div>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblPreparedAtDt" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblStaffname" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblSign" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblDriverSign" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblEnteredAtDt" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                    </td>
                    <td>
                        <div align="center">
                            <font class="blackfnt">
                                <asp:Label ID="lblEnteredBy" runat="server" CssClass="blackfnt"></asp:Label>
                            </font>
                        </div>
                    </td>
                </tr>
            </table>
            
            <%
                if (print_yn == "1")
                {
         
            %>

            <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
            </script>

            <%} %>
            
        </div>
    </form>
</body>
</html>
