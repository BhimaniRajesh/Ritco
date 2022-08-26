<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Vehicle_Movement_Report_Query" %>

<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="webxcomplete"
    TagPrefix="xac" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();             
        
    </script>

    <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>
   <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <div align="left">
                <table>
                    <tr>
                        <td>
                            <table style="width: 8in" border="0" align="left" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="left" colspan="3">
                                        <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                                            class="blklnkund"><strong>Enroute Status Update</strong></font><strong> &gt;
                                        </strong><font class="bluefnt"><strong>Vehicle Movement Report</strong></font>
                                        <hr align="center" size="1" color="#8ba0e5">
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="1" style="width: 8in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td colspan="7" align="center" class="hrow">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Selection Criteria </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Select Date &nbsp;</font>&nbsp;
                                    </td>
                                    <td align="left" colspan="3">
                                        <Date:DT ID="DT" runat="server" />
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Vendor</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox ID="txtPLPartner" runat="server" MaxLength="10" Width="100px" CssClass="ltxtm"
                                            TabIndex="3" autocomplete="off"></asp:TextBox>-<asp:TextBox ID="txtPLPartnernm" Width="250px"
                                                CssClass="ltxtm" runat="server" Enabled="false"></asp:TextBox><br />
                                        <xac:webxcomplete ID="xacPLPartner" runat="server" CodeTarget="txtPLPartner" MinPrefixLength="2"
                                            NameTarget="txtPLPartnernm" FilterString="03" WebxEntity="Vendor" />
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Vehicle ownership location</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox ID="txtVehLoc" runat="server" CssClass="ltxtm" TabIndex="2" Width="180px"
                                            autocomplete="off"></asp:TextBox><br />
                                        <xac:webxcomplete ID="xacVehLoc" runat="server" CodeTarget="txtVehLoc" MinPrefixLength="2"
                                            WebxEntity="BranchCode" />
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Vehicle number</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="ltxtm" TabIndex="2" Width="180px"
                                            autocomplete="off"></asp:TextBox><br />
                                        <xac:webxcomplete ID="xacVehicleNo" runat="server" CodeTarget="txtVehicleNo" MinPrefixLength="2"
                                            WebxEntity="Vehicle" />
                                    </td>
                                </tr>
                                <tr align="center" class="bgbluegrey">
                                    <td colspan="7">
                                        <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Submit" Width="75px"
                                            CssClass="fbtn" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
