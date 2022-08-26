   
    
    <%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TripSheetRes.aspx.cs" Inherits="GUI_Fleet_Reports_TripSheet" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>


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
        
 <table align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="center" colspan="3" style="vertical-align: top; text-align: left">
           
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" height="800px" processingmode="Remote"
                            width="6500px">
                        </rsweb:reportviewer>
               
            </td>
        </tr>
    </table>
  
   
</asp:Content> 