<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="billmr_step2.aspx.cs" Inherits="Finance_Billing_Billcollection_billmr_step2" %>

<%@ Register TagPrefix="collectiondetail" TagName="chqdetail" Src="~/Usercontrol/WebUserControl.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="uc1" %>
<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/MyReceiptControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--Model pop up Style--%>
    <style type="text/css">
        .eleWidth {
            width: 80px !important;
        }

        .eleWidthDev {
            width: 150px !important;
        }


        .ui-widget-header .ui-state-default, .ui-widget-header .ui-state-default:hover, .ui-widget-header .ui-icon:hover, .ui-widget-header .ui-button-text:hover {
            background-repeat: no-repeat !important;
            background-position-x: 30% !important;
        }

        /*.ui-dialog-titlebar-close > span:first-child, .ui-dialog-titlebar-close:hover > span:first-child {
            background-image: url('images/close.png') !important;
            background-repeat: no-repeat !important;
            position: relative !important;
            top: 0 !important;
            left: 0 !important;
            background-color: transparent !important;
        }*/
    </style>
    <%--Model pop up Style END--%>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>

    <script language="javascript" type="text/javascript" src="progressbar.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var months = new Array("", "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"

        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1

        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to
    </script>

    <%--</head>
<body>
    <form id="frm" runat="server">--%>
    <div>
        <asp:UpdatePanel ID="updstep1n2" runat="server" UpdateMode="Conditional">
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
                                        <font class="blackfnt">Remarks</font>
                                    </td>
                                    <td nowrap>
                                        <asp:TextBox ID="Txt_remarks" onblur="javascript:this.value=this.value.toUpperCase()"
                                            runat="server" Columns="30" MaxLength="2000" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                    </td>
                                    <td nowrap align="Left" >
                                        <asp:Label ID="lblCustName" runat="server" Text="Customer Name" CssClass="blackfnt" Visible="false"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblCreditLimit" runat="server" Text="Credit Limit" CssClass="blackfnt" Visible="false"></asp:Label>
                                    </td>
                                    <td nowrap align="Left" >
                                        <asp:TextBox ID="txtCustomerName" runat="server" BorderStyle="Groove" Width="240px"
                                            onblur="javascript:this.value=this.value.toUpperCase()" CssClass="blackfnt" MaxLength="100" Visible="false"></asp:TextBox>
                                        <br />
                                        <asp:TextBox ID="txtCreditLimit" runat="server" BorderStyle="Groove" Width="100px"
                                            CssClass="blackfnt" onkeypress="javascript:return validInt(event,this.getAttribute('id'))" Visible="false"></asp:TextBox>
                                    </td>
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
                            <asp:UpdateProgress ID="uppMain" runat="server">
                                <ProgressTemplate>
                                    <iframe frameborder="1" src="about:blank" style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
                                    <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                                            width="190px" cellpadding="0" bgcolor="white">
                                            <tr>
                                                <td align="right">
                                                    <img src="../../../images/loading.gif" alt="" /></td>
                                                <td>
                                                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                                            </tr>
                                        </table>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
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
                                                        <asp:TextBox ID="CHG9" Width="80" Text="0.00" MaxLength="10" Style="text-align:Right;color:blue;"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"
                                                            BorderStyle="Groove" CssClass="blackfnt" onclick="javascript: openEffortsPopup(this.id)" ></asp:TextBox>
                                                      
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
                                                            <asp:HiddenField ID="Hnd_PhotoXML" runat="server"></asp:HiddenField>   
                                                            <asp:HiddenField ID="Hidden_DebitnoteXML" runat="server"></asp:HiddenField>  
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
                                                <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:Label ID="lbl_Upload" CssClass="blackfnt" Text="Upload" runat="server"></asp:Label>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:FileUpload ID="fileupload" runat="server" Style="text-align: Left;"
                                                                    BorderStyle="Groove" CssClass="blackfnt" />
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
                            <uc1:UserMessage ID="MsgBox" runat="server" />
                            <asp:HiddenField ID="Hnd_Server_dt" runat="server" />
                            <asp:HiddenField ID="Hnd_Mindate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_Maxdate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_DKt_BIll" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_AlloW_BackDate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_Party_Code" runat="server"></asp:HiddenField>
			    <asp:HiddenField ID="Hnd_DebitnoteXML" runat="server"></asp:HiddenField>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
             <Triggers>
            <asp:PostBackTrigger ControlID="submit" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <%--Model pop up Design--%>
    <div>
        <div id="dialogform" title="Customer Debit Note Details" class="bgbluegrey">
            <div style="text-align: center">
                <br />
                <table width="50%" id="tblDebitNote" border="0" cellpadding="1" cellspacing="1" class="tblDebitNote boxbg">
                    <thead>
                        <tr class="bgbluegrey">
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">System Claim No.</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">System Claim Date</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Claim Type</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Vehicle or Warehouse</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Incident Date</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Billing Party</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Insurance Purchased By</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Claim To Be Paid By</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Debit Note No.</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Date</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Amount</span></td>
                            <td class="bgbluegrey"><span style="font-size: 8pt; font-family: Verdana">Details of Deduction</span></td>
                            <td></td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr class="bgbluegrey">
                            <td colspan="14" align="center">
                                <input type="button" value="OK" class="btn btn-primary" id="btnOK" onclick="return ValidOnSubmit();" />
                                <input type="button" value="Close" class="close btn btn-primary" id="btnClose" onclick="closeEffortsPopup()" />
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <br />
        </div>
    </div>
    <%--Model pop up Design END--%>
    <%--Model pop up java script --%>
    <script type="text/javascript">
        var serviceUrl = '<%=ResolveClientUrl("~/services/GSTCommonService.asmx")%>';
        $(document).ready(function () {
            dialog = $("#dialogform").dialog({
                autoOpen: false,
                height: 350,
                width: 950,
                modal: true,
                buttons: {
                    //Cancel: function () {
                    //    dialog.dialog("close");
                    //}
                }
            });
            hdnType = $("#ctl00_MyCPH1_hdnType");

        });

        $(document).on("contextmenu", function (e) {
            e.preventDefault();
        });

        function closeEffortsPopup() {
            $("#tblDebitNote>tbody>tr").html('');
            addRow(0);
            dialog.dialog("close");
        }
        var currentrowid = ""; 
        function openEffortsPopup(id) {
            //alert(id);
            //alert($("#" + id).closest("tr").find("[id$=_Hnd_Billno]").val());
           
            currentrowid = id;
            var len = $("#tblDebitNote > tbody > tr").length;
            if (len == 0) {
                len = len + 1;
                $(".tblDebitNote").append('<tr class="bgwhite">' +
                    '<td><input type="text" Class="blackfnt" id="txtClaimNo_' + len.toString() + '" onblur="GetClaimData(this);" style="width:250px;"> <input type="hidden" Class="blackfnt" id="hidClaimNo_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtClaimDate_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtClaimType_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtClaimVW_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtIncidentDate_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtBillingParty_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtInsurancePurchasedBy_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtClaimToBePaidBy_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtDebitNoteNo_' + len.toString() + '"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtDRDate_' + len.toString() + '"  ></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtDRAmount_' + len.toString() + '" onkeypress="javascript:return validFloat(event,this.getAttribute(' + "'id'" + '));"></td>' +
                    '<td><input type="text" Class="blackfnt" id="txtDetailsofDeduction_' + len.toString() + '"></td>' +
                    '<td class="clsAction" colspan="2"><input type="image" src="../../../../images/png/24/button-add.png" onClick="addRow(this)" /> <input type="image" src="../../../../images/png/24/button-cross.png" onClick="removeRow(this)" /></td ></tr > ');

               AutoCompleteForGSTMaster($("#txtClaimNo_" + len.toString()), serviceUrl + '/GetClaimNo', 'POST', 'application/json; charset=utf-8', 'json',
                    'searchText', 'v', 'v', 'v', 'v', 'v', "hidClaimNo_" + len.toString(), 'No entries found!', 2, 'BillingParty=' + $("#ctl00_MyCPH1_lblpartydetail").text().split(':')[0].trim(), true);
					
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = (day) + "-" + (month) + "-" + now.getFullYear();
                $("#txtDRDate_" + len.toString()).val(today);

            }

            dialog.dialog("open");
        }

        function addRow(ctrl) {
            var len = $("#tblDebitNote > tbody > tr").length;
            len = len + 1;

            $(".tblDebitNote").append('<tr class="bgwhite">' +
                '<td><input type="text" Class="blackfnt" id="txtClaimNo_' + len.toString() + '" onblur="GetClaimData(this);" style="width:250px;"><input type="hidden" Class="blackfnt" id="hidClaimNo_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtClaimDate_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtClaimType_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtClaimVW_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtIncidentDate_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtBillingParty_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtInsurancePurchasedBy_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtClaimToBePaidBy_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtDebitNoteNo_' + len.toString() + '"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtDRDate_' + len.toString() + '"  ></td>' +
                '<td><input type="text" Class="blackfnt" id="txtDRAmount_' + len.toString() + '" onkeypress="javascript:return validFloat(event,this.getAttribute(' + "'id'" + '));"></td>' +
                '<td><input type="text" Class="blackfnt" id="txtDetailsofDeduction_' + len.toString() + '"></td>' +
                '<td class="clsAction"><input type="image" src="../../../../images/png/24/button-add.png" onClick="addRow(this)" /> <input type="image" src="../../../../images/png/24/button-cross.png" onClick="removeRow(this)" /></td ></tr >');
            
			AutoCompleteForGSTMaster($("#txtClaimNo_" + len.toString()), serviceUrl + '/GetClaimNo', 'POST', 'application/json; charset=utf-8', 'json',
                    'searchText', 'v', 'v', 'v', 'v', 'v', "hidClaimNo_" + len.toString(), 'No entries found!', 2, 'BillingParty=' + $("#ctl00_MyCPH1_lblpartydetail").text().split(':')[0].trim(), true);

            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var today = (day) + "-" + (month) + "-" + now.getFullYear();
            $("#txtDRDate_" + len.toString()).val(today);

        }

        function removeRow(ctrl) {
            if ($(".tblDebitNote tbody tr").length != 1) {
                $(".tblDebitNote tbody tr:last-child").remove();
            }
            else {
                alert("You cannot delete first row");
            }
        }

        function ValidOnSubmit() {
            debugger;
            var hdnMiscXML = $("#<%=Hnd_DebitnoteXML.ClientID%>");
            var billnoString = currentrowid.substring(0, 28);
            var Billnoid = billnoString + "Hnd_Billno";
            var BillingGrigPaty = $("#ctl00_MyCPH1_lblpartydetail").text().split(":")[1];
            var totalRow = $("#tblDebitNote tbody tr").length;
            var DebitNoteXML = "";
            var claimrecoAmt = 0;
            try {
                for (var i = 1; i <= totalRow; i++) {
                    var ClaimNo = $("#txtClaimNo_" + i).val();
                    var ClaimDate = $("#txtClaimDate_" + i).val();
                    var ClaimType = $("#txtClaimType_" + i).val();
                    var ClaimVW = $("#txtClaimVW_" + i).val();
                    var IncidentDate = $("#txtIncidentDate_" + i).val();
                    var BillingParty = $("#txtBillingParty_" + i).val();
                    var InsurancePurchasedBy = $("#txtInsurancePurchasedBy_" + i).val();
                    var ClaimToBePaidBy = $("#txtClaimToBePaidBy_" + i).val();
                    var DebitNoteNo = $("#txtDebitNoteNo_" + i).val();
                    var DRDate = $("#txtDRDate_" + i).val();
                    var DRAmount = $("#txtDRAmount_" + i).val();
                    var DetailsofDeduction = $("#txtDetailsofDeduction_" + i).val();
                    if (ClaimNo == "") {
                        $("#txtClaimNo_" + i).focus();
                        throw "Please enter ClaimNo";
                    }
                    if (ClaimDate == "") {
                        $("#txtClaimDate_" + i).focus();
                        throw "Please enter Claim Date.";
                    }
                    if (ClaimType == "") {
                        $("#txtClaimType_" + i).focus();
                        throw "Please enter Claim Type.";
                    }
                    if (ClaimVW == "") {
                        $("#txtClaimVW_" + i).focus();
                        throw "Please enter Vhecle Or WHerehouse";
                    }
                    if (IncidentDate == "") {
                        $("#txtIncidentDate_" + i).focus();
                        throw "Please enter Incident Date.";
                    }
                    if (BillingParty == "") {
                        $("#txtBillingParty_" + i).focus();
                        throw "Please enter Billing Party.";
                    }
                    if (InsurancePurchasedBy == "") {
                        $("#txtInsurancePurchasedBy_" + i).focus();
                        throw "Please enter Insurance Purchased By";
                    }
                    if (ClaimToBePaidBy == "") {
                        $("#txtClaimToBePaidBy_" + i).focus();
                        throw "Please enter Claim To Be PaidBy";
                    }
                    if (DebitNoteNo == "") {
                        $("#txtDebitNoteNo_" + i).focus();
                        throw "Please enter Debit Note No.";
                    }
                    if (DRDate == "") {
                        $("#txtDRDate_" + i).focus();
                        throw "Please enter Date";
                    }
                    if (DRAmount == "") {
                        $("#txtDRAmount_" + i).focus();
                        throw "Please enter Bill Pay Amount";
                    }
                    if (DetailsofDeduction == "") {
                        $("#txtDetailsofDeduction_" + i).focus();
                        throw "Please enter Details of Deduction";
                    }

                    if (BillingGrigPaty == BillingParty) {
                        claimrecoAmt += parseFloat(DRAmount);
                        DebitNoteXML += "<Detail><ClaimNo>" + ClaimNo + "</ClaimNo>";
                        DebitNoteXML += "<ClaimDate>" + ClaimDate + "</ClaimDate>";
                        DebitNoteXML += "<ClaimType>" + ClaimType + "</ClaimType>";
                        DebitNoteXML += "<ClaimVW>" + ClaimVW + "</ClaimVW>";
                        DebitNoteXML += "<IncidentDate>" + IncidentDate + "</IncidentDate>";
                        DebitNoteXML += "<BillingParty>" + BillingParty + "</BillingParty>";
                        DebitNoteXML += "<InsurancePurchasedBy>" + InsurancePurchasedBy + "</InsurancePurchasedBy>";
                        DebitNoteXML += "<ClaimToBePaidBy>" + ClaimToBePaidBy + "</ClaimToBePaidBy>";
                        DebitNoteXML += "<DebitNoteNo>" + DebitNoteNo + "</DebitNoteNo>";
                        DebitNoteXML += "<DRDate>" + DRDate + "</DRDate>";
                        DebitNoteXML += "<DRAmount>" + DRAmount + "</DRAmount>";
                        DebitNoteXML += "<billno>" + $("#" + Billnoid).val() + "</billno>";
                        DebitNoteXML += "<DetailsofDeduction>" + DetailsofDeduction + "</DetailsofDeduction>";
                        DebitNoteXML += "</Detail>";
                    } else {
                        $("#txtClaimNo_" + i).val("");
                        $("#txtClaimNo_" + i).focus();
                        throw "This Biiling Party Name is Note same";
                    }
                    //alert(claimreco);

                }
                //alert(DebitNoteXML);
                hdnMiscXML.val(DebitNoteXML);
                $("#" + currentrowid).val(claimrecoAmt)
                var string = currentrowid.substring(0, 28);
                var id = string + "Hidden_DebitnoteXML";
                $("#" + id).val(DebitNoteXML)
                $("#tblDebitNote tbody tr").remove();
                dialog.dialog("close");
            } catch (e) {
                alert(e);
                return false;
            }
        }

        function GetClaimData(ctrl) {
            try {
                debugger;
                var claimno = $(ctrl).val();
                var txtClaimDate = $(ctrl).closest('tr').find("[id^='txtClaimDate_']");
                var txtClaimType = $(ctrl).closest('tr').find("[id^='txtClaimType_']");
                var txtClaimVW = $(ctrl).closest('tr').find("[id^='txtClaimVW_']");
                var txtIncidentDate = $(ctrl).closest('tr').find("[id^='txtIncidentDate_']");
                var txtBillingParty = $(ctrl).closest('tr').find("[id^='txtBillingParty_']");
                var txtInsurancePurchasedBy = $(ctrl).closest('tr').find("[id^='txtInsurancePurchasedBy_']");
                var txtClaimToBePaidBy = $(ctrl).closest('tr').find("[id^='txtClaimToBePaidBy_']");
                //alert(Claimtype.val());
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "billmr_step2.aspx/GetClaimDetails",
                    data: '{claimno: "' + claimno + '" }',
                    async: false,
                    datatype: "JSON",
                    success: function (data) {
                        var result = $.parseJSON(data.d);
                        if (data != "") {
                            txtClaimDate.val(result[0].MaterialDT);
                            txtClaimDate.attr('readonly', 'readonly');
                            txtClaimType.val(result[0].ClaimType);
                            txtClaimType.attr('readonly', 'readonly');
                            txtClaimVW.val(result[0].TypeVW);
                            txtClaimVW.attr('readonly', 'readonly');
                            txtIncidentDate.val(result[0].MaterialDT);
                            txtIncidentDate.attr('readonly', 'readonly');
                            txtBillingParty.val(result[0].BillingParty);
                            txtBillingParty.attr('readonly', 'readonly');
                            txtInsurancePurchasedBy.val(result[0].InsurancePurchasedBy);
                            txtInsurancePurchasedBy.attr('readonly', 'readonly');
                            txtClaimToBePaidBy.val(result[0].ClaimToBePaidBy);
                        }
                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                        return false;
                    }
                });
            } catch (e) {
                alert(e);
                return false;
            }

        }
		
		function AutoCompleteForGSTMaster(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
            $(eleId).autocomplete({
                minLength: minPrefixLength,
                source: function (request, response) {
                    var requestData, svcUrl;
                    type = type.toUpperCase();
                    if (type == "POST") {
                        requestData = "{'" + prefixText + "': '" + request.term + "'";

                        if (additionalData != undefined && additionalData != null) {
                            var addData = additionalData.split(',');
                            for (var i = 0; i < addData.length; i++) {
                                var keyval = addData[i].split('=');
                                requestData += (", '" + keyval[0] + "': '" + keyval[1] + "'");
                            }
                        }
                        requestData += "}";
                        svcUrl = url;
                    }
                    else {
                        svcUrl = url + "?" + prefixText + "=" + request.term;
                    }

                    $.ajax({
                        type: type,
                        contentType: contentType,
                        url: svcUrl,
                        dataType: dataType,
                        data: requestData,
                        success: function (data) {
                            if (data.d.length != 0) {
                                var retOut;
                                try {
                                    retOut = jQuery.parseJSON(data.d);
                                } catch (e) { retOut = data.d; }

                                response($.map(retOut, function (item) {
                                    return {
                                        label: item.Name,
                                        value: item.Value
                                    }
                                }));
                            } else {
                                if (disableNotFoundAlert == undefined || disableNotFoundAlert == null || disableNotFoundAlert == false) {
                                    alert(alertMsg);
                                }
                                $(eleId).val("");
                                $("#" + eleVal).val('');
                            }
                        },
                        error: function (errormessage) {
                            alert(errormessage.message);
                        }
                    })
                },
                open: function (event, ui) { disableACblur = true; return false; },
                close: function (event, ui) { disableACblur = false; return false; },
                focus: function (event, ui) {
                    if (focus == 'v') { $(this).val(ui.item.value); }
                    else if (focus == 'l') { $(this).val(ui.item.label); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); }
                    return false;
                },
                select: function (event, ui) {
                    if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
                    else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
                    else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }

                    if (EvalOrtext == 'v') { $("#" + eleVal).val(ui.item.value); }
                    else { $("#" + eleVal).val(ui.item.label); }

                    return false;
                }
            })
                .data("ui-autocomplete")._renderItem = function (ul, item) {
                    var rs1, rs2;
                    if (s1 == 'v') { rs1 = item.value; }
                    else if (s1 == 'l') { rs1 = item.label; }
                    if (s2 == 'v') { rs2 = item.value; }
                    else if (s2 == 'l') { rs2 = item.label; }
                    return $("<li>")
                        .append("<a>" + rs1 + " : " + rs2 + "</a>")
                        .appendTo(ul);
                };
        }

    </script>
    <%--Model pop up java script END --%>
    <script type="text/javascript">
        window.onload = OnLoad
        function OnLoad() {
            // alert("hi.....1")
            // progress_update()
            // alert("hi.....2")
            Bill_Wise_Calc()
            //  alert("hi.....3")
            // progress_stop()
        }
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
