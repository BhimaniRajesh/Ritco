<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"AutoEventWireup="true" CodeFile="Driver_Wise_Fuel_Register.aspx.cs" Inherits="GUI_Fleet_Reports_Driver_Wise_Fuel_Register" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>


  <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
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
      
      
      
       var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
       var ddlmanualname=document.getElementById("ctl00_MyCPH1_ddlmanualname");
      var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
   
       window.open("Driver_wise_Fuel_Register_Report.aspx?Start_dt=" + txtDateFrom.value + "&End_dt=" + txtDateTo.value + "&driver1=" + ddlmanualname.value + "&Company_Code=" + ddlCompanyList.value + "");

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
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Driver wise Fuel Register Report </asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    
 <table cellspacing="1" style="width: 800px">
        <tr>
            <td><asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate>
                <table cellspacing="1" style="width: 100%" class="boxbg">
                    
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                     <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="2" style="width: 154px"  >
                            <asp:Label ID="Label1"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                      
                     <tr style="background-color: white">
                        <td align="left" valign="center" style="width: 154px;">
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Transaction Date Range :</asp:Label></td>
                        <td align="left" colspan="3">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>        
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Width="150px">Driver Name :</asp:Label></td>
                        <td align="left" colspan = "3" style="width: 123%;">
                            <asp:DropDownList ID="ddlmanualname" runat="server" Width="229px">
                            </asp:DropDownList>
                         </td>
                    </tr>
                  
                    
                   
                  

   <tr style="background-color: white">
                        <td colspan="4" align="right" style="width: 100%">
                           <asp:UpdatePanel ID="UPShowSubmit" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                 <asp:Button ID="btnShow" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" OnClientClick="javascript:OnSub_DATACHECK();"/>
                                   <%-- <atlas:UpdateProgress runat="server" ID="Prog1">
                                        
                                        <ProgressTemplate>
                                        
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>

                                        </ProgressTemplate>
                                    </atlas:UpdateProgress>
                      --%>
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