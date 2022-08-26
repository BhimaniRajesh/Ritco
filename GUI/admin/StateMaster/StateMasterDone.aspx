<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StateMasterDone.aspx.cs"
    MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_Admin_StateMasterDone"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript">
        function popupView()
        {          
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
            window.open("StateMasterView.aspx?state=<%=stateCode %>&print=N","", winOpts);
            return false;
        }         
        function popupPrint()
        {
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
            window.open("StateMasterView.aspx?state=<%=stateCode %>&print=Y","", winOpts);
            return false;
        }
    </script>
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <br />
        <br />
        <asp:Table runat="server" ID="tblmain" HorizontalAlign="center" Width="99%" CellSpacing="1"
            CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3" Font-Bold="true">
                    <asp:Label ID="lblTitle" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    State Name</asp:TableCell>
                <asp:TableCell HorizontalAlign="center">                   
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblStateName" CssClass="bluefnt" Font-Bold="true" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="lnkBtnAddVehicleView" OnClientClick="javascript:return popupView()"
                        CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" />
                    |
                    <asp:LinkButton ID="lnkBtnAddVehiclePrint" OnClientClick="javascript:return popupPrint()"
                        CssClass="bluefnt" runat="server" Font-Bold="false" Text="Print" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <b>Choose the following option</b></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lnkBtnAddVehicle" CssClass="bluefnt" runat="server" Font-Bold="false"
                        PostBackUrl="~/GUI/admin/StateMaster/StateMaster.aspx?Flag=Add">Click here to enter more State</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                        OnClick="lnkBtnEditVehicle_Click">Click here to edit more State</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
           
        </asp:Table>
    </asp:Panel>
</asp:Content>

