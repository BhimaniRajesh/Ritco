<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="StandardExpense_FixedRouteAll.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Standard Expense</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">

        <asp:Label ID="lblMsg" ForeColor="Red" runat="server" Text=""></asp:Label>

        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Standard Expense For Fixed Route</b> </font>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF" runat="server" id="trbuttons">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="60%">
                <font class="blackfnt">Select options</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteNew.aspx" />
                <font class="blackfnt">|</font>
               <%-- <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationEdit.aspx?IsRedirect=false" />--%>
                <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteSelectEdit.aspx" />
                <font class="blackfnt">|</font>
                <%--<asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationView.aspx" />--%>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteSelectView.aspx" />
            </td>
        </tr>


    </table>

</asp:Content>


