<%@ Page Language="C#" AutoEventWireup="true" Trace="false" MasterPageFile="~/GUI/MasterPage.master" CodeFile="SuperSetCharge.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_DText" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cont1" runat="server">

<script language="javascript" type="text/javascript">

function openText(lblid,txtid,str)
{
    
  
    var s="ctl00_MyCPH1_" + txtid;
    s=s.toString();
    var txt=document.getElementById(s);
    var lbl=document.getElementById(lblid);
    var l=str.length;
    txt.value=str.substring(0,l-7);
    
 
    lbl.style.display='none';
    txt.style.display='block';
    
   return false;
}
 
</script>


<div align="center">
<br /><br />

    <asp:Table ID="Table1" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell>For Addition</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br /><br />

    <asp:Table ID="tbltextboxes" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">

    </asp:Table>
<br /><br />


    <asp:Table ID="Table2" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell>For Addition</asp:TableCell>
        </asp:TableRow>
    </asp:Table>
<br /><br />

    <asp:Table ID="tbltextboxes2" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">

    </asp:Table>
<br /><br />

    <asp:Table ID="Table3" runat="server" CellPadding="3" CellSpacing="1" CssClass="boxbg" Width="80%">
        <asp:TableRow BackColor="#ffffff">
            <asp:TableCell>
                <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit"  AccessKey="S" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>

</div>


</asp:Content>
