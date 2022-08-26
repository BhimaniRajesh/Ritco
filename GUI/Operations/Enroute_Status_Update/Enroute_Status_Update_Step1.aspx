<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Enroute_Status_Update_Step1.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Step1" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script src="../../images/CalendarPopup.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <br />            
            <asp:Table ID="tblCriteria" runat="server" Width="8in" CellSpacing="1" CssClass="ftbl">
                <asp:TableRow CssClass="hrow">
                    <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Center"><font class="blackfnt"><b>Enroute Status Update</b></font></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="nrow">
                    <asp:TableCell Width="25%">
                                <font class="blackfnt">Select Reference Type</font>
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2">
                        <asp:DropDownList ID="ddlRefType" CssClass="blackfnt" runat="server" Width="150px">
                            <asp:ListItem Selected="True" Value="1">Docket Number</asp:ListItem>
                            <asp:ListItem Value="2">THC Number</asp:ListItem>
                            <asp:ListItem Value="3">Vehicle Number</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="nrow">
                    <asp:TableCell Width="25%">                                
                        <font class="blackfnt">Select Update Method</font>
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2">
                        <asp:DropDownList ID="ddlRefUpdateMethod" CssClass="blackfnt" runat="server" Width="150px">
                            <asp:ListItem Selected="True" Value="1">User Entry</asp:ListItem>
                            <asp:ListItem Value="2">Upload Via XLS</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="frow">
                    <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="Center">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" runat="server"
                            CssClass="nbtn" TabIndex="10" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <%--<pgb:ProgressBar ID="pgrone" runat="server" />--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
