<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GSTSacProductMapingMaster.aspx.cs" Inherits="GUI_admin_GSTMaster_GSTSacProductMapingMaster" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="uc1" TagName="UserMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">

        var hdnSACGSTDetails = $("<%= hdnSACGSTDetails.ClientID %>");
        var hdnSACGSTDetails = $("<%= hdnSACGSTDetails.ClientID %>");

        $(document).ready(function () {

        });
        function onSACCategorySelection_Change(ddl) {
            try {
                var selectedSACCategory = $(ddl).val();
                var currentRow = $(ddl).closest("tr");
                if (selectedSACCategory != "") {

                    var jSACGSTDetails = JSON.parse($("#ctl00_MyCPH1_hdnSACGSTDetails").val())
                    for (var i = 0; i < jSACGSTDetails.length; i++) {
                        if (jSACGSTDetails[i].SACCategory == selectedSACCategory) {
                            $(currentRow).find("span[id$=lblSACCode]").text(jSACGSTDetails[i].SACCode);
                            $(currentRow).find("span[id$=lblIsRCMApplicable]").text(jSACGSTDetails[i].IsRCMApplicable);
                            $(currentRow).find("span[id$=lblGSTRate]").text(parseFloat(jSACGSTDetails[i].GSTRate).toFixed(2) + " %");
                        }
                    }
                }
                else {
                    $(currentRow).find("span[id$=lblSACCode]").text("");
                    $(currentRow).find("span[id$=lblIsRCMApplicable]").text("");
                    $(currentRow).find("span[id$=lblGSTRate]").text("");
                }

            } catch (e) {
                alert(e.message);
            }
        }

        function onBtnSubmit_Click() {
            try {

                var lstSACCategory = $("select[id$=ddlSACCategory]");

                for (var i = 0; i < lstSACCategory.length; i++) {
                    if ($(lstSACCategory[i]).val() == "") {
                        alert("Please select SAC Category.");
                        $(lstSACCategory[i]).focus();
                        return false;
                    }
                }
                if (confirm("Are you sure to save SAC Product Mapping Details?")) {
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
                    <span id="ctl00_MyCPH1_lblPageHead" class="blackfnt" style="font-weight: bold;">Service Type-SAC Mapping Master</span>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <asp:HiddenField ID="hdnSACGSTDetails" runat="server" />
    <asp:Panel ID="pnl_GST_SAC_Mapping" runat="server" Width="800px">
        <table id="tbl_Product_SAC_Master" class="boxbg" style="width: 100%">
            <thead>
                <tr class="bgbluegrey">
                    <th align="center">Sr No</th>
                    <th width="200" align="center" >Service Type</th>
                    <th align="center">SAC Category</th>
                    <th width="100" align="center">SAC Code</th>
                    <th align="center">RCM Applicable</th>
                    <th align="center">GST Rate (%)</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rp_Product_SAC_Master" runat="server" OnItemDataBound="rp_Product_SAC_Master_ItemDataBound">
                    <ItemTemplate>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">
                                <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblServiceType" runat="server" Text='<%# Eval("ServiceTypeText") %>'></asp:Label>
                                <asp:HiddenField ID="hdnServiceType" runat="server" Value='<%# Eval("ServiceType") %>' />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSACCategory" runat="server" DataTextField="CodeDesc" DataValueField="CodeId" onchange="onSACCategorySelection_Change(this)"></asp:DropDownList>
                                <asp:HiddenField ID="hdnSACCategory" runat="server" Value='<%# Eval("SACCategory") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblSACCode" runat="server" Text='<%# Eval("SACCode") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblIsRCMApplicable" runat="server" Text='<%# Eval("IsRCMApplicable") %>'></asp:Label>
                                <asp:HiddenField ID="hdnIsRCMApplicable" runat="server" Value='<%# Eval("IsRCMApplicable") %>' />

                            </td>
                            <td align="right">
                                <asp:Label ID="lblGSTRate" runat="server" Text='<%# Eval("GSTRate") %>'></asp:Label>
                                <asp:HiddenField ID="hdnGSTRate" runat="server" Value='<%# Eval("GSTRate") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>
                <tr class="bgbluegrey">
                    <td colspan="6" align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return onBtnSubmit_Click();" />
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
                    <a href="GSTSacProductMapingMaster.aspx">Click here to update GST SAC Product Mapping details.</a>
                </td>
            </tr>
        </tbody>
    </table>
    <uc1:UserMessage runat="server" ID="msgBox" />
</asp:Content>

