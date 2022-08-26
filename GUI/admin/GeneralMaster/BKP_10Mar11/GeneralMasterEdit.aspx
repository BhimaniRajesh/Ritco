<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="GeneralMasterEdit.aspx.cs" Inherits="GUI_admin_GeneralMaster_GeneralMasterEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript">

    function confirmDel()
    {
    
        if(confirm("You Sure You want to Delete this Record ?"))
            return true;
        else 
            return false;
    }
</script>

<br /><br />



<div align="center" style="width:9.5in;">

<table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="90%">
        <tr class="bgbluegrey">
            <td class="blackfnt" colspan="4" align="center">
                <asp:Label ID="lblmasterheader" runat="server"><strong>Genral Master</strong></asp:Label>
            </td>
        </tr>
 </table>
        <br />

<asp:UpdatePanel id="upd1" runat="server">
    <ContentTemplate>
    <asp:Table ID="tblitemlist" runat="server" CssClass="boxbg" BorderWidth="0" CellSpacing="1" CellPadding="0" Width="90%">
        <asp:TableRow CssClass="bgbluegrey" runat="server">
            <asp:TableCell CssClass="blackfnt" runat="server">
                <asp:Label ID="lblheadcode" runat="server"></asp:Label>
            </asp:TableCell>
            <asp:TableCell CssClass="blackfnt" runat="server">
                <asp:Label ID="lblheaddesc" runat="server"></asp:Label>
            </asp:TableCell>
            <asp:TableCell CssClass="blackfnt" runat="server">Edit</asp:TableCell>
            <asp:TableCell ID="TableCell1" CssClass="blackfnt" runat="server">Delete</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    </ContentTemplate>
</asp:UpdatePanel>
</div>
<asp:HiddenField ID="hdnsubid" runat="server" />
</asp:Content>

