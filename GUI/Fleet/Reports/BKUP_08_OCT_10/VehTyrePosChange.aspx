<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="VehTyrePosChange.aspx.cs" Inherits="GUI_Fleet_Reports_DieselCardList" %>


<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>


    <script type="text/javascript">
    
         function nwOpen()
        {
            window.open("Popup-Vehicle.aspx?","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
            

        }
          function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        } 
      function OnSub_DATACHECK()
    {
        window.open("VehTyrePosChangeReport.aspx","");
        return false;
    }
        function OnSub_DATACHECK()
    {
      
       var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
       var txtDays=document.getElementById("ctl00_MyCPH1_txtDays");
       var txtVehicleNo=document.getElementById("ctl00_MyCPH1_txtVehicleNo");
       var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
   
     window.open("VehTyrePosChangeReport.aspx?Dt_From=" + txtDateFrom.value + "&Dt_To=" + txtDateTo.value + "&VehPosNotChangeDay=" + txtDays.value + "&VehNo=" + txtVehicleNo.value+"&Company_Code=" + ddlCompanyList.value + "");

    }
        
    </script>
   <script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
  <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Vehicle Tyre Position Change</asp:Label>
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
                            <asp:Label ID="Label18"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
         <tr style="background-color: white">
            <td align="left" valign="center" width= "23%">
                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Vehicle Tyre Postion Change Date Range</asp:Label></td>
            <td align="left" colspan="2" width="77%">
                <Date:DT ID="DT" EnableTillDate="false" runat="server" />
            </td>
        </tr>

                        
                        
                        
                        
                        <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Width="150px">Vehicle No :</asp:Label></td>
                        <td align="left" style="width: 123%;">
                            <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="Input" Width="129px"></asp:TextBox>
                            <input id="vehno" runat="server"   type="button" value="..." onclick="javascript:nwOpen('Popup-Vehicle.aspx',null,'height=250,width=300,left=350,top=200,status=no,resizable=no,scrollbars=yes,toolbar=no,location=no,menubar=no');"  />
           <tr style="background-color: white">
               <td align="right" colspan="3" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                   font-family: Verdana; text-align: center">
                   OR</td>
           </tr>
                    
           <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                            <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Vehicles where Position not changed for:</asp:Label></td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="txtDays"  onkeydown="return numeric(event)" runat="server" Width="24px"></asp:TextBox>Days</td>
                    </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="Javascript: return OnSub_DATACHECK();" /> 
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