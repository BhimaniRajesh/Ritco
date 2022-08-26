<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TripsheetQueryNew" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">

<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>

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
     var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
     var tb_TextBox=document.getElementById("ctl00_MyCPH1_popUpVehicle_tb_TextBox");
      var tb_TextBox1=document.getElementById("ctl00_MyCPH1_popUpTyreNo_tb_TextBox");
      var txtTWIfrom=document.getElementById("ctl00_MyCPH1_txtTWIfrom");
      var txtTWIto=document.getElementById("ctl00_MyCPH1_txtTWIto");
     var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
     var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 20/5/2014
     window.open("Result.aspx?FROM_DT=" + txtDateFrom.value + "&TO_DT=" + txtDateTo.value + "&VEH_NO=" + tb_TextBox.value + "&TYRE_NO=" + tb_TextBox1.value + "&TWI_FROM=" + txtTWIfrom.value + "&TWI_TO=" + txtTWIto.value + "&Company_Code=" + ddlCompanyList.value + "&hdnRptId=" + hdnRptId.value + "");
        return false;
    }
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

    <script language="JavaScript" type="text/javascript">
    
        function numeric(e) { return ((e.keyCode == 8) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
      
    </script>

 <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
   
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 20/5/2014 --%>
 
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Tread Depth Register</asp:Label>
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
                            <td colspan="2" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label></td>
                        </tr>
                       
                       <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label1"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="1" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                       <tr style="background-color: white">
                        <td align="left" valign="center" width="23%" >
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Tread Depth Date Range:</asp:Label></td>
                        <td align="left" colspan="1" width="77%">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
                                      
                        
                      <tr style="background-color: white">
                        <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpVehicle" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Vehicle :"
                        Table_Name="webx_vehicle_hdr"
                        Value_Field="Veh_Internal_No"
                        Text_Field="VehNo"
                        Active_Flag_Field="ActiveFlag"
                        Width="500" Height="300" />
                        </td>
                      </tr>
                    
              
                    <tr style="background-color: white">
                        <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpTyreNo" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Tyre Number :"
                        Table_Name="WEBX_FLEET_TYREMST"
                        Value_Field="TYRE_NO"
                        Text_Field="TYRE_ID"
                        Active_Flag_Field="TYRE_ACTIVEFLAG"
                        Width="500" Height="300" />
                        </td>
                      </tr>
              
         
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Width="149px">Average TWI Range :</asp:Label></td>
               <td align="left" >
                   <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                   <asp:TextBox ID="txtTWIfrom" onkeydown="return numeric(event)" runat="server" BorderStyle="Groove" CssClass="input" ValidationGroup="VGDtFromTo"
                       Width="30" MaxLength="5" ></asp:TextBox><asp:Label ID="Label7" runat="server" CssClass="blackfnt"
                           Text=" To: "></asp:Label><asp:TextBox ID="txtTWIto" onkeydown="return numeric(event)" runat="server" BorderStyle="Groove"
                               CssClass="input" ValidationGroup="VGDtFromTo" Width="30" MaxLength="5"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
            
               <td align="left" colspan="2"  style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                         <asp:Button ID="Button1" runat="server" Text="Submit"  OnClientClick="Javascript: return OnSub_DATACHECK();"  /> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>  
    
</asp:Content> 