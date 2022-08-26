<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Secondary_Contract_Result.aspx.cs" Inherits="Secondary_Contract_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  <script type="text/javascript" language="javascript" src="../../Js/querystring.js" ></script>  
<script language="javascript">


    function ViewPrint(tPrintMode) {
        var qs = new Querystring()
        var strurl = "Secondary_Contract_View.aspx?Contract_Code=" + qs.get("Contract_Code") + "&PrintMode=" + tPrintMode
        popup = window.open(strurl, "pbr", "menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
    }
 
</script>
   
   <asp:Panel ID="Panel1" runat="server" Width="10in">
        <br />
        <asp:Table ID="Table1" CssClass="ftbl" runat="server" CellSpacing="1">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="3" Font-Bold="true">Contract Successfully Updated</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    Contract ID</asp:TableCell>
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    <asp:Label ID="lbl_customername" runat="server" CssClass="nfnt"></asp:Label> </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcontractid" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcustcode" runat="server" CssClass="nfnt"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblview" runat="server" onmouseover="this.style.cursor='pointer'"
                        Text="View" CssClass="nfnt" Font-Underline="true"></asp:Label>
                        <asp:LinkButton ID="lnkview" runat="server" CssClass="nfnt"></asp:LinkButton>
                        
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="left">
                    Your Next Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnklist" runat="server" Text="Update Same Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnklist_Click" CssClass="nfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnkcontract" runat="server" Text="Update Other Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcontract_Click" CssClass="nfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                       <asp:LinkButton ID="lnkcustomer" runat="server" Text="Update Other Customer" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcustomer_Click" CssClass="nfnt"></asp:LinkButton> 
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:HiddenField ID="hdnflagcstvnd" runat="server" />
</asp:Content>
