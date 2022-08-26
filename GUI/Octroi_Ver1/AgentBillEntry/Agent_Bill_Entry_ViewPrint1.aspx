<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agent_Bill_Entry_ViewPrint1.aspx.cs" Inherits="GUI_Octroi_Ver1_AgentBillEntry_Agent_Bill_Entry_ViewPrint1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">         
       var printyn='1'
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
            <table width="900" align="left">
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
                    <td>
                        <br />
                        <asp:Panel ID="pnlHeader" runat="server">
                            <br />
                            <br />
                            <table border="1" cellpadding="2" cellspacing="1" style="width: 100%"
                                align="left">
                                <tr>
                                    <td colspan="4" align="center" style="height: 21px">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                   Agent Bill Summary
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td>
                                        <font class="blackfnt">Octroi Agent </font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblOctAgent" runat="server" CssClass="blackfnt" Width="200px"></asp:Label>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Bill date</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblbilldt" runat="server" CssClass="blackfnt" Width="65px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td style="height: 25px">
                                        <font class="blackfnt">Octroi paid by Agent Rs.</font>
                                    </td>
                                    <td style="height: 25px">
                                        <font class="blackfnt">
                                            <asp:Label ID="lbloctamt" runat="server" CssClass="blackfnt" Width="100px"></asp:Label></font>
                                    </td>
                                    <td style="height: 25px">
                                        <font class="blackfnt">Agent Bill number</font>
                                    </td>
                                    <td style="height: 25px">
                                        <asp:Label ID="lblagntbillno" runat="server" CssClass="blackfnt" Width="150px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td>
                                        <font class="blackfnt">Agent service charge</font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblagnttax" runat="server" CssClass="blackfnt" Width="80px"></asp:Label></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Agent Bill date</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblagntbilldt" runat="server" CssClass="blackfnt" Width="65px"></asp:Label>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td>
                                        <font class="blackfnt">Other Charges</font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblothrchg" runat="server" CssClass="blackfnt" Width="80px"></asp:Label></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Service Charge(%)</font>
                                    </td>
                                    <td>
                                        &nbsp;<asp:Label ID="lblserchgper" runat="server" CssClass="blackfnt" Width="80px"></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td>
                                        <font class="blackfnt">Form charges</font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblfrmcharg" runat="server" CssClass="blackfnt" Width="80px"></asp:Label></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Service Tax charged</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblservicetxtchrg" runat="server" CssClass="blackfnt" Width="80px"></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td>
                                        <font class="blackfnt">Clearance charges</font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblclearchrg" runat="server" CssClass="blackfnt" Width="80px"></asp:Label></font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Sundry charges</font>
                                    </td>
                                    <td>
                                        &nbsp;<asp:Label ID="lblsundry" runat="server" CssClass="blackfnt" Width="80px"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white" style="height: 25px">
                                    <td style="height: 25px">
                                        <font class="blackfnt">Total Due</font>
                                    </td>
                                    <td style="height: 25px">
                                        <asp:Label ID="lbltotdue" runat="server" CssClass="blackfnt" Width="100px"></asp:Label>
                                    </td>
                                    <td style="height: 25px">
                                        <font class="blackfnt">Due date</font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblduedate" runat="server" CssClass="blackfnt" Width="65px"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <asp:Panel ID="pnlFooter" runat="server">
                            <asp:GridView ID="gvAgentBillDetails" OnPageIndexChanging="PageIndexChanged_Click"
                                PagerStyle-Mode="NumericPages" PageSize="50" AutoGenerateColumns="false" BackColor="white" runat="server" SelectedIndex="1"
                                EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true"
                                Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Width="5%" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DOCKNO" HeaderText="Doc No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OCTAMT" HeaderText="Octroi Amt ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RECPTNO" HeaderText="Reciept No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RECPTDT" HeaderText="Reciept Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>                                
                                <PagerStyle HorizontalAlign="Center" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />                                
                            </asp:GridView>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
