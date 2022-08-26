<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUp_Cust.aspx.cs" Inherits="GUI_UNI_Net_MIS_PopUp_Cust" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script language="javascript" type="text/javascript">

        function criteriaCheck() {

            var txtCustCode = document.getElementById("txtCustCode");
            var txtCustName = document.getElementById("txtCustName");

            if (txtCustCode.value == "" && txtCustName.value == "") {
                alert("Please enter Customer Code or Name initials...");
                return false;
            }

            return true;
        }

        function saveSelection() {
            var hdnSelection = document.getElementById("hdnSelection");
            if (ID == 'C') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value = hdnSelection.value;
            }
            else if (ID == 'V') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value = hdnSelection.value;
            }
            else if (ID == 'E') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value = hdnSelection.value;
            }
            else if (ID == 'D') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value = hdnSelection.value;
            }
            else if (ID == 'A') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value = hdnSelection.value;
            }
            else if (ID == 'B') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtBank.value = hdnSelection.value;
            }
            else if (ID == 'L') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtstartBranch.value = hdnSelection.value;
            }
            else if (ID == 'L1') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtEndBranch.value = hdnSelection.value;

            }
            else if (ID == 'L2') {
                window.opener.document.aspnetForm.ctl00$MyCPH1$txtEnrouteBranch.value = hdnSelection.value;
            }

            window.close();
            return false;
        }

        function Child(obj) {

            ID = document.getElementById('QID').value;
            var Str = obj.value;
            var hdnSelection = document.getElementById("hdnSelection");

            hdnSelection.value = hdnSelection.value + Str + ",";
        }


        function retrieveSelections() {


            var ID = document.getElementById('QID').value;
            var hdnSelection = document.getElementById("hdnSelection");

            if (ID == 'C') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value;
            }
            else if (ID == 'V') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendor.value;
            }
            else if (ID == 'E') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtEmployee.value;
            }
            else if (ID == 'D') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtDriver.value;
            }
            else if (ID == 'A') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtAccount.value;
            }
            else if (ID == 'B') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtBank.value;
            }
            else if (ID == 'L') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtstartBranch.value;
            }
            else if (ID == 'L1') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtEndBranch.value;
            }
            else if (ID == 'L2') {
                hdnSelection.value = window.opener.document.aspnetForm.ctl00$MyCPH1$txtEnrouteBranch.value;
            }
            return false;
        }

    </script>
    <title>Selection Box</title>
</head>
<body onload="javascript:return retrieveSelections()">
    <form id="form1" runat="server">
    <asp:Button ID="btnSave" runat="server" Text="Save & Close" CssClass="nbtn" OnClientClick="javascript:return saveSelection()"
        Style="position: fixed; top:3px; left:3px; " />
    <table border="0" style="width: 6.5in;" align="left" cellspacing="1" cellpadding="0">
        <tr>
            <td align="left">
                <br />
                <table border="0" style="width: 5.5in;" cellpadding="1" cellspacing="1" class="stbl">
                    <tr class="hrow">
                        <td colspan="2" align="center">
                            Criteria
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>
                            <font class="blackfnt">
                                <asp:Label CssClass="blackfnt" Text="" runat="server" ID="SelectID1"></asp:Label>
                                Code</font>
                        </td>
                        <td style="text-align: left">
                            <asp:TextBox ID="txtCustCode" runat="server" CssClass="ltxtm" Width="120px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>
                            <font class="blackfnt">
                                <asp:Label CssClass="blackfnt" Text="" runat="server" ID="SelectID2"></asp:Label>
                                Name</font>
                        </td>
                        <td style="text-align: left">
                            <asp:TextBox ID="txtCustName" runat="server" CssClass="ltxtm" Width="186px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="hbtn" Text="Submit" OnClientClick="javascript:return criteriaCheck();"
                                OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:HiddenField ID="QID" runat="server" />
                <table style="width: 5.5in;" cellpadding="1" cellspacing="1" class="stbl">
                    <tr class="hrow">
                        <td width="10" align="left">
                        </td>
                        <td width="100" align="left">
                            <asp:Label CssClass="nfnt" runat="server" ID="SelectID4"></asp:Label>
                            Code
                        </td>
                        <td width="100" align="left">
                            <asp:Label CssClass="nfnt" runat="server" ID="SelectID5"></asp:Label>
                            Name
                        </td>
                    </tr>
                    <asp:Repeater ID="rptMain" runat="server">
                        <ItemTemplate>
                            <tr id="tr1" runat="server" class="nrow">
                                <td id="td1" runat="server" width="10%" bgcolor="white" align="left">
                                    &nbsp;
                                    <input type="checkbox" id="chk" runat="server" onclick="javascript:return Child(this);"
                                        value='<%# DataBinder.Eval(Container.DataItem,"CUSTCD") %>' />
                                </td>
                                <td id="td2" runat="server" width="30%" bgcolor="white" align="left">
                                    &nbsp;<asp:Label ID="lblCust" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"CUSTCD") %>'></asp:Label>
                                </td>
                                <td id="td3" runat="server" bgcolor="white" align="left">
                                    &nbsp;<asp:Label ID="lblCustName" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"CUSTNM") %>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
                <asp:HiddenField ID="hdnSelection" runat="server" />
            </td>
        </tr>
    </table>
    <br />
    </form>
</body>
</html>
