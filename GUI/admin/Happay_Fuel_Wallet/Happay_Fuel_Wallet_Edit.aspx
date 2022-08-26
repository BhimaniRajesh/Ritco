<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Happay_Fuel_Wallet_Edit.aspx.cs" Inherits="GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        var controlIdPrefix = "ctl00_MyCPH1_";
        var txtBank = '<%=txtBank.ClientID%>';
        var hdnBank = '<%=hdnBank.ClientID%>';
        //var txtBank = $("#" + controlIdPrefix + "txtBank");
        //var hdnBank = $("#" + controlIdPrefix + "hdnBank");
        var reqData = {};
        serviceUrl = 'Happay_Fuel_Wallet_Edit.aspx/';
        //AutoCompleteByAjax("[id*=" + txtBank + "]", serviceUrl + 'GetBankList', 'POST', 'application/json; charset=utf-8', 'json', '%%%', 2, 'l', 'l', 'l', 'v', 'hdnBank', reqData);
        $(document).ready(function () {
            AutoCompleteByAjaxVer1("[id*='txtBank']", serviceUrl + 'BankList', 'POST', 'application/json; charset=utf-8', 'json', 'searchText', 2, 'l', 'l', 'l', 'l', 'ctl00_MyCPH1_hdnBank', 'No Bank found!', reqData, false);
        });
        function Validation() {
            if ($('#' + hdnBank).val() == "" || $('#' + txtBank).val() == "undefined") {
                return false;
            } else {
                return true;
            }
        }
    </script>


    <br />
    <br />
    <br />
    <table>
        <tr>
            <td>
                <table width="500px" class="stbl" id="tbl1" runat="server">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center"><b>Mapping Wallet with Bank</b></td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center">Select Bank</td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="txtBank" runat="server">
                            </asp:TextBox>
                            <asp:HiddenField ID="hdnBank" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite" id="trstp1btn" runat="server">
                        <td align="right" colspan="3">
                            <asp:Button ID="btnStep1" runat="server" Text="Step 1" CssClass="fbtn" OnClick="btnStep1_Click" OnClientClick="return Validation();"></asp:Button></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="step2" runat="server" visible="false">
            <td>
                <br />
                <table width="700px" id="tblstep2" class="stbl">
                    <tr class="bgwhite">
                        <td align="center"><b>Active</b></td>
                        <td align="center"><b>Bank Name</b></td>
                        <td align="center"><b>Account No.</b></td>
                        <td align="center"><b>Wallet</b></td>
                    </tr>
                    <asp:Repeater ID="BindBankDetails" runat="server">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td align="center">
                                    <asp:CheckBox runat="server" ID="IsActive" Checked="true" /></td>
                                <td align="left">
                                    <asp:Label ID="lblBankName" runat="server" Text='<%# Eval("BankName") %>'></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnAccCode" Value='<%# Eval("BankLeadgerCode") %>' />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Eval("AccountNo") %>'></asp:Label></td>
                                <td align="center">
                                    <asp:DropDownList ID="ddWallet" runat="server" SelectedValue ='<%# Eval("WalletType") %>'>
                                        <asp:ListItem Text="Happay" Value="Happay"></asp:ListItem>
                                        <asp:ListItem Text="Fuel Wallet" Value="Fuel Wallet"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Width="120"
                                CssClass="fbtn" Text="Submit" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


</asp:Content>

