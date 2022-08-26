<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TreadDepthMeasurement.aspx.cs" Inherits="GUI_Fleet_Reports_DieselCardList" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Tread Depth Measurement</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br/>
       
   <table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="text-align: left">
                <asp:UpdatePanel id="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional"><ContentTemplate>
<rsweb:reportviewer id="ReportViewer1" runat="server" Height="698px" Width="800px" processingmode="Remote" style="text-align: left"></rsweb:reportviewer> 
</ContentTemplate>
</asp:UpdatePanel></td>
        </tr>
        

   
</asp:Content> 