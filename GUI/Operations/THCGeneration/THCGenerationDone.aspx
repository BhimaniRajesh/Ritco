<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCGenerationDone.aspx.cs" Inherits="GUI_Operations_THCGeneration_THCGenerationDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        
        function OpenInWindow(windURL, h, w, l, t)
        {
		    var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
		    
		    window.open(windURL, "_blank", winOpts);
	    }
        
    </script>
    
    <asp:Panel ID="Panel1" HorizontalAlign="Left" runat="server">
        <asp:Table ID="Table1" runat="server" CssClass="stbl" CellSpacing="1" Width="650">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="4">
                    <asp:Label runat="server" ID="lblHeader" Font-Bold="true" CssClass="hfnt" ></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
             <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center" >
                    <asp:Label runat="server" ID="lblDocnoCP" Font-Bold="true"  CssClass="nfnt" Text="Document Name" ></asp:Label>
                </asp:TableCell >
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblSysNoCP" Font-Bold="true"    CssClass="nfnt" Text="System Number" ></asp:Label>
                </asp:TableCell>
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblManualNoCP" Font-Bold="true"   CssClass="nfnt" Text="Manual Number"></asp:Label>
                </asp:TableCell>
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblViewPrint" Font-Bold="true"   CssClass="nfnt" Text="View & Print"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
             <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblDocno"  CssClass="nfnt"  ></asp:Label>
                </asp:TableCell>
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblSysNo"  CssClass="nfnt"  ></asp:Label>
                </asp:TableCell>
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblManualNo"  CssClass="nfnt" ></asp:Label>
                </asp:TableCell>
                  <asp:TableCell HorizontalAlign="Center">
                    <asp:Label runat="server" ID="lblviewPrintLink"  CssClass="nfnt" Text="View & Print"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
