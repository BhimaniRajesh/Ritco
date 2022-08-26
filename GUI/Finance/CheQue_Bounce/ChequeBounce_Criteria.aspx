<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChequeBounce_Criteria.aspx.cs" Inherits="GUI_Finance_CheQue_Bounce_ChequeBounce_Criteria" %>

<%--<%@ Register Src="../../Common_UserControls/MyMessageBox.ascx" TagName="MyMessageBox" TagPrefix="uc1" %>--%>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="uc1" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetail.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script type="text/javascript" language="javascript">



        function validateEmail(field) {
            var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
            return (regex.test(field)) ? true : false;
        }
        function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
            var value = emailcntl.value;
            if (value != '') {
                var result = value.split(seperator);
                for (var i = 0; i < result.length; i++) {
                    if (result[i] != '') {
                        if (!validateEmail(result[i])) {
                            emailcntl.value = "";
                            emailcntl.focus();
                            alert('Please check, `' + result[i] + '` email addresses not valid!');
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        function CheckAll(Checkbox) {
            var gvDetails = document.getElementById("tblrpt");
            for (i = 1; i < gvDetails.rows.length; i++) {
                gvDetails.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = Checkbox.checked;
            }
        }
        function CheckItem(CheckBox) {
            var gvDetails = document.getElementById("tblrpt");
            if (CheckBox.checked == false) {
                gvDetails.rows[1].cells[0].getElementsByTagName("INPUT")[0].checked = false;
            }
        }
        function Valid() {
            var txtChequeNo = $('#<%=txtChequeNo.ClientID %>');
            var txtAmount = $('#<%=txtAmount.ClientID %>');
            var txtChequekdate = $('#<%=txtChequekdate.ClientID %>');
            var btnSubmit = $('#<%=btnSubmit.ClientID %>');
            if (txtChequeNo.val() == "") {
                alert('Please Enter Cheque No');
                txtChequeNo.focus();
                return false;
            }

            if (txtAmount.val() == "") {
                alert('Please Enter Cheque Amount');
                txtAmount.focus();
                return false;
            }
            if (txtChequekdate.val() == "") {
                alert('Please Enter Cheque Date');
                txtChequekdate.focus();
                return false;
            }
        }
        function ValidateOnSubmit() {
            var btnSubmit = $('#<%=btnSubmit.ClientID %>');
            var count = 0;
            var objChequeBounceRequest = {};
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
            var remarkCnt = 0, EmailCnt = 0;
			
			if (LocCode.val() == "All") {
                alert("Please select Location !!");
                return false;
            }

            $("input[id*='chkchq']").each(function () {

                var chkchq = $(this);
                if ($(chkchq).prop('checked')) {

                    var lblChequeNo = $("#" + chkchq.attr('id').replace('chkchq', 'lblChequeNo'));
                    var hdnCustomerCode = $("#" + chkchq.attr('id').replace('chkchq', 'hdnCustomerCode'));
                    var lblCustomerName = $("#" + chkchq.attr('id').replace('chkchq', 'lblCustomerName'));
                    var lblDepositDate = $("#" + chkchq.attr('id').replace('chkchq', 'lblDepositDate'));
                    var lblAmount = $("#" + chkchq.attr('id').replace('chkchq', 'lblAmount'));
                    var txtRemarks = $("#" + chkchq.attr('id').replace('chkchq', 'txtRemarks'));
                    var txtEmailID = $("#" + chkchq.attr('id').replace('chkchq', 'txtEmailID'));
                    var EntryBy = '<%= SessionUtilities.CurrentEmployeeID%>';
                    var FinYear = '<%= SessionUtilities.FinYear%>';
                    var EntryBranch = '<%= SessionUtilities.CurrentBranchCode%>';

                    if (txtRemarks.val() == "") {

                        remarkCnt = remarkCnt + 1;
                    }
                    if (txtEmailID.val() == "") {
                        //alert("Please Enter Email");
                        //return false;
                        EmailCnt = EmailCnt + 1;
                    }

                    if (txtRemarks.val() != "" && txtEmailID.val() != "") {
                        objChequeBounceRequest = {
                            BankName: BankName.val(),
                            ROLocation: ROLocation.val(),
                            Loccode: LocCode.val(),
                            ChequeNo: lblChequeNo.text(),
                            Amount: lblAmount.text(),
                            ChequeDate: lblDepositDate.text(),
                            CustomerCode: hdnCustomerCode.val(),
                            CustomerName: lblCustomerName.text(),
                            Remarks: txtRemarks.val(),
                            EmailID: txtEmailID.val(),
                            EntryBy: EntryBy,
                            FinYear: FinYear,
                            EntryBranch: EntryBranch
                        };
                    }
                }
            });

            if (remarkCnt > 0) {
                alert("Please Enter Remark");
                return false;
            }
            if (EmailCnt > 0) {
                alert("Please Enter Email");
                return false;
            }

            if (objChequeBounceRequest != null) {
                try {

                    var requestData = {};
                    requestData.objChequeBounceRequest = objChequeBounceRequest;
                    requestData = JSON.stringify(requestData);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ChequeBounce_Criteria.aspx/ChequeInsert",
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
    <div align="left">

        <uc1:UserMessage ID="msgBox" runat="server" />
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Banking Operation </strong></font>
                    <font class="bluefnt"><strong>&gt;
                    </strong><strong>Cheque Bounce ver1</strong> </font></td>
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
                                <font class="blackfnt"><b>Select   Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
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
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">Amount</font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'));"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">Cheque Date</font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtChequekdate" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                    BorderStyle="Groove">
                                </asp:TextBox>
                                <asp:Label ID="lbldockdateimage" runat="server">
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtChequekdate,'ancdockdate','dd/MM/yyyy'); return false;"
                                name="ancdockdate" id="ancdockdate">
                                <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                    border="0" />
                            </a>
                                </asp:Label>
                            </td>
                        </tr>


                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClientClick="javascript : return Valid();" OnClick="btnShow_Click" />

                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="upData" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <%-- <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnStep3" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="addRow" EventName="Click" />
             <asp:AsyncPostBackTrigger ControlID="IsEmptyPRS" EventName="CheckedChanged" />
        </Triggers>--%>
                        <ContentTemplate>
                            <table class="boxbg" style="width: 10in" id="tblrpt">
                                <asp:Repeater ID="gvChequeDetail" runat="server">
                                    <HeaderTemplate>
                                        <tr class="bgbluegrey" align="center">
                                            <th colspan="7">
                                                <h5>List Of Cheque</h5>
                                            </th>
                                        </tr>
                                        <tr class="bgbluegrey" style="align-content: stretch">
                                            <th>
                                                <asp:CheckBox ID="chkprsvendor" runat="server" onClick="CheckAll(this);" /></th>
                                            <th>Cheque No</th>
                                            <th>Customer Name</th>
                                            <th>Deposit Date</th>
                                            <th>Amount</th>
                                            <th>Remarks</th>
                                            <th>Email Id</th>

                                        </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="bgwhite" style="align-content: stretch">
                                            <td>
                                                <asp:CheckBox ID="chkchq" runat="server" name="checkVendor" onclick="CheckItem(this)" />
                                            </td>
                                            <td>

                                                <asp:Label ID="lblChequeNo" runat="server" Text='<%# Eval("ChequeNo") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hdnCustomerCode" runat="server" Value='<%# Eval("CustomerCode") %>' />
                                                <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDepositDate" runat="server" Text='<%# Eval("DepositDate") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmailID" runat="server" MaxLength="500" onblur="validateMultipleEmailsCommaSeparated(this,';');"></asp:TextBox>
                                                <font class="bluefnt">(Enter Multiple Email id ; )</font>
                                            </td>

                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript : return ValidateOnSubmit();" Visible="false" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>

