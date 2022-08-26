<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DoneCrossingVendorContract.aspx.cs" Inherits="GUI_admin_CrossingVendorMaster_DoneCrossingVendorContract" %>


    <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("./ViewCrossingVendorContract.aspx?ContractID=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

    <br />
    <asp:Table ID="Table1" runat="server" BorderWidth="1" CssClass="boxbg" Width="9in"
        CellSpacing="1">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Center">
            Contract successfully Added
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
            Document Name
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
            Document Number
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
            
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell HorizontalAlign="Center" Font-Bold="true">
            Contract ID
            </asp:TableCell>
            <asp:TableCell HorizontalAlign="Center">
                <asp:Label ID="lblContractNo" runat="server" Text=""></asp:Label>
            </asp:TableCell>
            <asp:TableCell HorizontalAlign="Center">
           <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("ContractNo")%>',0)">View</a>
           <%-- <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',0)">View</a> |
           <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',1)">Print</a>--%>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Left">
           Your Next Step :
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" HorizontalAlign="Left">
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
            <a href="./vendorContract_Step1.aspx">Add More Vendor Contract</a>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" HorizontalAlign="Left">
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
           <a href="../../Operations/Crossing/CrossingDocketCriteria.aspx">Prepare Crossing Challan</a>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</asp:Content>

