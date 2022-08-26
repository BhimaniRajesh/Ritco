<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DriverRegisterReport.aspx.cs" Inherits="admin_TireSearch" %>

<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/DateControl.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function nwOpen3(mNo) {
            window.open("Popup_Driver.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function OnSub_DATACHECK() {

            var txtDateFrom = document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
            var txtDateTo = document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
            var tb_TextBox = document.getElementById("ctl00_MyCPH1_popUpRTO_tb_TextBox");
            var tb_TextBox1 = document.getElementById("ctl00_MyCPH1_popUpVehicle_tb_TextBox");
            var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
            var ddlStatus = document.getElementById("ctl00_MyCPH1_ddlStatus");
            var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 20/5/2014

            window.open("DriverRegisterResult.aspx?LIC_EXP_DT_From=" + txtDateFrom.value + "&LIC_EXP_DT_To=" + txtDateTo.value + "&RTO=" + tb_TextBox.value + "&VEH_NO=" + tb_TextBox1.value + "&DRIVER_NAME=" + txtDriver1.value + "&DRIVER_STATUS=" + ddlStatus.value + "&hdnRptId=" + hdnRptId.value + "");
            return false;

        }

    </script>
 
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
     
    <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 20/5/2014 --%>
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Driver Register</asp:Label>
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
                                <td colspan="4" align="center">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" valign="center" width="23%">
                                    <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Date</asp:Label>
                                </td>
                                <td align="left" colspan="3" width="77%">
                                    <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4" align="right" valign="center" style="width: 100%; text-align: left;">
                                    <popUp:popUp ID="popUpRTO" runat="server" ReadOnly="false" Header_Text="RTO " Table_Name="WEBX_FLEET_DRIVERMST"
                                        Value_Field="Driver_id" Text_Field="Issue_By_RTO" Active_Flag_Field="ActiveFlag"
                                        Width="500" Height="300" />
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4" align="right" valign="center" style="width: 55%; text-align: left;">
                                    <popUp:popUp ID="popUpVehicle" runat="server" ReadOnly="false" Header_Text="Select Vehicle"
                                        Table_Name="webx_vehicle_hdr" Value_Field="Veh_Internal_No" Text_Field="VehNo"
                                        Active_Flag_Field="ActiveFlag" Width="500" Height="300" />
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left" colspan="1" style="width: 250px">
                                    <asp:Label ID="Label1" runat="server" Text="Driverwise" CssClass="blackfnt" Font-Bold="True"></asp:Label>&nbsp;
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtDriver1" AutoPostBack="true" CssClass="input" runat="server"
                                        OnTextChanged="RetrieveDriverDataInfo1"></asp:TextBox>
                                    <asp:Label ID="Label9" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                                        Width="14px"></asp:Label>
                                    <asp:Label ID="lblD1Error" Visible="false" runat="server" CssClass="redfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Driver Status</asp:Label>
                                </td>
                                <td align="left" style="width: 123%;" colspan="3">
                                    <asp:DropDownList ID="ddlStatus" runat="server" Width="229px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4" align="right" style="width: 100%">
                                    <asp:UpdatePanel ID="UPShowDriver" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                        <ContentTemplate>
                                            <asp:Button ID="btnShow" runat="server" Text="Show Driver Details >>" ValidationGroup="VGDtFromTo"
                                                OnClientClick="Javascript: return OnSub_DATACHECK();" />
                                            <asp:UpdateProgress runat="server" ID="Prog1">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                                    <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>
--%>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
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
