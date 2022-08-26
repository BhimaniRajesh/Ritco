<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_Summ_Popup.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <% string strDRSNo = Request.QueryString.Get("mrsno");
           
           string boxbg = "";
           string bgbluegrey = "bgwhite";
           string strborder = "1";
           string strspace = "1";
           
        %>
        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
            </script>

        <div style="width: 7.5in" align="center">
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'>
                <tr bgcolor="white">
                    <td bgcolor="white">
                        <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>' style="width: 7.5in">
                         <tr>
                                <td align="left" valign="top">
                                    <asp:Image Height="50" ID="imgLogo" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <font class="blackfnt"><h4>MR View</h4>
                                    </font>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 7.5in" border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'>
                            <tr bgcolor="#ffffff">
                                <td width="20%">
                                    <font class="blackfnt">MR No</font></td>
                                <td width="26%">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblmrsno" runat="server" Width="231px"></asp:Label></font></td>
                                <td width="22%">
                                    <font class="blackfnt">Branch</font></td>
                                <td width="32%">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblbranch" runat="server" Width="286px"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td width="20%">
                                    <font class="blackfnt">Customer Code No</font></td>
                                <td width="26%">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblccode" runat="server" Width="231px"></asp:Label></font></td>
                                <td width="22%">
                                    <font class="blackfnt">Dt.</font></td>
                                <td width="32%">
                                    <font class="blackfnt">
                                        <asp:Label ID="lbldt" runat="server" Width="286px"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td colspan="4">
                                    <font class="blackfnt">M/s. &nbsp;&nbsp;<b><br>
                                        <asp:Label ID="lblpartynm" runat="server" Width="524px"></asp:Label><br>&nbsp;&nbsp;</font></td>
                            </tr>
                        </table>
                        <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center">
                            <tr bgcolor="#ffffff">
                                <td width="20%" colspan="4">
                                    <font class="blackfnt">Received with thanks
                                        <asp:Label ID="lblmode" runat="server"></asp:Label>
                                        details given below :- </font>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:GridView ID="GrdPaidFollow" ShowFooter="true" EmptyDataText="No Records Found....."
                            AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false"
                            HeaderStyle-CssClass="bgbluegrey" BackColor="white" runat="server" SelectedIndex="1"
                            OnRowDataBound="GrdPaidFollow_RowDataBound" Width="7.5in">
                            <Columns>
                                <asp:TemplateField HeaderText="Bill No">
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblbillno" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"docno"))%>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataFormatString="{0:dd-MMM-yy}" HeaderText="Bill Date" DataField="bgndt">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Bill Amount" DataField="totbill">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="TDS" DataField="tdsded">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField  HeaderText="Freight Rebate" DataField="frtded">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Claim" DataField="clmded">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Unadjusted Amount" DataField="unexpded">
                                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="MRs Amount">
                                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblnetamt" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"netamt"))%>'
                                            runat="server"></asp:Label>
                                        <asp:Label ID="lblstar" runat="server" Text="*" ForeColor="red"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                        <table style="width: 7.5in" border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'>
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
