
<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="DocumentRegisterRes.aspx.cs" Inherits="GUI_Fleet_Reports_DocumentRegister" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    
    
         <table cellspacing="1" style="width: 1000px">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports > Document Register</asp:Label>
            </td> 
            
             <td align="right">
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif" OnClick="ImageButton1_Click"   />
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
    
    
<table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="vertical-align: top; text-align: left">
        <%--
               <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" processingmode="Remote" Height="800px" Width="1800px">
                </rsweb:reportviewer>--%>
                <asp:Panel ID="Panel1" Width="1000px"  Height="600px"  runat="server">
                
                 <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Font-Names="Verdana" Font-Size="8pt" 
                
                ShowPageNavigationControls="true" 
                ShowBackButton="true" 
                ProcessingMode="Remote" >
            </rsweb:ReportViewer>
            </asp:Panel>
            
            </td>
        </tr>
    </table>
   
</asp:Content> 
