<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_Tripsheet_pending_milkrun_Query" %>
<%@ Register TagName="LOC" TagPrefix="LOC" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/DateControl2.ascx" TagName="RPT_Date" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script src="../../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script src="../../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
    <script src="../../../Js/JScript.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function ShowHide() {
            PanelShowHide('ctl00_MyCPH1_pnlFilter');
            return false;
        }
         </script>
                    <input type="hidden" id="hdnRptId" runat="server" />
                     <table style="width: 100%;">
        <tr>
            <td>
                <asp:Table ID="Table3" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                    HorizontalAlign="Left" Width="970px">
                    <asp:TableHeaderRow CssClass="bgbluegrey">
                        <asp:TableHeaderCell>
                           Tripsheet pending for Trip Billing (Milkrun)
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                </asp:Table>
            </td>
        </tr>
        </table>
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Table ID="Table2" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                    HorizontalAlign="Left" Width="970px">
                    <asp:TableHeaderRow CssClass="bgbluegrey">
                        <asp:TableHeaderCell>
                            Advance Filter
                            <asp:Button ID="btnShowHide" OnClientClick="return ShowHide()" runat="server" Text="Show/Hide"
                                CssClass="hbtn" />
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                </asp:Table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlFilter" runat="server">
                    <asp:Table ID="tblMain" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                        HorizontalAlign="Left" Width="970px">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell ColumnSpan="2">
                                <%--   <uc1:LocationHirarchy ID="LH" runat="server" />--%>
                                <LOC:LOC ID="LOC" runat="server" />
                            </asp:TableCell></asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
                                Select Arrival Date
                            </asp:TableCell>
                            <asp:TableCell>
                                <uc2:RPT_Date ID="dtDate" runat="server" />
                            </asp:TableCell>
                            </asp:TableRow>
                        
                    </asp:Table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Table ID="Table1" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                    HorizontalAlign="Left" Width="970px">
                    <asp:TableHeaderRow CssClass="bgbluegrey">
                        <asp:TableHeaderCell ColumnSpan="1">
                            <asp:Button ID="btnSubmit" runat="server"  OnClick="btnShow_Click" Text="Submit" /><%--OnClientClick="return newPopupWindow();"--%>
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var pnl = document.getElementById("ctl00_MyCPH1_pnlFilter");
        pnl.style.display = "none";
        pnl.style.visibility = "hidden";
        document.getElementById('ctl00_MyCPH1_dtDate_radDate_3').checked = true;
        document.getElementById('ctl00_MyCPH1_dtDate_txtDateFrom').value = "01/01/2012";
    </script>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>

</asp:Content>

