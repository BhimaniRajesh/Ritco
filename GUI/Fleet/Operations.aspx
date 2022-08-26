<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Operations.aspx.cs" Inherits="GUI_Fleet_Operations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Operations</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Fleet Operations</b> </font>
            </td>
        </tr>


        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width=8%>
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vehicle Request</font>
            </td>

            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="New" PostBackUrl="~/GUI/Fleet/Operations/Request/frmNewRequest.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View/Print" PostBackUrl="~/GUI/Fleet/Operations/Request/frmViewPrintRequestQuery.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vehicle Request Approval/Allocation </font>
            </td>

            <td align="center">
            <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Approve/Reject" PostBackUrl="~/GUI/Fleet/Operations/Request/frmRequestApprovalQuery.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Trip Sheet</font>
            </td>

            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="New" PostBackUrl="~/GUI/Fleet/Operations/Issue/frmVehicleIssueSlip.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Close" PostBackUrl="~/GUI/Fleet/Operations/Issue/frmCloseVehicleIssueSlipQuery.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View/Print" PostBackUrl="~/GUI/Fleet/Operations/Issue/frmViewPrintVehicleIssueSlipQuery.aspx" />

            </td>
        </tr>

        

                 

    </table>
</asp:Content>