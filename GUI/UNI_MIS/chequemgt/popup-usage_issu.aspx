<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-usage_issu.aspx.cs"
    Inherits="GUI_UNI_MIS_chequemgt_popup_usage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Usage</title>
    <link id="Link1" href="../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body bgcolor="#FFFFFF">
    <form name="frm" method="post">

        <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"

    function nwOpen(mrsno,type,printyn)
        {
    
        var typ= type.toUpperCase();

        
                        if(typ == "JOURNAL")
                        {           
                            
                            window.open("Print/JournalVoucherView.aspx?voucherno=" + mrsno + "&printyn=N");
                          //  ..,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                        
                        }
                        else if(typ == "CASH PAYMENT" || typ == "BANK PAYMENT")
                        {            //debit            
                           window.open("Print/DebitVoucherView.aspx?voucherno=" + mrsno + "&printyn=N");
                           //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
                        else if(typ == "CASH RECEIPT" || typ == "BANK RECEIPT")
                        {                   
                      //  credit     
                           //window.open("Print/CreditVoucherView.aspx?voucherno=" + voucherId + "&printyn=N,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
                           
                           window.open("Print/CreditVoucherView.aspx?voucherno=" + mrsno + "&printyn=N");
                           //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
                        else if(typ == "CONTRA")
                        {                        
                           window.open("Print/ContraVoucherView.aspx?voucherno=" + mrsno + "&printyn=N");
                           //,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
         
               //  window.open(" voucher_vew_print.aspx?vno="+mrsno+"&type="+type+"&printyn="+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               
        }
        </script>

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <tr>
                                    <td>
                                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <p align="center">
                                                        <font class="bluefnt"><strong><u>Cheque Summary</u></strong></font>
                                                    </p>
                                                    <table cellspacing="1" cellpadding="1" border="0" class="boxbg" width="95%" align="center">
                                                        <tr class="bgbluegrey">
                                                            <td valign="top" bgcolor="#FFFFFF" width="129">
                                                                <font class="blackfnt">Cheque number</font></td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left">
                                                                <div align="left">
                                                                    <font class="blackfnt">&nbsp;<asp:Label ID="Label1" runat="server"></asp:Label></font></div>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="166">
                                                                <p align="left">
                                                                    <font class="blackfnt">Cheque date</font>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="222">
                                                                <font class="blackfnt">&nbsp;<asp:Label ID="Label5" runat="server"></asp:Label></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" bgcolor="#FFFFFF" width="129">
                                                                <font class="blackfnt">Issue location</font></td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left">
                                                                <div align="left">
                                                                    <font class="blackfnt">&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label></font></div>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="166">
                                                                <p align="left">
                                                                    <font class="blackfnt">Issue date</font>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="222">
                                                                <font class="blackfnt">&nbsp;<asp:Label ID="Label6" runat="server"></asp:Label></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" bgcolor="#FFFFFF" width="129">
                                                                <font class="blackfnt">Issue voucher no ##</font></td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left">
                                                                <a class="bluefnt"  href="JavaScript:nwOpen('<%=voucherNo%>','<%=vovtype%>',0)">
                                                                    <%=voucherNo%>
                                                                </a>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="166">
                                                                <p align="left">
                                                                    <font class="blackfnt">Issued from</font>
                                                            </td>
                                                            <td valign="top" bgcolor="#FFFFFF" align="left" width="222">
                                                                <font class="blackfnt"><font class="blackfnt">&nbsp;<asp:Label ID="Label7" runat="server"></asp:Label></font></font></td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="166">
                                                                <font class="blackfnt">Cheque Amount </font>
                                                            </td>
                                                            <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="222">
                                                                <font class="blackfnt">&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label></font></td>
                                                            <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="166">
                                                                <font class="blackfnt">Issued to</font></td>
                                                            <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="222">
                                                                <font class="blackfnt"><font class="blackfnt">&nbsp;<asp:Label ID="Label8" runat="server"
                                                                    CssClass="blackfnt"></asp:Label></font></font></td>
                                                        </tr>
                                                    </table>
                                                    <br>
                                                    <font class="blackfnt">## Click on voucher number to view full details</font><br>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
