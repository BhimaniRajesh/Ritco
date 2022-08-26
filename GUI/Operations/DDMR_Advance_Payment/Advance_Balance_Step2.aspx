<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Advance_Balance_Step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    
    <script type="text/javascript" src="../../images/dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript" src="../../Finance/VendorPayment_Ver1/VendorPayment.js"></script>
    
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	cal.showNavigationDropdowns();
	User_CTR_Frm_Name="ctl00_MyCPH1_UCMyPaymentControl1_"
	FRM_NM="ctl00_MyCPH1_"
	 var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		    FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
		
	//	onkeyup="javascript:Total_calC_THC_BalPayment()"
	
    


    </script>

    <br />
    <div align="left">
        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
            runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <table border="0" style="width: 6in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                                class="boxbg">
                                <tr class="bgbluegrey">
                                    <td colspan="2">
                                        Select Process
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td>
                                        <asp:RadioButton ID="RD_Process_Bill" runat="server" Text="Vendor Bill Entry<b>(No Payment)</b>"
                                            GroupName="RD_Prcess" CssClass="blackfnt" onclick="javascript:ONProcessChange()" />
                                    </td>
                                    <td>
                                        <asp:RadioButton ID="RD_Process_Payment" runat="server" Text="Vendor Bill Entry<b>(Part/Full Payment)</b>"
                                            GroupName="RD_Prcess" CssClass="blackfnt" onclick="javascript:ONProcessChange()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Payment_Row1" runat="server">
                        <td>
                            <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                                class="boxbg">
                                <asp:HiddenField ID="click_count" runat="server" Value="0" />
                                <asp:HiddenField ID="Hnd_ServerDt" runat="server" Value="0" />
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <font face="verdana" size="3"><b>
                                            <asp:Label ID="Lbl_Title" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                                            <asp:HiddenField ID="Hnd_Server_dt" runat="server" />
                                        </b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lbl_date" runat="server"></asp:Label></font>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">
                                            <asp:TextBox ID="TxtVoucherDT" runat="server" Width="65px" Columns="10" onblur="javascript:ValidateDate(this)"
                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtVoucherDT,'a1','dd/MM/yyyy'); return false;"
                                                name="a1" id="a1">
                                                <img src="../../images/calendar.jpg" border="0" />
                                            </a>DD/MM/YYYY </font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lbl_manualno" runat="server"></asp:Label></font>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">
                                            <asp:TextBox ID="Txt_Manual_Voucherno" runat="server" Width="100px" onblur="javascript:this.value=this.value.toUpperCase()"
                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Tr_Bill1" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt">Vendor Name</font>
                                    </td>
                                    <td align="Left" colspan="2">
                                        <font class="blackfnt">
                                            <asp:Label ID="Lbl_VendorCode" runat="server" CssClass="blackfnt"></asp:Label></font>
                                    </td>
                                    <td align="Left" nowrap>
                                        <a href="#" id="View_Contract" runat="server" target="_blank"><font class="bluefnt">
                                            <b>View Vendor Contract</b></font> </a>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Tr_Bill3" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt"><b>Vendor Bill Amount</b></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Txt_billamt"
                                                runat="server" Enabled="false" MaxLength="12" Columns="10" Text='0.00'></asp:TextBox></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">Vendor Bill Date</font>
                                    </td>
                                    <td align="Left">
                                        <font class="bluefnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: left" ID="Txt_VDate"
                                                runat="server" Enabled="true" MaxLength="12" Columns="10"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$Txt_VDate,'a2','dd/MM/yyyy'); return false;"
                                                name="a2" id="a2">
                                                <img src="../../images/calendar.jpg" border="0" />
                                            </a>DD/MM/YYYY </font>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Tr1" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt"><b>Payment Amount</b></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Txt_PaymentAmt"
                                                runat="server" Enabled="false" MaxLength="12" Columns="10" Text='0.00'></asp:TextBox></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt"><b>Pending Amount</b></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Txt_PendingAmt"
                                                runat="server" Enabled="false" MaxLength="12" Columns="10" Text='0.00'></asp:TextBox></font>
                                    </td>
                                </tr>
                                <%--<tr bgcolor="#FFFFFF" id="Tr_Bill4" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt">Due Days</font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Txt_DueDays"
                                                onkeypress="javascript:validInt(event)" onblur="javascript:ADD_DueDate()" runat="server"
                                                Enabled="true" MaxLength="3" Columns="10" Text='15'></asp:TextBox></font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">Due Date</font>
                                    </td>
                                    <td align="Left">
                                        <font class="blackfnt">
                                            <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: left" ID="Txt_Duedate"
                                                runat="server" Enabled="false" MaxLength="12" Columns="10"></asp:TextBox>
                                        </font>
                                    </td>
                                </tr>--%>
                                <tr bgcolor="white" id="Tr_Bill5" runat="server">
                                    <td align="Left">
                                        <font class="blackfnt">Remarks</font>
                                    </td>
                                    <td align="Left" colspan="3">
                                        <font class="redfnt">
                                            <asp:TextBox ID="Txt_Remarks" onblur="javascript:this.value=this.value.toUpperCase()"
                                                Width="200" Text="" Rows="3" TextMode="MultiLine" MaxLength="500" Style="text-align: Left"
                                                runat="server" BorderStyle="Groove" CssClass="input"></asp:TextBox></font>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="TR_THC_ADV" runat="server" visible="false">
                        <td>
                            <br />
                            <div align="left">
                                <asp:GridView ID="GV_THC_BAL_PAYMENT" align="center" runat="server" AutoGenerateColumns="False"
                                    Width="800px" BorderWidth="0" CellSpacing="1" CellPadding="3" BorderStyle="None"
                                    CssClass="boxbg" Visible="true" ShowFooter="true" EmptyDataText="No Records Found..."
                                    Style="width: 9.5in" OnRowDataBound="CustomersGridView_RowDataBound">
                                    <%--OnRowDataBound="CustomersGridView_RowDataBound"  --%>
                                    <Columns>
                                        <asp:TemplateField HeaderText="SRNo." ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white">
                                            <HeaderTemplate>
                                                <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="docno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"DDMRNo") %>'></asp:Label>
                                                <asp:HiddenField ID="Hnd_Docdt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"DDMRDt") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amt.(+)"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="indpcamt"
                                                    runat="server" Enabled="false" MaxLength="12" Columns="10" Text='<%# DataBinder.Eval(Container.DataItem,"ContAmt") %>'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_PCAMT"
                                                    Font-Bold="true" runat="server" Enabled="false" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Other Amt.(+) "
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="indothamt"
                                                    MaxLength="10" Columns="8" Enabled="false" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OTherChrg") %>'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_OTHAMT"
                                                    Font-Bold="true" runat="server" Enabled="false" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text="Advance Amt. (-) "
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" Enabled="false"
                                                    ID="indadvamt" MaxLength="12" Columns="10" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>'></asp:TextBox>
                                                <asp:HiddenField ID="NetbalAmt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"BalAmt") %>' />
                                                <asp:HiddenField ID="Hidden_indadvamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>' />
                                                <asp:HiddenField ID="Hnd_DOcumentType" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"DocType") %>' />
                                               <%-- <asp:HiddenField ID="Hnd_SCHG" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHGCODE") %>' />--%>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="TotalNetamt"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblNetPayable" Style="text-align: center" CssClass="blackfnt" Text="Balance Amt."
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="indnetpay"
                                                    Enabled="false" MaxLength="12" Columns="10" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BalAmt") %>'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_Balamt"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_1" Style="text-align: center" CssClass="blackfnt" Text="Incentive Charges(+)"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="TxtIncChrg"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_IncChrg"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_2" Style="text-align: center" CssClass="blackfnt" Text="Penalty Charge(-)"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="TxtPenChrg"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_PenChrg"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_3" Style="text-align: center" CssClass="blackfnt" Text="Deduction Charges(-)"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="TxtDedChrg"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_DedChrg"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_4" Style="text-align: center" CssClass="blackfnt" Text="SCHG4"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG4"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG4"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_5" Style="text-align: center" CssClass="blackfnt" Text="SCHG5"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG5"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG5"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_6" Style="text-align: center" CssClass="blackfnt" Text="SCHG6"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG6"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG6"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_7" Style="text-align: center" CssClass="blackfnt" Text="SCHG7"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG7"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG7"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_8" Style="text-align: center" CssClass="blackfnt" Text="SCHG8"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG8"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG8"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_9" Style="text-align: center" CssClass="blackfnt" Text="SCHG9"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG9"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG9"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="Lbl_Chg_10" Style="text-align: center" CssClass="blackfnt" Text="SCHG10"
                                                    runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="SCHG10"
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="true"
                                                    MaxLength="12" Columns="10" runat="server" Text='0.00'></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_SCHG10"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblNetPaymentAmt" CssClass="blackfnt" Text="Net Payable" runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:TextBox ID="indNetPaymentAmt" BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right"
                                                        MaxLength="12" Columns="10" Enabled="false" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BalAmt") %>'></asp:TextBox>
                                                </center>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_BalanceAMT"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-BackColor="white" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Right"
                                            FooterStyle-HorizontalAlign="Right">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblNetPaymentAmt1" CssClass="blackfnt" Text="Payment Amount" runat="server"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:TextBox ID="indNetBillPaymentAmt" BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right"
                                                        MaxLength="12" Columns="10"   runat="server" Text="0.00"></asp:TextBox>
                                                </center>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right" ID="Total_BillPayment"
                                                    Font-Bold="true" runat="server" Enabled="false" MaxLength="12" Text="0.00" Columns="10"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle />
                                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                    <HeaderStyle CssClass="bgbluegrey" />
                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                    <FooterStyle CssClass="bgbluegrey" />
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr id="Payment_Row2" runat="server">
                        <td>
                            <br />
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                                <tr class="bgbluegrey">
                                    <td style="text-align: center" class="blackfnt" colspan="4">
                                        <b>S.tax & TDS Details</b>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td style="text-align: center" class="blackfnt" colspan="2">
                                        <asp:CheckBox ID="Svctax_yn" runat="server" onclick="javascript:Stax_Tds_Calc()" />
                                        <strong><font color="red">Plz Check Here to Enable Service Tax </font></strong>
                                    </td>
                                    <td style="text-align: center" class="blackfnt" colspan="2">
                                        <asp:CheckBox ID="TDS_yn" runat="server" onclick="javascript:Stax_Tds_Calc()" />
                                        <strong><font color="red">Plz Check Here to Enable TDS </font></strong>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td style="text-align: center" class="blackfnt" colspan="2">
                                        <strong>ADD Service Tax(+) </strong>
                                    </td>
                                    <td style="text-align: center" class="blackfnt" colspan="2">
                                        <strong>LESS TDS (-) </strong>
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Amount Applicable
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtAmtAppl" runat="server" Style="text-align: right" BorderStyle="Groove"
                                            Text="0.00" CssClass="blackfnt" Width="80px" Enabled="False"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Amount Applicable
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" Style="text-align: right" BorderStyle="Groove"
                                            Text="0.00" CssClass="blackfnt" Width="80px" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Service tax (+)
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" Style="text-align: right" Text="0.00"
                                            onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="blackfnt"
                                            Width="80px" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField ID="HdnServiceTax" runat="server" />
                                        <asp:HiddenField ID="HdnServiceTaxRate" runat="server" />
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;TDS Section
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:DropDownList ID="Tdssection" runat="server" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Education Cess (+)
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtEduCess" runat="server" Style="text-align: right" Text="0.00"
                                            onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="blackfnt"
                                            Width="80px" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField ID="HdnEduCess" runat="server" />
                                        <asp:HiddenField ID="HdnEduCessRate" runat="server" />
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;TDS Rate
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" Style="text-align: right" Text="0.000"
                                            BorderStyle="Groove" onblur="javascript:Stax_Tds_Calc()" CssClass="blackfnt"
                                            Width="80px" MaxLength="7" Enabled="true"></asp:TextBox>
                                        <asp:HiddenField ID="HdnTDSRate" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Higher Education Cess (+)
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" Style="text-align: right" Text="0.00"
                                            onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="blackfnt"
                                            Width="80px" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField ID="HdnHEduCess" runat="server" />
                                        <asp:HiddenField ID="HdnHEduCessRate" runat="server" />
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;TDS Amount (-)
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" Style="text-align: right" Text="0.00"
                                            onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="blackfnt"
                                            Width="80px" Enabled="false"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="HdnTdsAmt" />
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;Service Tax Reg No.
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtSrvTaxNo" runat="server" Style="text-align: left" BorderStyle="Groove"
                                            CssClass="blackfnt" Width="140px" MaxLength="20"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;PAN Number
                                    </td>
                                    <td style="text-align: left" class="blackfnt">
                                        &nbsp;<asp:TextBox ID="txtPanNo" runat="server" Style="text-align: left" BorderStyle="Groove"
                                            CssClass="blackfnt" Columns="10" MaxLength="10" Width="80px"></asp:TextBox>
                                        <asp:HiddenField ID="Hnd_totalAmount" runat="server" Value="0.00" />
                                         <asp:HiddenField ID="Hnd_PaymentAmt" runat="server" Value="0.00" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Payment_Row3" runat="server">
                        <td>
                            <table border="0" cellspacing="1" cellpadding="4" width="700" align="left" class="boxbg">
                                <caption>
                                    <font class="blackfnt">Note : Please enter the payment details if Net Payable amount &gt;0 . </font>
                                    <tr class="bgbluegrey">
                                        <td align="center" colspan="4">
                                            <font class="blackfnt"><b>Payment Details</b></font>
                                        </td>
                                    </tr>
                                    <tr style="background-color: #FFFFFF">
                                        <td align="center" colspan="4">
                                            <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" />
                                        </td>
                                    </tr>
                                </caption>
                            </table>
                        </td>
                    </tr>
                    <tr id="Payment_Row4" runat="server">
                        <td align="left">
                            <br />
                            <asp:UpdateProgress ID="uppMain" runat="server">
                                <ProgressTemplate>
                                    <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                                        top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                            <tr>
                                                <td align="right">
                                                    <img src="../../images/loading.gif" alt="" />
                                                </td>
                                                <td>
                                                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <br />
                            <asp:HiddenField ID="Hnd_Doc_type" runat="server" />
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>

                <script language="javascript" type="text/javascript">

                    window.onload = onPageLoad
                    function onPageLoad() {
                        //if(document.getElementById(FRM_NM+"Hnd_Doc_type").value=="THC")
                        // {
                        FRM_NM = "ctl00_MyCPH1_"
                        Total_calC_THC_BalPayment_Onload()
                        OpenChild()

                        // }
                    }
                    function OpenChild() {
                        //var FRM_NM = "ctl00_MyCPH1_"
                        document.getElementById(FRM_NM + "TR_THC_ADV").style.display = "none";
                        document.getElementById(FRM_NM + "Payment_Row1").style.display = "none";
                        document.getElementById(FRM_NM + "Payment_Row2").style.display = "none";
                        document.getElementById(FRM_NM + "Payment_Row3").style.display = "none";
                        document.getElementById(FRM_NM + "Payment_Row4").style.display = "none";
                    }

                    function ONProcessChange() {

                        if (document.getElementById(FRM_NM + "RD_Process_Bill").checked) {
                            document.getElementById(FRM_NM + "TR_THC_ADV").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row1").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row2").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row3").style.display = "none";
                            document.getElementById(FRM_NM + "Payment_Row4").style.display = "block";
                            //  document.getElementById(FRM_NM+"Tr_Bill1").style.display ="block";
                            // document.getElementById(FRM_NM+"Tr_Bill2").style.display ="block";
                            document.getElementById(FRM_NM + "Tr_Bill3").style.display = "block";
                            //document.getElementById(FRM_NM + "Tr_Bill4").style.display = "block";
                            document.getElementById(FRM_NM + "Tr_Bill5").style.display = "block";
                            document.getElementById(FRM_NM + "lbl_date").innerText = "Bill Date";
                            document.getElementById(FRM_NM + "lbl_manualno").innerText = "Vendor Billno";
                        }
                        else if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                            document.getElementById(FRM_NM + "TR_THC_ADV").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row1").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row2").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row3").style.display = "block";
                            document.getElementById(FRM_NM + "Payment_Row4").style.display = "block";
                            // document.getElementById(FRM_NM+"Tr_Bill1").style.display ="none";
                            //  document.getElementById(FRM_NM+"Tr_Bill2").style.display ="none";
                            document.getElementById(FRM_NM + "Tr_Bill3").style.display = "block";
                            //document.getElementById(FRM_NM + "Tr_Bill4").style.display = "block";
                            document.getElementById(FRM_NM + "Tr_Bill5").style.display = "block";
                            document.getElementById(FRM_NM + "lbl_date").innerText = "Bill Date";
                            document.getElementById(FRM_NM + "lbl_manualno").innerText = "Vendor Billno";
                        }
                        
                        var grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                        var rows = grid.rows.length;
                        var TOT_Billamt = 0;
                        for (var i = 2; i <= rows - 1; i++) {
                            if (i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                            if (document.getElementById(FRM_NM + "RD_Process_Bill").checked) {
                                document.getElementById(Form_name + "indNetBillPaymentAmt").disabled = true;
                                document.getElementById(Form_name + "indNetBillPaymentAmt").value = "0.00";
                            }
                            else if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                            document.getElementById(Form_name + "indNetBillPaymentAmt").disabled = false;
                            document.getElementById(Form_name + "indNetBillPaymentAmt").value = document.getElementById(Form_name + "indNetPaymentAmt").value;
                            }
                        }
                        Total_calC_THC_BalPayment_Onload()
                        //Stax_Tds_Calc()
                    }

                    function Total_calC_THC_BalPayment_Onload() {
                        var grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                        var rows = grid.rows.length;

                        Total_AdvAMT = 0;
                        Total_ContractAmt = 0;
                        Total_OthAmt = 0;
                        Total_BalanceAMT = 0;
                        IND_BalanceAMT = 0;
                        Ind_TOT_oth = 0;
                        Total_BalAMT = 0;
                        Total_PaymentAMT = 0;
                        for (var i = 2; i <= rows - 1; i++) {
                            if (i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                            Total_AdvAMT = parseFloat(Total_AdvAMT) + parseFloat(document.getElementById(Form_name + "indadvamt").value)
                            Total_ContractAmt = parseFloat(Total_ContractAmt) + parseFloat(document.getElementById(Form_name + "indpcamt").value)
                            //Total_OthAmt = parseFloat(Total_OthAmt) + parseFloat(document.getElementById(Form_name + "indothamt").value)

                            //document.getElementById(Form_name + "indnetpay").value = rounditn(parseFloat(document.getElementById(Form_name + "indpcamt").value) - parseFloat(document.getElementById(Form_name + "indadvamt").value) + parseFloat(document.getElementById(Form_name + "indothamt").value), 2)
                            document.getElementById(Form_name + "indnetpay").value = rounditn(parseFloat(document.getElementById(Form_name + "indpcamt").value) - parseFloat(document.getElementById(Form_name + "indadvamt").value), 2)
                            Total_BalAMT = parseFloat(Total_BalAMT) + parseFloat(document.getElementById(Form_name + "indnetpay").value)

                            document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(document.getElementById(Form_name + "indnetpay").value, 2);
                            if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                                document.getElementById(Form_name + "indNetBillPaymentAmt").value = rounditn(document.getElementById(Form_name + "indnetpay").value, 2);
                            }
                            Total_BalanceAMT = parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value);
                            Total_PaymentAMT = parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value);

                        }
                        if (i < 10)
                            Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                        else
                            Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                        document.getElementById(Form_name1 + "TotalNetamt").value = rounditn(Total_AdvAMT, 2);
                        document.getElementById(Form_name1 + "Total_PCAMT").value = rounditn(Total_ContractAmt, 2);
                        //document.getElementById(Form_name1 + "Total_OTHAMT").value = rounditn(Total_OthAmt, 2);
                        document.getElementById(Form_name1 + "Total_Balamt").value = rounditn(Total_BalAMT, 2);
                        document.getElementById(Form_name1 + "Total_BalanceAMT").value = rounditn(Total_BalanceAMT, 2);
                        document.getElementById(Form_name1 + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "Hnd_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "txtAmtAppl").value = rounditn(Total_BalanceAMT, 2);
                        document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(Total_BalanceAMT, 2);

                        Stax_Tds_Calc()
                    }
                    function Stax_Tds_Calc() {

                        var TaxAmount = 0
                        if (document.getElementById(FRM_NM + "Svctax_yn").checked) {
                            AmtAply = document.getElementById(FRM_NM + "txtAmtAppl").value
                            document.getElementById(FRM_NM + "txtServiceTax").value = rounditn((parseFloat(AmtAply) * 10) / 100, 2)
                            document.getElementById(FRM_NM + "txtEduCess").value = rounditn((parseFloat(document.getElementById(FRM_NM + "txtServiceTax").value) * 2) / 100, 2)
                            document.getElementById(FRM_NM + "txtHEduCess").value = rounditn((parseFloat(document.getElementById(FRM_NM + "txtServiceTax").value) * 1) / 100, 2)
                            var AmtAply_Tds = document.getElementById(FRM_NM + "txtAmtAppl").value
                            TaxAmount = parseFloat(TaxAmount) + parseFloat(document.getElementById(FRM_NM + "txtServiceTax").value)
                            TaxAmount = parseFloat(TaxAmount) + parseFloat(document.getElementById(FRM_NM + "txtEduCess").value)
                            TaxAmount = parseFloat(TaxAmount) + parseFloat(document.getElementById(FRM_NM + "txtHEduCess").value)
                            document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(parseFloat(TaxAmount) + parseFloat(AmtAply_Tds), 2)
                        }
                        else {
                            document.getElementById(FRM_NM + "txtServiceTax").value = "0.00"
                            document.getElementById(FRM_NM + "txtEduCess").value = "0.00"
                            document.getElementById(FRM_NM + "txtHEduCess").value = "0.00"
                            document.getElementById(FRM_NM + "txtAmtApplL").value = document.getElementById(FRM_NM + "txtAmtAppl").value
                        }
                        document.getElementById(FRM_NM + "txtTDSRate").value = rounditn(document.getElementById(FRM_NM + "txtTDSRate").value, 3)
                        if (document.getElementById(FRM_NM + "TDS_yn").checked) {
                            AmtAply = document.getElementById(FRM_NM + "txtAmtApplL").value
                            document.getElementById(FRM_NM + "txtTDSAmt").value = rounditn((parseFloat(AmtAply) * parseFloat(document.getElementById(FRM_NM + "txtTDSRate").value)) / 100, 2)
                            TaxAmount = parseFloat(TaxAmount) - parseFloat(document.getElementById(FRM_NM + "txtTDSAmt").value)
                        }
                        else {
                            document.getElementById(FRM_NM + "txtTDSAmt").value = "0.00"
                        }
                        Total_BalanceAMT = parseFloat(document.getElementById(FRM_NM + "txtAmtAppl").value) + parseFloat(TaxAmount)

                        if (document.getElementById(FRM_NM + "RD_Process_Bill").checked) 
                        {
                            document.getElementById(FRM_NM + "Txt_billamt").value = rounditn(Total_BalanceAMT, 2)
                        }
                        else if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) 
                        {
                            document.getElementById(User_CTR_Frm_Name + "txtNetPay").value = rounditn(Total_BalanceAMT, 2)
                            document.getElementById(User_CTR_Frm_Name + "txtAmtApplA").value = rounditn(Total_BalanceAMT, 2)
                            if (document.getElementById(User_CTR_Frm_Name + "ddlPayMode").value == "Cash") 
                            {
                                document.getElementById(User_CTR_Frm_Name + "txtCashAmt").value = rounditn(Total_BalanceAMT, 2)
                            }
                            if (document.getElementById(User_CTR_Frm_Name + "ddlPayMode").value == "Bank") 
                            {
                                document.getElementById(User_CTR_Frm_Name + "txtChqAmt").value = rounditn(Total_BalanceAMT, 2)
                            }
                            if (document.getElementById(User_CTR_Frm_Name + "ddlPayMode").value == "Both") 
                            {
                                document.getElementById(User_CTR_Frm_Name + "txtCashAmt").value = "0.00";
                                document.getElementById(User_CTR_Frm_Name + "txtChqAmt").value = "0.00";
                            }
                        }
                    }


                    /*************************************************************************************************************
                    Balance Payment/BillEntry Calculation Function
                    *************************************************************************************************************/
                    var PaymentAmt_Flag = "N";
                    function Total_calC_THC_BalPayment(OBJ,Contract_Type) 
                    {
                        //alert("1");
                        Objname = OBJ.name.replace(Form_name, '');
                        if (Objname == "indNetBillPaymentAmt") {
                            PaymentAmt_Flag = "Y";
                        }
                        var grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                        var rows = grid.rows.length;
                        Total_SvcTax = 0;
                        Total_Tds = 0;
                        Tot_bal_Amt = 0;
                        Total_BalanceAMT = 0;
                        IND_BalanceAMT = 0;
                        Total_PaymentAMT = 0;
                        Total_TxtIncChrg = 0;
                        Total_TxtPenChrg = 0;
                        Total_TxtDedChrg = 0;
                        for (var i = 2; i <= rows - 1; i++) 
                        {
                            if (i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"

                            var Advamt = parseFloat(document.getElementById(Form_name + "indadvamt").value);
                            var ContractAmt = parseFloat(document.getElementById(Form_name + "indpcamt").value);
                            // var ContractAmt=parseFloat(document.getElementById(Form_name+"indpcamt").value)
                            //var OtherAmt = parseFloat(document.getElementById(Form_name + "indothamt").value);
                            var TxtIncChrg = parseFloat(document.getElementById(Form_name + "TxtIncChrg").value);
                            var TxtPenChrg = parseFloat(document.getElementById(Form_name + "TxtPenChrg").value);
                            var TxtDedChrg = parseFloat(document.getElementById(Form_name + "TxtDedChrg").value);

                            Total_TxtIncChrg = parseFloat(Total_TxtIncChrg) + parseFloat(document.getElementById(Form_name + "TxtIncChrg").value)
                            Total_TxtPenChrg = parseFloat(Total_TxtPenChrg) + parseFloat(document.getElementById(Form_name + "TxtPenChrg").value)
                            Total_TxtDedChrg = parseFloat(Total_TxtDedChrg) + parseFloat(document.getElementById(Form_name + "TxtDedChrg").value)
                            
                            if (Contract_Type == "KM_BASED") {
                                var Tot_ind_Balamt = -parseFloat(Advamt) + parseFloat(OtherAmt) + parseFloat(Charge_Val_Tot);

                            }
                            else {
                                var Tot_ind_Balamt = (parseFloat(ContractAmt)+ parseFloat(TxtIncChrg)) - (parseFloat(Advamt)+parseFloat(TxtPenChrg) + parseFloat(TxtDedChrg));
                            }

                            if (parseFloat(Tot_ind_Balamt) <= 0) {
                                if (PaymentAmt_Flag == "N") {
                                    if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                                        document.getElementById(Form_name + "indNetBillPaymentAmt").value = "0.00"
                                    }
                                }
                                document.getElementById(Form_name + "indNetPaymentAmt").value = "0.00";
                            }
                            else {
                                if (PaymentAmt_Flag == "N") {
                                    if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                                        document.getElementById(Form_name + "indNetBillPaymentAmt").value = rounditn(Tot_ind_Balamt, 2);
                                    }
                                }
                                document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(Tot_ind_Balamt, 2);
                            }
                            if (parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value) < parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value)) {
                                //alert("61");
                                alert("Bill Entry Payment Amount sould be less then Bill Entry Amount");
                                document.getElementById(Form_name + "indNetBillPaymentAmt").value = 0.00;
                                //alert("62");
                                document.getElementById(Form_name + "indNetBillPaymentAmt").focus();
                                return false;
                            }

                            Total_BalanceAMT = rounditn(parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value), 2)
                            Total_PaymentAMT = parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value)
                        }

                        if (rows < 10)
                            Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + rows + "$"
                        else
                            Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + rows + "$"

                        document.getElementById(Form_name_Footer + "Total_BalanceAMT").value = rounditn(Total_BalanceAMT, 2)
                        document.getElementById(Form_name_Footer + "Total_IncChrg").value = rounditn(Total_TxtIncChrg, 2)
                        document.getElementById(Form_name_Footer + "Total_PenChrg").value = rounditn(Total_TxtPenChrg, 2)
                        document.getElementById(Form_name_Footer + "Total_DedChrg").value = rounditn(Total_TxtDedChrg, 2)
                        if (Contract_Type == "KM_BASED") {
                            Total_BalanceAMT = parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(FRM_NM + "Txt_ContractAmt").value)
                        }
                        //alert("7");
                        document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "Hnd_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);

                        document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
                        document.getElementById(Form_name1 + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 2);
                        document.getElementById(FRM_NM + "txtAmtAppl").value = rounditn(Total_BalanceAMT, 2)
                        document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(Total_BalanceAMT, 2)
                        //alert("8");
                        Stax_Tds_Calc()
                        //alert("9");

                   }
                </script>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
