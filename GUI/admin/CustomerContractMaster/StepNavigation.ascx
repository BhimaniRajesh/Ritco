<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StepNavigation.ascx.cs"
    Inherits="GUI_admin_CustomerContractMaster_StepNavigation" %>

<script type="text/javascript" language="javascript">
    function NavigationClick(id) {

        if (!ValidateContractInformation())
            return false;
        
        var lnkNavigation = document.getElementById(id);
        var hdnFlagSave = document.getElementById("ctl00_MyCPH1_nvpMain_hdnFlagSave");
            
        if (confirm("Do you want to save Record ?"))
            hdnFlagSave.value = "Y";
        else
            hdnFlagSave.value = "N";

        return true;
    }
</script>
<asp:Panel runat="server" ID="panNavigation" Width="13in" HorizontalAlign="Left">

<table class="ftbl"  cellspacing="1">
    <tr class="hrow">
        <asp:Repeater ID="reptNavigation" OnItemDataBound="lnkNavigation_ItemDataBound" runat="server">
            <ItemTemplate>
                <td>
                    &nbsp;<asp:LinkButton ID="lnkNavigation" OnClick="lnkNavigation_Click" Font-Bold="true"
                        runat="server" CssClass="hfnt"></asp:LinkButton>
                    <asp:HiddenField ID="hdnServiceCode" runat="server" />
                    &nbsp;&nbsp;
                </td>
            </ItemTemplate>
        </asp:Repeater>
    </tr>
</table>
</asp:Panel>
<asp:HiddenField ID="hdnContractID" runat="server" />
<asp:HiddenField ID="hdnCustCode" runat="server" />
<asp:HiddenField ID="hdnFlagSave" runat="server" />
