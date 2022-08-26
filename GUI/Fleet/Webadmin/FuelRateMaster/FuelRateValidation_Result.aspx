<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="FuelRateValidation_Result.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateValidation_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Submit for Validation</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">

                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Fuel Rate validated successfully" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color: White">
            <td align="center">
                <asp:HyperLink ID="hyper" NavigateUrl="FuelRateValidation.aspx" Text="Click here to validated another Fuel Rate" runat="server"></asp:HyperLink>
            </td>
        </tr>
    </table>
</asp:Content>
