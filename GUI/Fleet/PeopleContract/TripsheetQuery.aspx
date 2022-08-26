<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TripsheetQuery.aspx.cs" Inherits="TripsheetQuery" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <script language="javascript">

        function ViewPrint(mOrderNo, tPrintMode) {
            var strurl = "ViewPrintPrepareJob.aspx?ONo=" + mOrderNo + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "pbr", "menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
        }


    </script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">View/Print Tripsheet >> Query</asp:Label>
            </td>
            <td align="right">
               
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <%-- 
 <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  --%>
    <div align="left">
        <table cellspacing="1" width="800px" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="2" align="center" style="height: 21px; width: 30%">
                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" Text="Search Criteria"
                        runat="server"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td width="30%">
                    <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Text="Enter Tripsheet No.:"
                        Font-Bold="True"></asp:Label>
                </td>
                <td width="70%">
                    <asp:TextBox CssClass="input" ID="txtTripsheetNo" runat="Server" ValidationGroup="VGRequestID"
                        BorderStyle="Groove"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_txtTripsheetNo" runat="server" ControlToValidate="txtTripsheetNo"
                        ErrorMessage="*" ValidationGroup="VGRequestID" />
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID"
                                OnClick="btnShowMultipleRequest_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" colspan="2">
                    <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Text="OR" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td width="30%">
                    <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True" Text="Tripsheet Date Range:"></asp:Label>
                </td>
                <td width="70%">
                    <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo"
                                OnClick="btnShowMultipleRequest_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="2">
                    <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnShowSingleRequest" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
