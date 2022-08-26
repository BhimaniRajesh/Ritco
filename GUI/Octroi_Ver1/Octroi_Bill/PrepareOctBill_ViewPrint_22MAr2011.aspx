<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrepareOctBill_ViewPrint.aspx.cs"
    Inherits="GUI_Octroi_Ver1_Octroi_Bill_PrepareOctBill_ViewPrint" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
       var printyn='<%=printyn%>'
       if(printyn=="1")
       {
			window.print();
	   }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <table width="1000" align="left">
                <%--<tr>
        <td>
            <table bgcolor="white" border="0" id="tblLogo"
                            runat="server" cellpadding="0" cellspacing="0" class="boxbg" width="100%" >
                            <tr>
                                <td align="center" class="bgbluegrey">
                                    <table border="0" cellpadding="0" cellspacing="0" class="bgwhite" style="height: 100%;
                                        width: 100%">                                        
                                        <tr class="blackfnt" style="height: 22%">
                                            <td align="left" valign="top">
                                                <asp:Label ID="lblTitle" Font-Names="Book Antiqua" Font-Bold="true" Font-Size="18px"
                                                    Text="FUTURE LOGISTIC SOLUTIONS LIMITED" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="middle">
                                                <asp:Label ID="Label1" CssClass="blackfnt" Text="5A - Shyam Nagar, Off Jogeshwari Vikhroli Link Road,"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td rowspan="3" align="right">
                                                <img id="logo" style="height: 60px; width: 150px" alt="FutureLogo" src="../../images/Future_Group.jpg"/>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="top">
                                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Jogeshwari (East), Mumbai 400060"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="top">
                                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Tel No. 39569700 : Fax No. 39569701"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
        </td>
        </tr>--%>
                <tr>
                    <td style="width: 900px;" align="left">
                        <br />
                        <asp:Panel ID="pnlDetail" runat="server">
                            <table align="left" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
                                <tr class="bgbluegrey" style="height: 25px">
                                    <td colspan="5" align="center">
                                        <font class="blackfnt"><b>Octroi Bill Summary</b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 15px">
                                    <td style="width: 148px">
                                        <font class="blackfnt">Customer</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCustomer_Name" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Customer Type </font>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblCustomerType" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 15px">
                                    <td>
                                        <font class="blackfnt">Bill Date </font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblbgndt" runat="server" CssClass="blackfnt" Width="65px"></asp:Label><a
                                            href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtbgndt,'anchor112','dd/MM/yyyy'); return false;"
                                            name="anchor112" id="anchor112"> </a>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Due Date </font>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblduedate" runat="server" CssClass="blackfnt" Width="65px"></asp:Label></td>
                                </tr>
                                <tr bgcolor="white" style="height: 15px">
                                    <td>
                                        <font class="blackfnt">Bill Submission at </font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblbillsubloc" runat="server" CssClass="blackfnt" Width="200px"></asp:Label></td>
                                    <td>
                                        <font class="blackfnt">Billing Party Address</font></td>
                                    <td colspan="2">
                                        <asp:Label ID="Lbl_Party_address" runat="server" CssClass="blackfnt" Height="16px"
                                            Width="200px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <font class="blackfnt">Bill Collection at </font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblbillcolloc" runat="server" CssClass="blackfnt" Width="200px"></asp:Label></td>
                                    <td style="width: 203px">
                                        <font class="blackfnt">Party Phone Number</font></td>
                                    <td colspan="2">
                                        <asp:Label ID="Lbl_Party_tellno" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <font class="blackfnt">Manual Billno.</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblManualbillno" runat="server" CssClass="blackfnt" Width="150px"></asp:Label></td>
                                    <td>
                                        <font class="blackfnt">Party E-mail</font></td>
                                    <td colspan="2">
                                        <asp:Label ID="Lbl_Party_Email" runat="server" CssClass="blackfnt" Width="150px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <font class="blackfnt">Remark</font></td>
                                    <td colspan="2">
                                        <asp:Label ID="lblRemark" runat="server" CssClass="blackfnt" Width="270px"></asp:Label></td>
                                    <td>
                                        <font class="blackfnt">Total Bill Amount</font></td>
                                    <td>
                                        &nbsp;<asp:Label ID="lblbillamt" runat="server" CssClass="blackfnt" Width="65px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <font class="blackfnt">Special Instruction</font></td>
                                    <td colspan="4">
                                        <font class="blackfnt">
                                            <asp:Label ID="lblspl_ins" runat="server" CssClass="blackfnt" Width="270px"></asp:Label>
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td style="width: 900px;" align="left">
                        <br />
                        <asp:Panel ID="pnlFooter" runat="server">
                            <asp:GridView ID="gvOctroiDetails" OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages"
                                CssClass="boxbg" PageSize="50" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                                BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found..."
                                EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Dockno" HeaderText="Doc No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="declval" HeaderText="Decl. Value">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OCT_AMT" HeaderText="Octroi Amt ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="oct_Percentage" HeaderText="Octroi (%) ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="clearance_chrg" HeaderText="Clearance Charge">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="processing_per" HeaderText="Processing Charge(%)">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="process_chrg" HeaderText="Processing Charge">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OTCHG" HeaderText="Other Charge">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SVRCAMT" HeaderText="S.Tax">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CESSAMT" HeaderText="Cess">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Hedu_Cess" HeaderText="Higher Edu. Cess">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DKTTOT" HeaderText="Total">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OCT_RECEIPTNO" HeaderText="Reciept No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RECPTDT" HeaderText="Reciept Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle CssClass="bgbluegrey" />
                                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <br />
        </div>
    </form>
</body>
</html>
