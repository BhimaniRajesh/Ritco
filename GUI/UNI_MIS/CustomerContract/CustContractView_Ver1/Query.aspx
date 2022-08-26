<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Voucher_register_Query" Trace="false" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="ProgressBar" Src="~/GUI/Common_UserControls/ProgressBar.ascx"
    TagPrefix="probar" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="AutoComplete"
    TagPrefix="auc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        function cust(ID) {
            ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID=" + ID

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }

        function OnSub_DATACHECK() {

            return true;
        }

    </script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function btnlocpopupClick11() {
            window.open("DataPopUp11.aspx?poptp=loccode&code1=ctl00_MyCPH1_txtLocation&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
            return false;
        }
        function btnlocpopupClick() {
            window.open("DataPopUp.aspx?poptp=custcd&code1=ctl00_MyCPH1_txtLocation&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
            return false;
        }

        function CheckStatus() {
            var rdbtnWithoutContract = document.getElementById("ctl00_MyCPH1_rdbtnWithoutContract");
            var rdbtnWithContract = document.getElementById("ctl00_MyCPH1_rdbtnWithContract");
            var rdbtnBoth = document.getElementById("ctl00_MyCPH1_rdbtnBoth");
            var trStatus = document.getElementById("ctl00_MyCPH1_trStatus");

            if (rdbtnWithContract.checked) {
                trStatus.style["display"] = "block";
            }
            else {
                trStatus.style["display"] = "none";
            }

        }

        function changeCustomer() {
            var rdbtnWithContract = document.getElementById("ctl00_MyCPH1_rdbtnWithContract");
            var trStatus = document.getElementById("ctl00_MyCPH1_trStatus");
            rdbtnWithContract.checked = true;
            trStatus.style["display"] = "block";
        }

        function ValidateOnSubmit() {
            var contype;
            var fromdt = document.getElementById('ctl00_MyCPH1_DT_txtDateFrom');
            var todt = document.getElementById('ctl00_MyCPH1_DT_txtDateTo');
            var rdbtnEntryDate = document.getElementById('ctl00_MyCPH1_rdbtnEntryDate');
            var rdbtnContractDate = document.getElementById('ctl00_MyCPH1_rdbtnContractDate');
            var rdbtnExpirydate = document.getElementById('ctl00_MyCPH1_rdbtnExpirydate');
            var rdbtnWithoutContract = document.getElementById('ctl00_MyCPH1_rdbtnWithoutContract');
            var rdbtnBoth = document.getElementById('ctl00_MyCPH1_rdbtnBoth');
            var ddlContractType = document.getElementById('ctl00_MyCPH1_ddlContractType');
            var txtLocation = document.getElementById('ctl00_MyCPH1_txtLocation');
            if (rdbtnEntryDate.checked) { contype = 'EN'; }
            if (rdbtnContractDate.checked) { contype = 'CO'; }
            if (rdbtnExpirydate.checked) { contype = 'EX'; }
            var cont, trStatus, strPopupUrl;
            if (rdbtnWithoutContract.checked) {
                cont = 'W';
                trStatus = document.getElementById('ctl00_MyCPH1_trStatus');
                trStatus.style['display'] = 'none';
            }
            else if (rdbtnBoth.checked) {
                cont = 'B';
                trStatus = document.getElementById('ctl00_MyCPH1_trStatus');
                trStatus.style['display'] = 'none';
            }
            else {
                var rdbtnActive = document.getElementById('ctl00_MyCPH1_rdbtnActive');
                var rdbtnInactive = document.getElementById('ctl00_MyCPH1_rdbtnInactive');
                var rdbtnExpired = document.getElementById('ctl00_MyCPH1_rdbtnExpired');
                if (rdbtnActive.checked) {
                    cont = 'A';
                }
                if (rdbtnInactive.checked) { cont = 'I'; }
                if (rdbtnExpired.checked) { cont = 'E'; }
            }
            var txtCustCode = document.getElementById('ctl00_MyCPH1_txtCustCode');
            var txtCustContract = document.getElementById('ctl00_MyCPH1_txtCustContract');
            
            //var strPopupURL = 'Result.aspx?fromdt=' + fromdt.value + '&todt=' + todt.value + '&con_type=' + contype + '&Con_status=' + cont;
            strPopupUrl = 'Result.aspx?id=' + Math.random() + '&fromdt=' + fromdt.value + '&todt=' + todt.value + '&con_type=' + contype + '&Con_status=' + cont + '&servicetype=' + ddlContractType.value
            + '&LocCode=' + txtLocation.value + '&CustCode=' + txtCustCode.value + '&ContractId=' + txtCustContract.value;
            window.open(strPopupUrl, '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=970 ,height=650,status=no,left=10,top=10');
            return false;
        }
    </script>

    <div align="left">
        <br />
        <br />
        <%-- <asp:UpdatePanel ID="upp" runat="server" UpdateMode="Always" RenderMode="Block">
            <ContentTemplate>--%>
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="stbl" align="left">
                        <tr class="hrow">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Customer Contract View Criteria</b></font>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <font class="blackfnt">Contract date type</font>
                            </td>
                            <td align="left" colspan="4">
                                <asp:RadioButton ID="rdbtnEntryDate" runat="server" Text="Entry date" GroupName="Datetype" />
                                <asp:RadioButton ID="rdbtnContractDate" runat="server" Text="Contract date" GroupName="Datetype" />
                                <asp:RadioButton ID="rdbtnExpirydate" runat="server" Text="Expiry date" GroupName="Datetype" />
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <font class="blackfnt">Date range</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <font class="blackfnt">Customer</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:RadioButton ID="rdbtnWithContract" Checked="true" runat="server" OnClick="javascript:return CheckStatus()"
                                    Text="With Contract" GroupName="Custcontract" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="rdbtnWithoutContract" runat="server" OnClick="javascript:return CheckStatus()"
                                    Text="Without Contract" GroupName="Custcontract" />&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="rdbtnBoth" runat="server" OnClick="javascript:return CheckStatus()"
                                    Text="Both" GroupName="Custcontract" />
                            </td>
                        </tr>
                        <tr class="nrow" runat="server" id="trStatus">
                            <td align="left">
                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Contract status" runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <asp:RadioButton ID="rdbtnActive" runat="server" Text="Active" GroupName="ContractStatus" />
                                <asp:RadioButton ID="rdbtnInactive" runat="server" Text="Inactive" GroupName="ContractStatus" />
                                <asp:RadioButton ID="rdbtnExpired" runat="server" Text="Expired" GroupName="ContractStatus" />
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" Text="Contract Pay Basis" runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <asp:DropDownList ID="ddlContractType" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Location" runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txtLocation" Enabled="true" runat="server" BorderStyle="Groove"
                                    Width="234"></asp:TextBox><br />
                                <auc:AutoComplete ID="aucloc" MinPrefixLength="2" runat="server" WebxEntity="BranchCode"
                                    CodeTarget="txtLocation" FilterString="12345" />
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td colspan="4" align="center">
                                <font class="blackboldfnt">OR</font>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Customer code" runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtCustCode" Enabled="true" BorderStyle="Groove" runat="server"
                                                Width="234"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnlocpopup" runat="server" OnClientClick="javascript:return btnlocpopupClick()"
                                                CssClass="nbtn" Text="...." />
                                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td colspan="4" align="center">
                                <font class="blackboldfnt">OR</font>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Contract ID" runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <asp:TextBox ID="txtCustContract" Enabled="true" BorderStyle="Groove" runat="server"
                                    Width="234" onclick="javascript:return changeCustomer();"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr class="hrow">
                            <td colspan="4" align="center">
                                <asp:Button ID="btnShow" CssClass="fbtn" OnClick="btnShow_Click" runat="server" Text="Show" OnClientClick="return ValidateOnSubmit()"
                                    Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <%--   </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <probar:ProgressBar ID="ProgressBar" runat="server" />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
