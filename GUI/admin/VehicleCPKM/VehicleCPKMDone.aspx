<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VehicleCPKMDone.aspx.cs" Inherits="GUI_admin_VehicleCPKM_VehicleCPKMDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <table border="0"  cellpadding="0" cellspacing="0" style="width: 50%">
            <tr>
                <td height="30">
                    <font class="bluefnt">
                        <strong>Add/Remove Vehicle in CPKM Done</strong> </font>
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
        
        <asp:Table runat="server" ID="tblmain"  Width="50%" CellSpacing="1"
            CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3" Font-Bold="true">
                    <b>
                        <asp:Label ID="lblTitle" runat="server"></asp:Label></b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                   Choose the following Option</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnkBtnAddVehicle" CssClass="bluefnt" runat="server" Font-Bold="false"
                        PostBackUrl="~/GUI/admin/VehicleCPKM/AddVehicleInCPKM.aspx">Click Here to Add more Vehicle</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

