<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BillMrDone.aspx.cs" Inherits="Finance_Billing_Billcollection_BillMrDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../../../images/dropdowncontent.js"></script>

    <%--!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">--%>

    <script language="javascript" type="text/javascript">
 
 function popupmenu1(mrsno)
 { 
     // alert(mrsno)
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
     
      confirmWin=window.open('./MR_Summ_Popup.aspx?mrsno='+ mrsno,"",winOpts);
 }
    </script>

    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Msg_err" CssClass="redfnt" Font-Bold="true" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="left" style="width: 7.0in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt"><b>Following document has been successfully generated:</b></font></td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td colspan="3" style="width: 130px">
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                <font class="blackfnt">BillMR</font></td>
                            <td align="center">
                                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
                            <td class="blackfnt">
                                <a href="javascript:popupmenu1('<%=mrsno%>')">View/Print</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<%-- </form>
</body>
</html>
--%>
