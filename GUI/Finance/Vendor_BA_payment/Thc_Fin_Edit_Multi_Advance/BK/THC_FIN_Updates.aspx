<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="THC_FIN_Updates.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THC_FIN_Updates" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        var txtContractAmt, txtAdvanceAmt, txtBalAmt, txtTdsRate, txtSvtaxRate, txtServiceTaxAmount, txtTdsChrg, txtCessAmt, txtHCessAmt, txtServiceTaxAmount;
        var txtTelChrg, txtMamulChrg, txtLoadChrg, ddlLoadOpertype;
        var txtAdvanceCash, txtAdvanceCheque, txtOtherAdvance, txtTotalAdvance;
        var ctrlPrefixId, btnSubmit;
        function ValidateThcData() {
            try {
                var balAmt = parseFloat(txtContractAmt.val()) - parseFloat(txtAdvanceAmt.val()) - 500;

                if (parseFloat(txtBalAmt.val()) < 0) {
                    throw new Error("Net Balance is less than Zero. Please valid Data");
                }
                if (balAmt < 500) {
                    throw new Error("Contract Amount should be 500Rs. More than Advance Amount Need to Increase More 'Contract Amount-Advance Amount-500'");
                }
                btnSubmit.hide();
            } catch (e) {
                alert(e.message);
                return false;
            }
            return true;
        }
        $(document).ready(function () {
            ctrlPrefixId = "ctl00_MyCPH1_";
            txtContractAmt = $("#" + ctrlPrefixId + "txtContractAmt");
            txtAdvanceAmt = $("#" + ctrlPrefixId + "txtAdvanceAmt");
            txtBalAmt = $("#" + ctrlPrefixId + "txtBalAmt");
            txtTdsRate = $("#" + ctrlPrefixId + "txtTdsRate");
            txtSvtaxRate = $("#" + ctrlPrefixId + "txtSvtaxRate");
            txtServiceTaxAmount = $("#" + ctrlPrefixId + "txtServiceTaxAmount");
            txtTdsChrg = $("#" + ctrlPrefixId + "txtTdsChrg");
            txtCessAmt = $("#" + ctrlPrefixId + "txtCessAmt");
            txtHCessAmt = $("#" + ctrlPrefixId + "txtHCessAmt");
            txtPanNo = $("#" + ctrlPrefixId + "txtPanNo");

            txtTelChrg = $("#" + ctrlPrefixId + "txtTelChrg");
            txtMamulChrg = $("#" + ctrlPrefixId + "txtMamulChrg");
            txtLoadChrg = $("#" + ctrlPrefixId + "txtLoadChrg");
            ddlLoadOpertype = $("#" + ctrlPrefixId + "ddlLoadOpertype");

            txtAdvanceCash = $("#" + ctrlPrefixId + "txtAdvanceCash");
            txtAdvanceCheque = $("#" + ctrlPrefixId + "txtAdvanceCheque");
            txtOtherAdvance = $("#" + ctrlPrefixId + "txtOtherAdvance");
            txtTotalAdvance = $("#" + ctrlPrefixId + "txtTotalAdvance");
            hdnAdvancePaid = $("#" + ctrlPrefixId + "hdnAdvancePaid");
            txtAdvPaidBy = $("#" + ctrlPrefixId + "txtAdvPaidBy");
            hdnAdvanceVoucherNo = $("#" + ctrlPrefixId + "hdnAdvanceVoucherNo");
            btnSubmit = $("#" + ctrlPrefixId + "btnSubmit");
            //if (hdnAdvancePaid.val() != "O" && parseFloat(txtAdvanceAmt.val()) > 0) {
            //    txtAdvanceCash.prop("disabled", true);
            //    txtAdvanceCheque.prop("disabled", true);
            //    txtOtherAdvance.prop("disabled", true);
            //    txtAdvanceAmt.prop("disabled", true);
            //    txtPanNo.prop("disabled", true);
            //}
            InitAutoComplete();
        });
        function fbalamt() {

            if (txtContractAmt.val() == "")
                txtContractAmt.val("0.00");

            if (txtAdvanceAmt.val() == "")
                txtAdvanceAmt.val("0.00");

            if (txtBalAmt.val() == "")
                txtBalAmt.val("0.00");

            if (txtTelChrg.val() == "")
                txtTelChrg.val("0.00");
            if (txtMamulChrg.val() == "")
                txtMamulChrg.val("0.00");
            if (txtLoadChrg.val() == "")
                txtLoadChrg.val("0.00");

            if (txtAdvanceCash.val() == "")
                txtAdvanceCash.val("0.00");
            if (txtAdvanceCheque.val() == "")
                txtAdvanceCheque.val("0.00");
            if (txtOtherAdvance.val() == "")
                txtOtherAdvance.val("0.00");
            if (txtTotalAdvance.val() == "")
                txtTotalAdvance.val("0.00");

            if (txtTdsRate.val() == "")
                txtTdsRate.val("0.00");

            if (txtSvtaxRate.val() == "")
                txtSvtaxRate.val("0.00");

            if (txtTdsChrg.val() == "")
                txtTdsChrg.val("0.00");

            if (txtServiceTaxAmount.val() == "")
                txtServiceTaxAmount.val("0.00");

            if (txtCessAmt.val() == "")
                txtCessAmt.val("0.00");

            if (txtHCessAmt.val() == "")
                txtHCessAmt.val("0.00");

            if (parseFloat(txtTdsRate.val()) > 0) {
                txtTdsChrg.val(parseFloat(txtTdsRate.val()) * parseFloat(txtContractAmt.val()) / 100);
            } else
                txtTdsChrg.val("0.00");

            if (parseFloat(txtSvtaxRate.val()) > 0) {
                txtServiceTaxAmount.val(parseFloat(txtSvtaxRate.val()) * parseFloat(txtContractAmt.val()) / 100);
                txtCessAmt.val(parseFloat(2) * parseFloat(txtServiceTaxAmount.val()) / 100);
                txtHCessAmt.val(parseFloat(1) * parseFloat(txtServiceTaxAmount.val()) / 100);
            }
            else {
                txtServiceTaxAmount.val(0);
                txtCessAmt.val(0);
                txtHCessAmt.val(0);
            }

            txtAdvanceAmt.val(parseFloat(txtAdvanceCash.val()) + parseFloat(txtAdvanceCheque.val()) + parseFloat(txtOtherAdvance.val()));
            txtTotalAdvance.val(txtAdvanceAmt.val());

            var contractAmt = parseFloat(txtContractAmt.val());
            var telChrg = parseFloat(txtTelChrg.val());
            var mamulChrg = parseFloat(txtMamulChrg.val());
            var loadChrg = parseFloat(txtLoadChrg.val());
            var tdsChrg = parseFloat(txtTdsChrg.val());
            var serviceTaxAmount = parseFloat(txtServiceTaxAmount.val());
            var cessAmt = parseFloat(txtCessAmt.val());
            var hCessAmt = parseFloat(txtHCessAmt.val());
            var advanceAmt = parseFloat(txtAdvanceAmt.val());
            var balAmount = parseFloat(txtBalAmt.val());
            if (ddlLoadOpertype.val() == "P")
                balAmount = contractAmt + telChrg - mamulChrg + loadChrg - tdsChrg + serviceTaxAmount + cessAmt + hCessAmt - advanceAmt;
            else
                balAmount = contractAmt + telChrg - mamulChrg - loadChrg - tdsChrg + serviceTaxAmount + cessAmt + hCessAmt - advanceAmt;

            txtBalAmt.prop("disabled", false);
            txtBalAmt.val(rounditn(balAmount));
            txtBalAmt.prop("disabled", true);
        }

        function rounditn(Num, decplaces) {
            Places = decplaces
            if (Places > 0) {

                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {

                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    var Rounder = Math.pow(10, Places);
                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    //alert("Hi")
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();

                    }
                }
            }
            else return Math.round(Num);

        }
        function validFloat(event, txtid) {
            var tb = document.getElementById(txtid);
            var txt = tb.value;
            if (event.keyCode == 13)
                return true;

            if (event.keyCode == 46)
                if (txt.indexOf('.') != -1)
                    event.keyCode = 0;

            if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
            { event.keyCode = 0; return false; }
        }
        function validpanno(obj) {
            var txtPanNo = $("#" + ctrlPrefixId + "txtPanNo");

            if (txtPanNo.val() != "") {
                if (txtPanNo.length != 10) {
                    alert("PAN number should be of 10 character");
                    return false;
                }
            }
        }
        function InitAutoComplete() {
            var txtadvpaidby = $("#<%= txtAdvPaidBy.ClientID%>");
            AutoCompleteByAjax(txtadvpaidby, "../../../../RestService/MasterService.svc/GetLocationList", "POST", "application/json; charset=utf-8", "json", "prefixText", 'v', 'v', 'l', 'v', null, 'Invalid Location');

            var txtBalamtbr = $("#<%= txtBalAmtBrcd.ClientID%>");
            AutoCompleteByAjax(txtBalamtbr, "../../../../RestService/MasterService.svc/GetLocationList", "POST", "application/json; charset=utf-8", "json", "prefixText", 'v', 'v', 'l', 'v', null, 'Invalid Location');

        }
    </script>
    <div>
        <br />
        <asp:UpdatePanel runat="server" RenderMode="Inline" UpdateMode="Conditional">
            <ContentTemplate>
                <UserControl:UserMessage runat="server" ID="usrMsg" />
                <table border="0" width="950px" cellpadding="2" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" class="blackfnt"><b><%= Session["THCCalledAs"].ToString() %>  Financial Edit Multi Advance</b></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center" class="blackfnt"><b><%= Session["THCCalledAs"].ToString() %>  Details</b></td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="950px">
                                <tr class="bgwhite">
                                    <td>
                                        <%= Session["THCCalledAs"].ToString() %> No</td>
                                    <td>
                                        <asp:Label Style="text-align: right;" Text="0.00" CssClass="bluefnt"
                                            ID="lblThcNo" runat="server"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnThcBrcd" />
                                    </td>
                                    <td>
                                        <%= Session["THCCalledAs"].ToString() %> Branch</td>
                                    <td>
                                        <asp:Label Style="text-align: right;" Text="0.00" CssClass="bluefnt"
                                            ID="lblThcBr" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Manual <%= Session["THCCalledAs"].ToString() %> No</td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtManualTHCNo" runat="server" Width="70px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>
                                        <%= Session["THCCalledAs"].ToString() %> Date</td>
                                    <td>
                                        <asp:Label Text="0.00" CssClass="bluefnt"
                                            ID="lblThcdt" runat="server"></asp:Label>
                                        <asp:HiddenField ID="hdThcdt" Value="" runat="server" />
                                    </td>
                                    <td>Route Name</td>
                                    <td>
                                        <asp:Label Text="0.00" CssClass="bluefnt"
                                            ID="lblRouteName" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Vendor Name</td>
                                    <td>
                                        <asp:Label Text="0.00" CssClass="bluefnt"
                                            ID="lblVenodorName" runat="server"></asp:Label>
                                    </td>
                                    <td>Vehicle No</td>
                                    <td>
                                        <asp:Label Text="0.00" CssClass="bluefnt"
                                            ID="lblVehNo" runat="server"></asp:Label>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center" class="blackfnt"><b><%= Session["THCCalledAs"].ToString() %>  Financial Details</b></td>
                    </tr>
                    <tr class="bgwhite" runat="server" id="trcharges">
                        <td>
                            <table width="800px">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%">
                                            <tr class="bgwhite">
                                                <td>Standard Contract Amount</td>
                                                <td>
                                                    <asp:Label Text="0.00" CssClass="bluefnt" ID="lblStdPcAmt" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Contract Amount (+)</td>
                                                <td>
                                                    <asp:TextBox Text="0.00" CssClass="rtxtm" onkeypress="validFloat(event,this.getAttribute('id'))" onblur="javascript:fbalamt();"
                                                        ID="txtContractAmt" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Telephone Charges
                                                </td>
                                                <td>
                                                    <asp:TextBox Text="0.00" CssClass="rtxtm" onkeypress="validFloat(event,this.getAttribute('id'))" onblur="javascript:fbalamt();"
                                                        ID="txtTelChrg" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <asp:Label runat="server" ID="lblHumali" CssClass="blackfnt" Text="Humali"></asp:Label>
                                                    <asp:DropDownList ID="ddlLoadOpertype" runat="server" onblur="javascript:fbalamt();">
                                                        <asp:ListItem Value="P">(+)</asp:ListItem>
                                                        <asp:ListItem Value="M">(-)</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLoadChrg" CssClass="rtxtm" onkeypress="validFloat(event,this.getAttribute('id'))" Text="0.00" onblur="javascript:fbalamt();"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Mamul (-)
                                                </td>
                                                <td>
                                                    <asp:TextBox Text="0.00" CssClass="rtxtm" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:fbalamt();" ID="txtMamulChrg" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>TDS Rate (%)</td>
                                                <td>
                                                    <asp:TextBox Text="0.00" CssClass="rtxtm" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:fbalamt();" ID="txtTdsRate" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>TDS Amount (-)</td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" Enabled="false" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:fbalamt();" ID="txtTdsChrg" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Service Tax Rate (%)</td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:fbalamt();" ID="txtSvtaxRate" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Service Tax (+)
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" Enabled="false" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:fbalamt();" ID="txtServiceTaxAmount" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Cess (+)
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" Enabled="false" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        ID="txtCessAmt" onblur="javascript:fbalamt();" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Higher Cess (+)
                                                </td>
                                                <td>
                                                    <asp:HiddenField Value="0" ID="txtcwt" runat="server" />
                                                    <asp:TextBox CssClass="rtxtm" Enabled="false" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        ID="txtHCessAmt" onblur="javascript:fbalamt();" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%">
                                            <tr class="bgwhite">
                                                <td>TDS Type
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTdsAcccode" runat="server" CssClass="ddlm">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Party PAN Number
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="ltxtm" onblur="javascript:return validpanno(this);"
                                                        MaxLength="10" ID="txtPanNo" runat="server"></asp:TextBox>
                                                    <asp:HiddenField Value="0" ID="advanceamt_paid" runat="server" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Advance Amount</td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" Enabled="false" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))" onblur="javascript:fbalamt();"
                                                        ID="txtAdvanceAmt" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>Advance Amount Paid By
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="ltxtm" onblur="javascript:fbalamt();this.value=this.value.toUpperCase();"
                                                        ID="txtAdvPaidBy" runat="server"></asp:TextBox>
                                                    <asp:HiddenField runat="server" ID="netpayamt" Value="0" />
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Balance Amount</b>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="rtxtm" ID="txtBalAmt" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Balance Payable At</b></td>
                                                <td>
                                                    <asp:TextBox CssClass="ltxtm" ID="txtBalAmtBrcd" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Advance Cash</b></td>
                                                <td>
                                                    <asp:TextBox Width="70px" CssClass="rtxtm" ID="txtAdvanceCash" onblur="javascript:fbalamt();" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Advance Cheque</b></td>
                                                <td>
                                                    <asp:TextBox Width="70px" CssClass="rtxtm" ID="txtAdvanceCheque" onblur="javascript:fbalamt();" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Other Advance</b></td>
                                                <td>
                                                    <asp:TextBox Width="70px" CssClass="rtxtm" ID="txtOtherAdvance" onblur="javascript:fbalamt();" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr class="bgwhite">
                                                <td>
                                                    <b>Total Advance</b></td>
                                                <td>
                                                    <asp:TextBox Width="70px" CssClass="rtxtm" ID="txtTotalAdvance" onblur="javascript:fbalamt();" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                        Enabled="False" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" OnClientClick="javascript:return ValidateThcData();" />
                        </td>
                    </tr>
                </table>
                <asp:Label runat="server" ID="lblMessage"></asp:Label>
                <asp:HiddenField runat="server" ID="hdnTdsAccCode" />
                <asp:HiddenField runat="server" ID="hdnTdsAccDesc" />
                <asp:HiddenField runat="server" ID="hdnAdvancePaid" />
                <asp:HiddenField runat="server" ID="hdnAdvanceVoucherNo" />

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script language="javascript" type="text/javascript">
        window.onload = fbalamt
    </script>


    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
</asp:Content>
