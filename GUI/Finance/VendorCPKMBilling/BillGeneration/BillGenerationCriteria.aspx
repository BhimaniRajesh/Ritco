<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BillGenerationCriteria.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillGeneration_BillGenerationCriteria" %>

<%@ Register Src="~/Common_UserControls/RPT_Date.ascx" TagPrefix="MultiCheckCombo"
    TagName="RPT_Date" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Assembly="Anthem.AutoSuggest" Namespace="Anthem" TagPrefix="Anthem" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <style>
        /* The Modal (background) */.modal
        {
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
        /* Modal Content */.modal-content
        {
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
        /* The Close Button */.close
        {
        }
        .close:hover, .close:focus
        {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

    <script language="JavaScript" src="./../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvCPKMBillDT.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        var ServiceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';


        //$(document).ready(function () {
        //InitializedAutocomplete();

        //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        //function EndRequestHandler(sender, args) {
        //    InitializedAutocomplete();
        //}

        //});

       <%-- function InitializedAutocomplete() {

            var txtVehicleNo = '#<%= txtVehicleNo.ClientID%>';
            var hdnVehicleNo = '<%= hdnVehicleNo.ClientID%>';

            try {
                AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle", []);
            } catch (e) {
                //alert(e);
            }


        }--%>


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

            var lblIGST = $(e).closest('tr').find('span[id*="lblIGST"]');
            var hdnIGST = $(e).closest('tr').find('input[id*="hdnIGST"]');
            var lblCGST = $(e).closest('tr').find('span[id*="lblCGST"]');
            var hdnCGST = $(e).closest('tr').find('input[id*="hdnCGST"]');
            var lblSGST = $(e).closest('tr').find('span[id*="lblSGST"]');
            var hdnSGST = $(e).closest('tr').find('input[id*="hdnSGST"]');
            var lblFinalAmount = $(e).closest('tr').find('span[id*="lblFinalAmount"]');
            var hdnFinalAmount = $(e).closest('tr').find('input[id*="hdnFinalAmount"]');
            var lblRejectRemark = $(e).closest('tr').find('span[id*="lblRejectRemark"]');
            var hdnNoofTyre = $(e).closest('tr').find('input[id*="hdnNoofTyre"]');
            

            var lblCreditKms = $(e).closest('tr').find('span[id*="lblCreditKms"]');
            var hdnCreditKms = $(e).closest('tr').find('input[id*="hdnCreditKms"]');

            var lblBalanceKms = $(e).closest('tr').find('span[id*="lblBalanceKms"]');
            var hdnBalanceKms = $(e).closest('tr').find('input[id*="hdnBalanceKms"]');

            if ($(e).closest('tr').find('input[type=checkbox]:checked').prop("checked")) {

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
                    BalanceKms = parseFloat(hdnNetDistance.val()) - parseFloat(hdnCreditKms.val());
					//BalanceKms = parseFloat(parseFloat(hdnCreditKms.val() - hdnNetDistance.val()));
					var BalanceKms1=0.0;
					if(parseFloat(BalanceKms) < 0)	
					{
						BalanceKms1=0;
					}
					else	
					{
						BalanceKms1=BalanceKms;
					}
                    hdnBaseRate.val(lblBaseRate.html());
                    Amount = (parseFloat(lblBaseRate.html()) * BalanceKms1) * (parseFloat(hdnNoofTyre.val()) - 1);
                    lblAmount.html(parseFloat(Amount <0 ? 0 : Amount).toFixed(2));
                    hdnAmount.val(Amount <0 ? 0 : Amount);
                    lblBalanceKms.html(BalanceKms);
                    hdnBalanceKms.val(BalanceKms);
                    if (txtRebate.val() != '') {
                        RebateAmt = (Amount <0 ? 0 : Amount) - parseFloat(txtRebate.val());
                        lblNetAmount.html(parseFloat(RebateAmt).toFixed(2));
                        hdnNetAmount.val(RebateAmt);
                        NetAmount = RebateAmt;
                    }
                    if (hdnGSTCredit.val() == "Y") {
                        if (ddlGST.val() == "1") {
                            IGST = NetAmount * parseFloat(hdnGSTPercantage.val()) / 100
                            CGST = 0;
                            SGST = 0;
                        }
                        else if (ddlGST.val() == "2") {
                            var TotAmt = 0
                            TotAmt = NetAmount * (parseFloat(hdnGSTPercantage.val())) / 100
                            CGST = TotAmt / 2;
                            SGST = TotAmt / 2;

                            IGST = 0;

                        }
                        lblIGST.html(parseFloat(IGST).toFixed(2));
                        hdnIGST.val(parseFloat(IGST).toFixed(2));
                        lblCGST.html(parseFloat(CGST).toFixed(2));
                        hdnCGST.val(parseFloat(CGST).toFixed(2));
                        lblSGST.html(parseFloat(SGST).toFixed(2));
                        hdnSGST.val(parseFloat(SGST).toFixed(2));

                    }else {
                        lblIGST.html(0);
                        hdnIGST.val(0);
                        lblCGST.html(0);
                        hdnCGST.val(0);
                        lblSGST.html(0);
                        hdnSGST.val(0);
                    }

                    //lblFinalAmount.html(NetAmount + IGST + CGST + SGST);
                    //hdnFinalAmount.val(NetAmount + IGST + CGST + SGST);

                    lblFinalAmount.html(parseFloat(parseFloat(NetAmount) + parseFloat(IGST) + parseFloat(CGST) + parseFloat(SGST)).toFixed(2));
                    hdnFinalAmount.val(parseFloat(parseFloat(NetAmount) + parseFloat(IGST) + parseFloat(CGST) + parseFloat(SGST)).toFixed(2));

                }
                if (parseFloat(hdnBalanceKms.val()) <= 0) {
                    txtAddSubtractKms.attr("disabled", true);
                    txtRebate.attr("disabled", true);
                    ddlGST.attr("disabled", true);
                }
            } else {
                lblFinalAmount.html("0");
                hdnFinalAmount.val("0");
            }
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
            //Add By Minesh
            var txtTDSAmount = $('#<%=txtTDSAmount.ClientID%>');
            var hdnTDSAmount = $('#<%=hdnTDSAmount.ClientID%>');
            
            var SubTotal = 0, MiscTotal = 0, TotalBill = 0,TDSAmount=0
            if (txtTDSAmount.val() == "") {
                TDSAmount = 0;
            }
            else {
                TDSAmount = parseFloat(txtTDSAmount.val());
            }
            MiscTotal = parseFloat(hdnMiscAmount.val()) || 0;
            $("span[id*='lblFinalAmount']").each(function (data) {
                var lblFinalAmount = $(this);
                var chkVehicleNo = $('#' + $(this).attr('id').replace("lblFinalAmount", "chkVehicleNo"));
                if (chkVehicleNo.prop("checked")) {
                    SubTotal = SubTotal + parseFloat(lblFinalAmount.html());
                } else {
                    SubTotal = SubTotal + 0;
                }
            });
            txtSubTotal.val(parseFloat(SubTotal).toFixed(2));
            hdnSubTotal.val(parseFloat(SubTotal).toFixed(2));
            //Add By Minesh//alert(txtTDSAmount.val());
            txtTotalbillAmount.val(parseFloat(MiscTotal + SubTotal - TDSAmount).toFixed(0));
            hdnTotalbillAmount.val(parseFloat(MiscTotal + SubTotal - TDSAmount).toFixed(0));
        
        }
    </script>

    <div style="width: 10in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <UserControl:UserMessage runat="server" ID="umsg" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td height="30">
                                        <font class="bluefnt"><strong>Bill Generation of CPKM</strong> </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="horzblue">
                                        <img src="../../images/clear.gif" width="2" height="1" alt="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../../images/clear.gif" width="15" height="10" alt="" />
                                    </td>
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
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CPKM Bill Generation"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <b>Fleet Center</b>
                                        </td>
                                        <td colspan="5">
                                            <b>
                                                <%=SessionUtilities.CurrentBranchCode %></b>
                                        </td>
                                       
                                    </tr>
                                    <tr class="nrow" runat="server" visible="true">
                                        <td>
                                            <b>Select Vendor</b>
                                        </td>
                                        <td colspan="5">
                                            <font class="blackfnt">
                                                <Anthem:AutoSuggestBox runat="server" ID="txtVedor" DataKeyField="vendorcode" TextBoxDisplayField="vendorname"
                                                    ItemNotFoundMessage="No vendor found!" Required="false" OnTextChanged="txtVedor_TextChanged">
                                                    <headertemplate>
                                                    </headertemplate>
                                                    <itemtemplate>
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr class="blackfnt">
                                                                <td nowrap>
                                                                    <%# ((DataRowView)Container.DataItem)["vendorcode"]%>
                                                                </td>
                                                                <td width="20" align="center" nowrap>: </td>
                                                                <td nowrap>
                                                                    <%# ((DataRowView)Container.DataItem)["vendorname"]%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </itemtemplate>
                                                </Anthem:AutoSuggestBox>
                                            </font>
                                        </td>
                                     
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <b>Month/Year</b>
                                        </td>
                                        <td colspan="5">
                                            <asp:DropDownList runat="server" ID="ddlMonth">
                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                                <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                                <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                                <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                                <asp:ListItem Text="December" Value="12"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:DropDownList runat="server" ID="ddlYear">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr class="bgbluegrey">
                                        <td colspan="5" align="center">
                                            <asp:Button runat="server" ID="Button1" Text="Submit" OnClick="btnSearch_DatewiseOnclick" />
                                        </td>
                                    </tr>
                                    <tr bgcolor="white">
                                        <td colspan="5" align="center" class="blackfnt" valign="top">
                                            <font class="blackfnt"><b>OR</b> </font>
                                        </td>
                                    </tr>
                                    <tr bgcolor="white">
                                        <td align="left" class="blackfnt" style="height: 76px" valign="top">
                                            <b>Date Range</b>
                                        </td>
                                        <td align="left" colspan="2" style="width: 404px; height: 76px" valign="top">
                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                <ContentTemplate>
                                                    <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                                        OnSelectedIndexChanged="radDate_SelectedIndexChanged" ValidationGroup="VGDtFromTo"
                                                        Width="198px">
                                                        <asp:ListItem Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                                        <asp:ListItem Selected="True" Text=" Today" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            &nbsp;
                                            <%--<input id="CmdFromDate" type="button" value="" onclick="showCalendarControl(txtDateFrom);" style="width: 32px"  />--%>
                                            &nbsp;<%--<input id="CmdToDate" type="button" value="" onclick="showCalendarControl(txtDateTo);" onmouseout="hidecalendarcontrol();" style="width: 32px"  />--%>
                                        </td>
                                        <td align="left" colspan="1" style="height: 76px;BORDER-RIGHT: #8ba0e5 1px solid" valign="top">
                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                <ContentTemplate>
                                                    <asp:Label ID="lblFromDate" runat="server" Font-Size="X-Small" Height="20px"><b>FromDate :</b></asp:Label>
                                                    <asp:TextBox ID="txtDateFrom" runat="Server" Width="83px"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateFrom, 'alnkDateFrom', 'dd/MM/yyyy'); return false;"
                                                        id="alnkDateFrom">
                                                        <img src="../../../images/calendar.jpg" border="0" alt="" />
                                                    </a>
                                                    <asp:Label ID="lblToDate" runat="server" Font-Size="X-Small" Height="20px"><b>ToDate :</b></asp:Label>
                                                    <asp:TextBox ID="txtDateTo" runat="Server" Width="86px"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateTo, 'alnkDateTo', 'dd/MM/yyyy'); return false;"
                                                        id="alnkDateTo">
                                                        <img src="../../../images/calendar.jpg" border="0" alt="" />
                                                    </a>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            <asp:CustomValidator ID="CustomValidator3" runat="server" align="left" ErrorMessage="To date can not be smaller than from date "
                                                OnServerValidate="abc" Width="255px"></asp:CustomValidator>
                                            <asp:CustomValidator ID="CustomValidator4" runat="server" ErrorMessage="Date Range can not be greater than 1 month "
                                                OnServerValidate="daterange" Width="269px"></asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr class="bgbluegrey">
                                        <td colspan="5" align="center">
                                            <asp:Button runat="server" ID="btnSearch" Text="Submit" OnClick="btnSearch_OnClick" />
                                        </td>
                                    </tr>
                                    <tr class="nrow" style="display: none" runat="server" id="trGv">
                                        <td colspan="4">
                                            <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMBillDT" AutoGenerateColumns="False"
                                                CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                                PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
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
                                                            <asp:HiddenField runat="server" ID="hdnVendorCode" Value='<%# Eval("VendorCode") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnVendorName" Value='<%# Eval("VendorName") %>' />
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
                                                            <asp:Label runat="server" ID="lblClosingKM" Text='<%# Eval("ClosingKM") %>'></asp:Label>
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
                                                            <asp:TextBox runat="server" ID="txtAddSubtractKms" Text='<%# Eval("KMs") %>' onchange="return AmontCalculation(this);"
                                                                CssClass="ltxt"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Actual Closing Km">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblActualClosingKm" Text='<%# Eval("ActualClosingKm") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnActualClosingKm" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Distance">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNetDistance" Text='<%# Eval("NetDistance") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnNetDistance" />
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
                                                            <asp:HiddenField runat="server" ID="hdnBalanceKms" />
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
                                                            <asp:HiddenField runat="server" ID="hdnAmount" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Rebate">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtRebate" Text='<%# Eval("Rebate") %>' onchange="return AmontCalculation(this);"
                                                                CssClass="ltxt"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNetAmount" Text='<%# Eval("NetAmount") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnNetAmount" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Select GST">
                                                        <ItemTemplate>
                                                            <asp:DropDownList runat="server" ID="ddlGST" onchange="AmontCalculation(this);">
                                                                <asp:ListItem Text="IGST" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="CGST+SGST" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:HiddenField runat="server" ID="hdnGSTPercantage" Value='<%# Eval("GSTPercantage") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnGSTCredit" Value='<%# Eval("GSTCredit") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="IGST">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblIGST" Text='<%# Eval("IGST") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnIGST" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CGST">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblCGST" Text='<%# Eval("CGST") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnCGST" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="SGST">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblSGST" Text='<%# Eval("SGST") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnSGST" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Final Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblFinalAmount" Text='<%# Eval("FinalAmount") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnFinalAmount" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Reject Remark">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblRejectRemark" Text='<%# Eval("RejectRemark") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr class="nrow" style="display: none" runat="server" id="trTotal">
                                        <td colspan="4">
                                            <table cellpadding="1" cellspacing="1" border="0" style="width: 30%" class="boxbg">
                                                <tr class="nrow">
                                                    <td>
                                                        <b>Sub Total Amount</b>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Enabled="False" ID="txtSubTotal" CssClass="ltxt" Width="200PX"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnSubTotal" />
                                                    </td>
                                                </tr>
                                                <tr class="nrow">
                                                    <td>
                                                        <b>Misc. Amount</b>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Enabled="False" ID="txtMiscAmount" CssClass="ltxt" Width="200PX"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnMiscAmount" />
                                                        <a id="aModel">Add Misc Charge</a>
                                                    </td>
                                                </tr>
                                                <tr class="nrow">
                                                    <td>
                                                        <b>TDS Amount</b>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtTDSAmount" CssClass="ltxt" Width="200PX" onblur="Subtotal();"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnTDSAmount" />
                                                    </td>
                                                </tr>
                                                <tr class="nrow">
                                                    <td>
                                                        <b>Total Bill Amount</b>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Enabled="False" ID="txtTotalbillAmount" CssClass="ltxt"
                                                            Width="200PX"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnTotalbillAmount" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trsubbtn" class="bgbluegrey" style="display: none" runat="server">
                                        <td align="center" colspan="4">
                                            <asp:Button runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" CssClass="btn btn-primary"
                                                Text="Submit" />
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
                        <table cellpadding="1" cellspacing="1" border="0" style="width: 100%;"
                            class="boxbg" id="tblMiscChanges">
                            <thead>
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="center">
                                        <b>Misc. Charges Amount</b>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td>
                                        <b>Particular</b>
                                    </td>
                                    <td>
                                        <b>Bill Pay</b>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="nrow">
                                    <td>
                                        <input type="text" class="ltxt" id="txtParticular_1" />
                                    </td>
                                    <td>
                                        <input type="text" class="ltxt" id="txtAmount_1" />
                                    </td>
                                    <td>
                                        <a id="aAdd_1" onclick="AddRow(this.id)">
                                            <img src="../../../../images/png/24/button-add.png" /></a><a id="aRemove_1" onclick="RemoveRow(this.id)"><img
                                                src="../../../../images/png/24/button-cross.png" /></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table cellpadding="1" cellspacing="1" border="0" style="width: 100%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center">
                                    <input type="button" value="OK" class="btn btn-primary" id="btnOK" />
                                    <input type="button" value="Close" class="close btn btn-primary" id="btnClose" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField runat="server" ID="hdnMiscXML" />
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>
    </div>

    <script>
        var hdnMiscXML = $("#<%=hdnMiscXML.ClientID%>");


        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        function EndRequestHandler(sender, args) {
            $("#aRemove_1").hide();
            // Get the modal
            var modal = document.getElementById('myModal');

            // Get the button that opens the modal
            var btn = document.getElementById("aModel");
            var btnClose = document.getElementById("btnClose");

            var btnOK = document.getElementById("btnOK");
            // Get the <span> element that closes the modal
            //var span = document.getElementsByClassName("close")[0];

            // When the user clicks the button, open the modal 
            btn.onclick = function() {
                modal.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            btnClose.onclick = function() {
                modal.style.display = "none";
            }
            // debugger;
            btnOK.onclick = function() {
                var txtMiscAmount = $('#<%=txtMiscAmount.ClientID%>');
                var hdnMiscAmount = $('#<%=hdnMiscAmount.ClientID%>');
                hdnMiscXML.val("");
                var miscnetAMount = 0

                var totalRow = $("#tblMiscChanges tbody tr").length;
                var miscXML = "<Root>";
                try {
                    for (var i = 1; i <= totalRow; i++) {
                        var perticular = $("#txtParticular_" + i).val();
                        var amount = $("#txtAmount_" + i).val();
                        if (perticular == "") {
                            $("#txtParticular_" + i).focus();
                            throw "Please enter Perticular";

                        }
                        if (amount == "") {
                            $("#txtAmount_" + i).focus();
                            throw "Please enter Bill Pay Amount";

                        }
                        miscXML += "<Detail><Perticular>" + perticular + "</Perticular>";
                        miscXML += "<Amount>" + amount + "</Amount></Detail>";
                        miscnetAMount = miscnetAMount + parseFloat(amount);

                    }
                    miscXML += "</Root>";
                    hdnMiscXML.val(miscXML);
                    txtMiscAmount.val(miscnetAMount);
                    hdnMiscAmount.val(miscnetAMount);
                    Subtotal();

                    // alert(miscXML);
                    modal.style.display = "none";
                } catch (e) {
                    alert(e);
                    return false;
                }
            }

            // When the user clicks anywhere outside of the modal, close it

        }


        function AddRow(id) {
            var M = $("#tblMiscChanges tbody tr").length;

            $("#" + id).hide();
            $("#" + id.replace("aAdd_", "aRemove_")).show();
            M = M + 1;

            var row = '<tr class="nrow">' +
                '<td><input type="text" class="ltxt" id="txtParticular_' + M + '"></td>' +
                '<td><input type="text" class="ltxt" id="txtAmount_' + M + '"></td>' +
                '<td><a id="aAdd_' + M + '" onclick="AddRow(this.id)"><img src="../../../../images/png/24/button-add.png"/></a><a id="aRemove_' + M + '" onclick="RemoveRow(this.id)"><img src="../../../../images/png/24/button-cross.png"/></a></td>' +
                '</tr>';
            $("#tblMiscChanges tbody").append(row);

        }

        function RemoveRow(id) {

            var rowcount = $("#tblMiscChanges tbody tr").length;
            if (rowcount == 2)
                $("#aRemove_1").hide();

            var rowId = parseInt(id.substr(8));
            $("#" + id).closest("tr").remove();
            for (var cRow = rowId; cRow < rowcount; cRow++) {
                $("#txtParticular_" + (cRow + 1)).attr("id", "txtParticular_" + cRow);
                $("#txtAmount_" + (cRow + 1)).attr("id", "txtAmount_" + cRow);
                $("#aAdd_" + (cRow + 1)).attr("id", "aAdd_" + cRow);
                $("#aRemove_" + (cRow + 1)).attr("id", "aRemove_" + cRow);

            }
            $("#aAdd_" + (cRow - 1)).show();
        }
    </script>

</asp:Content>
