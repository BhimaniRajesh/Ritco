<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DoneVendorContract.aspx.cs" Inherits="GUI_admin_Vendor_Contract_Done" %>


    <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
            
        }
        function OpenPopupWindow(contractID)
        {
            //debugger            
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270";
            var strPopupURL = "./ContractView.aspx?ContractID=" + contractID;
            winNew = window.open(strPopupURL, "_blank", strWinFeature);
            return false;
        }

    </script>

    <br />
    <asp:Table ID="Table1" runat="server" BorderWidth="1" CssClass="boxbg" Width="9in"
        CellSpacing="1">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Center">
            Contract Successfully Saved
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center" Width="130">
            Document Name
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
            Document Number
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
            
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" Width="130">
            Contract ID
            </asp:TableCell>
            <asp:TableCell HorizontalAlign="Center">
                <asp:Label ID="lblContractNo" runat="server" Text=""></asp:Label>
            </asp:TableCell>
            <asp:TableCell HorizontalAlign="Center">
            <a href="#" onclick="Javascript:OpenPopupWindow('<%=Request.QueryString.Get("ContractNo")%>'); return false;">View</a>
            <%--<a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',0)">View</a> |
            <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',1)">Print</a>--%>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Left">
           Your Next Step :
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" HorizontalAlign="Left" Width="130">
            </asp:TableCell>
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
            <a href="vendorContract_Step1.aspx">Add More Vendor Contract</a>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</asp:Content>

