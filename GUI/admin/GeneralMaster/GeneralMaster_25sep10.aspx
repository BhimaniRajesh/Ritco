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
    <table border="0" cellpadding="3" cellspacing="1" class="stbl" style="width:90%;">
        <tr class="hrow">
            <td colspan="4" align="center">
                <asp:Label ID="lblmasterheader" runat="server"><strong>Genral Master</strong></asp:Label>
            </td>
        </tr>
        <tr class="nrow"  id="trcode" runat="server" style="display:none;">
            <td width="15%" align="left">
                <asp:Label ID="lblcodedisc" runat="server"></asp:Label> : 
            </td>
            <td class="blackfnt" colspan="3" align="left">
                <asp:Label CssClass="bluefnt" Font-Bold="true" ID="lblautocode" runat="server"></asp:Label>
                <asp:Label ID="lblmisc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="nrow" id="trprimary" runat="server">
            <td align="left">
                <asp:Label ID="lblprimarytext" runat="server"></asp:Label> : 
            </td>
            <td class="blackfnt" align="left" colspan="3">
                <asp:TextBox ID="txtprimary" BorderStyle="Groove" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="frow">
            <td align="center" colspan="4">
                <asp:Button ID="btnone" OnClick="btnone_Click" CssClass="fbtn" runat="server" Text="Submit" />
                <asp:Button ID="btntwo" OnClick="btntwo_Click" CssClass="fbtn" runat="server" Text="GoTo Listing" />
            </td>
        </tr>

    </table>

</div>

</asp:Content>