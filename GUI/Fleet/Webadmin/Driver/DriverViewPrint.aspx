<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="DriverViewPrint.aspx.cs" Inherits="GUI_Fleet_Webadmin_Driver_DriverViewPrint" %>

<html>
<head runat="server">
    <script lang="javascript" type="text/javascript">
        function printme() {
            //var qs = new Querystring()
            //var mPrintMode = qs.get("PrintMode");
            //if (mPrintMode == "1") {
            //    window.print();
            //}
        }
        function popupMe(strFile) {
            //ctl00_MyCPH1_LblEBill
            //var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            var mstrFile = document.getElementById(strFile).innerText
            var mFilePath = "http://ritco-tms.southeastasia.cloudapp.azure.com/RitcoLog_Live/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }
    </script>
</head>
<body onload="printme()">

    <form id="form1" runat="server">
        <div>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Driver Master View</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                </tr>
            </table>
            <br />
            <table cellspacing="1" cellpadding="3" width="900px" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center">
                        <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Details"></asp:Label></td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblDriverCode" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Code"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:Label ID="lblDriverCodeVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Name"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDriverNameVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Name"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Manual Driver Code"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblManualDriverCodeVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="F'Name"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblFathersNameVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>

                    <td align="left">
                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Number"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblVehicleNumberVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt " Font-Bold="true" Text="Location"></asp:Label>

                    </td>
                    <td align="left">
                        <asp:Label ID="lblLocationVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <b style="color: red;">*</b>
                        <asp:Label ID="lblContactNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Mobile No."></asp:Label>

                    </td>
                    <td align="left">
                        <asp:Label ID="lblContactNoVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" rowspan="2">
                        <asp:Label ID="lblCAddress" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Current Address"></asp:Label>
                    </td>
                    <td align="left" rowspan="2">
                        <asp:Label ID="lblCAddressVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDOB" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Date Of Birth"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDOBVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">

                    <td align="left">
                        <b style="color: red">*</b>
                        <asp:Label ID="lvlValDt" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Validity"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblValDtVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblLicNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L No."></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblLicNoVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblbIssueDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Issue Date"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblbIssueDateVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <b style="color: red;">*</b>
                        <asp:Label ID="lblIssued" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Issued By RTO"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblRTOVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblFlag" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Status"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblStatusVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">

                    <td align="left">
                        <asp:Label ID="lblLicIssueDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Issue Date:"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblLicIssueDateVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblLicCategory" runat="server" CssClass="blackfnt" Font-Bold="true" Text="License Category"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblLicCategoryVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td>
                        <asp:Label ID="lblAddressVerfiedBy" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address verified by"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAddressVerfiedByVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAddressVerfiedDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address verified Date"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAddressVerfiedDateVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Village"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblVillageVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tahseel"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblTahseelVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPS" runat="server" CssClass="blackfnt" Font-Bold="true" Text="P.S"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblPSVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblPO" runat="server" CssClass="blackfnt" Font-Bold="true" Text="P.O"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblPOVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblDist" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Dist."></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDistVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblState" runat="server" CssClass="blackfnt" Font-Bold="true" Text="State"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblStateVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label15" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Mobile No.(Village)"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblVillageMobileNoVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Alternative Number"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblAlternativeMobileNoVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblReferenceName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reference Name"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblReferenceNameVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <b style="color: red">*</b>
                        <asp:Label ID="lblReferenceMobileNo" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reference Mobile No."></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblReferenceMobileNoVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Address Proof"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <b style="color: red">*</b>
                        <asp:Label ID="Label19" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Aadhar Card No"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtAadharCardNo" runat="server" MaxLength="16" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('LblAadharCardNo')">
                            <asp:Label ID="LblAadharCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Election Card No"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtElectionCardNo" runat="server" MaxLength="20" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('lblElectionCardNo')">
                            <asp:Label ID="lblElectionCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Ration Card No"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtRationCardNo" runat="server" MaxLength="16" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('lblRationCardNo')">
                            <asp:Label ID="lblRationCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Passport No"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtPassportNo" runat="server" MaxLength="20" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('lblPassportNo')">
                            <asp:Label ID="lblPassportNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="true" Text="PAN Card No"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtPANCardNo" runat="server" MaxLength="16" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('lblPANCardNo')">
                            <asp:Label ID="lblPANCardNo" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                    <td align="left">

                        <asp:Label ID="Label18" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Bank Account Statement"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="txtBankAccountStatement" runat="server" MaxLength="20" CssClass="input"></asp:Label>
                        <a href="javascript:popupMe('lblBankAccountStatement')">
                            <asp:Label ID="lblBankAccountStatement" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <b style="color: red">*</b>
                        <asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Photo"></asp:Label>
                    </td>
                    <td align="left">
                        <a href="javascript:popupMe('lblPhoto')">
                            <asp:Label ID="lblPhoto" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label21" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Driver Bio Data"></asp:Label>
                    </td>
                    <td align="left">
                        <a href="javascript:popupMe('lblDriverBioData')">
                            <asp:Label ID="lblDriverBioData" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblDriverLicVerfiedBy" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Verified by"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDriverLicVerfiedByVal" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblDLVerifiedDate" runat="server" CssClass="blackfnt" Font-Bold="true" Text="D/L Verified date"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label runat="server" ID="txtDLVerifiedDate" />
                        
                        <a href="javascript:popupMe('lbl_DLVerifiedDate')">
                            <asp:Label ID="lbl_DLVerifiedDate" runat="server" CssClass="blackfnt" Font-Bold="false" ForeColor="red" Text="" Font-Underline="true"></asp:Label></a>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>


