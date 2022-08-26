<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_NET_MIS_LRWiseCollection_Result" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <meta http-equiv="X-UA-Compatible" content="IE=Emulate11" >
    <title>LR Wise Collection Register</title>
</head>
<body>
    <form id="form1" runat="server">

    <script type="text/javascript" language="javascript">
        function Disable(reportViewerID) {
            var exportList = document.getElementById(reportViewerID + '_ctl01_ctl05_ctl00');
            exportList.options.length = 0;
            exportList.innerHTML = '';
            appendOption(exportList, 'Select a format', '');
            appendOption(exportList, 'Excel', 'EXCEL');
            appendOption(exportList, 'PDF', 'PDF');
            appendOption(exportList, 'CSV', 'CSV');
        }
        function appendOption(listCtrl, optionText, optionValue) {
            var newOption = document.createElement('option');
            newOption.text = optionText;
            newOption.value = optionValue;
            try {
                listCtrl.add(newOption, null);
            }
            catch (ex) {
                listCtrl.add(newOption);
            }
        }
    </script>

    <div>
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" exportcontentdisposition="AlwaysAttachment"
            showbackbutton="true" showpagenavigationcontrols="true" showparameterprompts="false"
            processingmode="Remote" showprintbutton="true" toolbaritemhoverbackcolor="Aqua"
            toolbaritempressedhoverbackcolor="BlueViolet" showrefreshbutton="true" width="100%"
            height="600px">
            <serverreport displayname="CNote Wise Collection Register"></serverreport>
        </rsweb:reportviewer>
    </div>

    <script type="text/javascript" language="javascript">
        Disable('<%=ReportViewer1.ClientID %>');      
    </script>

    </form>
</body>
</html>
