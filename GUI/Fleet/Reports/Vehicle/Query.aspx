<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_Trip_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../Js/AssignValue.js"></script>
    <script src="../../../Js/JScript.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function ShowHide() {
            PanelShowHide('ctl00_MyCPH1_pnlFilter');
            return false;
        }

        function OnSub_DATACHECK() {

            var cboRo = document.getElementById("ctl00$MyCPH1$Fromlc$cboRo");
            var cboLo = document.getElementById("ctl00$MyCPH1$Fromlc$cboLo");
            var txtDateFrom = document.getElementById("ctl00_MyCPH1_dtBookingDate_txtDateFrom");
            var txtDateTo = document.getElementById("ctl00_MyCPH1_dtBookingDate_txtDateTo");
            //var txtCust = document.getElementById("ctl00_MyCPH1_txtCust");
var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId");
            /*  function validate() {
            // var txtCust = document.getElementById("ctl00_MyCPH1_txtCust");
            if (document.getElementById("ctl00_MyCPH1_txtCust").value =="") 
            {
            alert("enter a route");
                   
            }

            }*/
            window.open("Result.aspx?region=" + cboRo.value + "&location=" + cboLo.value + "&fromdate=" + txtDateFrom.value + "&todate=" + txtDateTo.value + "&hdnRptId=" + hdnRptId.value + "");
        }

        var cal = new CalendarPopup("testdiv1");
        cal.SetCssPrefix("TEST");
        cal.ShowNavigationDropdown();
    </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: White;
        z-index: 99;">
   </div>
 <input type="hidden" id="hdnRptId" runat="server" />
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
                                <Location:LH ID="Fromlc" runat="server" />
                            </asp:TableCell></asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell> Select Date </asp:TableCell><asp:TableCell>
                               <uc2:RPT_Date ID="dtBookingDate" runat="server" />
                            </asp:TableCell></asp:TableRow>
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
                            <asp:Button ID="btnSubmit" OnClientClick="return OnSub_DATACHECK();" runat="server"
                                Text="Submit" />
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
         document.getElementById('ctl00_MyCPH1_dtBookingDate_radDate_3').checked = true;
         document.getElementById('ctl00_MyCPH1_dtBookingDate_txtDateFrom').value = "01/01/1950";
  </script>
</asp:Content>
