<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Driver_wise_Fuel_Register_Report.aspx.cs"  Inherits="Driver_wise_Fuel_Register_Report" %>




<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<table width="100%">
            <tr>
                <td>
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" processingmode="Remote" Height="500px" Width="6000px" SizeToReportContent="True">
                        </rsweb:reportviewer>
                     </td>
            </tr>
        </table>
        
    </div>
    </form>
</body>
</html>