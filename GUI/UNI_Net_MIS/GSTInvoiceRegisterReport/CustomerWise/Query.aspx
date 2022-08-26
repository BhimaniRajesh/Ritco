<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_GSTInvoiceRegisterReport_CustomerWise_Query" %>

<%@ Register TagPrefix="UserControl" TagName="DateRange" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">

        var serviceUrl = '<%=ResolveUrl("~/services/WebxCommonService.asmx/")%>';

    </script>
    <script language="javascript" type="text/javascript">
        var controlIdPrefix = "ctl00_MyCPH1_";
        var reqData = {};
        var txtCustomerCode = $("#" + controlIdPrefix + "txtCustomerCode");
        var txtCustomerName = $("#" + controlIdPrefix + "txtCustomerName");
        $(document).ready(function () {
            AutoCompleteByAjaxVer1("[id*='txtCustomerCode']", serviceUrl + 'GetCustomer', 'POST', 'application/json; charset=utf-8', 'json', 'searchText', 2, 'vl', 'vl', 'l', 'v', 'ctl00_MyCPH1_txtCustomerName', 'No Customer found!', reqData, false);
            //AutoCompleteByAjaxVer1("[id*='txtCustomerCode']", serviceUrl + 'GetCustomer', 'POST', 'application/json; charset=utf-8', 'json', 'searchText', 2, 'vl', 'vl', 'l', 'v', txtCustomerName.id, 'No Customer found!', reqData, false);

            $(document).on("blur", "[id*='txtCustomerCode']", function () {
                if (!(WebxConvert.IsStringNullOrEmpty($(this).val()))) {
                    var requestData = "{ 'customerId' : '" + $(this).val() + "'}";
                    WebxCommon.invokeWebxAJAXRequest(serviceUrl + 'CheckValidCustomer', 'POST', 'application/json; charset=utf-8', 'json', requestData, OnValidate, false);
                }
            });
        });
        function OnValidate(data) {
            if ((!(WebxConvert.IsObjectNullOrEmpty(data))) && (data.d.length > 0)) {
                var result = JSON.parse(data.d)[0];
                txtCustomerCode.val(result.Value);
                txtCustomerName.val(result.Name);
            }
            else {
                alert('Invalid Customer');
                txtCustomerCode.val('');
                txtCustomerName.val('');
            }
        }
        function AutoCompleteByAjaxVer1(eleId, url, type, contentType, dataType, prefixText, minLength, focus, select, s1, s2, eleVal, alertMsg, additionalFiltersArr, showAlert) {

            $(eleId).autocomplete({
                minLength: 3,
                source: function (request, response) {

                    var requestData = {};
                    requestData.prefixText = request.term;

                    if (!(WebxConvert.IsObjectUndefinedOrNull(additionalFiltersArr))) {
                        for (var i = 0; i < additionalFiltersArr.length; i++) {
                            // requestData[additionalFiltersArr[i][0]] = additionalFiltersArr[i][1];
                        }
                    }
                    requestData = JSON.stringify(requestData);
                    $.ajax({
                        minLength: minLength,
                        type: type,
                        contentType: contentType,
                        url: url,
                        dataType: dataType,
                        data: requestData,
                        //data: "{ '" + prefixText + "': '" + request.term + "'}",
                        success: function (data) {
                            //alert(JSON.stringify(data));
                            if (data.d.length != 0) {
                                //   alert('in func');
                                var retOut = jQuery.parseJSON(data.d);
                                // alert('json obj ' + retOut);
                                response($.map(retOut, function (item) {
                                    //   alert('n ' + item.Name); //yeh alert bhi aaya
                                    //   alert('v ' + item.Value);
                                    return {
                                        label: item.Name,
                                        value: item.Value
                                    }
                                }));
                            } else {
                                if (showAlert)
                                    alert(alertMsg);
                                $(eleId).val('');
                            }
                        }
                    })
                },
                open: function (event, ui) { disableACblur = true; return false; },
                close: function (event, ui) { disableACblur = false; return false; },
                focus: function (event, ui) {
                    if (focus == 'v') { $(this).val(ui.item.value); }
                    else if (focus == 'l') { $(this).val(ui.item.label); }
                    else if (focus == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); }
                    return false;
                },
                select: function (event, ui) {
                    if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
                    else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
                    else if (select == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
                    return false;
                }
            })
            .data("ui-autocomplete")._renderItem = function (ul, item) {
                var rs1, rs2;
                if (s1 == 'v') { rs1 = item.value; }
                else if (s1 == 'l') { rs1 = item.label; }
                if (s2 == 'v') { rs2 = item.value; }
                else if (s2 == 'l') { rs2 = item.label; }
                return $("<li>")
                .append("<a>" + rs1 + " : " + rs2 + "</a>")
                .appendTo(ul);
            };
        }

        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
		
		
        function OnSubmit() {
            try {
				var dtBookingDate = '<%=dtBookingDate.ClientID%>';
				var txtCustomerCode = '<%=txtCustomerCode.ClientID%>';
				var txtDockNo = '<%=txtDockNo.ClientID%>';
				var ddlState = '<%=ddlState.ClientID%>';
				var ddlSacCode = '<%=ddlSacCode.ClientID%>';
				var ddlDocType = '<%=ddlDocType.ClientID%>';

                var dtBookingDate_txtDateFrom = $('#' + dtBookingDate + '_'+'txtDateFrom');
                var dtBookingDate_txtDateTo = $('#' + dtBookingDate + '_'+'txtDateTo');

                if (dtBookingDate_txtDateFrom.val() == "") {
                    throw new Error("Please Enter Valid From Date");
                }
                if (dtBookingDate_txtDateTo.val() == "") {
                    throw new Error("Please Enter Valid To Date");
                }
                
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width="+screen.availWidth+",height="+screen.availHeight+",status=no,left=0,top=0"
                var FromDate1 = moment(dtBookingDate_txtDateFrom.val(), "DD/MM/YYYY").format('DD MMM YYYY');
                var ToDate1 = moment(dtBookingDate_txtDateTo.val(), "DD/MM/YYYY").format('DD MMM YYYY');

                var strPopupURL = "Result.aspx?FromDate=" + FromDate1
                    + "&ToDate=" + ToDate1 + "&State=" + $("#" + ddlState +" option:selected").val() 
					+ "&DocType=" + $("#"+ ddlDocType +" option:selected").val() 
					+ "&PartyCode=" + $("#"+ txtCustomerCode).val()
					+ "&SACCode=" + $("#"+ ddlSacCode +" option:selected").val()
					+ "&DocumentNo=" + $("#"+ txtDockNo).val();
					
                winNew = window.open(strPopupURL, "_blank", strWinFeature);
                return false;
            } catch (e) {
                alert(e.message);
            }
        }
    </script>
    
		<table style="width: 950px" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="top">
                <br />
                <font class="blklnkund"><strong>Reports &gt;Finance &gt;Invoice Register &gt;</strong></font>
                <font class="blklnkund"><strong>Customer GST Invoice Register Report</strong></font>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td valign="top">
				<table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
					<tr class="hrow">
						<th colspan="2" align="center">
							<b>Selection Criteria</b>
						</th>
					</tr>
					<tr class="nrow" id="trDate">
						<td>Select Transaction Date Range
						</td>
						<td align="left">
							<UserControl:DateRange ID="dtBookingDate" runat="server" />
						</td>
					</tr>
					<tr class="nrow">
						<td>Select State 
						</td>
						<td>
							<asp:DropDownList runat="server" ID="ddlState" Width="150px" CssClass="ddlm">
							</asp:DropDownList>
							<asp:HiddenField ID="hdnSupplyState" runat="server" />
						</td>
					</tr>
					<tr class="nrow">
						<td>Document Type
						</td>
						<td>
							<asp:DropDownList runat="server" ID="ddlDocType" Width="150px" CssClass="ddlm">
								<asp:ListItem Text="--All--" Value=""></asp:ListItem>
								<asp:ListItem Text="Transaction Bill" Value="1"></asp:ListItem>
								<asp:ListItem Text="General Bill" Value="2"></asp:ListItem>
								<asp:ListItem Text="Debit Note" Value="3"></asp:ListItem>
								<asp:ListItem Text="On Account Advance" Value="4"></asp:ListItem>

							</asp:DropDownList>

						</td>
					</tr>
					<tr class="nrow">
						<td>Select Customer
						</td>
						<td>
							<asp:TextBox ID="txtCustomerCode" runat="server" Width="80" CssClass="ltxt"></asp:TextBox>
							<asp:TextBox ID="txtCustomerName" runat="server" Width="160" Enabled="false" CssClass="ltxt"></asp:TextBox>
						</td>
					</tr>
					<tr class="nrow">
						<td>Select Sac
						</td>
						<td>
							<asp:DropDownList runat="server" ID="ddlSacCode" Width="150px"  CssClass="ddlm">
							</asp:DropDownList>
						</td>
					</tr>
					<tr style="background-color: white">
						<td colspan="3" align="center" style="height: 21px">
							<asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server"> OR </asp:Label>
						</td>
					</tr>
					<tr class="nrow">
						<td>Enter Document No 
						</td>
						<td>
							<asp:TextBox ID="txtDockNo" runat="server" CssClass="ltxt"></asp:TextBox>

						</td>
					</tr>
					<tr class="hrow">
						<th colspan="4" align="center">
							<asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return OnSubmit();" CssClass="nbtn" OnClick="btnSubmit_Click" Text="Submit" />
						</th>
					</tr>
				</table>
			
			</td>
        </tr>
    </table>
        
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
    <asp:HiddenField ID="hdnFromDate" runat="server" />
    <asp:HiddenField ID="hdnToDate" runat="server" />
</asp:Content>

