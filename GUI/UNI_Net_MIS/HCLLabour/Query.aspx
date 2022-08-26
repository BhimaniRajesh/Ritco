<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_HCLLabour_Query" %>

<%@ Register TagPrefix="UserControl" TagName="DateRange" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
          </script>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <div style="width: 800px;">
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
            <tr class="hrow">
                <td colspan="2" align="center">
                    <b>HCL Report</b>
                </td>
            </tr>
            <tr class="nrow" id="trDate">
                <td><b>Select Date Range</b></td>
                <td align="left">
                    <%--<UserControl:DateRange ID="dtBookingDate" runat="server" />--%>
                     <Date:DT ID="dtBookingDate" runat="server" />
                </td>
            </tr>
             <tr class="nrow">
              <td><b>Status</b></td>
                <td align="left">
                    <asp:DropDownList id="ddStatus" runat="server">
                        <asp:ListItem Value="ALL" Selected="True">--ALL--</asp:ListItem>
                        <asp:ListItem Value="PendingApproval">Pending For Approval</asp:ListItem>
                        <asp:ListItem Value="Paid">Paid</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="nrow" >
                <td colspan="2"  align="center">Or</td>
            </tr>
            <tr class="nrow">
              <td><b>Bill Number</b></td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtBillNo"></asp:TextBox>
                </td>
            </tr>

            <tr class="hrow" id="trSubmit">
                <td align="center" colspan="3">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
</asp:Content>

