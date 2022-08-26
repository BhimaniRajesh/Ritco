<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="vendorContract_profile.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_profile" %>

<%@ Register Src="~/GUI/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="Vendor_Contract.js"></script>

    <br />
    <br />
    <br />

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();  
    </script>

    <script language="javascript" type="text/javascript">
        var ctrlPrefix = "ctl00_MyCPH1_";

        function openPopupLoc() {
            window.open("frm_Popup_Location.aspx?CtrlID=" + ctrlPrefix + "txtContractloccode", null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
        }


        function onSave() {
            var ucContractDT = document.getElementById(ctrlPrefix + "ucContractDT_txtDtBox");
            if (ucContractDT.value == "") {
                alert("Please select contract date");
                ucContractDT.focus();
                return false;
            }
            else {
                var res = isValidDate(ucContractDT.value, "Contract")
                if (!res) {
                    ucContractDT.focus();
                    ucContractDT.value = ""
                    return false;
                }
            }
            var txtContractloccode = document.getElementById(ctrlPrefix + "txtContractloccode");
            if (txtContractloccode.value == "") {
                alert("Please select contract signing location");
                txtContractloccode.focus();
                return false;
            }
            var ucValidTill = document.getElementById(ctrlPrefix + "ucValidTill_txtDtBox");
            if (ucValidTill.value == "") {
                alert("Please select valid till date");
                ucValidTill.focus();
                return false;
            }
            else {
                var res = isValidDate(ucValidTill.value, "Valid Till")
                if (!res) {
                    ucValidTill.focus();
                    ucValidTill.value = ""
                    return false;
                }
            }

            var ucEffectiveFrom = document.getElementById(ctrlPrefix + "ucEffectiveFrom_txtDtBox");
            if (ucEffectiveFrom.value == "") {
                alert("Please select effective from date");
                ucEffectiveFrom.focus();
                return false;
            }
            else {
                var res = isValidDate(ucEffectiveFrom.value, "Effective From")
                if (!res) {
                    ucEffectiveFrom.focus();
                    ucEffectiveFrom.value = ""
                    return false;
                }
            }
            var cboVendorCategory = document.getElementById(ctrlPrefix + "cboVendorCategory");
            if (cboVendorCategory.value == "") {
                alert("Please select vendor category");
                cboVendorCategory.focus();
                return false;
            }
            var cboVendorContractCat = document.getElementById(ctrlPrefix + "cboVendorContractCat");
            if (cboVendorContractCat.value == "") {
                alert("Please select vendor contract category");
                cboVendorContractCat.focus();
                return false;
            }

            var TDSChk = document.getElementById(ctrlPrefix + "TDSChk");
            var txtTdsRate = document.getElementById(ctrlPrefix + "txtTdsRate");
            if (TDSChk.checked) {
                if (txtTdsRate.value == "") {
                    txtTdsRate.focus();
                    alert("Please insert TDS Rate.");
                    txtTdsRate.value = "";
                    return false;
                }
            }
            var txtVendorPin = document.getElementById(ctrlPrefix + "txtVendorPin");
            if (txtVendorPin.value != "") {
                if (txtVendorPin.value.length != 6) {
                    txtVendorPin.focus();
                    alert("Please insert valid pincode number.");
                    txtVendorPin.value = "";
                    return false;
                }
            }
            var hidVendorTypeID = document.getElementById(ctrlPrefix + "hidVendorTypeID");
            var txtDefCharge = document.getElementById(ctrlPrefix + "txtDefCharge");
            if (hidVendorTypeID.value == "08") {
                if (txtDefCharge.value == "") {
                    txtDefCharge.focus();
                    alert("Please Enter Default Charge.");
                    return false;
                }
                else {
                    var defAmt = parseFloat(txtDefCharge.value);
                    if (defAmt <= 0) {
                        txtDefCharge.focus();
                        alert("Please Enter Default Charge.");
                        return false;
                    }
                }
            }
            return true;
        }
        function changeTDSStatus() {
            var TDSChk = document.getElementById(ctrlPrefix + "TDSChk");
            var txtTDS = document.getElementById(ctrlPrefix + "txtTDS");
            if (TDSChk.checked) {
                txtTDS.value = "Yes";
            }
            else {
                txtTDS.value = "No";
            }
            return true;
        }
    </script>

    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="300" valign="top">
                <table align="letf" border="0" cellpadding="5" cellspacing="1" style="width: 9.5in;"
                    class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <font class="blackfnt"><b>VENDOR CONTRACT MASTER </b></font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF">
                            &nbsp;<b>Note</b> : All fields marked with <span class="redfnt">*</span> are mandatory
                            <table border="0" align="left" cellspacing="1" cellpadding="6" style="width: 9.0in;"
                                class="boxbg">
                                <tr class="bgbluegrey">
                                    <td colspan="4">
                                        <font class="blackfnt"><strong><u>Vendor Contract Step 2:Vendor Contract Profile</u></strong></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td nowrap>
                                        <font class="blackfnt">Vendor Name</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblvendor" CssClass="blackfnt" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Vendor Type</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblvendortype" CssClass="blackfnt" runat="server" Text=""></asp:Label>
                                        <input type="hidden" runat="server" id="hidVendorTypeID" value="" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td nowrap>
                                        <font class="blackfnt">Contract Code</font>
                                    </td>
                                    <td class="blackfnt">
                                        <asp:Label ID="lblConrtaID" runat="server" Text="System Generated" CssClass="bluefnt"></asp:Label>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Contract date </font><span class="redfnt">*</span>
                                    </td>
                                    <td nowrap>
                                        <uc1:DatePicker ID="ucContractDT" runat="server"></uc1:DatePicker>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td nowrap>
                                        <font class="blackfnt">Contract signing location <span class="redfnt">*</span></font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContractloccode" MaxLength="4" CssClass="blackfnt" BorderStyle="Groove"
                                            runat="server" Width="48px"></asp:TextBox>
                                        <input type="button" value="..." runat="server" class="blackfnt" borderstyle="Groove"
                                            id="btnAt" onclick="openPopupLoc();" />
                                        <ajaxToolkit:AutoCompleteExtender ID="extLocation" runat="server" MinimumPrefixLength="1"
                                            ServiceMethod="GetLocationList" ServicePath="../../services/WebService.asmx"
                                            TargetControlID="txtContractloccode">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Valid Until <span class="redfnt">*</span></font>
                                    </td>
                                    <td nowrap>
                                        <uc1:DatePicker ID="ucValidTill" runat="server"></uc1:DatePicker>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">Vendor representative</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendorPerName" CssClass="blackfnt" BorderStyle="Groove" runat="server"
                                            Width="90px"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Effective from date </font><span class="redfnt">*</span>
                                    </td>
                                    <td nowrap>
                                        <uc1:DatePicker ID="ucEffectiveFrom" runat="server"></uc1:DatePicker>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">Designation</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendorPerDesg" runat="server" MaxLength="50" Width="144px" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Company employee name</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCompEmpName" runat="server" MaxLength="50" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">Vendor Witness</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendorWitness" runat="server" MaxLength="100" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Designation </font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCompEmpDesg" runat="server" MaxLength="50" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">Vendor Address</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendorAdd" TextMode="MultiLine" runat="server" MaxLength="500"
                                            Width="136px" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Company witness </font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCompWitness" runat="server" MaxLength="100" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">City- Pin</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVendorCity" runat="server" MaxLength="50" Width="88px" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>-<asp:TextBox ID="txtVendorPin" MaxLength="6"
                                                runat="server" Width="48px" CssClass="blackfnt" BorderStyle="Groove" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Vendor category </font><span class="redfnt">*</span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cboVendorCategory" runat="server" CssClass="blackfnt">
                                            <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
                                            <asp:ListItem Text="Contract" Value="C"></asp:ListItem>
                                            <asp:ListItem Text="Non Contract" Value="NC"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">TDS Applicable</font>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="TDSChk" runat="server" onclick="javascript:return changeTDSStatus();" />
                                        <asp:TextBox ID="txtTDS" runat="server" ReadOnly="True" Width="30px" CssClass="blackfnt"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Contract Category </font><span class="redfnt">*</span>
                                    </td>
                                    <td>
                                        &nbsp;<asp:DropDownList ID="cboVendorContractCat" runat="server" CssClass="blackfnt"
                                            Width="80px">
                                            <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
                                            <asp:ListItem Text="Contract" Value="C"></asp:ListItem>
                                            <asp:ListItem Text="Subcontract" Value="S"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <font class="blackfnt">TDS Rate</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTdsRate" runat="server" CssClass="blackfnt" MaxLength="8" Style="text-align: right;"
                                            BorderStyle="Groove" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"></asp:TextBox>
                                    </td>
                                    <td nowrap>
                                        <font class="blackfnt">Security deposit cheque(s)</font>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNoOfCheques" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td width="20%">
                                        <font class="blackfnt">Payment interval</font>
                                    </td>
                                    <td width="20%">
                                        &nbsp;<asp:DropDownList ID="cboPayInterval" runat="server" CssClass="blackfnt">
                                            <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
                                            <asp:ListItem Text="Quarterly" Value="Q"></asp:ListItem>
                                            <asp:ListItem Text="Monthly" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Weekly" Value="W"></asp:ListItem>
                                        </asp:DropDownList>
                                        <td width="20%" nowrap>
                                            <font class="blackfnt">Security deposit date</font>
                                        </td>
                                        <td nowrap>
                                            &nbsp;<uc1:DatePicker ID="ucSDDate" runat="server"></uc1:DatePicker>
                                        </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td width="20%">
                                        <font class="blackfnt">Payment Basis</font>
                                    </td>
                                    <td width="20%">
                                        &nbsp;<asp:DropDownList ID="cboTransType" runat="server" CssClass="blackfnt">
                                            <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
                                            <asp:ListItem Text="Cash" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Cheque" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="DD" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td width="20%" nowrap>
                                        <font class="blackfnt">Security deposit Amount</font>
                                    </td>
                                    <td>
                                        &nbsp;<asp:TextBox ID="txtSecDepAmt" runat="server" MaxLength="12" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td width="20%" nowrap>
                                        <font class="blackfnt">Payment location</font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">&nbsp;
                                            <asp:TextBox ID="txtPayLoccode" runat="server" MaxLength="50" Width="48px"></asp:TextBox></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Monthly Phone Charges</font>
                                    </td>
                                    <td>
                                        &nbsp;<asp:TextBox ID="txtMonPhChrg" runat="server" MaxLength="8" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" runat="server" id="trDefCharge">
                                    <td width="20%" nowrap>
                                        <font class="blackfnt">Default Charge <span class="redfnt">*</span></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">&nbsp;
                                            <asp:TextBox ID="txtDefCharge" runat="server" MaxLength="8" Style="text-align: right;"
                                                Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"></asp:TextBox></font>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td colspan="4" align="center" valign="middle">
                                        &nbsp;
                                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="Javascript:return onSave();"
                                            OnClick="btnShow_Click" Width="75px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="blackfnt">
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
