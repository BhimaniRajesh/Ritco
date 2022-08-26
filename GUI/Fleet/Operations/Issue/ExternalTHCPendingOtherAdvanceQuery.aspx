<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ExternalTHCPendingOtherAdvanceQuery.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalTHCPendingOtherAdvanceQuery" %>


<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../../Images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../../Images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
         var serviceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
        var txtCustomer, hdnCustomerCode;

        $(document).ready(function () {

            txtCustomer = $("#" + controlIdPrefix + "txtCustomer");
            hdnCustomerCode = $("#" + controlIdPrefix + "hdnCustomerCode");

            AutoCompleteByAjax(txtCustomer, serviceUrl + "/GetCustomerList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCustomerCode.attr('id'), 'Invalid Customer');
        });
        //Check Customer exist or not
        var txtCustomerName;
        function IsExistCustomer(obj) {
            if (obj.value != "") {
                txtCustomerName = obj;
                AjaxRequestWithPostAndJson(serviceUrl + "/IsExistCustomer", JSON.stringify(obj.value), checkCustomerSuccess, errorFunction, false);
            }
            else {
                return true;
            }
        }
        //get customer code
        function checkCustomerSuccess(data) {
            if (data != '') {
                if (hdnCustomerCode.val() == data) {
                    hdnCustomerCode.val(data);
                }
            }
            else {
                txtCustomerName.value = "";
                txtCustomerName.focus();
                alert("Invalid Customer !!");
                return false;
            }
        }
        function Validate() {

            if ($("#" + controlIdPrefix + "txtETHCNo").val().trim() == "" & hdnCustomerCode.val().trim() == "All") {
                alert("Please select customer.!");
                txtCustomer.focus();
                return false;
            }
            return true;
            
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                    <font class="blklnkund"><strong>Fleet </strong></font><font class="bluefnt">
                        <strong>&gt;</strong>
                        <strong>External THC Pending Other Advance  </strong></font><font class="bluefnt">
                            <strong>&gt;</strong>
                            <strong>Query</strong> </font>
                </td>
            </tr>

            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Stock Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="1">
                                <font class="blackfnt">Branch Name</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="cboLoc" runat="server" AutoPostBack="false" EnableViewState="true"
                                    DataTextField="LocName" DataValueField="LocCode" />
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="left" colspan="1">
                                <font class="blackfnt">Customer Name</font>
                            </td>
                            <td align="left" colspan="3">
                               <asp:TextBox ID="txtCustomer" runat="server" Width="190px" onblur="javascript:return IsExistCustomer(this)"></asp:TextBox>
                            <asp:HiddenField ID="hdnCustomerCode" runat="server" Value="All" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Ethc Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>

                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter ETHC No</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtETHCNo" runat="server" />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClientClick="javascript: return Validate();" OnClick="btnShow_Click" runat="server" Text="Submit" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

</asp:Content>