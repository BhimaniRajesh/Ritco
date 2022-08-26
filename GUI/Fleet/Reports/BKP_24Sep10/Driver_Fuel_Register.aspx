<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Driver_Fuel_Register.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div>
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="VExp"  runat="server" Font-Names="Verdana" Font-Size="8pt" Height="650px"
                ShowParameterPrompts="True" ShowBackButton="True" ProcessingMode="Remote" Width="100%">
                <ServerReport ReportPath="/Reports/rpt_Vehicle_Exp" ReportServerUrl="http://124.247.224.12/reportserver" />    
        </rsweb:ReportViewer>
    
    </div>
</asp:Content>
