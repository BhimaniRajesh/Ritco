
<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"     CodeFile="FuelVendorBillRegisterResult.aspx.cs" Inherits="FuelVendorBillRegisterResult" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="atlas" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    
<table cellspacing="1" cellpadding="2" style="width: 100%">
    <tr >
        <td colspan="3" align="right" style="vertical-align: middle; width: 30%; text-align: right; height: 60px;">
            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif" OnClick="ImageButton1_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>  
        </td>
    </tr>
   </table>
        
<table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="vertical-align: top; text-align: left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" processingmode="Remote" Height="800px" Width="100%" SizeToReportContent="True">
                        </rsweb:reportviewer>
                    </ContentTemplate>
                </asp:UpdatePanel>
               
               
            </td>
        </tr>
    </table>
  
   
</asp:Content> 
