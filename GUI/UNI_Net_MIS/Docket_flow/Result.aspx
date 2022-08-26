<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageReport.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Docket_flow_Result" %>

	
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
      <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                             SizeToReportContent="true"   
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px"  ShowBackButton="true"
                                ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" width="100%">
                             
                            </rsweb:ReportViewer>
    </div>
</asp:Content>
