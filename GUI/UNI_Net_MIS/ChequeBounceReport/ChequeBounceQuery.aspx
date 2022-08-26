<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChequeBounceQuery.aspx.cs" Inherits="GUI_UNI_Net_MIS_ChequeBounceReport_ChequeBounceQuery" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetailAll.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        //function ValidateOnSubmit() {
        //    var BankName = $("#ctl00_MyCPH1_Fromlc_DDL_BankList");
        //    if (BankName.val() == "") {
        //        alert('Please select Bank Name');
        //        return false;
        //    }
        //}
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Banking Operation </strong></font>
                    <font class="bluefnt"><strong>&gt;
                    </strong><strong>Cheque Bounce Register</strong> </font></td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell>
                                                <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" />
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>

                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>

                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" width="800" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select   Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt">ChequeBounce Date</font>
                            </td>
                            <td>
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>


                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click" OnClientClick="javascript : return ValidateOnSubmit();"/>

                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>

