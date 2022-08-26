<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TripRouteExpDone.aspx.cs" Inherits="TyrePatternSearch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633;
                text-align: left;">
                <br />
                Fuel Rate Master<br />
                <br />
                <hr />
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
                <table cellspacing="0" width="900">
                    <tr style="background-color: white">
                        <td align="right" colspan="3" style="text-align: left" class="boxbg">
                            <table cellspacing="1" style="width: 100%">
                                <tr style="background-color: white">
                                    <td align="left" style="width: 222px; height: 26px" colspan="2">
                                        <asp:Label ID="Label3" runat="server" Text="Record Inserted/Updated Successfully "></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="height: 26px">
                                        <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Add/Edit More Records"
                                            CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/FuelRateMaster/FuelRateMasterEntry.aspx?Flag=Add"
                                            ValidationGroup="VGCreate"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
