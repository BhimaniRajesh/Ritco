<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FreightBillGeneration.aspx.cs"
    Inherits="GUI_Finance_Billing_GST_BillGeneration_FreightBillGeneration" EnableEventValidation="false" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="uc1" TagName="UserMessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        <%--var btnSubmitID = '<%=btnSubmit.ClientID%>';
        var tdCompanyCriteriaID = '<%=tdCompanyCriteria.ClientID%>';
        var tdCompanyHeaderDetailID = '<%=tdCompanyHeaderDetail.ClientID%>';
        var tdCompanyDetailID = '<%=tdCompanyDetail.ClientID%>';
        var Table1SubmitID = '<%=Table1.ClientID%>';
        var txtCompanyNameID = '<%=txtCompanyName.ClientID%>';
        var hdnCompanyCodeID = '<%=hdnCompanyCode.ClientID%>';
        var hdnValidID = '<%=hdnValid.ClientID%>';
        var txtGSTCityID = '<%=txtGSTCity.ClientID%>';
        var txtGSTStateID = '<%=txtGSTState.ClientID%>';
        var hdnGSTCityID = '<%=hdnGSTCity.ClientID%>';
        var hdnGSTStateID = '<%=hdnGSTState.ClientID%>';
        var txtGSTBillingAddresID = '<%=txtGSTBillingAddres.ClientID%>';
        var txtCGSTNumberID = '<%=txtCGSTNumber.ClientID%>';
        var txtIGSTNumberID = '<%=txtIGSTNumber.ClientID%>';
        var tdCompanyDetailExcelID = '<%=tdCompanyDetailExcel.ClientID%>';
        var rptDocketDetails = '<%=rptDocketDetails.ClientID%>';        --%>
        var lblCount = '<%=lblCount.ClientID%>';
        var lblSummarySubTotal = '<%=lblSummarySubTotal.ClientID%>';
        var lblSummaryGSTTotal = '<%=lblSummaryGSTTotal.ClientID%>';
        var lblSummaryTotal = '<%=lblSummaryTotal.ClientID%>';

    </script>
    <script language="javascript" type="text/javascript" src="JS/FreightBillGeneration.js?v1=46"></script>
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1
        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to
		
		function OnReportingUnloadingDateChange(ctrl, type) 
		{
		    
            if (type == "R") {
			
                var id = $(ctrl).attr("id");
                var txtReportingDate = $(ctrl);
                var txtReportingDateHrs = $("#" + id.replace("txtReportingDate", "txtReportingDateHrs"));
                var txtReportingDateMin = $("#" + id.replace("txtReportingDate", "txtReportingDateMin"));
                var txtUnloadingDate = $("#" + id.replace("txtReportingDate", "txtUnloadingDate"));
                var txtUnloadingDateHrs = $("#" + id.replace("txtReportingDate", "txtUnloadingDateHrs"));
                var txtUnloadingDateMin = $("#" + id.replace("txtReportingDate", "txtUnloadingDateMin"));
                var lnkDocketDate = $("#" + id.replace("txtReportingDate", "lblTransactionDate"));
				
				
                if (txtReportingDate.val() != "" ) {
                    
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) < new Date(lnkDocketDate.text())) {
                        alert("Reporting Date can not be less then Booking Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }
					
					if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date()) {
                        alert("Reporting Date can not be future Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }
					
                    if( txtUnloadingDate.val() != ""){
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val()))) {
                        alert("Unloading Date can not be less then Reporting Date");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
					
					if (new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val())) > new Date()) {
                        alert("Unloading Date can not be future Date !!");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
					
					}
                }

            } else if (type == "U") {
                var id = $(ctrl).attr("id");
                var txtReportingDate = $("#" + id.replace("txtUnloadingDate", "txtReportingDate"));
                var txtReportingDateHrs = $("#" + id.replace("txtUnloadingDate", "txtReportingDateHrs"));
                var txtReportingDateMin = $("#" + id.replace("txtUnloadingDate", "txtReportingDateMin"));
                var txtUnloadingDate = $(ctrl);
                var txtUnloadingDateHrs = $("#" + id.replace("txtUnloadingDate", "txtUnloadingDateHrs"));
                var txtUnloadingDateMin = $("#" + id.replace("txtUnloadingDate", "txtUnloadingDateMin"));
                var lnkDocketDate = $("#" + id.replace("txtReportingDate", "lblTransactionDate"));

                if (txtUnloadingDate.val() != "" && txtReportingDate.val() != "") {
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) < new Date(lnkDocketDate.text())) {
                        alert("Reporting Date can not be less then Booking Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }

                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val()))) {
                        alert("Unloading Date can not be less then Reporting Date");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
					
					if (new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val())) > new Date()) {
                        alert("Unloading Date can not be future Date !!");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
                }

            }
            //else if (type == "H") { }
            //else if (type == "M") { }

        }
        function getDateStringFrom_ddmmyyy(strDate) {
            var arr = strDate.split("/");
            return (arr[1] + "/" + arr[0] + "/" + arr[2])
        }
		
    </script>
    <table style="width: 100%;">
        <tr>
            <td>
                <uc1:UserMessage runat="server" ID="msgBox" />
            </td>
        </tr>
        <tr runat="server" id="trMain1">
            <td>
                <asp:Panel ID="pnlFilter" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table id="tblMain" runat="server" class="boxbg" cellpadding="3" cellspacing="1" width="803px">
                                <tr class="hrow">
                                    <td colspan="5" align="center">
                                        <asp:Label runat="server" ID="lblCustomerDetails" Text="Customer & Invoice Details" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="200px">
                                        <span style="margin-right: 15px;">Customer</span>
                                    </td>
                                    <td width="200px" colspan="2">
                                        <asp:Label runat="server" ID="lblCustomerName" Text=""></asp:Label>
                                        <asp:HiddenField ID="hidCustomerID" runat="server" />
                                    </td>
                                    <td width="200px">
                                        <span style="margin-right: 15px;">Invoice Number</span>
                                    </td>
                                    <td width="200px">
                                        <asp:Label runat="server" ID="lblInvoiceNumber" Text="System Generated" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="200px" rowspan="2">
                                        <span style="margin-right: 15px;">Billing address</span>
                                    </td>
                                    <td width="200px" rowspan="2" colspan="2">
                                        <asp:Label runat="server" ID="lblBillingAddress" Text=""></asp:Label>
                                        <asp:HiddenField ID="hidBillingAddress" runat="server" />
                                        <asp:HiddenField ID="hidBillingAddressStateWise" runat="server" />
                                    </td>
                                    <td width="200px">
                                        <span style="margin-right: 15px;">Invoice Date</span>
                                    </td>
                                    <td width="200px">
                                        <asp:HiddenField runat="server" ID="hdnSysDate" />
                                        <asp:HiddenField runat="server" ID="hdnPastDate" />
                                        <%-- <asp:TextBox ID="txtGenerationDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt" Enabled="true"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtGenerationDate,'anchor112','dd/MM/yyyy'); return false;"
                                            name="anchor112" id="anchor112">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>--%>
                                        <asp:TextBox ID="txtGenerationDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt" onblur="javascript: return ValidateDateOnBlur();"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtGenerationDate,'anchor1123','dd/MM/yyyy'); return false;"
                                            name="anchor1123" id="anchor1123">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td style="width: 200px">Due Date</td>
                                    <td>
                                        <asp:TextBox ID="txtDueDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt" onblur="javascript: return ValidateDateOnBlur();"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDueDate,'anchor1122','dd/MM/yyyy'); return false;"
                                            name="anchor112" id="anchor1122">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td></td>
                                    <td>
                                        <center><b>State</b></center>
                                    </td>
                                    <td>
                                        <center><b>Location</b></center>
                                    </td>
                                    <td>
                                        <center><b>City</b></center>
                                    </td>
                                    <td>
                                        <center><b>GSTIN</b></center>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Generation</td>
                                    <td>
                                        <%--<asp:Label runat="server" ID="lblBillGenerationState" Text=""></asp:Label>--%>
                                        <asp:DropDownList ID="ddlBillGenerationState" runat="server" DataTextField="Name"
                                            DataValueField="Code" onchange="javascript:return OnChangeState(1)" Width="150px">
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hidBillGenerationState" runat="server" />
                                        <asp:HiddenField ID="hidBillGenerationStateType" runat="server" />
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlBillGenerationLocation"
                                            onchange="javascript:return OnChangeLocation(1)" Width="150px">
                                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:Label runat="server" ID="lblBillGenerationLocation" Text="" Width="150px"></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hidBillGenerationLocation"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillGenerationCity" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationCity"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationCityName"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillGenerationGSTIN" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationGSTINNumber"></asp:HiddenField>
                                    </td>

                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Submission</td>
                                    <td>
                                        <%--<asp:Label runat="server" ID="lblBillSubmissionState" Text=""></asp:Label>--%>
                                        <asp:DropDownList ID="ddlBillSubmissionState" runat="server" DataTextField="Name"
                                            DataValueField="Code" onchange="javascript:return OnChangeState(2)" Width="150px">
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hidBillSubmissionState" runat="server" />
                                        <asp:HiddenField ID="hidBillSubmissionStateName" runat="server" />
                                        <asp:HiddenField ID="hidBillSubmissionStateType" runat="server" />
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlBillSubmissionLocation"
                                            onchange="javascript:return OnChangeLocation(2)" Width="150px">
                                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:Label runat="server" ID="lblBillSubmissionLocation" Text="" Width="150px"></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hidBillSubmissionLocation"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillSubmissionCity" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionCity"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionCityName"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillSubmissionGSTIN" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionGSTINNumber"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Collection</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillCollectionState" Text=""></asp:Label>
                                        <%--<asp:DropDownList ID="ddlBillCollectionState" runat="server" DataTextField="Name"
                                            DataValueField="Code" onchange="javascript:return OnChangeState(3)" Width="150px">
                                        </asp:DropDownList>--%>
                                        <asp:HiddenField ID="hidBillCollectionState" runat="server" />
                                        <asp:HiddenField ID="hidBillCollectionStateName" runat="server" />
                                        <asp:HiddenField ID="hidBillCollectionStateType" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillCollectionLocation" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hidBillCollectionLocation"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillCollectionCity" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionCity"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionCityName"></asp:HiddenField>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblBillCollectionGSTIN" Text="" Width="150px"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionGSTINNumber"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="hrow align-center">
                                        <center><b>GST Details </b></center>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Service Type</td>
                                    <td colspan="2">
                                        <asp:Label runat="server" ID="lblServiceType" Text=""></asp:Label>
                                        <asp:HiddenField ID="hidServiceType" runat="server" />
                                        <asp:HiddenField ID="hidProductType" runat="server" />
                                        <asp:HiddenField ID="hidSACType" runat="server" />
                                    </td>
                                    <td>Intra-state</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblInterState" Text=""></asp:Label>
                                        <asp:HiddenField runat="server" ID="hidInterState"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>SAC Category</td>
                                    <td colspan="4">
                                        <asp:Label runat="server" ID="lblSACCategory" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>GST Rate</td>
                                    <td style="text-align: right">
                                        <asp:Label runat="server" ID="lblGSTRate" Text=""></asp:Label>
                                    </td>
                                    <td></td>
                                    <td>RCM</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblITC" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite" style="display: none;">
                                    <td>Customer GSTIN</td>
                                    <td colspan="2">
                                        <asp:Label runat="server" ID="lblCustomerGSTIN" Text=""></asp:Label>
                                    </td>
                                    <td>Transporter GSTIN</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblTransporterGSTIN" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Table ID="tblBillDetails" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                        HorizontalAlign="Left" Width="1000px">
                        <asp:TableRow CssClass="hrow">
                            <asp:TableCell ColumnSpan="5" HorizontalAlign="center">
                                <asp:Label runat="server" ID="lblTransactionDetails" Text="Transaction Details" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" runat="server" ID="tdBillDetails" Width="1000px">
                            <asp:TableCell ColumnSpan="5" Width="1000px">
                                <table class="boxbg" id="tblDocketDetail" width="1000px">
                                    <tr>
                                        <th class="hrow align-center">
                                            <asp:CheckBox ID="chkAllSelect" runat="server" onclick="SelectAll()" />
                                        </th>
                                        <th class="hrow align-center">Sr. No.</th>
                                        <th class="hrow align-center">ID</th>
                                        <th class="hrow align-center">Date</th>
                                        <th class="hrow align-center">From City</th>
                                        <th class="hrow align-center">To City</th>
                                        <th class="hrow align-center">Docket Amount</th>
                                        <th class="hrow align-center">Misc</th>
                                        <th class="hrow align-center">Sub Total</th>
                                        <th class="hrow align-center">GST Amount</th>
                                        <th class="hrow align-center">Docket Total</th>
                                        <th class="hrow align-center">Reporting Date Time</th>
                                        <th class="hrow align-center">Unloading Date Time</th>
                                        <th class="hrow align-center">Remarks</th>
                                        <th class="hrow align-center">User Name</th>
                                    </tr>
                                    <asp:Repeater ID="rptDocketDetails" runat="server">
                                        <ItemTemplate>
                                            <tr class="bgwhite">
                                                <td class="alignCenter">
                                                    <asp:CheckBox ID="chkSelect" runat="server" onclick="OnCheck()" />
                                                </td>
                                                <td class="align-center"><%# Container.ItemIndex + 1%></td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblTransactionID" Text='<%# DataBinder.Eval(Container.DataItem,"TransactionID") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidTransactionIDSuffix" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TransactionIDSuffix") %>' />
                                                </td>
                                                <td class="alignCenter">
                                                    <asp:Label runat="server" ID="lblTransactionDate" Text='<%# DataBinder.Eval(Container.DataItem,"TransactionDate") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidTransactionDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SysTransactionDate") %>' />
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblFromCityState" Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidOrigin" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ORGNCD") %>' />
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblToCityState" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidDestination" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"REASSIGN_DESTCD") %>' />
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label runat="server" ID="lblSubTotal" Text='<%# DataBinder.Eval(Container.DataItem,"SubTotal") %>'></asp:Label>
                                                    <asp:HiddenField ID="hidSACCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SACCode") %>' />
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox runat="server" ID="txtMiscCharge" Text='0' Width="50" onblur="OnCheck();" onkeypress = "javascript:return validFloat(event,this.id);"></asp:TextBox>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label runat="server" ID="lblSub_Total" Text='<%# DataBinder.Eval(Container.DataItem,"SubTotal") %>'></asp:Label>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label runat="server" ID="lblGSTAmount" Text='<%# DataBinder.Eval(Container.DataItem,"GSTAmount") %>'></asp:Label>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label runat="server" ID="lblTotal" Text='<%# DataBinder.Eval(Container.DataItem,"Total") %>'></asp:Label>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtReportingDate" runat="server" Width="65" BorderStyle="groove" onblur="return OnReportingUnloadingDateChange(this,'R');" 
                                                        CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"ReportingDate") %>'></asp:TextBox><img src="./../../../images/calendar.jpg" border="0" />
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderReportingDate" Format="dd/MM/yyyy" TargetControlID="txtReportingDate" runat="server" />
                                                    <asp:HiddenField ID="hdnReportingDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ReportingDate") %>' />
                                                    <asp:TextBox ID="txtReportingDateHrs" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                        CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDateHrs")%>'></asp:TextBox>
                                                    :
                                            <asp:TextBox ID="txtReportingDateMin" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDateMin")%>'></asp:TextBox>
                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Hours !!" ControlToValidate="txtReportingDateHrs" MinimumValue="0" MaximumValue="23"></asp:RangeValidator>
                                                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Invalid Minute !!" ControlToValidate="txtReportingDateMin" MinimumValue="0" MaximumValue="59"></asp:RangeValidator>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtUnloadingDate" runat="server" Width="65" BorderStyle="groove" onblur="return OnReportingUnloadingDateChange(this,'U');" 
                                                        CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>'></asp:TextBox><img src="./../../../images/calendar.jpg" border="0" />
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderUnloadingDate" Format="dd/MM/yyyy" TargetControlID="txtUnloadingDate"
                                                        runat="server" />
                                                    <asp:HiddenField ID="hdnUnloadingDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>' />
                                                    <asp:TextBox ID="txtUnloadingDateHrs" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                        CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDateHrs")%>'></asp:TextBox>
                                                    :
                                                     <asp:TextBox ID="txtUnloadingDateMin" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                         CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDateMin")%>'></asp:TextBox>
                                                    <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Invalid Hours !!" ControlToValidate="txtUnloadingDateHrs" MinimumValue="0" MaximumValue="23"></asp:RangeValidator>
                                                    <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Invalid Minute !!" ControlToValidate="txtUnloadingDateMin" MinimumValue="0" MaximumValue="59"></asp:RangeValidator>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:TextBox ID="txtRARemark" runat="server" Width="65" BorderStyle="groove" Text=''></asp:TextBox>
                                                </td>
                                                <td style="text-align: right">
                                                    <asp:Label runat="server" ID="Label4" Text='<%# SessionUtilities.CurrentEmployeeID+" : "+empnm %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="hrow DocketSummaryHeader" ID="trDocketSummaryHeader">
                            <asp:TableCell ColumnSpan="5" HorizontalAlign="center">
                                <asp:Label runat="server" ID="lblSummaryofTransactions" Text="Summary of Transactions" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite DocketSummary" runat="server" ID="tdDocketSummary" Width="800px">
                            <asp:TableCell ColumnSpan="5" Width="800px">
                                <table class="boxbg" id="tblDocketSummary" width="795px">
                                    <tr>
                                        <th class="hrow align-center">Count</th>
                                        <th class="hrow align-center">Sub Total</th>
                                        <th class="hrow align-center">SGST</th>
                                        <th class="hrow align-center">UTGST</th>
                                        <th class="hrow align-center">CGST</th>
                                        <th class="hrow align-center">IGST</th>
                                        <th class="hrow align-center">GST Total</th>
                                        <th class="hrow align-center">Total</th>
                                    </tr>
                                    <tr class="bgwhite">
                                        <td style="text-align: center">
                                            <asp:Label runat="server" ID="lblCount" class="count" Text="0"></asp:Label>
                                            <asp:HiddenField ID="hdsubTotal" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidSummarySGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidSummaryUTGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidSummaryCGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidSummaryIGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdgstTotal" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdtotal" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidSGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidUTGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidUTGSTNo" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidCGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidIGST" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdCount" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidCreditDays" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidClickCount" runat="server" Value="0" />
                                            <asp:HiddenField ID="hidMaxDate" runat="server" />
                                            <asp:HiddenField ID="hidInvoiceDateEditable" runat="server" />
                                            <asp:HiddenField ID="hidInvoiceDateBackDaysYN" runat="server" />
                                            <asp:HiddenField ID="hidInvoiceDateBackDays" runat="server" />
                                            <asp:HiddenField ID="hidDueDateEditable" runat="server" />
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummarySubTotal" class="subTotal" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummarySGST" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummaryUTGST" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummaryCGST" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummaryIGST" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummaryGSTTotal" class="gstTotal" Text="0.00"></asp:Label>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label runat="server" ID="lblSummaryTotal" class="total" Text="0.00" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="hrow LedgerSummaryHeader">
                            <asp:TableCell ColumnSpan="5" HorizontalAlign="center">
                                <asp:Label runat="server" ID="lblSummaryofLedgerPosting" Text="Summary of Ledger Posting" Font-Bold="true" style="display:none;width: 100%;"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow LedgerSummary">
                            <asp:TableCell ColumnSpan="4">
                                 <table id="tblLedgerSummary" class="stbl" style="display:none;width: 100%;">
                                            <thead>
                                                <tr class="hrow">
                                                    <th>Ledger</th>
                                                    <th>Sub Ledger</th>
                                                    <th>Dr</th>
                                                    <th>Cr</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:Panel>
            </td>
        </tr>
        <tr runat="server" id="trMain2">
            <td>
                <asp:Table ID="Table1" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                    HorizontalAlign="Left" Width="803px">
                    <asp:TableHeaderRow CssClass="bgbluegrey">
                        <asp:TableHeaderCell ColumnSpan="5">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript:return onSubmitClick();" OnClick="btnSubmit_Click" />
                            <asp:HiddenField ID="hidBusinessType" runat="server" />
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
