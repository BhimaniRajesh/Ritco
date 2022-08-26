<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MultiCheckCombo.ascx.cs" Inherits="GUI_Common_UserControls_MultiCheckCombo" %>
<script type="text/javascript">
    //Script para incluir en el ComboBox1 cada item chekeado del chkListMateriales

    function CheckALLItem(checkBox) {
        //ctl00_MyCPH1_MultichkRoute_MultiSelection_ctl00_chkItem
        //ctl00_MyCPH1_MultiChkFTLType_MultiSelection
        //ctl00_MyCPH1_MultiChkFTLType_txtCombo
        var checkBoxid = checkBox.id;
        var setcheckBoxid = checkBoxid.split("_chkALL");

        var MultiSelectionID = setcheckBoxid[0];
        var sMultiSelectionID = MultiSelectionID.split("_MultiSelection");
        var MultiSelectionRows = document.getElementById(sMultiSelectionID[0] + "_MultiSelectionRows").value;
        var s = "", v = "";
        for (var i = 0; i < parseInt(MultiSelectionRows) ; i++) {
            var innerID = MultiSelectionID;
            if (i < 10) innerID = innerID + "_ctl0" + i; else innerID = innerID + "_ctl" + i;
            // var chkItem = document.getElementById(MultiSelectionID + "_chkItem_" + i);
            //  var lblText = document.getElementById(MultiSelectionID + "_lblText_" + i);
            var chkItem = document.getElementById(innerID + "_chkItem");
            var lblText = document.getElementById(innerID + "_lblText");
            chkItem.checked = checkBox.checked;
            if (chkItem.checked) {
                s = (s == "") ? lblText.innerHTML : s + "," + lblText.innerHTML;
                v = (v == "") ? chkItem.value : v + "," + chkItem.value;
            }
        }
        var ls = sMultiSelectionID[0].split("_MultiSelection");
        var TxtBox = document.getElementById(ls[0] + '_txtCombo');
        TxtBox.value = s;
        document.getElementById(ls[0] + '_hidSelectedText').value = s;
        document.getElementById(ls[0] + '_hidSelectedValue').value = v;
    }

    function CheckItem(checkBox) {
        var checkBoxid = checkBox.id;
        var setcheckBoxid = checkBoxid.split("_ct");

        var MultiSelectionID = setcheckBoxid[0];
        <%--var MultiSelectionID = "<%=MultiSelection.ClientID %>";ctl00_MyCPH1_MultiChkFTLType_MultiSelectionRows--%>
        var sMultiSelectionID = MultiSelectionID.split("_MultiSelection");
        var MultiSelectionRows = document.getElementById(sMultiSelectionID[0] + "_MultiSelectionRows").value;
        var MultiSelection_chkALL = document.getElementById(sMultiSelectionID[0] + "_MultiSelection_chkALL");
        var s = "", v = "";
        var count = 0;

        for (var i = 0; i < parseInt(MultiSelectionRows) ; i++) {
            var innerID = MultiSelectionID;
            if (i < 10) innerID = innerID + "_ctl0" + i; else innerID = innerID + "_ctl" + i;

            // var chkItem = document.getElementById(MultiSelectionID + "_chkItem_" + i);
            // var lblText = document.getElementById(MultiSelectionID + "_lblText_" + i);

            var chkItem = document.getElementById(innerID + "_chkItem");
            var lblText = document.getElementById(innerID + "_lblText");

            if (chkItem.checked) {
                s = (s == "") ? lblText.innerHTML : s + "," + lblText.innerHTML;
                //s = s + ", " + lblText.innerHTML;
                v = (v == "") ? chkItem.value : v + "," + chkItem.value;
                count++;
            }
        }
        if (count == parseInt(MultiSelectionRows)) {
            MultiSelection_chkALL.checked = true;
        }
        else {
            MultiSelection_chkALL.checked = false;
        }
        var ls = sMultiSelectionID[0].split("_MultiSelection");
        var TxtBox = document.getElementById(ls[0] + '_txtCombo');
        TxtBox.value = s;
        document.getElementById(ls[0] + '_hidSelectedText').value = s;
        document.getElementById(ls[0] + '_hidSelectedValue').value = v;
    }

    function MigrateFocus() {
        document.getElementById("<%=txtCombo.ClientID%>").focus();
    }
</script>
<div>
    <asp:Panel ID="ddlMultiSelection" runat="server">
        <div>
            <asp:TextBox ID="txtCombo" runat="server" ReadOnly="true" CssClass="input-xxlarge"></asp:TextBox>
        </div>
        <div>
            <asp:TextBox ID="TextBox1" runat="server" ReadOnly="true" CssClass="input-xxlarge"
                onfocus="MigrateFocus();" Style="border-left: 0px" Visible="false"></asp:TextBox>
        </div>
    </asp:Panel>
    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender111" runat="server" TargetControlID="ddlMultiSelection"
        PopupControlID="Panel111" Position="Bottom">
    </ajaxToolkit:PopupControlExtender>
    <input type="hidden" name="hidSelectedText" id="hidSelectedText" runat="server" />
    <input type="hidden" name="hidSelectedText" id="hidSelectedValue" runat="server" />
    <asp:Panel ID="Panel111" runat="server" ScrollBars="None" CssClass="multi_check">
        <asp:Panel ID="InnerPanel" runat="server" ScrollBars="Vertical" CssClass="multi_check">
            <table>
                <tr id="InnerPanelALL" runat="server">
                    <td>
                        <input type="checkbox" id="MultiSelection_chkALL" runat="server" value="<%# Eval(DataValueField) %>"
                            onclick="CheckALLItem(this)" />
                    </td>
                    <td>
                        <asp:Label ID="lblAllText" runat="server" Text="--Select All--" />
                        <asp:HiddenField ID="MultiSelectionRows" runat="server" Value="0" />
                    </td>
                </tr>
            </table>
            <table>
                <asp:Repeater ID="MultiSelection" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <input type="checkbox" id="chkItem" runat="server" value="<%# Eval(DataValueField) %>"
                                    onclick="CheckItem(this)" />
                            </td>
                            <td>
                                <asp:Label ID="lblText" runat="server" Text='<%# Eval(DataTextField) %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </asp:Panel>
    </asp:Panel>
</div>
