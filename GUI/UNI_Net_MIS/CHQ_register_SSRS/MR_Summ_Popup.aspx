<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_Summ_Popup.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/jscript">
    function OpenPopupWindow(strBillno)
    {
         
        strMrsno=document.getElementById("lblmrsno").innerText
         
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,titlebar=no,scrollbars=no,width=700,height=400,status=no,left=60,top=270"
        var strPopupURL = "../../Finance/Billing/BillViewPrint/FrmAreaBillView.aspx?billno=" + strBillno
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 8.0in" align="left">
            <table border="1" class="bgbluegrey">
                <tr bgcolor="white">
                    <td bgcolor="white">
                        <table border="0" cellpadding="2" cellspacing="2" class="std" width="100%">
                            <tr>
                                <td align="left" valign="top" style="width: 885px">
                                    <font><b>
                                        <asp:Image Height="50" ID="imgLogo" runat="server" Width="150" /><br />
                                    </b>
                                        <br />
                                    </font>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080">
                            <tr bgcolor="#ffffff">
                                <td >
                                    <font class="blackfnt"><b>MR No</b></font></td>
                                <td >
                                    <font class="blackfnt">
                                        <asp:Label ID="lblmrsno" runat="server"></asp:Label></font></td>
                                <td >
                                    <font class="blackfnt"><b>Branch</b></font></td>
                                <td >
                                    <font class="blackfnt">
                                        <asp:Label ID="lblbranch" runat="server" ></asp:Label></font></td>
                                <td >
                                    <font class="blackfnt"><b>MR Type</b></font></td>
                                <td >
                                    <font class="blackfnt">
                                        <asp:Label ID="lblMRType" runat="server"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td >
                                    <font class="blackfnt"><b>Customer Code No</b></font></td>
                                <td >
                                    <font class="blackfnt">
                                        <asp:Label ID="lblccode" runat="server"></asp:Label></font></td>
                                <td>
                                    <font class="blackfnt"><b>Dt.</b></font></td>
                                <td colspan="3">
                                    <font class="blackfnt">
                                        <asp:Label ID="lbldt" runat="server" ></asp:Label></font></td>
                                
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="6">
                                    <font class="blackfnt">M/s. &nbsp;&nbsp;<b><br>
                                        <asp:Label ID="lblpartynm" runat="server" Width="524px"></asp:Label><br>&nbsp;&nbsp;</font></td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center">
                            <tr bgcolor="#ffffff">
                                <td width="20%" colspan="6">
                                    <font class="blackfnt">Received with thanks
                                        <asp:Label ID="lblmode" runat="server"></asp:Label>
                                        details given below :- </font>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:GridView ID="GrdPaidFollow" ShowFooter="true" EmptyDataText="No Records Found....."
                            AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="true"
                            HeaderStyle-CssClass="bgbluegrey" BackColor="white" runat="server" SelectedIndex="1"
                            OnRowDataBound="GrdPaidFollow_RowDataBound" Width="100%" FooterStyle-BackColor="white">
                            <Columns>
                                <asp:TemplateField HeaderText="Bill No">
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                                    <ItemTemplate>
                                        <%--<asp:Label ID="lblbillno" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"docno"))%>'
                                            runat="server"></asp:Label>--%>
                                        <asp:LinkButton ID="lblBillno" Visible="false" CssClass="blackfnt" Font-Underline="true"
                                            Text='<%# DataBinder.Eval( Container.DataItem,"Billno") %>' runat="server"></asp:LinkButton>
                                        <a href="JavaScript:OpenPopupWindow('<%# DataBinder.Eval( Container.DataItem,"Billno") %>')">
                                            <font cssclass="Blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "Billno")%></a>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                        <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#999999"
                            align="center">
                            <tr bgcolor="#ffffff">
                                <td align="left" colspan="3" nowrap="nowrap" style="height: 18px" width="9%">
                                    <asp:Label ID="lbltotalinword" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="right" colspan="4" nowrap="nowrap" style="height: 18px" width="25%">
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td width="9%" align="left" colspan="3" nowrap style="height: 18px">
                                    <font class="blackfnt">Note : Cheque/D. D. are subject to Reliasation </font>
                                </td>
                                <td width="25%" align="right" colspan="4" nowrap style="height: 18px">
                                    <font class="blackfnt">FOR </font>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="8">
                                    <p>
                                        &nbsp;</p>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="8">
                                    <p>
                                        &nbsp;</p>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="8">
                                    <p>
                                        &nbsp;</p>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="7" align="center">
                                    <div align="center">
                                        <font face="verdana" size="-2">CUSTOMER COPY</font></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
