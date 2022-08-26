<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bill_popUp.aspx.cs" Inherits="GUI_UNI_MIS_BILL_MR_Register_Bill_popUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left"> <tr>
            <td valign="top">
                <br />
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" AutoGenerateColumns="false"
                    CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                     ShowFooter="false" OnRowDataBound="dgDocket_RowDataBound"
                    AllowPaging="false" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" EmptyDataText="No Records Found..."
                    >
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                         <asp:BoundField DataField="orgncd" HeaderText="Origin">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                         <asp:BoundField DataField="reassign_destcd" HeaderText="Destination">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                         <asp:BoundField DataField="subtotal" HeaderText="SubTotal">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="svctax" HeaderText="S.tax">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                            
                        </asp:BoundField>
                         <asp:BoundField DataField="cess" HeaderText="Cess">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                         <asp:BoundField DataField="hedu_cess" HeaderText="H.Cess">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                         <asp:BoundField DataField="otchg" HeaderText="Other chg">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dktchg" HeaderText="DKT chg">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dkttot" HeaderText="Amount">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        
                    </Columns>
                    <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                        Width="200" />
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                   <FooterStyle CssClass="bgbluegrey" Wrap="false" Width="200" />
                </asp:GridView>
            </td>
        </tr></table>
    </div>
    </form>
</body>
</html>
