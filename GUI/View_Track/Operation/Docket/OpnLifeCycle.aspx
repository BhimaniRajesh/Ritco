<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OpnLifeCycle.aspx.cs" Inherits="GUI_Tracking_ver1_Docket_OpnLifeCycle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Operation Life Cycle</title>
        <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
         <script type="text/javascript" language="Javascript">
         function OpenPopupWindowDocket(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operation/DocketEntry/DocketPrint/DocketView_XLS.aspx?dockno="+strDoc+"&docksf=."+"&DocketCalledAs="
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         function OpenPopupWindowPRS(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operations/PRS/PRS_View_Print.aspx?DRSNo=" + strDoc +",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         function OpenPopupWindowLS(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDoc +",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         function OpenPopupWindowMF(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strDoc +",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         function OpenPopupWindowTHC(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strDoc +".,0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         function OpenPopupWindowDRS(strDoc)
         {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../../Operations/DRS/DRS_View_Print.aspx?DRSNo=" + strDoc +",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="8" nowrap align="center">
                        <font class="blackboldfnt">
                            <%=call_dkt%>
                            Operation Life Cycle</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
    <asp:Table ID="tblOPNLIFECYCLE" Visible="true" runat="server" CellPadding="3" CellSpacing="1"
                Style="width: 8.0in;" CssClass="boxbg">
            </asp:Table>
            </td>
            </tr></table>
    </div>
    </form>
</body>
</html>
