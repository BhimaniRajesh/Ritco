<%@ Page Language="C#" AutoEventWireup="true" CodeFile="1.aspx.cs" Inherits="Tracking_1" %>
<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="Div2" class="toolbar">
        <br />
            <div style="float: left; width: 90%">
                <radTS:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1">
                </radTS:RadTabStrip>
            </div>
            
            <radTS:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" Height="293px"
                Width="695px" BorderStyle="Ridge" >
            </radTS:RadMultiPage>
        </div>
    </form>
</body>
</html>
