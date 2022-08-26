<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PaymentCollectionBounceCheque.aspx.cs" Inherits="GUI_Finance_CheQue_Bounce_PaymentCollectionBounceCheque" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="uc1" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchyActiveLocation.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="../../Js/moment.js"></script>
    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function cust(ID) {

            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../../UNI_NET_MIS/PopUp_Cust.aspx?ID=" + ID

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }

        function GetTotalAmount() {
            var amount = 0.00;

            var txtCashAmount = '<%=txtCashAmount.ClientID%>';
            var txtInstrumentAmount = '<%=txtInstrumentAmount.ClientID%>';
            var lblTotalAmount = '<%=lblTotalAmount.ClientID%>';

            if ($.trim($("#" + txtCashAmount).val()) == "") { $("#" + txtCashAmount).val('0'); }
            if ($.trim($("#" + txtInstrumentAmount).val()) == "") { $("#" + txtInstrumentAmount).val('0'); }

            amount = parseFloat($("#" + txtCashAmount).val()) + parseFloat($("#" + txtInstrumentAmount).val());

            $("#" + lblTotalAmount).text(amount);
        }

        function GetBalanceAmount() {
            var BalanceAmount = 0.00;
            var lblTotalBalanceAmount = '<%=lblTotalBalanceAmount.ClientID%>';
            $("input[id*='chkchq']").each(function () {
                var chkchq = $(this);
                if ($(chkchq).prop('checked')) {
                    var txtReceiveAmount = $("#" + chkchq.attr('id').replace('chkchq', 'txtReceiveAmount'));
                    BalanceAmount = BalanceAmount + parseFloat(txtReceiveAmount.val());
                }
            });
            $("#" + lblTotalBalanceAmount).text(BalanceAmount);
        }

        function validReceivedAmount(senderId) {
            var id = $(senderId).attr('id');
            var lblChequeAmount = $("#" + id.replace('txtReceiveAmount', 'lblChequeAmount'));
            var lblBalanceAmount = $("#" + id.replace('txtReceiveAmount', 'lblBalanceAmount'));

            if ($.trim($("#" + id).val()) == "") { $("#" + id).val($(lblChequeAmount).text()); }

            if ($.trim($("#" + id).val()).length > 0) {
                var ReceivedAmount = parseFloat($.trim($("#" + id).val()));
                var ChequeAmount = parseFloat($(lblChequeAmount).text());
                var BalanceAmount = parseFloat($(lblBalanceAmount).text());

                if (ChequeAmount < ReceivedAmount) {
                    alert("Amount is not greater then Cheque Amount");
                    $("#" + id).focus();
                    return false;
                }
                else {
                    $(lblBalanceAmount).text(ChequeAmount - ReceivedAmount);
                    GetBalanceAmount();
                }
            }
            return true;
        }
        function ValidateOnSubmit() {

            var btnSubmit = $('#<%=btnSubmit.ClientID %>');
            var ddlBankAccount = ('#<%=ddlBankAccount.ClientID %>');
            var txtCashAmount = ('#<%=txtCashAmount.ClientID %>');
            var txtInstrumentAmount = ('#<%=txtInstrumentAmount.ClientID %>');
            var ddlPayType = ('#<%=ddlPayType.ClientID %>');
            var txtInstrumentNo = ('#<%=txtInstrumentNo.ClientID %>');

            var count = 0;
            var objPaymentCheque = {};
            objPaymentCheque.DetailListChequBouncePaymentRequest = [];
            $("input[id*='chkchq']").each(function () {
                var chkchq = $(this);
                if ($(chkchq).prop('checked')) {
                    count++;
                }
            });
            if (count == 0) {
                alert("Please select at least one Detail");
                return false;
            }

            var ROLocation = $("#ctl00_MyCPH1_Fromlc_cboRO");
            var LocCode = $("#ctl00_MyCPH1_Fromlc_cboLO");
            var BankName = $("#ctl00_MyCPH1_Fromlc_DDL_BankList");

            var lblTotalAmount = '<%=lblTotalAmount.ClientID%>';
            var lblTotalBalanceAmount = '<%=lblTotalBalanceAmount.ClientID%>';
            var ddlBankAccount = '<%=ddlBankAccount.ClientID %>';
            var txtInstrumentNo = '<%=txtInstrumentNo.ClientID %>';
            var txtInstrumentDate = ('<%=txtInstrumentDate.ClientID %>');
            if (parseFloat($("#" + lblTotalAmount).text()) != parseFloat($("#" + lblTotalBalanceAmount).text())) {
                alert("Received Amount & Total Amount Should be same");
                return false;
            }
            if ($("#" + txtInstrumentNo).val() == "" && ($(txtCashAmount).val() != $("#" + lblTotalAmount).text())) {
                alert("Instrument No can not blank");
                $("#" + txtInstrumentNo).focus();
                return false;
            }

            if ($("#" + txtInstrumentDate).val() == "" && ($(txtCashAmount).val() != $("#" + lblTotalAmount).text())) {
                alert("Instrument Date can not blank");
                $("#" + txtInstrumentDate).focus();
                return false;
            }

            if ($("#" + ddlBankAccount).val() == "" && ($(txtCashAmount).val() != $("#" + lblTotalAmount).text())) {
                alert("Plesae select Bank Account");
                return false;
            }
			
			var LocCode = $("#ctl00_MyCPH1_Fromlc_cboLO");

            if (LocCode.val().toUpperCase() == "ALL") {
                alert("Please select Location !!");
                LocCode.focus();
                return false;
            }
			
            $("input[id*='chkchq']").each(function () {

                var chkchq = $(this);
                if ($(chkchq).prop('checked')) {

                    var lblChequeNo = $("#" + chkchq.attr('id').replace('chkchq', 'lblChequeNo'));
                    var hdnCustomerCode = $("#" + chkchq.attr('id').replace('chkchq', 'hdnCustomerCode'));
                    var lblCustomerName = $("#" + chkchq.attr('id').replace('chkchq', 'lblCustomerName'));
                    var lblDepositDate = $("#" + chkchq.attr('id').replace('chkchq', 'lblDepositDate'));
                    var lblBounceBy = $("#" + chkchq.attr('id').replace('chkchq', 'lblBounceBy'));
                    var lblBounceDate = $("#" + chkchq.attr('id').replace('chkchq', 'lblBounceDate'));
                    var lblChequeAmount = $("#" + chkchq.attr('id').replace('chkchq', 'lblChequeAmount'));
                    var txtReceiveAmount = $("#" + chkchq.attr('id').replace('chkchq', 'txtReceiveAmount'));
                    var lblBalanceAmount = $("#" + chkchq.attr('id').replace('chkchq', 'lblBalanceAmount'));
                    var LocCode = $("#ctl00_MyCPH1_Fromlc_cboLO");
                    //var txtCashAmount = $("#" + chkchq.attr('id').replace('chkchq', 'txtCashAmount'));
                    //var txtInstrumentAmount = $("#" + chkchq.attr('id').replace('chkchq', 'txtInstrumentAmount'));
                    //var txtInstrumentNo = $("#" + chkchq.attr('id').replace('chkchq', 'txtInstrumentNo'));
                    //var txtInstrumentDate = $("#" + chkchq.attr('id').replace('chkchq', 'txtInstrumentDate'));
                    //var ddlPayType = $("#" + chkchq.attr('id').replace('chkchq', 'ddlPayType'));
                    //var ddlBankAccount = $("#" + chkchq.attr('id').replace('chkchq', 'ddlBankAccount'));
                    <%-- var EntryBy = '<%= SessionUtilities.CurrentEmployeeID%>';
                    var FinYear = '<%= SessionUtilities.FinYear%>';
                    var EntryBranch = '<%= SessionUtilities.CurrentBranchCode%>';--%>
                    var InstrumentDate = ""
                    if ($("#" + txtInstrumentDate).val() == "")
                        InstrumentDate = "";
                    else
                        InstrumentDate= moment($("#" + txtInstrumentDate).val(), "DD/MM/YYYY").format('DD MMM YYYY');

                    objPaymentCheque.DetailListChequBouncePaymentRequest.push({
                        ChequeNo: lblChequeNo.text(),
                        CustomerCode: hdnCustomerCode.val(),
                        CustomerName: lblCustomerName.text(),
                        DepositDate: lblDepositDate.text(),
                        BounceBy: lblBounceBy.text(),
                        BounceDate: lblBounceDate.text(),
                        Amount: lblChequeAmount.text(),
                        ChequeDate: lblDepositDate.text(),
                        ChequeAmount: lblChequeAmount.text(),
                        ReceiveAmount: txtReceiveAmount.val(),
                        BalanceAmount: lblBalanceAmount.text(),
                        CaseAmount: $(txtCashAmount).val(),
                        InstrumentAmount: $(txtInstrumentAmount).val(),
                        InstrumentType: $('#<%=ddlPayType.ClientID %> option:selected').val(),
                        InstrumentNo: $("#" + txtInstrumentNo).val(),
                        InstrumentDate: InstrumentDate,
                        BankName: $('#<%=ddlBankAccount.ClientID %> option:selected').val(),
                        Loccode : LocCode.val()
                        //EntryBy: EntryBy,
                        //FinYear: FinYear,
                        //EntryBranch: EntryBranch
                    });
                }
            });
            if (objPaymentCheque.DetailListChequBouncePaymentRequest.length > 0) {
                try {
                    var requestData = {};
                    requestData.objPaymentCheque = objPaymentCheque;
                    requestData = JSON.stringify(requestData);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PaymentCollectionBounceCheque.aspx/PaymentChequeInsert",
                        data: requestData,
                        async: false,
                        dataType: "json",
                        success: function (data) {
                            var VoucherNo = (jQuery.parseJSON(data.d)[0].VoucherNo);
                            window.location.href("ChequeBounceDone.aspx?VoucherNo=" + VoucherNo);
                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                            return false;
                        }
                    });
                }
                catch (e) {
                    alert(e.message);
                    return false;
                }
            }
            else {
                alert("No Records to Insert!!!");
                return false;
            }
            return false;
        }
    </script>
    <script type="text/javascript" language="javascript">
        function CheckAll(Checkbox) {

            var gvDetails = document.getElementById("tblrpt");
            for (i = 1; i < gvDetails.rows.length - 1; i++) {
                gvDetails.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
            GetBalanceAmount();
        }
        function CheckItem(CheckBox) {
            var gvDetails = document.getElementById("tblrpt");
            if (CheckBox.checked == false) {
                gvDetails.rows[1].cells[0].getElementsByTagName("INPUT")[0].checked = false;
            }
            GetBalanceAmount();
        }
    </script>
    <div align="left">
        <uc1:UserMessage ID="msgBox" runat="server" />
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Banking Operation </strong></font>
                    <font class="bluefnt"><strong>&gt;
                    </strong><strong>Payment Collection of Bounce Cheque</strong> </font></td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell>
                                                <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" />
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>

                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" width="800" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">Select Branch</font>
                            </td>
                            <td>
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr align="left" style="background-color: white;">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">Select Documnet Date</font>
                            </td>
                            <td>
                                <Date:DT ID="DT" runat="server" EnableTillDate="true" />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">Cheque No</font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtChequeNo" runat="server" MaxLength="10"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="upData" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <div id="divData" runat="server">
                                <table class="boxbg" style="width: 10in" id="tblrpt">
                                    <asp:Repeater ID="gvChequeDetail" runat="server" OnItemDataBound="gvChequeDetail_ItemDataBound">
                                        <HeaderTemplate>
                                            <tr class="bgbluegrey" align="center">
                                                <th colspan="9">
                                                    <h5>List Of Bounce Cheque</h5>
                                                </th>
                                            </tr>
                                            <tr class="bgbluegrey" style="align-content: stretch">
                                                <th>
                                                    <asp:CheckBox ID="chkprsvendor" runat="server" onClick="CheckAll(this);" /></th>
                                                <th>Cheque No</th>
                                                <th>Customer Name</th>
                                                <th>Deposit Date</th>
                                                <th>Bounce By</th>
                                                <th>Bounce Date</th>
                                                <th>Cheque Amount</th>
                                                <th>Received Amount</th>
                                                <th>Balance Amount</th>
                                            </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="bgwhite" style="align-content: stretch">
                                                <td>
                                                    <asp:CheckBox ID="chkchq" runat="server" name="checkVendor" onclick="CheckItem(this)" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblChequeNo" runat="server" Text='<%# Eval("CHEQUENO") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hdnCustomerCode" runat="server" Value='<%# Eval("CUSTOMERCODE") %>' />
                                                    <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CUSTOMERNAME") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDepositDate" runat="server" Text='<%# Eval("CHEQUEDATE") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBounceBy" runat="server" Text='<%# Eval("BOUNCEBY") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBounceDate" runat="server" Text='<%# Eval("BOUNCEDATE") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblChequeAmount" runat="server" Text='<%# Eval("BALANCEAMOUNT") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtReceiveAmount" runat="server" onblur="javascript:return validReceivedAmount(this);"
                                                        onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# Eval("BALANCEAMOUNT") %>'></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBalanceAmount" runat="server" Text='<%# Eval("BALANCEAMOUNT") %>'></asp:Label>
                                                </td>

                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <tr class="bgwhite">
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lblTotalBalanceAmount" runat="server" Text="0.00"></asp:Label></td>
                                        <td></td>
                                    </tr>
                                </table>
                                <table class="boxbg" style="width: 10in">
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt">Cash Amount</font>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCashAmount" runat="server" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return GetTotalAmount();"></asp:TextBox>
                                        </td>
                                        <td colspan="5"></td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt">Instrument Type</font>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlPayType" runat="server">
                                                <asp:ListItem Value="CH">Cheque</asp:ListItem>
                                                <asp:ListItem Value="NE">NEFT </asp:ListItem>
                                                <asp:ListItem Value="RT">RTGS </asp:ListItem>
                                            </asp:DropDownList></td>

                                        <td>
                                            <font class="blackfnt">Instrument Amount</font>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInstrumentAmount" runat="server" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                onblur="javascript:return GetTotalAmount();"></asp:TextBox>
                                        </td>
                                        <td>
                                            <font class="blackfnt">Instrument No</font>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInstrumentNo" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <font class="blackfnt">Instrument Date</font>
                                        </td>
                                        <td>
                                            <%--<asp:TextBox ID="txtInstrumentDate" runat="server" Width="60px" onblur="javascript:ValidateForm(this)"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtInstrumentDate,'anchor2','dd/MM/yyyy'); return false;" name="anchor2" id="a2">
                                                <img src="../../../../images/calendar.jpg" border="0" />
                                            </a>--%>
                                            <asp:TextBox ID="txtInstrumentDate" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                                BorderStyle="Groove">
                                            </asp:TextBox>
                                            <asp:Label ID="lbldockdateimage" runat="server">
                                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtInstrumentDate,'ancdockdate','dd/MM/yyyy'); return false;"
                                                    name="ancdockdate" id="ancdockdate">
                                                    <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                                        border="0" />
                                                </a>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <font class="blackfnt">Bank Name</font>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlBankAccount" runat="server"></asp:DropDownList>
                                        </td>
                                        <td>
                                            <font class="blackfnt">Total Amount</font>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalAmount" runat="server" Text="0.00"></asp:Label></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="8">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript : return ValidateOnSubmit();" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>

