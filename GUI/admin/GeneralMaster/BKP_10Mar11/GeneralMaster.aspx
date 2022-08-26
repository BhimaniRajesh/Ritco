<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="GeneralMaster.aspx.cs" Inherits="GUI_admin_GenralMaster_GenralMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript">
function caps(id)
{
    var txt=document.getElementById(id);
    var val=txt.value;
    txt.value=val.toUpperCase();
}


</script>

<div align="center" style="width:9.5in;">
<br /><br />
<br /><br />
 
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:90%;">
        <tr class="bgbluegrey">
            <td class="blackfnt" colspan="4" align="center">
                <asp:Label ID="lblmasterheader" runat="server"><strong>Genral Master</strong></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff" id="trcode" runat="server" style="display:none;">
            <td class="blackfnt" width="15%" align="left">
                <asp:Label ID="lblcodedisc" runat="server"></asp:Label> : 
            </td>
            <td class="blackfnt" colspan="3" align="left">
                <asp:Label CssClass="bluefnt" Font-Bold="true" ID="lblautocode" runat="server"></asp:Label>
                <asp:Label ID="lblmisc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff" id="trprimary" runat="server">
            <td class="blackfnt" align="left">
                <asp:Label ID="lblprimarytext" runat="server"></asp:Label> : 
            </td>
            <td class="blackfnt" align="left" colspan="3">
                <asp:TextBox ID="txtprimary" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="center" colspan="4">
                <asp:Button ID="btnone" OnClick="btnone_Click" runat="server" Text="Submit" />
                <asp:Button ID="btntwo" OnClick="btntwo_Click" runat="server" Text="GoTo Listing" />
            </td>
        </tr>

    </table>

</div>

</asp:Content>
