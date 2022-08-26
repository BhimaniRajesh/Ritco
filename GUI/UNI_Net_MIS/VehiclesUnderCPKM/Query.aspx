<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_VehiclesUnderCPKM_Query" %>

<%@ Register TagName="DT" TagPrefix="DT" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPHHeader" runat="Server">
    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="./../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 7in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                    </strong><strong>Vehicles Under CPKM Report </strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue"></td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table id="selection" border="0" cellspacing="1" cellpadding="3" class="boxbg" width="700">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="left" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="blackfnt">Select Fleet Center</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlCenter" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">
                            <font class="blackfnt">Select Vendor</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlVendor" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">
                            <font class="blackfnt">Date Range</font>
                        </td>
                        <td align="left">
                            <DT:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">
                            <font class="blackfnt">Select Vehicle Status</font>
                        </td>
                        <td align="left">
                            <asp:RadioButtonList ID="rbVehicle" runat="server"  RepeatDirection="Horizontal">
                                <asp:ListItem Text="Current Vehicle" Value="0" Selected="true" />
                                <asp:ListItem Text="Removed Vehicle" Value="1" />
                            </asp:RadioButtonList>

                        </td>
                    </tr>
                    <tr align="center" class="bgbluegrey">
                        <td colspan="2">
                            <asp:Button ID="btnShow" runat="server" Text="Submit" OnClick="btnShow_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="testdiv1" name="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

