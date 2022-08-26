<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyreInterchangeReport_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript" src="./../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="./../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function OnSub_DATACHECK() {
            var cboRO = document.getElementById("ctl00_MyCPH1_Fromlc_cboRO");
            var cboLO = document.getElementById("ctl00_MyCPH1_Fromlc_cboLO");
            var txtDateFrom = document.getElementById("ctl00_MyCPH1_dtFromTo_txtDateFrom");
            var txtDateTo = document.getElementById("ctl00_MyCPH1_dtFromTo_txtDateTo");        
            var txtDocNo = document.getElementById("ctl00_MyCPH1_txtDocNo");

            window.open("Result.aspx?FromDate=" + txtDateFrom.value + "&ToDate=" + txtDateTo.value + "&TyreNo=" + txtDocNo.value + "&RO=" + cboRO.value + "&LO=" + cboLO.value + "");

            return false;
        }
    </script>
    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">              
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>             
                <font class="bluefnt"><strong>Tyre Interchange Report</strong></font>&nbsp;
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1">
            </td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10">
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top">
                                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Date :"
                                    Width="102px"></asp:Label>
                            </td>
                            <td valign="top">
                                <uc1:RPT_Date ID="dtFromTo" runat="server" />
                            </td>
                        </tr>                     
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Tyre No. :"></asp:Label>
                            </td>
                            <td align="left">                             
                                <asp:TextBox ID="txtDocNo" runat="server" Width="200px"></asp:TextBox>&nbsp;<label
                                    class="blackfnt">[ Enter coma (,) separated if multiple]</label>                            
                                <%--<ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                    EnableCaching="true" BehaviorID="AutoCompleteEx" ServiceMethod="AutoVhNo" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../../../services/WebService.asmx"
                                    TargetControlID="txtDocNo">
                                </ajaxToolkit:AutoCompleteExtender>--%>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow2" runat="server" Text="Show" Width="75px" OnClientClick="Javascript: return OnSub_DATACHECK();" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
