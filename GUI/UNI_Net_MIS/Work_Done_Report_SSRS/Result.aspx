<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPageReport.master"  CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_WorkDone_Testing_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
     <rsweb:ReportViewer  ShowBackButton="true" ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ProcessingMode="Remote" Height="600px"  width="100%" ShowParameterPrompts="False">
                                <ServerReport DisplayName="Work Done Report" ReportPath="/TMS/Report7"></ServerReport>
                            </rsweb:ReportViewer>
    </div>
</asp:Content>

