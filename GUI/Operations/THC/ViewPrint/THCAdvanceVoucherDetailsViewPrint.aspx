<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THCAdvanceVoucherDetailsViewPrint.aspx.cs" Inherits="GUI_Operations_THC_ViewPrint_THCAdvanceVoucherDetailsViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link id="Link1" href="../../../images/style.css" rel="stylesheet" type="text/css"
        runat="server" />
    <title>THC View</title>
    <script language="javascript" type="text/jscript">
   
    </script>
</head>
<body>

    <form id="f2122121" runat="server">


        <br />
        <div align="left">
            <table border="0" align="left" style="width: 9.5in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
                <tr class="bgbluegrey">
                    <td width="100%" align="center" height="18" colspan="4">
                        <font class="blackfnt"></font><font class="bluefnt"><b>Advance Voucher Summary.  
                       &nbsp;&nbsp;&nbsp; </b>
                            <asp:Label ID="lblTHCNo" runat="server" Text="Label"></asp:Label>
                        </font>
                        &nbsp;</td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <table border="0" align="left" style="width: 9.5in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
                            <tr align="left" bgcolor="#FFFFFF">
                                <td align="right">
                                    
                                            <%-- <asp:DataGrid ID="DataGrid1" OnItemDataBound="DataGrid1_ItemDataBound" runat="server" PageSize="1000" AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left">
                                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                            <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="Voucherno" HeaderText="Voucher No">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" width="2in" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="Debit" HeaderText="Debit">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>--%>
                                            <%--<asp:BoundColumn DataField="Credit" HeaderText="Credit">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>--%>
                                            <%--<asp:BoundColumn DataField="Narration" HeaderText="Narration">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>
                                            </Columns>
                                        </asp:DataGrid> --%>

                                            <asp:GridView ID="GridView1" ShowFooter="true" runat="server" PageSize="1000" AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" RowStyle-HorizontalAlign="Left">
                                                <FooterStyle BackColor="White" Font-Bold="true" ForeColor="#003399" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <PagerStyle HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" CssClass="whitefnt" />
                                                <RowStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />

                                                <Columns>
                                                    <asp:BoundField DataField="Voucherno" HeaderText="Voucher No" FooterText="Total:" FooterStyle-Font-Bold="true">
                                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Width="2in" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Debit" HeaderText="Debit">
                                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Narration" HeaderText="Narration">
                                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        
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
