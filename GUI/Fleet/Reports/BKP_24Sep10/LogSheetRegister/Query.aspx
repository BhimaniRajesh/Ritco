<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_LogSheetReg" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();


        function OnSubmit() {

            var txtDateFrom = document.getElementById('ctl00_MyCPH1_DT_txtDateFrom');
            var txtDateTo = document.getElementById('ctl00_MyCPH1_DT_txtDateTo');
            var txtVehicle = document.getElementById('ctl00_MyCPH1_popUpVehicle_tb_TextBox');
            var ddlLocation = document.getElementById('ctl00_MyCPH1_ddlLocation');

            window.open("Result.aspx?FromDt=" + txtDateFrom.value + "&ToDate=" + txtDateTo.value + "&Vehicle=" + txtVehicle.value + "&Loc=" + ddlLocation.value, "pbr", "scrollbars=yes,resizable=yes,statusbar=yes,width=1000,height=600'")
            return false;
        } 
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <%--<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>--%>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports > Log Sheet Register</asp:Label>
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <table cellspacing="1" style="width: 700px">
        <tr>
            <td>
                <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="center" width="23%">
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Log Sheet Date Range :</asp:Label>
                        </td>
                        <td align="left" colspan="1" width="77%">
                            <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
            
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                            <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Location" ></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td align="left" colspan="2">
                            <asp:DropDownList ID="ddlLocation" runat="server" Width="122px">
                                    </asp:DropDownList>
                        </td>
                    </tr>
                   
                    <tr style="background-color: white">
                        <td colspan="3" align="right" valign="center" style="width: 100%; text-align: left;">
                            <popUp:popUp ID="popUpVehicle" runat="server" ReadOnly="false" Header_Text="Select Vehicle :"
                                Table_Name="webx_vehicle_hdr" Value_Field="Veh_Internal_No" Text_Field="VehNo"
                                Active_Flag_Field="ActiveFlag" Width="500" Height="300" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                        </td>
                        <td align="left" colspan="2" style="text-align: right">
                            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="OnSubmit()"/>   <%--OnClick="btnShow_Click" --%>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
