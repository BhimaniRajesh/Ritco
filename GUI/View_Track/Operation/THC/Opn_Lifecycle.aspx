<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Opn_Lifecycle.aspx.cs" Inherits="GUI_View_Track_Operation_THC_Opn_Lifecycle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Operation Lifecycle</title>
            <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table id="Table1" runat="server" style="width: 8.0in" border="0" cellpadding="3" cellspacing="1"
                            class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center">
                                    <font class="blackboldfnt">Operation Lifecycle</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td  BackColor="white">
                                    <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                        AllowPaging="false"  CssClass="boxbg"  style="width: 8.0in"
                                        AutoGenerateColumns="false"  EmptyDataText="No Records Found..."    >
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
                                            <asp:BoundField DataField="THC NO" HeaderText="THC No">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="RouteName" HeaderText="RouteName">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Source" HeaderText="Origin">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Destination" HeaderText="Destination">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="ArriveDate" HeaderText="Arrv. Dt">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="DepartDate" HeaderText="Dept. Dt">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="THC Status" HeaderText="Status">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="MF Status" HeaderText="MF Status">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Docket" HeaderText="Docket">
                                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Docket Orgin" HeaderText="Docket Orgin">
                                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Docket Destination" HeaderText="Docket Destination">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Docket Currently At" HeaderText="Docket Currently At">
                                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Docket Status" HeaderText="Docket Status">
                                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            
                                        </Columns>
                                        <RowStyle />
                                        
                                        <HeaderStyle CssClass="bgbluegrey" />
                                       
                                        <FooterStyle CssClass="boxbg" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
    </div>
    </form>
</body>
</html>
