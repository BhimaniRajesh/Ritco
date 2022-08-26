<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Done.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillGeneration_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 50%">
            <tr>
                <td height="30">
                    <font class="bluefnt">
                        <strong>Credit KMS For CPKM Approved or Rejected</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
            </tr>

        </table>

        <asp:Table runat="server" ID="tblmain" Width="90%" CellSpacing="1"
            CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="6" Font-Bold="true">
                    <b>
                        <asp:Label ID="lblTitle" runat="server"></asp:Label></b>
                </asp:TableCell>
            </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="6">
                   Choose the following Option</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="6">
                    <asp:LinkButton ID="lnkBtnAddVehicle" CssClass="bluefnt" runat="server" Font-Bold="false"
                        PostBackUrl="ApprovalCriteria.aspx">Click Here to Approved/Reject.</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

