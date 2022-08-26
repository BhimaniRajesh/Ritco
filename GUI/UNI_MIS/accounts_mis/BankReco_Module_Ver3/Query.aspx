<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetail.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script language="JavaScript" type="text/javascript">

        function Check_Submit_Data() 
        {
            if (document.getElementById('ctl00$MyCPH1$Fromlc$DDL_BankList').value == "") {
                alert("Plz Select Bank")
                document.getElementById('ctl00$MyCPH1$Fromlc$DDL_BankList').focus();
                return false;
            }
            if (document.getElementById('ctl00_MyCPH1_DT_radDate_0').checked) {
                if (document.getElementById('ctl00$MyCPH1$DT$txtDateFrom').value == "") {
                    alert("Plz Enter From date")
                    document.getElementById('ctl00$MyCPH1$DT$txtDateFrom').focus();
                    return false;
                }
                if (document.getElementById('ctl00$MyCPH1$DT$txtDateTo').value == "") {
                    alert("Plz Enter To date")
                    document.getElementById('ctl00$MyCPH1$DT$txtDateTo').focus();
                    return false;
                }
            }
        }
        function nwOpen(mNo) {

            window.open("../setting_cust_opn_bal/popupbranch.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Bank Reconcilation Module</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" />
                </td>
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
                                                <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
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
                                <font class="blackfnt"><b>Select Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Transaction Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center" colspan="4">
                                <asp:RadioButtonList ID="dlstTranType" runat="server" RepeatDirection="Horizontal"
                                    Width="321px" CssClass="blackfnt" Font-Bold="True">
                                    <asp:ListItem Selected="True" Value="A">All</asp:ListItem>
                                    <asp:ListItem Value="R">Reconciled</asp:ListItem>
                                    <asp:ListItem Value="NR">Not Reconciled</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
