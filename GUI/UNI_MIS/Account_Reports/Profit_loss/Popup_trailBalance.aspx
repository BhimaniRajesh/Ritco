<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup_trailBalance.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Trail_balance_Popup_trailBalance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <script language="javascript" type="text/javascript">
 
 
  function OpenPopupWindow2(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../accounts_mis/ledger/result.aspx?" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        </script>
 
 
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
    <form id="form1" runat="server">
    
    <asp:Table id="tblTBalance" runat="server" CellPadding="3" border="1" CellSpacing="1" style="width: 100%" CssClass="boxbg">
        
        </asp:Table>
    
    </form>
</body>
</html>
