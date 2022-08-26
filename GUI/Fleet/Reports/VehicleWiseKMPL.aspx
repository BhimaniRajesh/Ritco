<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="VehicleWiseKMPL.aspx.cs" Inherits="GUI_Fleet_Reports_VehicleWiseKMPL" %>

<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
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
      
       var tb_TextBox=document.getElementById("ctl00$MyCPH1$popUp$tb_TextBox");
       var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
       var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
       var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 21/5/2014

       window.open("VehicleWiseKMPLReport.aspx?VEHNO=" + tb_TextBox.value + "&VSlip_FROMDT=" + txtDateFrom.value + "&VSLIP_TODT=" + txtDateTo.value + "&Company_Code=" + ddlCompanyList.value + "&hdnRptId=" + hdnRptId.value + "");

      //return false;

        
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

    
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 21/5/2014 --%>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Vehicle Wise KMPL</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
  
       <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="vertical-align: top; width: 50%; text-align: left">
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                     <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                         <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label18"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label></td>
                         <td align="left" valign="top"  colspan="2" >
                             <Company:CMPFT ID="CMPFT1" runat="server" />
                          </td>
                   </tr> 
                     <tr style="background-color: white">
                        <td colspan="3" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUp" runat="server"
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
                <td align="left" valign="center" width="15%" >
                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Vehicle Run Date</asp:Label></td>
                <td align="left" colspan="1" width="85%">
                <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                </td>
            </tr>

           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right; width: 73%;">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="Javascript: return OnSub_DATACHECK();" /> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>

      <br/>
       
    
    
</asp:Content> 