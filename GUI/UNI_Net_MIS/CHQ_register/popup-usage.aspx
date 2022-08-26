<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-usage.aspx.cs" Inherits="GUI_UNI_MIS_chequemgt_popup_usage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Usage</title>
    <link id="Link1" href="../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>

<script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"

 function nwOpenMR(mrsno,type,printyn)
        {
                window.open(" ../../Finance/Billing_Ver1/BillCollection/MR_Summ_Popup.aspx?mrsno="+mrsno+"&type="+type+"&printyn="+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600,height=350,status=no,left=220,top=70");
 
//               if(type=="2")
//               {
//                window.open(" ../../Finance/MoneyRecipt/MR_Summ_Popup.aspx?mrsno="+mrsno+"&type="+type+"&printyn="+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
//               }
//               else
//               {
//                window.open(" ../../operation/singlescreen_docketentry/docketprint/paidmr/MR_Summ_Popup.aspx?mrsno="+mrsno+","+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
//               }
        }
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

<body bgcolor="#FFFFFF">
    <form name="frm" method="post" runat="server">
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <p align="center">
                        <font class="bluefnt"><strong><u>Cheque Summary</u></strong></font>
                    </p>
                    <table cellspacing="1" cellpadding="1" border="0" class="boxbg" width="95%" align="center">
                        <tr class="bgbluegrey">
                            <td valign="top" bgcolor="#FFFFFF" style="width: 179px">
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
                            <td valign="top" bgcolor="#FFFFFF" style="width: 179px">
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
                            <td valign="top" bgcolor="#FFFFFF" style="width: 179px; height: 18px">
                                <font class="blackfnt">Deposit location</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" style="height: 18px">
                                <div align="left">
                                    <font class="blackfnt">&nbsp;<asp:Label ID="Label9" runat="server"></asp:Label></font></div>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="166" style="height: 18px">
                                <p align="left">
                                    <font class="blackfnt">Deposit date</font>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="222" style="height: 18px">
                                <font class="blackfnt">&nbsp;<asp:Label ID="Label10" runat="server"></asp:Label></font></td>
                        </tr>
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" style="width: 179px">
                                <font class="blackfnt">Deposit voucher no ##</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left">
                               <%-- <a class="bluefnt" href="JavaScript:nwOpen('<%=voucherNo%>','<%=vovtype%>',0)">--%>
                                    <%=voucherNo%>
                                <%--</a>--%>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="166">
                                <p align="left">
                                    <font class="blackfnt">Deposited from</font>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="222">
                                <font class="blackfnt"><font class="blackfnt">&nbsp;<asp:Label ID="Label7" runat="server"></asp:Label></font></font></td>
                        </tr>
                        <tr>
                            <td valign="top" height="19" bgcolor="#FFFFFF" align="left" style="width: 179px">
                                <font class="blackfnt">Cheque Amount </font>
                            </td>
                            <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="222">
                                <font class="blackfnt">&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label></font></td>
                            <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="166">
                                <font class="blackfnt">Recived From</font></td>
                            <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="222">
                                <font class="blackfnt"><font class="blackfnt">&nbsp;<asp:Label ID="Label8" runat="server"
                                    CssClass="blackfnt"></asp:Label></font></font></td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#ffffff" height="19" style="width: 179px" valign="top">
                                Accounted Amount</td>
                            <td align="left" bgcolor="#ffffff" height="19" valign="top" width="222">
                                <asp:Label ID="Label11" runat="server"></asp:Label></td>
                            <td align="left" bgcolor="#ffffff" height="21" valign="top" width="166">
                            </td>
                            <td align="left" bgcolor="#ffffff" height="21" valign="top" width="222">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#ffffff" height="19" style="width: 179px" valign="top">
                                Un Accounted Amount</td>
                            <td align="left" bgcolor="#ffffff" height="19" valign="top" width="222">
                                <asp:Label ID="Label12" runat="server"></asp:Label></td>
                            <td align="left" bgcolor="#ffffff" height="21" valign="top" width="166">
                            </td>
                            <td align="left" bgcolor="#ffffff" height="21" valign="top" width="222">
                            </td>
                        </tr>
                    </table>
                    <br>
                    <%--<font class="blackfnt">## Click on voucher number to view full details</font><br>--%>
        </table>
        <center>
            <asp:GridView ID="GridView1" runat="server" align="center" BorderWidth="0" CellPadding="5"
                Width="92%" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="boxbg" PageSize="25" AllowSorting="False"
                AutoGenerateColumns="false" EmptyDataText="No Records Found...">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No." HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderText="Document No." HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" />
                        <ItemTemplate>
                            <center>
                                <a class="bluefnt" href="JavaScript:nwOpenMR('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "mrstype") %>',0)">
                                    <%#DataBinder.Eval(Container.DataItem, "docno")%>
                                </a>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="chqdt" HeaderText="Date " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="chqamt" HeaderText="Amount " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="clamt" HeaderText="Amount Used From This Cheque " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </center>
    </form>
</body>
</html>
