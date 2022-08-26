<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PODTHCVehicleViewQuery.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_PODTHCVehicleViewQuery" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Fleet </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>View & Print </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>THC Details Of Owned Vehicle</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="1" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top" width="104">
                                <asp:Label ID="Label4" CssClass="blackfnt" Text="Select THC Type" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlSelection" runat="server">
                                    <asp:ListItem Text="All" Value="" />
                                    <asp:ListItem Text="Internal THC Details" Value="I" />
                                    <asp:ListItem Text="External THC Details" Value="E" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top" width="104">
                                <asp:Label ID="lblVehicle" CssClass="blackfnt" Text="Select Vehicle" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlVehicleNo" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Branch" runat="server"
                                    Width="145px"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlro" runat="server" Width="261px" CssClass="input">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top" width="104">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td valign="top" align="left">
                                <asp:Label ID="lblStatut" CssClass="blackfnt" Text="Select Status" runat="server"
                                    Width="145px"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="input">
                                    <asp:ListItem Value="P">Pending for Upload</asp:ListItem>
                                    <asp:ListItem Value="U">Uploaded POD</asp:ListItem>
                                    <asp:ListItem Value="">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
