<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TripsheetValidationEdit.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_TripsheetValidationEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript">
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>

    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <asp:Label runat="server" Text="" ForeColor="Red" ID="lblRedirectMsg"></asp:Label>

            <table border="0" cellspacing="1" cellpadding="3" width="500px" class="boxbg" id="tblDCRCriteria" runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Validation Form: Edit"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <b><font class="blackfnt"><b>Controlling Branch Basis</b></font></b>
                    </td>

                    <td align="center">
                        <b><font class="blackfnt"><b>Before Expiry Date</b></font></b>
                    </td>
                    <td></td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="4">
                        <font class="blackfnt"><b>For Vehicle</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt">Fitness</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtFitness" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt">National Permit</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtNationalPermit" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt">5 Year Permit</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtFiveYearPermit" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt">Insurance</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtInsurance" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt">Road Tax</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtRoadTax" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                 <tr bgcolor="white">
                    <td align="center">
                        <font class="blackfnt"><b>C/F Allowed</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt">Diesel Ltrs</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtDieselLtrs" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Ltrs</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="4">
                        <font class="blackfnt"><b>For Driver</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                     <%--   <font class="blackfnt">Driver License</font>--%>
                          <font class="blackfnt">D/L Validity</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtDriverLicense" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <%--<font class="blackfnt">Driver License Verification</font>--%>
                        <font class="blackfnt">D/L Verified Date</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtDriverLicenseVerification" MaxLength="3" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Days</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center">
                        <%--<font class="blackfnt"><b>C/F Allowed</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt">Cash</font>--%>
                         <font class="blackfnt">Driver Balance</font>
                    </td>
                    <td align="center">
                        <asp:TextBox runat="server" Width="70px" ID="txtCash" MaxLength="6" onkeypress="return isNumber(event)"></asp:TextBox>
                    </td>
                    <td>
                        <font class="blackfnt">Rs.</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="right" colspan="3">
                        <asp:Button ID="btnEdit" ValidationGroup="grpQuery" Width="47px" runat="server" Text="Edit" OnClick="btnEdit_Click" />

                    </td>
                </tr>
                <%-- <tr style="background-color: white">
                    <td colspan="3">
                        <asp:Label ID="lblConfirm" runat="server" Text="" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>--%>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
