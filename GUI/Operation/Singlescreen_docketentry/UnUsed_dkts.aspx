<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UnUsed_dkts.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_UnUsed_dkts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
    <title>UnUsed <%=dkt_call%> List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Table id="tblUnUsedDktlist"  runat="server" CellPadding="3" CellSpacing="1" style="width:300px;" CssClass="boxbg">
        
        </asp:Table>
    </div>
    </form>
</body>
</html>
