<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="billmr_step2_test.aspx.cs" Inherits="Finance_Billing_Billcollection_billmr_step2" %>

<%@ Register TagPrefix="collectiondetail" TagName="chqdetail" Src="~/Usercontrol/WebUserControl.ascx" %>
<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/MyReceiptControl.ascx" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar" TagPrefix="pgb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>

    <script language="javascript" type="text/javascript" src="progressbar.js"></script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
	 
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
    </script>

    <%--</head>
<body>
    <form id="frm" runat="server">--%>
    <div>
        <asp:UpdatePanel ID="updstep1n2" runat="server">
            <ContentTemplate>
                <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
                    <asp:HiddenField ID="click_count" runat="server" Value="0" />
                    <tr>
                        <td>
                            <div id="showbar" style="font-size: 8pt; padding: 2px; border: solid black 1px; visibility: hidden">
                                <span id="progress1">&nbsp; &nbsp;</span> <span id="progress2">&nbsp; &nbsp;</span>
                                <span id="progress3">&nbsp; &nbsp;</span> <span id="progress4">&nbsp; &nbsp;</span>
                                <span id="progress5">&nbsp; &nbsp;</span> <span id="progress6">&nbsp; &nbsp;</span>
                                <span id="progress7">&nbsp; &nbsp;</span> <span id="progress8">&nbsp; &nbsp;</span>
                                <span id="progress9">&nbsp; &nbsp;</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <font class="blackfnt"><strong>Bill Collection </strong></font>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../../../images/clear.gif" width="15" height="10"></td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 60%"
                                align="Left">
                                <tr bgcolor="white" style="height: 25px">
                                    <td colspan="2" align="Left" style="height: 25px">
                                        <font class="blackfnt"><b>You Selected </b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="Left">
                                        <font class="blackfnt">Customer Code and Name</font></td>
                                    <td>
                                        <asp:Label ID="lblparty" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td style="width: 282px" align="Left">
                                        <font class="blackfnt">Docket Booking Date Range </font>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 90%"
                                align="Left">
                                <tr bgcolor="white">
                                    <td align="Left" nowrap>
                                        <font class="blackfnt"><b>MR Number </b></font>
                                    </td>
                                    <td align="Left" nowrap>
                                        <font class="blackfnt" color="red"><b>System Generated</b> </font>
                                    </td>
                                    <td align="Left" nowrap>
                                        <font class="blackfnt">CFN No. </font>
                                    </td>
                                    <td align="Left" nowrap>
                                        <asp:TextBox ID="Txt_manualMRsno" runat="server" Width="100px" onchange="javascript:this.value=this.value.toUpperCase()"
                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left" nowrap>
                                        <font class="blackfnt">MR Generation Date</font></td>
                                    <td nowrap>
                                        <asp:TextBox ID="txtVoucherDate" runat="server" Width="65px" Columns="8" onblur="javascript:ValidateDate(this)"
                                            BorderStyle="Groove" CssClass="blackfnt" Enabled="true"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                                            name="anchor1" id="a1">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a><font class="blackfnt">dd/mm/yyyy </font>
                                    </td>
                                    <td style="width: 282px" align="Left">
                                        <font class="blackfnt">MR branch </font>
                                    </td>
                                    <td style="width: 339px">
                                        <asp:Label ID="lblmrsbr" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td nowrap align="Left">
                                        <font class="blackfnt">Party Code and Name</font></td>
                                    <td nowrap>
                                        <asp:Label ID="lblpartydetail" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
                                    <td nowrap align="Left">
                                        <font class="blackfnt">Party Address </font>
                                    </td>
                                    <td nowrap>
                                        <asp:Label ID="lblpartyAddress" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
                                </tr>
                                <tr bgcolor="white">
                                    <td nowrap align="Left">
                                        <font class="blackfnt">Remarks</font></td>
                                    <td nowrap colspan="3">
                                        <asp:TextBox ID="Txt_remarks" onblur="javascript:this.value=this.value.toUpperCase()"
                                            runat="server" Columns="30" MaxLength="2000" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Tr_MultiView" runat="server" visible="false">
                        <td>
                            <br />
                            <table border="0" cellpadding="1" cellspacing="1" bgcolor="gray" style="width: 100%"
                                align="Left">
                                <tr bgcolor="white">
                                    <td>
                                        <asp:Label ID="Lbl_MtV_1" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField ID="HND_Dkt_Billno" runat="server" />
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td>
                                        <asp:MultiView ID="MultiView1" runat="server">
                                            <asp:View ID="View1" runat="server">
                                                <asp:GridView align="Left" ID="GridView1" Width="100%" runat="server" BorderWidth="0"
                                                    CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                                    AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"
                                                    OnRowDataBound="CustomersGridView_RowDataBound" EmptyDataText="No Records Found..."
                                                    OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="lblBillno" CssClass="blackfnt" Text="Billno" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="Lbl_Dockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Dockno") %>'></asp:Label>
                                                                <asp:HiddenField ID="HND_PendAmt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>' />
                                                                <asp:HiddenField ID="Hnd_SCHG" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHGCODE") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_1" CssClass="blackfnt" Text="Chg1" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG1" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG1" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_2" CssClass="blackfnt" Text="Chg2" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG2" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG2" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_3" CssClass="blackfnt" Text="Chg3" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG3" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG3" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_4" CssClass="blackfnt" Text="Chg4" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG4" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG4" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_5" CssClass="blackfnt" Text="Chg5" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG5" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG5" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_6" CssClass="blackfnt" Text="Chg6" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG6" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG6" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_7" CssClass="blackfnt" Text="Chg7" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG7" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG7" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_8" CssClass="blackfnt" Text="Chg8" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG8" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG8" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_9" CssClass="blackfnt" Text="Chg9" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG9" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG9" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Lbl_Chg_10" CssClass="blackfnt" Text="Chg10" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="CHG10" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                    runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Right" />
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="Txt_TOT_CHG10" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="lbl_Remarks" CssClass="blackfnt" Text="Remarks" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:TextBox Width="200" onblur="javascript:this.value=this.value.toUpperCase()"
                                                                    ID="Txt_Remarks" Text="" MaxLength="100" Style="text-align: Left;" runat="server"
                                                                    BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle />
                                                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                                    <HeaderStyle CssClass="bgbluegrey" />
                                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                                    <FooterStyle BackColor="white" />
                                                </asp:GridView>
                                            </asp:View>
                                        </asp:MultiView>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="right">
                                        <asp:Button ID="Btn_Dkt_details_Clear" runat="server" Text="Clear Data" CssClass="blackfnt"
                                            OnClientClick="javascript:Make_All_Zero()" />
                                        <asp:Button ID="Btn_Dkt_details_save" runat="server" Text="Click Here To Save Docket Wise Bill Collection Details"
                                            CssClass="blackfnt" OnClick="Save_DocketWise_Collection" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <pgb:ProgressBar ID="ProgressBar1" runat="server" />
                            <table border="0" cellpadding="1" cellspacing="1" width="100%" align="Left">
                                <tr bgcolor="white">
                                    <td>
                                        <center>
                                            <font class="blackfnt"><b>List of Bills : </b></font>
                                        </center>
                                        <asp:GridView align="Left" ID="dockdata" Width="100%" runat="server" BorderWidth="0"
                                            CellSpacing="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                            AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="CustomersGridView_RowDataBound"
                                            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged">
                                            <Columns>
                                                <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        Srno.
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:Label ID="LblSrno" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                                                            <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblBillno" CssClass="blackfnt" Text="Billno" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LK_Btn" runat="server" OnClick="Show_DocketWise_Collection" Text='<%# DataBinder.Eval(Container.DataItem,"Billno") %>'></asp:LinkButton>
                                                        <asp:HiddenField ID="Hnd_Billno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Billno") %>' />
                                                        <asp:HiddenField ID="Hnd_SCHG" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHGCODE") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="bgndt" HeaderText="Bill Date" ItemStyle-BackColor="white"
                                                    ItemStyle-Wrap="false">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" />
                                                </asp:BoundField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblbillamt" CssClass="blackfnt" Text="Bill Amt." runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="billamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"BILLAMT") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblPendAmt" CssClass="blackfnt" Text="Pending Amt." runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="pendamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>'></asp:Label>
                                                        <asp:HiddenField ID="txtpendamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="TDS" CssClass="blackfnt" Text="TDS" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="tds" runat="server" Width="80" onblur="javascript:Bill_Wise_Calc()"
                                                                Text="0.00" MaxLength="10" Style="text-align: Right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_1" CssClass="blackfnt" Text="Chg1" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG1" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_2" CssClass="blackfnt" Text="Chg2" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG2" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_3" CssClass="blackfnt" Text="Chg3" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG3" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_4" CssClass="blackfnt" Text="Chg4" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG4" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_5" CssClass="blackfnt" Text="Chg5" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG5" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_6" CssClass="blackfnt" Text="Chg6" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG6" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_7" CssClass="blackfnt" Text="Chg7" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG7" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_8" CssClass="blackfnt" Text="Chg8" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG8" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_9" CssClass="blackfnt" Text="Chg9" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG9" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Lbl_Chg_10" CssClass="blackfnt" Text="Chg10" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="CHG10" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblunexpamt" CssClass="blackfnt" Text="Balance Amount " runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="unexpamt" Width="80" Text="0.00" MaxLength="10" Style="text-align: Right;"
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                                BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblnetamt" CssClass="blackfnt" Text="Net Recd. Amount  " runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="totalamt" MaxLength="10" Enabled="False" Text='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>'
                                                                Width="80" Style="text-align: Right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                            <asp:HiddenField ID="Hidden_svctax_rate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"svctax_rate") %>' />
                                                            <asp:HiddenField ID="Hidden_cess_rate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"cess_rate") %>' />
                                                            <asp:HiddenField ID="Hidden_H_cess_rate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"H_cess_rate") %>' />
                                                            <asp:HiddenField ID="Hidden_svrcamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"svrcamt") %>' />
                                                            <asp:HiddenField ID="ptmscd" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ptmscd") %>' />
                                                            <asp:HiddenField ID="Billtype" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"paybas") %>' />
                                                            <asp:HiddenField ID="Hnd_BillSubDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"BillSubDate") %>' />
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lbl_Remarks" CssClass="blackfnt" Text="Remarks" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox Width="200" onblur="javascript:this.value=this.value.toUpperCase()"
                                                            ID="Txt_Remarks" Text="" MaxLength="100" Style="text-align: Left;" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle />
                                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                            <HeaderStyle CssClass="bgbluegrey" />
                                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                            <FooterStyle CssClass="boxbg" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <table border="0" cellspacing="1" cellpadding="4" width="80%" align="left" class="boxbg">
                                <font class="redfnt"><b>Note : Please Enter the Collection Details if Net Collection
                                    Amount >0 . </b></font>
                                <br />
                                <tr class="bgbluegrey">
                                    <td colspan="4" align="center">
                                        <font class="blackfnt"><b>Collection Details</font>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF">
                                    <td colspan="4" align="left">
                                        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server">
                                            <ContentTemplate>
                                                <UC5:UCMyReceiptControl ID="UCMyReceiptControls" runat="server"></UC5:UCMyReceiptControl>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <center>
                                <asp:Button ID="submit" runat="server" Text="Submit" OnClick="submit_Click1" CssClass="blackfnt"
                                    OnClientClick="javascript:return ONSubmit_Collection(this)" /></center>
                            <asp:HiddenField ID="Hnd_Server_dt" runat="server" />
                            <asp:HiddenField ID="Hnd_Mindate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_Maxdate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_DKt_BIll" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_AlloW_BackDate" runat="server"></asp:HiddenField>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script>
        window.onload=OnLoad
        function OnLoad()
        {   
           // alert("hi.....1")
           // progress_update()
           // alert("hi.....2")
            Bill_Wise_Calc()
          //  alert("hi.....3")
           // progress_stop()
        }
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
