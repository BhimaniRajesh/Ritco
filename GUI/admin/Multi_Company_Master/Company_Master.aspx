<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Company_Master.aspx.cs" Inherits="GUI_admin_Multi_Company_Master_Company_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        function popuplist(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl;
            confirmWin = window.open(url, "", winOpts);
            return false;
        }
        function LocBlur(id) {
            var str = "";
            for (var i = 0; i < id.length - 14; i++) {
                str += id.charAt(i);
            }

            document.getElementById(id).value = document.getElementById(id).value.toUpperCase()
            var txtLocation = document.getElementById(id);

            var Location = txtLocation.value;
            if (Location == "")
                return false;

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
                findobj.open("GET", strpg, true);
                findobj.onreadystatechange = function() {
                    if (findobj.readyState == 4 && findobj.status == 200) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            alert("Location Code is not Valid... Please Enter Valid Location Code");
                            txtLocation.value = "";
                            txtLocation.focus();
                            return false;
                        }

                    }
                }
                findobj.send(null);
            }
            return false;
        }
        function CompanyCode(id) {
            var str = "";
            for (var i = 0; i < id.length - 14; i++) {
                str += id.charAt(i);
            }
            document.getElementById(id).value = document.getElementById(id).value.toUpperCase()
            var txtCompanyCode = document.getElementById(id);

            var CompanyCode = txtCompanyCode.value;
            if (CompanyCode == "")
                return false;

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "CheckExist.aspx?mode=Company&Code=" + CompanyCode + "&sid=" + Math.random();
                findobj.open("GET", strpg, true);
                findobj.onreadystatechange = function() {
                    if (findobj.readyState == 4 && findobj.status == 200) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "true") {
                            alert("Company Code is Already Exists... Please Enter Valid Company Code");
                            txtCompanyCode.value = "";
                            txtCompanyCode.focus();
                            return false;
                        }
                    }
                }
                findobj.send(null);
            }
            return false;
        }
        function CheckData() {
            var prefix = "ctl00_MyCPH1_";
            var txtCmpCode = document.getElementById(prefix + "txtCmpCode");
            var txtCmpName = document.getElementById(prefix + "txtCmpName");
            var txtContactPerson = document.getElementById(prefix + "txtContactPerson");
            var txtContactNo = document.getElementById(prefix + "txtContactNo");
            var txtBrcd = document.getElementById(prefix + "txtBrcd");
            var txtAddress = document.getElementById(prefix + "txtAddress");

            if (txtCmpCode.value == "") {
                alert("Please Enter Company Code");
                txtCmpCode.focus();
                return false;
            }
            if (txtCmpName.value == "") {
                alert("Please Enter Company Name");
                txtCmpName.focus();
                return false;
            }
            if (txtContactPerson.value == "") {
                alert("Please Enter Contact Person Name");
                txtContactPerson.focus();
                return false;
            }
            if (txtContactNo.value == "") {
                alert("Please Enter Contact Number");
                txtContactNo.focus();
                return false;
            }
            if (txtBrcd.value == "") {
                alert("Please Enter Branch Code");
                txtBrcd.focus();
                return false;
            }
            if (txtAddress.value == "") {
                alert("Please Enter Company Address");
                txtAddress.focus();
                return false;
            }
            return true;
        }
    </script>

    <br />
    <br />
    <div style="width: 9in">
        <table border="0" cellpadding="1" cellspacing="1" class="stbl" width="100%">
            <tr class="hrow">
                <td align="center" colspan="4">
                    <strong>Multiple Company Master</strong>
                </td>
            </tr>
            <tr class="nrow">
                <td>
                    &nbsp;<asp:Label ID="lblcmpcode" Style="text-align: left" runat="server" Text="Company Code"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtCmpCode" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" onblur="javascript:this.value=this.value.toUpperCase()"
                        MaxLength="10"></asp:TextBox>
                </td>
                <td>
                    &nbsp;<asp:Label ID="lblcmpname" Style="text-align: left" runat="server" Text="Company Name"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtCmpName" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" onblur="javascript:this.value=this.value.toUpperCase()"
                        MaxLength="100"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>
                    &nbsp;<asp:Label ID="lblContactPerson" Style="text-align: left" runat="server" Text="Contact Person Name"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtContactPerson" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="50" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td>
                    &nbsp;<asp:Label ID="lblContactNo" Style="text-align: left" runat="server" Text="Contact No"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtContactNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: right;" MaxLength="20" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>
                    &nbsp;<asp:Label ID="lblBrcd" Style="text-align: left" runat="server" Text="Branch Code"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtBrcd" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="50" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                    <input id="btnLocCode" type="button" value="..." runat="server" />
                </td>
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblTelNo" runat="server" Text="Telephone No"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtTelNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: right;" MaxLength="25" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>
                    &nbsp;<asp:Label ID="lblAddress" Style="text-align: left" runat="server" Text="Company Address"></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtAddress" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="250px" Style="text-align: left;" TextMode="MultiLine" MaxLength="250"
                        onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td>
                    &nbsp;<asp:Label ID="lblSTaxNo" runat="server" Text="Service Tax No."></asp:Label>
                </td>
                <td>
                    &nbsp;<asp:TextBox ID="txtSTaxno" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="20" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblPANNo" runat="server" Text="PAN No."></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtPANNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="20" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblTANNo" runat="server" Text="TAN No."></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtTANNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="20" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblFAXNo" runat="server" Text="FAX No."></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtFAXNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: right;" MaxLength="25" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                </td>
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblHelpLineNo" runat="server" Text="Help Line No."></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtHelpLineNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: right;" MaxLength="25" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblRegNo" runat="server" Text="Registration No."></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtRegNo" CssClass="blackfnt" runat="server" BorderStyle="Groove"
                        Width="160px" Style="text-align: left;" MaxLength="25" onblur="javascript:this.value=this.value.toUpperCase()"></asp:TextBox>
                </td>
                <td style="text-align: left; width: 160px;">
                    &nbsp;<asp:Label ID="lblActive" Style="text-align: left" runat="server" Text="Active"></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:CheckBox ID="chkActive" runat="server" />
                </td>
            </tr>
            <tr class="nrow">
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblPunchLine" runat="server" Text="Punch Line"></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:TextBox ID="txtPunchLine" Width="260px" MaxLength="300" BorderStyle="Groove"
                        CssClass="blackfnt" runat="server"></asp:TextBox>
                </td>
                <td style="text-align: left; width: 170px;">
                    &nbsp;<asp:Label ID="lblImage" runat="server" Text="Company Image"></asp:Label>
                </td>
                <td style="text-align: left">
                    &nbsp;<asp:FileUpload ID="imgUpload" runat="server" />
                </td>
            </tr>
            <tr class="frow">
                <td align="center" colspan="4">
                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();"
                        CssClass="fbtn" Text="Submit" Width="100px" OnClick="btnSubmit_Click" />
                    <asp:HiddenField ID="click_count" runat="server" Value="0" />
                </td>
            </tr>
        </table>
        <br />
    </div>
</asp:Content>
