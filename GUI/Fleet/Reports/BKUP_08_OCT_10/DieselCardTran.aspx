<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="DieselCardTran.aspx.cs" Inherits="GUI_Fleet_Reports_DieselCardList" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>

  <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
         function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        } 
        
    function OnSub_DATACHECK()
    {
        window.open("DieselCardTranReport.aspx","");
        return false;
    }
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Diesel Card Transaction Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
           
               <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label2"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
           <tr style="background-color: white">
                        <td align="Left" valign="center" width="24%">
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Transaction Date Range</asp:Label></td>
                         <td align="left" colspan="1" width="76%" >
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>                                  
                        
                        
                      <tr style="background-color: white">
                        <td colspan="3" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpCard" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Card "
                        Table_Name="WEBX_FLEET_FUELCARD"
                        Value_Field="Fuel_Card_ID"
                        Text_Field="Manual_Fuel_Card_No"
                        Active_Flag_Field="Active_Flag"
                        Width="800" Height="300" />
                        </td>
                      </tr>                                  
                   
                      
           <tr style="background-color: white">
               <td align="right" colspan="3" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                   font-family: Verdana; text-align: center">
                   OR</td>
           </tr>
                    
                                   
                    <tr style="background-color: white">
                        <td colspan="3" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpVehicle" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Vehicle"
                        Table_Name="webx_vehicle_hdr"
                        Value_Field="Veh_Internal_No"
                        Text_Field="VehNo"
                        Active_Flag_Field="ActiveFlag"
                        Width="800" Height="300" />
                        </td>
                      </tr>                  
                    
                    
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                       <%-- <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> --%>
                        <asp:Button ID="Button1" runat="server" Text="Submit"  OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"  /> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>
      <br/>
       
                                
</asp:Content> 