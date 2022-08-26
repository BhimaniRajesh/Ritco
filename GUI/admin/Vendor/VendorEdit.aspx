<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="VendorEdit.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="ums" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            onChangeVenderType();
        });
        function onChangeVenderType() {
            if ((document.getElementById("ctl00_MyCPH1_ddVendorType").value) == "12") {
                $("#trOtherAdvance").show();
            } else {
                $("#trOtherAdvance").hide();
            }
        }
        function checkChange() {
            var s = "ctl00_MyCPH1_";
            var txtflag = document.getElementById(s + "txtact");
            var chkflag = document.getElementById(s + "chact");

            if (chkflag.checked == true)
                txtflag.value = "Y";
            else
                txtflag.value = "N";

        }

        function checkChange2() {
            var s = "ctl00_MyCPH1_";
            var txtflag = document.getElementById(s + "txtblk");
            var chkflag = document.getElementById(s + "chblk");

            if (chkflag.checked == true)
                txtflag.value = "Y";
            else
                txtflag.value = "N";

        }
        function checkChangechkOA() {
            var s = "ctl00_MyCPH1_";
            var txtOA = document.getElementById(s + "txtOA");
            var chkOA = document.getElementById(s + "chkOA");

            if (chkOA.checked == true)
                txtOA.value = "Y";
            else
                txtOA.value = "N";

        }

        function nwOpen() {
            window.open("popupLoc.aspx", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }

        function checklocation(obj) {


            var a;
            a = 1;

            obj.value = obj.value.toUpperCase()

            var test1 = obj.value.substring((obj.value.length - 1), (obj.value.length))
            if (test1 == ",") {
                var s = obj.value.substring(0, (obj.value.length - 1))
            }
            else {
                var s = obj.value
            }





            var loc = s.split(",")



            for (j = 0; j < loc.length; j++) {
                a = 1;
                for (i = 0; i < str.length; i++) {
                    if (loc[j].length >= 2) {
                        if (loc[j] == str[i]) {
                            a = 2
                            break;
                            //return false;
                        }
                        else {
                            continue
                        }
                    }
                    //  break
                }


                if (a != 2) {
                    alert("please enter valid location : " + loc[j])
                    obj.focus();
                    return false;

                }

            }
            return true;
        }



        //function x(PanNo, servtaxno, vendorbstno, vendorcstno, ddVendorType, txtvenname, id) {

        //    if (!fsubmit(PanNo, servtaxno, vendorbstno, vendorcstno, ddVendorType, txtvenname))
        //        return false;

        //    if (!checklocation(id))
        //        return false;

        //    return true;
        //}

        function x(PanNo, vendorbstno, ddVendorType, txtvenname, txtAddress, txtCstLoc, txttel, txtemail, txtContactPerson, txtPhoneNumber, id) {

            if (!fsubmit(PanNo, vendorbstno, ddVendorType, txtvenname, txtAddress, txtCstLoc, txttel, txtemail, txtContactPerson, txtPhoneNumber))
                return false;

            if (!checklocation(id))
                return false;

            return true;
        }


        function EmailCheck(obj) {
            if (obj.value != "") {
                if (obj.value.indexOf("@") == -1 || obj.value.indexOf(".") == -1) {
                    alert("Invalid Email Address")
                    obj.focus();
                    return false;
                }
            }
        }


        function tupper(obj) {
            obj.value = obj.value.toUpperCase()
            //txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
        }


        function check2(dbt, crdt) {
            if (isNaN(dbt.value)) {
                alert("Please Enter Only Numeric Value")
                dbt.focus();
                return false
            }
            if (dbt.value < 0) {
                alert("Please Enter Positive Value")
                dbt.focus();
                return false
            }


            if (crdt(pin.value)) {
                alert("Please Enter Only Numeric Value")
                crdt.focus();
                return false
            }
            if (crdt.value < 0) {
                alert("Please Enter Positive Value")
                crdt.focus();
                return false
            }




        }

        function check(pin, tel, mob, email) {

            if (isNaN(pin.value)) {
                alert("Please Enter Only Numeric Value")
                pin.focus();
                return false
            }
            if (pin.value < 0) {
                alert("Please Enter Positive Value")
                pin.focus();
                return false
            }
            if (isNaN(tel.value)) {
                alert("Please Enter Only Numeric Value")
                tel.focus();
                return false
            }
            if (tel.value < 0) {
                alert("Please Enter Positive Value")
                tel.focus();
                return false
            }
            if (isNaN(mob.value)) {
                alert("Please Enter Only Numeric Value")
                mob.focus();
                return false
            }
            if (mob.value < 0) {
                alert("Please Enter Positive Value")
                mob.focus();
                return false
            }


            if (email.value != "") {
                if (email.value.indexOf("@") == -1 || email.value.indexOf(".") == -1) {
                    alert("Invalid Email Address")
                    email.focus();
                    return false;
                }
            }


        }
        function fsubmit(PanNo, vendorbstno, ddVendorType, txtvenname, txtAddress, txtCstLoc, txttel, txtemail, txtContactPerson, txtPhoneNumber) {
            if (ddVendorType.value == "-- Select --") {
                alert("Please Select Vendor Type")
                ddVendorType.focus()
                return false;
            }
            if (txtvenname.value == "") {
                alert("Please Enter Vendor Name")
                txtvenname.focus()
                return false;
            }
            if (txtAddress.value == "") {
                alert("Please Enter Address")
                txtAddress.focus()
                return false;
            }
            if (txtCstLoc.value == "") {
                alert("Please Enter Customer Location")
                txtCstLoc.focus()
                return false;
            }
            if (txttel.value == "") {
                alert("Please Enter vendor Phone Numebr")
                txttel.focus()
                return false;
            }
            if (txtemail.value == "") {
                alert("Please Enter Email Id")
                txtemail.focus()
                return false;
            }
            if (txtContactPerson.value == "") {
                alert("Please Enter Contact Person")
                txtContactPerson.focus()
                return false;
            }
            if (txtPhoneNumber.value == "") {
                alert("Please Enter Phone Number")
                txtPhoneNumber.focus()
                return false;
            }


            if (document.getElementById("ctl00_MyCPH1_txtpin")) {
                if ((document.getElementById("ctl00_MyCPH1_txtpin").value) == "") {
                    alert("Enter Pincode");
                    document.getElementById("ctl00_MyCPH1_txtpin").focus();
                    return false;
                }

                if (IsNumericDot(document.getElementById("ctl00_MyCPH1_txtpin").value) == false) {
                    alert("Enter PinCode in Postive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtpin").focus();
                    return false;
                }

            }
            if (document.getElementById("ctl00_MyCPH1_ddcity")) {
                if ((document.getElementById("ctl00_MyCPH1_ddcity").value) == "-- Select --") {
                    alert("Select City");
                    document.getElementById("ctl00_MyCPH1_ddcity").focus();
                    return false;
                }
            }

            if (document.getElementById("ctl00_MyCPH1_ddcity")) {
                if ((document.getElementById("ctl00_MyCPH1_ddcity").value) == "-- Select --") {
                    alert("Select City");
                    document.getElementById("ctl00_MyCPH1_ddcity").focus();
                    return false;
                }
            }

            if (PanNo.value != "") {
                if (!isNaN(PanNo.value)) {
                    alert("Only Numbers are not allowed")
                    PanNo.focus();
                    return false;
                }

                if (PanNo.value.length < 10) {
                    alert("Minimum Size of PAN No. is 10")
                    PanNo.focus()
                    return false;
                }

                if (PanNo.value.indexOf(".") > 1 || PanNo.value.indexOf("-") > 1) {
                    alert("Special Charachter are Not Allowed")
                    PanNo.focus()
                    return false;
                }
            }

            if (PanNo.value == "") {
                alert("Please Enter Pan No")
                PanNo.focus()
                return false;
            }


            //if (servtaxno.value != "") {
            //    if (!isNaN(servtaxno.value)) {
            //        alert("Only Numbers are not allowed")
            //        servtaxno.focus();
            //        return false;
            //    }
            //    if (servtaxno.value.length < 10) {
            //        alert("Minimum Size of Service Tax No. is 10")
            //        servtaxno.focus()
            //        return false;
            //    }

            //    if (servtaxno.value.indexOf(".") > 1 || servtaxno.value.indexOf("-") > 1) {
            //        alert("Special Charachter are Not Allowed")
            //        servtaxno.focus()
            //        return false;
            //    }

            //}
            //	if(servtaxno.value=="")
            //        {
            //         alert("Please Enter Service Tax No")
            //         servtaxno.focus()
            //         return false;
            //        }

            if (vendorbstno.value != "") {
                if (!isNaN(vendorbstno.value)) {
                    alert("Only Numbers are not allowed")
                    vendorbstno.focus();
                    return false;
                }
                if (vendorbstno.value.length != 15) {
                    alert("Minimum Size of GST No. is 15")
                    vendorbstno.focus()
                    return false;
                }

            }
            //	if(vendorbstno.value=="")
            //{
            // alert("Please Enter Local Sales Tax No.")
            // vendorbstno.focus()
            // return false;
            //}

            //if (vendorcstno.value != "") {
            //    if (!isNaN(vendorcstno.value)) {
            //        alert("Only Numbers are not allowed")
            //        vendorcstno.focus();
            //        return false;
            //    }
            //    if (vendorcstno.value.length < 13) {
            //        alert("Minimum Size should be 13")
            //        vendorcstno.focus()
            //        return false;
            //    }

            //}
            if (document.getElementById("ctl00_MyCPH1_txtDiscount")) {
                if ((document.getElementById("ctl00_MyCPH1_txtDiscount").value) == "") {
                    alert("Enter Discount Rate");
                    document.getElementById("ctl00_MyCPH1_txtDiscount").focus();
                    return false;
                }
            }

            return true;

        }

        var months = new Array("", "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December");

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function isInteger(s) {
            for (var i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag) {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }

            return returnString;
        }





        function IsNumericDot(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }
        function ViewPanDoucment(ctrl) {
            var lblPanView = $(ctrl);
            var Doc = $("#" + lblPanView.attr('id').replace("lblPanView", "hdnPanUpload")).val();
            if (Doc != "") {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
                var strPopupURL = "https://ritcoblob.blob.core.windows.net/" + $("#<%=hdnContainerName.ClientID%>").val() + "/" + Doc;
                winNew = window.open(strPopupURL, "_blank", strWinFeature);
            }
        }
        function ViewAadhaarDoucment(ctrl) {
            var lblAadhaarView = $(ctrl);
            var Doc = $("#" + lblAadhaarView.attr('id').replace("lblAadhaarView", "hdnAadhaarUpload")).val();
            if (Doc != "") {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
                var strPopupURL = "https://ritcoblob.blob.core.windows.net/" + $("#<%=hdnContainerName.ClientID%>").val() + "/" + Doc;
                winNew = window.open(strPopupURL, "_blank", strWinFeature);
            }
        }
        function ValidatePanNo(ctrl) {
            var PanNo = $(ctrl);
            if (PanNo.val() != "") {
                var PANCardRegx = new RegExp('^[a-z-A-Z]{3}[cpfhtCPFHT]{1}[a-z-A-Z]{1}[0-9]{4}[a-z-A-Z]{1}$');
                if (PANCardRegx.test(PanNo.val()) == false) {
                    //alert(PanNoValidateMessage);
                    alert("Incorrect PanNo !!");
                    PanNo.val("")
                    PanNo.focus();
                    return false;
                }
                else {
                    PanNo.val(PanNo.val().toUpperCase());
                }
            }
        }
        function ValidateAadharNo(ctrl) {
            var AadhaarNo = $(ctrl);
            if (AadhaarNo.val() != "") {
                var AadhaarCardRegx = new RegExp('^[0-9]{12}$');
                if (AadhaarCardRegx.test(AadhaarNo.val()) == false) {
                    //alert(PanNoValidateMessage);
                    alert("Incorrect Aadhaar No !!");
                    AadhaarNo.val("")
                    AadhaarNo.focus();
                    return false;
                }

            }
        }



    </script>

    <br />
    <br />
    <asp:Panel ID="plnerr" Visible="false" runat="server">
        <table width="90%">
            <tr>
                <td align="center">
                    <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label1" Text="Please Try Again....." runat="server"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnl1" runat="server">
        <asp:UpdatePanel ID="DataGrid2_Update" runat="server" UpdateMode="Always" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
                    align="center">
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="bluefnt" Font-Bold="True" runat="server">Vendor Information</asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td style="width: 111px"><font class="blackfnt">System Date</font></td>
                        <td style="width: 195px" colspan="3">
                            <asp:TextBox ID="txtSystemDate" runat="server" MaxLength="39" Width="94px" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td style="width: 111px"><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Vendor Code</font></td>
                        <td style="width: 195px">
                            <asp:Label ID="lblcstcode" runat="server" class="blackfnt"></asp:Label>
                        </td>
                        <td style="width: 188px">
                            <font class="blackfnt">
                                <p align="left"><font class="blackfnt" color="red">*</font> 
                                    <font class="blackfnt">Name</font>
                                </p>
                            </font>
                        </td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtvenname" runat="server" Width="94px" Enabled="false"></asp:TextBox>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtbilldt"></asp:RequiredFieldValidator>--%>
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtbilldt"
                            ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>--%>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Vendor Type </font>
                        </td>
                        <td style="width: 195px">
                            <asp:DropDownList ID="ddVendorType" runat="server" Width="200px" OnChange ="onChangeVenderType();">
                            </asp:DropDownList></td>
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Address</font></td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatordd" runat="server" ErrorMessage="*" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>--%>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Customer Locations <font size="1">(Separated by commas)</font></font></td>
                        <td colspan="3">
                            <asp:TextBox ID="txtCstLoc" runat="server" Width="381px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            <asp:Label ID="Label2" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen()">...</a>'
                                Width="14px"></asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Vendor City </font>
                        </td>
                        <td style="width: 195px">
                            <asp:DropDownList ID="ddcity" runat="server" Width="150" CssClass="input">
                            </asp:DropDownList>
                        </td>
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Pincode</font></td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtpin" MaxLength="6" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Vendor Phone No. </font>
                        </td>
                        <td style="width: 195px">
                            <asp:TextBox ID="txttel" runat="server" MaxLength="10" Width="100px"></asp:TextBox>
                        </td>
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">E - Mail </font>
                        </td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtemail" runat="server" onblur="EmailCheck(this)" Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <%--Added by Mayank on 9th Nov 2016 START Updated 3 columns for Insert: ContactPerson,PhoneNumber,PhoneNumber2--%>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Contact Person</font></td>
                        <td style="width: 195px">
                            <asp:TextBox ID="txtContactPerson" name="txtContactPerson" runat="server" MaxLength="20" Width="100px"></asp:TextBox>
                        </td>
                        <td><font class="blackfnt" color="red">*</font> 
                            <font class="blackfnt">Phone Number</font></td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtPhoneNumber" name="txtPhoneNumber" runat="server" MaxLength="10" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td style="width: 195px">
                            <font class="blackfnt">Phone Number 2</font></td>
                        <td>
                            <asp:TextBox ID="txtPhoneNumber2" name="txtPhoneNumber2" runat="server" MaxLength="10" Width="100px"></asp:TextBox>
                        </td>
                        <td style="width: 264px">
                            <td>
                    </tr>
                    <%--Added by Mayank on 9th Nov 2016 END--%>
                    <tr bgcolor="white" style="height: 25px">
                        <td>
                            <font class="blackfnt">Active </font>
                        </td>
                        <td style="width: 195px">
                            <asp:CheckBox ID="chact" runat="server" />
                            <asp:TextBox ID="txtact" Enabled="false" runat="server" Width="30px"></asp:TextBox>
                        </td>
                        <td>
                            <font class="blackfnt">Black Listed </font>
                        </td>
                        <td style="width: 264px">
                            <asp:CheckBox ID="chblk" runat="server" />
                            <asp:TextBox ID="txtblk" runat="server" Enabled="false" Width="30px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr bgcolor="white" style="height: 25px" id="trOtherAdvance">
                        <td><font class="blackfnt">Other Advance  </font></td>
                        <td style="width: 195px">
                            <asp:CheckBox ID="chkOA" runat="server" />
                            <asp:TextBox ID="txtOA" Enabled="false" runat="server" Width="30px"></asp:TextBox>
                        </td>
                        <td colspan="4"></td>
                    </tr>

                    <tr class="bgbluegrey">
                        <td align="center" colspan="4">
                            <font class="bluefnt"><b>Other Information</b></font></td>
                    </tr>

                    <%--<tr bgcolor="white" style="height: 25px">
                        <td>
                            <font class="blackfnt">PAN No. </font>
                        </td>
                        <td style="width: 195px">
                            <asp:TextBox ID="PanNo" MaxLength="10" runat="server" Width="123px"></asp:TextBox>
                        </td>
                        <td>
                            <font class="blackfnt">Service Tax No. </font>
                        </td>
                        <td style="width: 264px">
                            <asp:TextBox ID="servtaxno" MaxLength="10" runat="server"></asp:TextBox>
                        </td>
                    </tr>--%>
                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt" color="red">*</font> <font class="blackfnt">PAN No.  </font></td>
                        <td style="width: 195px">
                            <asp:TextBox ID="PanNo" MaxLength="10" runat="server" Width="123px" onblur="return ValidatePanNo(this);"></asp:TextBox>
                        </td>
                        <td><font class="blackfnt" color="red">*</font> <font class="blackfnt">Pan Upload </font></td>
                        <td style="width: 264px">
                            <asp:FileUpload ID="fldPanUpload" runat="server" />
                            <asp:Label runat="server" ID="lblPanView" Text="View" onclick="ViewPanDoucment(this)" Visible="false" Style="cursor: pointer"></asp:Label>
                            <asp:HiddenField ID="hdnPanUpload" runat="server" />
                        </td>
                    </tr>

                    <tr bgcolor="white" style="height: 25px">
                        <td><font class="blackfnt">Aadhar No.  </font></td>
                        <td style="width: 195px">
                            <asp:TextBox ID="txtAadhaarNo" Text="" runat="server" Width="128px" onblur="return ValidateAadharNo(this);"></asp:TextBox>
                        </td>
                        <td><font class="blackfnt">Aadhaar Upload </font></td>
                        <td style="width: 264px">
                            <asp:FileUpload ID="fldAadhaarUpload" runat="server" />
                            <asp:Label runat="server" ID="lblAadhaarView" Text="View" onclick="ViewAadhaarDoucment(this)" Visible="false" Style="cursor: pointer"></asp:Label>
                            <asp:HiddenField ID="hdnAadhaarUpload" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td>
                            <font class="blackfnt">GST No. </font>
                        </td>
                        <td style="width: 195px" colspan="3">
                            <asp:TextBox ID="vendorbstno" MaxLength="15" runat="server" Width="123px"></asp:TextBox>
                        </td>
                        <%--<td>
                            <font class="blackfnt">Central Sales Tax No.</font></td>
                        <td style="width: 264px">
                            <asp:TextBox ID="vendorcstno" MaxLength="13" runat="server"></asp:TextBox>
                        </td>--%>
                    </tr>
                    <tr bgcolor="white" style="height: 25px">
                        <td>
                            <font class="blackfnt">Remarks : </font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="300" TextMode="MultiLine"></asp:TextBox></td>
                        <td><font class="blackfnt" color="red">*</font> <font class="blackfnt">Discount Rate </font></td>
                        <td style="width: 264px">
                            <asp:TextBox ID="txtDiscount" runat="server" MaxLength="10" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        &nbsp;<table border="0" cellspacing="2" cellpadding="2" width="50%" align="center">
            <tr>
                <td align="right">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
                <asp:HiddenField ID="hdnContainerName" runat="server" />
                <td>
                    <asp:Button ID="btnReset" runat="server" Text="Reset" />
                    <ums:UserMessage ID="umsg" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
