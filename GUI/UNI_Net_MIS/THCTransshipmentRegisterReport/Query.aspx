<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_THCTransshipmentRegisterReport_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function OnSub_DATACHECK() {
            if (!DateCheck())
                return false;
        }

    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong> THC</strong></font><font class="bluefnt"><strong>&gt;
                            &gt; </strong><strong>THC Transshipment Register Report</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>

        <tr>
            <td height="300" valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select THC Transshipment Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Branch :</font>
                            </td>
                            <td align="left" colspan="3">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Date Range :</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Status :</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Approval" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Consider As Normal" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="center">Select ThcNo
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox CssClass="ltxt" runat="server" ID="txtTHCNo"  />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>
</asp:Content>
