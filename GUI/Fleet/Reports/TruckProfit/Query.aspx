<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TruckProfit_Query" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="../../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">

        function OnSub_DATACHECK() {

            var txtDateFrom = document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
            var txtDateTo = document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
            var txtVehicleNo = document.getElementById("ctl00_MyCPH1_txtVehicleNo");

            var cboRO = document.getElementById("ctl00$MyCPH1$Fromlc$cboRO");
            var cboLO = document.getElementById("ctl00$MyCPH1$Fromlc$cboLO");
            var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 20/5/2014

            if (txtDateFrom.value == "") {
                alert("Kindly Enter From Date");
                txtDateFrom.focus();
                return false;
            }

            if (txtDateTo.value == "") {
                alert("Kindly Enter To Date");
                txtDateTo.focus();
                return false;
            }

            if (txtVehicleNo.value == "") {
                alert("Kindly Enter the Vehicle No.");
                txtVehicleNo.focus();
                return false;
            }


            window.open("Result.aspx?FROMDT=" + txtDateFrom.value + "&TODT=" + txtDateTo.value + "&VEHNO=" + txtVehicleNo.value + "&RO=" + cboRO.value + "&LO=" + cboLO.value + "&hdnRptId=" + hdnRptId.value + "");
            return false;
        }


        function nwOpen() {
            window.open("Popup-Vehicle.aspx?", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
        }
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

    </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 20/5/2014 --%>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Truck Profitability</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    <table cellspacing="1" style="width: 800px">
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <table cellspacing="1" style="width: 100%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="2" align="center">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" colspan="4">
                                    <Location:LH ID="Fromlc" runat="server" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="right" valign="center" style="text-align: left; width: 69px;">
                                    <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True" Width="171px">Date Range:</asp:Label>
                                </td>
                                <td align="left" colspan="1">
                                    <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Width="150px">Vehicle No :</asp:Label>
                                </td>
                                <td align="left" style="width: 123%;">
                                    <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="Input" Width="129px"></asp:TextBox><input
                                        id="Vehno" runat="server" type="button" value="..." onclick="javascript:nwOpen('Popup-Vehicle.aspx',null,'height=250,width=300,left=350,top=200,status=no,resizable=no,scrollbars=yes,toolbar=no,location=no,menubar=no');" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="2" align="right" style="width: 100%">
                                    <asp:UpdatePanel ID="UPShowCustomer" UpdateMode="Always" RenderMode="Inline" runat="server">
                                        <ContentTemplate>
                                            <asp:Button ID="btnShow" OnClientClick="Javascript: return OnSub_DATACHECK();" runat="server"
                                                Text="Submit" Width="75px" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
