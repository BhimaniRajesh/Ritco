<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PAYMENT_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
	    function nwOpen()
        {
            window.open("popupven.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
     
	    function nwOpen2(m1,m2)
        {
        //debugger
            window.open("popupasset.aspx?cd=" + m1+"&nm="+m2,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        //ctl00$MyCPH1$txtven
        
        
function cahs_N_bank(obj)
    {
                 
    }
    </script>

    <div align="center" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Goods Receipt</b></font>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
                        cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :
                                </label>
                            </td>
                            <td style="height: 10px">
                                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Vendor :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblloc" Text="All" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Purchase Order Code :</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </td>
            </tr>
        </table>
        <%--<tr>  
                                                                
                                                                
                                                                
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 90%"
            align="center">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="Label4" CssClass="bluefnt" Font-Bold="True" runat="server">Vendor Payment Voucher Summary</asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 90%"
            align="center">
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 15%">
                    <font class="blackfnt">Voucher No.</td>
                <td style="width: 35%">
                    <asp:Label ID="Label3" ForeColor="red" Text=" System Generated..." runat="server"
                        CssClass="blackfnt">
                       
                    </asp:Label>
                </td>
                <td style="width: 15%">
                    <font class="blackfnt">Voucher Date</font></td>
                <td style="width: 35%">
                    <asp:TextBox ID="txtvovdt" Width="100" runat="server" onblur="javascript:return validQuotationDate(this.getAttribute('id'))"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtvovdt,'anchor3','dd/MM/yyyy'); return false;"
                        name="anchor3" id="a3">
                        <img src="./../../images/calendar.jpg" border="0"></img>
                    </a><font class="blackfnt">dd/mm/yyyy</font>
                </td>
            </tr>
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 15%">
                    <font class="blackfnt">Vendor</td>
                <td style="width: 35%" colspan="3">
                    <asp:Label ID="lblven" runat="server" CssClass="blackfnt">
                       
                    </asp:Label>
                </td>
            </tr>
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 15%">
                    <font class="blackfnt">Vendor Tax No.</td>
                <td style="width: 35%">
                    <asp:Label ID="lblventax" Text="" runat="server" CssClass="blackfnt">
                       
                    </asp:Label>
                </td>
                <td style="width: 15%">
                    <font class="blackfnt">VendorPan No.</font></td>
                <td style="width: 35%">
                    <asp:Label ID="lblvenpan" runat="server" CssClass="blackfnt">
                       
                    </asp:Label>
                </td>
            </tr>
        </table>
        <br />
      <%--  <br />
        <br />--%>
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 90%"
            align="center">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="Label2" CssClass="bluefnt" Font-Bold="True" runat="server">Vendor Bill Details</asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" style="width: 90%" align="center">
            <tr bgcolor="white">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5"
                        Width="100%" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                        CellSpacing="1" OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                        ShowFooter="true" FooterStyle-BackColor="white" PagerSettings-FirstPageText="[First]"
                        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" Width="50" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                    <asp:CheckBox ID="chksrno" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="pocode" ItemStyle-Wrap="true" HeaderText="PO Code" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="podt" ItemStyle-Wrap="true" HeaderText="PO Date" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="totalamt" ItemStyle-Wrap="true" HeaderText="Net Payable"
                                HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="paidamt" ItemStyle-Wrap="true" HeaderText="Amount Paid"
                                HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Current Payment">
                                <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="True" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txttot" MaxLength="4" runat="server" Enabled="false"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txttottot" runat="server" Enabled="false"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr align="center">
            </tr>
        </table>
        <br />
       
        <center>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 90%"
                align="center">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="Label9" CssClass="bluefnt" Font-Bold="True" runat="server">Payment Summary</asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 90%"
                align="center">
                <tr bgcolor="white" style="height: 25px">
                    <td style="width: 15%">
                        <font class="blackfnt">TDS Rate</td>
                    <td style="width: 35%" align="left">
                        <asp:TextBox ID="txttdxrate" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 15%">
                        <font class="blackfnt">TDS Type</font></td>
                    <td align="left" style="width: 35%">
                        <asp:DropDownList ID="ddtdstype" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td style="width: 15%">
                        <font class="blackfnt">TDS Amount</td>
                    <td align="left" style="width: 35%">
                        <asp:TextBox align="left" ID="txttdsamt" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 15%">
                        <font class="blackfnt">TDS Deduct For</font></td>
                    <td align="left" style="width: 35%">
                        <asp:DropDownList ID="ddtdsdeductfor" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                   
                   
                        <td colspan="3" align="right" style="width: 15%">
                            <font class="blackfnt"><b>Net Payable</b></font></td>
                        <td align="left" style="width: 35%">
                            <asp:TextBox ID="txtnetpay" Width="100" runat="server"></asp:TextBox>
                        </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Mode Of Transaction </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:UpdatePanel ID="u1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboModeOfTransaction" runat="server" Width="60px" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"
                                        AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                                        <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                                        <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Payment Account</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboPaymentAccount" runat="server" Width="152px" AutoPostBack="true"
                                        onchange="javascript:cahs_N_bank(this)">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Cheque No </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:TextBox ID="txtChequeNo" runat="server" Width="70px" MaxLength="6"></asp:TextBox></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Cheque Date </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:TextBox ID="txtChequeDate" runat="server" Width="70px" onblur="javascript:ValidateForm(this)"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor4','dd/MM/yyyy'); return false;"
                                name="anchor4" id="a4">
                                <img src="./../../images/calendar.jpg" border="0"></img>
                            </a>dd/mm/yyyy </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left">
                        <font class="blackfnt">Payment Amount</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:TextBox ID="txtPaymentAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Cash Amount</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:TextBox ID="txtCashAmount" runat="server" Width="70px" Enabled="false"></asp:TextBox></font>
                    </td>
                </tr>
            </table>
        </center>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
