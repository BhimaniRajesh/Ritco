<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillDetail_TLL.aspx.cs" Inherits="GUI_Octroi_ViewOctroiBill_BillDetail_TLL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Bill Details</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="1" style="font-family:Verdana"   runat="server" id="tblMain" cellpadding="0" cellspacing="0">
            <tr class="blackfnt">
                <td>
                    <table id="Table2" runat="server" align="left" border="1" cellpadding="0" cellspacing="0"
                        style="font-family: Verdana">
                        <tr class="blackfnt">
                            <td style="text-align: right;" colspan="3">
                    <asp:Image ID="imgLogo" ImageUrl="~/GUI/images/TLL_000046.JPG" runat="server" Height="53px" Width="149px" /></td>
                            <td colspan="5">
                                <strong>Attachment of Bill No. :-
                    <asp:Label ID="lblBillNo" runat="server"></asp:Label></strong> </td>
                    <td colspan="5">
                     <strong>Party Name:-
                    <asp:Label ID="lblPartyName" runat="server"></asp:Label></strong>
                    </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt">
                <td >
                    <asp:GridView ID="grvBill" runat="server" AutoGenerateColumns="False" CssClass="boxbg" >
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Inv No.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "InvNo")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Docket No.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Date
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    From
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Location1")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                   To
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Location2")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Mode
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Mode")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                   Pcs.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Pcs")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Wt.
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "Weight")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Octroi<br />
                                    Amount
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "OctrioAmount")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Octroi <br />
                                    Charges
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "OctrioCharge")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                            </asp:TemplateField>
                             <asp:TemplateField>
                                <HeaderTemplate>
                                    ServiceTax <br />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "ServiceTax")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Other<br />
                                    Charges
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "OtherAmount")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    Amount
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "TotalAmount")%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                    <table id="tblSubTot" runat="server" align="right" border="1" cellpadding="0" cellspacing="0"
                        style="font-family: Verdana">
                        <tr class="blackfnt">
                            <td colspan="12" style="text-align: right">
                                <strong>Sub Total</strong></td>
                            <td>
                                <asp:Label ID="lblSubTot" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="blackfnt">
                            <td colspan="12" style="text-align: right">
                                <strong>TOTAL</strong></td>
                            <td>
                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt">
                <td style="text-align: center">
                    <strong>TOTAL : </strong>
                    <asp:Label ID="lblWordRs" runat="server" Font-Bold="True"></asp:Label><strong> Only</strong></td>
            </tr>
            <tr class="blackfnt">
                <td  style="text-align: left"><table id="Table1" runat="server" align="left" border="1" cellpadding="0" cellspacing="0"
                        style="font-family: Verdana">
                    <tr class="blackfnt">
                        <td  style="text-align: right">
                            <strong>Other</strong></td>
                        <td>
                            <asp:Label ID="lblOther" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr class="blackfnt">
                <td  style="text-align: left">
                    <br />
                    * T = Train , A = Air , R = Road Transport , E = Express
                </td>
            </tr>
            
        </table>
    
    </div>
    </form>
</body>
</html>
