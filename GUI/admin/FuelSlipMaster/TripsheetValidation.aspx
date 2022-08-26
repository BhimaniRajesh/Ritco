<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TripsheetValidation.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_TripsheetValidation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tripsheet Validation</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">

        <asp:Label ID="lblMsg" ForeColor="Red" runat="server" Text=""></asp:Label>

            <tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <font class="blackfnt"><b>Tripsheet Validation</b> </font>
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
                    <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationAdd.aspx" />
                    <font class="blackfnt">|</font>
                    <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationEdit.aspx?IsRedirect=false" />
                    <font class="blackfnt">|</font>
                    <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationView.aspx" />
                </td>
            </tr>
     

    </table>

</asp:Content>


