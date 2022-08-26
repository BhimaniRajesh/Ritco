<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_JobTaskNotDone_Query" Title="Untitled Page" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
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
        
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Job Task Not Done</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
        
    </table>
    
     <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td style="width: 699px">  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        
                        
             <tr class="bgbluegrey">
                <td colspan="2" align="center">
                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
            </td>
            </tr>

                        <tr style="background-color: white">
                            <td align="left" valign=top>
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Job Order Date Range:</asp:Label>
                            </td>
                            <td align="left" >
                                <Date:DT ID="DT" EnableTillDate="False" runat="server" />
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                            <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Job Order No:</asp:Label></td>
                        <td align="left" colspan="2" style="width: 540px">
                            <asp:TextBox ID="txtjoborderno" runat="server"></asp:TextBox>
                        </tr>
          
                      <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left; height: 26px;">
               <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Location Name:</asp:Label></td>
               <td align="left" colspan="2" style="height: 26px; width: 800px;"><asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
                     <ContentTemplate>                 
                        <asp:TextBox ID="txtlocname" runat="server" CssClass="blackfnt"></asp:TextBox>
                        <asp:HiddenField ID="hfloccode" runat="server" />
                          <asp:Button ID="btnPopupLocation" runat="server" Text="..." Width="21px" />
                <atlas:AutoCompleteExtender ID="AutoCompleteExtender3"  ServicePath="../../../../GUI/services/TyreWebService.asmx" runat="server"  DropDownPanelID="Panel1" ServiceMethod="GetLocation">
                    <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" 
                         TargetControlID="txtlocname" />
                </atlas:AutoCompleteExtender>
                <asp:Panel ID="Panel1" Height="200px" ScrollBars="Vertical" BackColor="transparent" runat="server" BorderStyle="Inset" BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False" Font-Size="8pt" Font-Underline="False" HorizontalAlign="Left"></asp:Panel>                      
                     </ContentTemplate>
                    </asp:UpdatePanel>
                      </td>
                     </tr>
           
                     <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right; width: 540px;">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo"  OnClick="btnShow_Click" />
                        <%--<asp:Button ID="btnShow" runat="server" Text="Sub" ValidationGroup="VGDtFromTo"  OnClick="btnShow_Click" /> --%>
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>
                 
      </asp:Content>

