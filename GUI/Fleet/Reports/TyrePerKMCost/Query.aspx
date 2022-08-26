<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyrePerKMCost_Query" Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function nwOpen() {
            window.open("Popup-Vehicle.aspx?", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
        }

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function cust(ID) {
            ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID=" + ID

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OnSubmit() {

            var txtDateFrom = document.getElementById("ctl00_MyCPH1_DT_txtDateFrom");
            var txtDateTo = document.getElementById("ctl00_MyCPH1_DT_txtDateTo");
           
            var strPopupURL = "Result.aspx?DateFrom=" + txtDateFrom.value + "&DateTo=" + txtDateTo.value + "";

            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"

            winNew = window.open(strPopupURL, "_blank", strWinFeature)

            return false;
        }
        
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Cost Per KM Run</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 700px" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center">
                        <asp:Label ID="lblQry" CssClass="blackfnt" runat="server">Search Criteria</asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="right" valign="center" style="text-align: left; width: 69px;">
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Width="171px">Date Range:</asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td colspan="2" align="right" style="width: 100%">
                        <asp:UpdatePanel ID="UPShowCustomer" UpdateMode="Conditional" RenderMode="Inline"
                            runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnShow" OnClientClick="javascript:return OnSubmit();" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

