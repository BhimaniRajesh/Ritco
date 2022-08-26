<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExecutionServiceQuery.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_UNI_Net_MIS_ExecutionService_ExecutionServiceQuery" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="DTP" TagPrefix="DateP" Src="~/GUI/Common_UserControls/DatePicker.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<script language="JavaScript" src="./../../Js/CalendarPopup.js"></script>
    <script language="javascript" src="./../../Js/commonJs.js"></script>
    <script language="javascript" src="../../Js/moment.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function ViewReport() {
            var FromDate = moment(document.getElementById('<%=DT.ClientID%>_txtDateFrom').value, "DD/MM/YYYY").format('DD MMM YYYY');
            var Todate = moment(document.getElementById('<%=DT.ClientID%>_txtDateTo').value, "DD/MM/YYYY").format('DD MMM YYYY');
            var txtIndentNo = document.getElementById('<%=txtIndentNo.ClientID%>');
            var ExDate = document.getElementById('<%=DTP.ClientID%>_txtDtBox');
            if (ExDate.value != "") {
                var ExecutionDate = moment(document.getElementById('<%=DTP.ClientID%>_txtDtBox').value, "DD/MM/YYYY").format('DD MMM YYYY');
            }
            else
            {
                var ExecutionDate = "";
            }
            var queryString = "?FromDate=" + FromDate + "&ToDate=" + Todate + "&IndentNo=" + txtIndentNo.value + "&ExecutionDate=" + ExecutionDate;
            var url = "ExecutionServiceResult.aspx" + queryString;
            window.open(url, "pbr", "letf=0,top=05,width=1500,height=600,toolbar=0,scrollbars=0,status=0,dir=ltr");
            return false;
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;</strong>
                        <strong>Execution Service Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Execution Service Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Date Range</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" EnableTillDate="true" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter Indent Number</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtIndentNo" runat="server">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Enter Execution Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <DateP:DTP ID="DTP" runat="server" ImageUrl="../../Images/calendar.jpg" />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClientClick="return ViewReport();"
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
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

