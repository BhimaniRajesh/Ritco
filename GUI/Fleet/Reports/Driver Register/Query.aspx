<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_Driver_Register_Query" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">

<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>


<script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>


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
            <td >
            
            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate>
                <table cellspacing="1" style="width: 100%" class="boxbg">
                    
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    
                     <tr style="background-color: white">
                        <td align="right" valign="center" style="width: 140px; text-align: left; height: 112px;">
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">License Expiry Date</asp:Label></td>
                        <td align="left" colspan="1" style="height: 112px">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
                    
                    <tr style="background-color: white">
                        <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpRTO" runat="server"
                        ReadOnly="false"
                        Header_Text="RTO "
                        Table_Name="WEBX_FLEET_DRIVERMST"
                        Value_Field="Driver_id"
                        Text_Field="Issue_By_RTO"
                        Active_Flag_Field="ActiveFlag"
                        Width="500" Height="300" />
                        </td>
                      </tr>
                    
                    <tr style="background-color: white">
                        <td colspan="3" align="right" valign="center" style="width: 55%; text-align: left;">
                        <popUp:popUp ID="popUpVehicle" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Vehicle"
                        Table_Name="webx_vehicle_hdr"
                        Value_Field="Veh_Internal_No"
                        Text_Field="VehNo"
                        Active_Flag_Field="ActiveFlag"
                        Width="500" Height="300" />
                        </td>
                      </tr>
                    
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True">Driver name</asp:Label></td>
                        <td align="left" style="width: 55%;">
                            <asp:TextBox ID="txtDriverName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Driver surname</asp:Label></td>
                        <td align="left" style="width: 75%;">
                            <asp:TextBox ID="txtDriverSurName" runat="server"></asp:TextBox></td>
                    </tr>

   <tr style="background-color: white">
                        <td colspan="2" align="right" style="width: 100%">
                           <asp:UpdatePanel ID="UPShowDriver" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                 <asp:Button ID="btnShow" runat="server" Text="Show Driver Details >>" 
                                 ValidationGroup="VGDtFromTo" OnClick="btnShow_Click" />
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
