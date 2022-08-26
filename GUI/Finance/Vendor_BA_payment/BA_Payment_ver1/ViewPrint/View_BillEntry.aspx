<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View_BillEntry.aspx.cs" EnableEventValidation="false" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_ViewPrint_View_BillEntry" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <table id="tblMain"  runat="server" width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table id="Table3" align="left" runat="server" cellpadding="3" cellspacing="1" style="width: 9.0in;"
                            class="boxbg">
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label2" Text="Bill Entry Number" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="lblBillno" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label3" Text="Bill Entry date" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="transdate" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label21" Text="Vendor Name" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="vendorname" runat="server"></asp:Label></font>
                                </td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label19" Text="Vendor Bill number" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="vendorbillno" runat="server"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                            <td> <font class="blackfnt">
                                    <asp:Label ID="Label1" Text="Vendor Bill Date" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="vendorbilldt" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label22" Text="Due date" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="duedt" runat="server"></asp:Label></font>
                                </td>
                               
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label4" Text="Service Tax No." runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                </td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label5" Text="PAN Number" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label6" Text="Total Commission" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="txtNetCommission" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label7" Text="TDS Type" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="lblTDSType" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label8" Text="Service Tax rate (%)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="svtax_rate" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label9" Text="TDS Deducted For" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="lblTDSDeductedFor" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label10" Text="Service Tax (+) " runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="svrcamt" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label11" Text="Bill Type" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <asp:Label ID="Label18" Text="Bill Type" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label12" Text="Cess (+)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="cessamt" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label13" Text="Other Amount (+)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="oth_amt" runat="server"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label14" Text="TDS rate (%)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="tds_rate" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label15" Text="Other Deductiom (-)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="oth_ded" runat="server"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label16" Text="TDS amount (-)" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="tds_chrg" runat="server"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label17" Text="Net Amount " runat="server" CssClass="blackboldfnt"></asp:Label></font></td>
                                <td> <font class="blackfnt">
                                    <asp:Label ID="TotalNetpayable" runat="server"></asp:Label></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td> <font class="blackfnt">
                                    <asp:Label ID="Label20" Text="Remark" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                <td colspan="3"> <font class="blackfnt">
                                    <asp:Label ID="txtremarks" runat="server"></asp:Label></font></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                    <br />
                        <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="3" BorderWidth="0"
                            HeaderStyle-CssClass="bgbluegrey"  CssClass="boxbg" AutoGenerateColumns="false" OnRowDataBound="dgDocket_RowDataBound">
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
                                <asp:BoundField DataField="docno" HeaderText="Cnote/HWB No">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField  Visible ="false" DataField="docsf" HeaderText="Cnote/HWB Sf">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField DataField="origin" HeaderText="Origin ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField DataField="desination" HeaderText="Destination ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField DataField="paybas" HeaderText="Pay Basis">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="mode" HeaderText="trn_mod">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dockdt" HeaderText=" Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pkgsno" HeaderText=" Package      ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="actuwt" HeaderText=" ActualWt   ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="subtotal" HeaderText=" Sub Total   ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"   HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="stax_cess_hcess" HeaderText=" S.Tax+HigherEdu.cess   ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="slabrate" HeaderText=" SlabRate ">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField  Visible="false" DataField="commission" HeaderText=" Commission">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "commission")%>'        runat="server">
                                            </asp:Label>
                                           
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Right" />
                                    </asp:TemplateField>
                            </Columns>
                            <RowStyle />
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                         
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="height: 21px; text-align: center">
                    <br />
                    <br />
                        <asp:Button ID="btnDwnXLS" runat="server" OnClick="btnDwnXLS_Click" Text="Download XLS" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
