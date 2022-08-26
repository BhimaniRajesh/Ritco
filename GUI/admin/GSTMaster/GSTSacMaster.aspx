<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GSTSacMaster.aspx.cs" Inherits="GUI_admin_GSTMaster_GSTSacMaster" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="uc1" TagName="UserMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        var rp_GST_SAC = $('#<%= rp_GST_SAC.ClientID %>');

        function ValidFloat(e) {
            if ((e.keyCode >= 48 && e.keyCode <= 57) || e.keyCode == 46 || e.keyCode == 8 || e.keyCode == 190) {
                return true;
            }
            return false;
        }
        function ValidateGSTRate(e, txtPercentage) {
            if ($(txtPercentage).val() != "" && (parseFloat($(txtPercentage).val()) <= 0 || (parseFloat($(txtPercentage).val()) > 100))) {
                alert("GST Rate must be in range of 1 to 100.");
                $(txtPercentage).val("").focus();
                return false;
            }
            return true;
        }
        function onBtnSubmit_Click() {
            try {
                var rows = rp_GST_SAC.find("tbody tr");
                for (var i = 0; i < rows.length; i++) {
                    if ($(rows[i]).find("input[id$=txtGSTRate]").val() == "") {
                        alert("Please enter GST Rate");
                        $(rows[i]).find("input[id$=txtGSTRate]").val("").focus();
                        return false;
                    }
                }
                if (confirm("Are you sure to save GST SAC rate?")) {
                    return true;
                }
                else {
                    return false;
                }
            } catch (e) {
                alert(e.message);
                return false;
            }
        }
    </script>
    <table cellspacing="1" style="width: 100%">
        <tbody>
            <tr style="background-color: white">
                <td align="left">
                    <span id="ctl00_MyCPH1_lblPageHead" class="blackfnt" style="font-weight: bold;">GST SAC Master</span>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <asp:Panel ID="pnl_GST_SAC" runat="server" Width="700px">
        <table id="tbl_GST_SAC" class="boxbg" width="100%">
            <thead>
                <tr class="bgbluegrey">
                    <th align="center">Sr No</th>
                    <th align="center" width="150">SAC</th>
                    <th align="center" width="150">SAC Code</th>
                    <th align="center">GST Rate (%)</th>
                    <th align="center">RCM Applicable</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rp_GST_SAC" runat="server" OnItemDataBound="rp_GST_SAC_ItemDataBound">
                    <ItemTemplate>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">
                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblSACCategory" runat="server" Text='<%# Eval("SACCategoryText") %>'></asp:Label>
                                <asp:HiddenField ID="hdnSACCategory" runat="server" Value='<%# Eval("SACCategory") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="txtSACCode" runat="server" Text='<%# Eval("SACCode") %>' CssClass="ltxt" title="SAC Code" Width="150" MaxLength="50"></asp:TextBox>
                                <asp:HiddenField ID="hdnSACCode" runat="server" Value='<%# Eval("SACCode") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="txtGSTRate" runat="server" Text='<%# Eval("GSTRate") %>' CssClass="rtxt" title="GST Rate in %" Width="100" onkeypress="return ValidFloat(event);" onblur="return ValidateGSTRate(event,this);" MaxLength="6"></asp:TextBox>
                                <asp:HiddenField ID="hdnGSTRate" runat="server" Value='<%# Eval("GSTRate") %>' />
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rbtnRCMApplicable" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:HiddenField ID="hdnRCMApplicable" runat="server" Value='<%# Eval("IsRCMApplicable") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>
                <tr class="bgbluegrey">
                    <td colspan="5" align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return onBtnSubmit_Click();" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
    </asp:Panel>
    <table id="tblDetailSaved" runat="server" class="boxbg" cellpadding="3" cellspacing="1" visible="false" width="500">
        <thead>
            <tr class="bgbluegrey">
                <th>
                    <asp:Label ID="lblMsg" runat="server" Text="" Font-Bold="true"></asp:Label>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr class="bgwhite">
                <td>
                    <a href="GSTSacMaster.aspx">Click here to update GST SAC Rates.</a>
                </td>
            </tr>
        </tbody>
    </table>
    <uc1:UserMessage runat="server" ID="msgBox" />
</asp:Content>

