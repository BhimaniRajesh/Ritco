<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ParcelBillView.aspx.cs" Inherits="GUI_Finance_Billing_BillViewPrint_ParcelBillView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopupWindow(strbillno)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "FrmAreaBillView.aspx?billno=" + strbillno
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function OpenPopup(Bill_Number) 
        { 
            window.open("VarunaBillView.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
        }
        function OpenPopupDetail(Bill_Number) 
        { 
            window.open("VarunaBillView_Detail.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
        }
    </script>

    <div align="left">
        <br />
        <table style="width: 10in;">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Operations</b></font></a>
                    <b>&gt; </b><font class="bluefnt"><b>Bill Details</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <%--<img src="../../../images/back.gif" border="0" alt="" />--%>
                    </a>
                </td>
            </tr>
        </table>
        <br />
        <div style="width: 10.5in;" align="center">
            <table id="tblall" runat="server" border="0" cellpadding="3" colspan="2" bgcolor="#ffffff"
                cellspacing="1" class="boxbg">
                <tr bgcolor="#ffffff" class="bgbluegrey">
                    <td align="center" style="height: 25px" colspan="3">
                        <font class="blackfnt" size="3"><b>You Selected</b></font></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="height: 25px; width: 29%;">
                        <font class="blackfnt" size="3"><b>Bill Status Date Range</b></font></td>
                    <td align="left" style="height: 25px">
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lbldaterange" runat="server"></asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 29%">
                        <font class="blackfnt" size="3"><b>Bill Type</b></font></td>
                    <td align="left">
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lblbilltype" runat="server"></asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" align="left">
                        <font class="blackfnt" size="3"><strong>Customer Code</strong></font></td>
                    <td class="blackfnt" align="left">
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lblccode" runat="server"></asp:Label></font></td>
                </tr>
            </table>
            <br />
            <table id="tblbillno" runat="server" border="0" cellpadding="3" colspan="2" bgcolor="#ffffff"
                cellspacing="1" class="boxbg">
                <tr bgcolor="#ffffff" class="bgbluegrey">
                    <td align="center" style="height: 25px" colspan="3">
                        <font class="blackfnt" size="3"><b>You Selected</b></font></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="height: 25px; width: 29%;">
                        <font class="blackfnt" size="3"><b>
                            <asp:Label ID="lbldbillno" Text="System Bill No" runat="server" Width="100%"></asp:Label>
                            <asp:Label ID="lbldmbillno" Text="Manual Bill No" runat="server" Width="100%"></asp:Label>
                        </b></font>
                    </td>
                    <td align="left" style="height: 25px">
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lblbillno" runat="server" Width="100%"></asp:Label>
                            <asp:Label ID="lblmbillno" runat="server" Width="100%"></asp:Label>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <asp:TextBox ID="TxtDateRange" runat="server" Width="170px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 391px; position: absolute; top: 49px"></asp:TextBox>
            <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 391px; position: absolute; top: 84px"></asp:TextBox>
            <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 391px; position: absolute; top: 120px"></asp:TextBox>
            <asp:GridView ID="GrdLoadUnload" Style="width: 10in" OnRowDataBound="GrdLoadUnload_RowDataBound"
                OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages" CssClass="boxbg"
                PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
                runat="server" SelectedIndex="1" Width="686px" EmptyDataText="No Bills Found For Given Details !!"
                EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true">
                <Columns>
                    <asp:TemplateField HeaderText="Bill Number">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:LinkButton ID="lblbillno" Visible="false" CssClass="blackfnt" Font-Underline="true"
                                Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:LinkButton>
                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                                <font cssclass="Blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Manual BillNo">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblManualBillNo" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"manualbillno") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Billing Branch">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bbrcd") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Party Name">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblpartycode" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ptmscd") %>'
                                runat="server"></asp:Label>
                            <asp:Label ID="Label2" CssClass="blackfnt" Text=" : " runat="server"></asp:Label>
                            <asp:Label ID="Label1" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ptmsnm") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Bill Type">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblbilltype" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"paybas") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill Amount">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblbillamt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"billamt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Generation Date">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblgendate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bgndt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submission Date">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblsubdate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bsbdt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Due Date">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblduedate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bduedt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Collection Date">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblcollectiondate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bcldt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill Status">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblbillstatus" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"billstatus") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Covering Later">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                                <font class="Blackfnt">
                                    <asp:Label ID="lblView1" runat="server" CssClass="blackfnt" Text="View"></asp:Label></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill View | XLS">
                        <HeaderStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                                <font class="Blackfnt">
                                    <asp:Label ID="lblView11" runat="server" CssClass="blackfnt" Text="View"></asp:Label></a>
                            <asp:LinkButton ID="lnkbilldtl" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                                runat="server" OnClick="xlsView"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            &nbsp;<br />
            <br />
            <table id="tblbillGrid2" runat="server" visible="false" style="width: 7.5in" border="1">
                <tr style="height: 50px">
                    <td align="left" colspan="7">
                        <%--<asp:Image ID="Image1" runat="server" ImageAlign="Top" ImageUrl="http://124.247.224.12/varuna/GUI/images/newVaruna.gif"
                            Height="30" Width="124px" />--%>
                        <img alt="" src="http://124.153.78.155/ritco/GUI/images/ritco_new.gif" />
                    </td>
                    <td align="center" colspan="8">
                        <label class="blackfnt">
                            <span><b>RAJDHANI INTERSTATE TRANSPORT CO. (Regd.)</b></span></label><br />
                        <label class="blackfnt">
                            <span>336,Udyog Vihar,Phase-IInd</span></label><br />
                        <label class="blackfnt">
                            <span>Gurgaon, Harayana </span>
                        </label>
                        <br />
                        <label class="blackfnt">
                            <span>(Ph.no.0124-3917191,3917881 Fax.no.3043333,3017777)</span></label><br />
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="7">
                        <font><b>To<br />
                            Customer Code :
                            <asp:Label ID="lblCustCode" runat="server"></asp:Label><br />
                            Customer Name :
                            <asp:Label ID="lblCustName" runat="server"></asp:Label><br />
                            Address :
                            <asp:Label ID="lblCustAdd" runat="server"></asp:Label><br />
                        </b></font>
                    </td>
                    <td align="left" colspan="8">
                        <font><b>BillNo :
                            <asp:Label ID="lblBill_no" runat="server"></asp:Label><br />
                            Bill Date :
                            <asp:Label ID="lblBillDate" runat="server"></asp:Label><br />
                            Period :</b> </font>
                    </td>
                </tr>
                <tr>
                    <td colspan="15">
                        <font>
                            <asp:GridView ID="BillViewGridDetail" ShowFooter="true" CssClass="boxbg" PageSize="1000" AutoGenerateColumns="false"
                                HeaderStyle-CssClass="bgwhite" BackColor="white" HeaderStyle-Font-Bold="true"
                                runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!"
                                Visible="true" Style="width: 100%" OnRowDataBound="BillViewGrid_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR. NO.">
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno1" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Booking">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocket_Dt" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DocketDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblFrom3" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"FromCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GR NO.">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblLRNo1" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DocketNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            No.<br />
                                            of<br />
                                            Pkgs
                                        </HeaderTemplate>
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPkgs3" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"PKGSNO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalpkgs" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Destination">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblbTo3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="State Region">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblblRegion" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Region") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Consignee">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblblConsignee" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Cnee") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Weight">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblWeight" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"ChargeWeight") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalWeight" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Amount">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblamount" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Rate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotaFreight" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Sub<br />
                                            total
                                        </HeaderTemplate>
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblSubtotal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Subtotal") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalSubtotal" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Svc Tax">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblservicetax" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"servicetax") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalservicetax" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Cess+<br />
                                            High.<br />
                                            Cess
                                        </HeaderTemplate>
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblcess" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"CESS") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalCess" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotal" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Total") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotaltotal" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ack.Recd.">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblAckRecd" runat="server" Text=""></asp:Label>
                                        </ItemTemplate>
                                       
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgwhite" Font-Bold="true" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="bgwhite" Font-Bold="true" HorizontalAlign="Right" />
                            </asp:GridView>
                        </font>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="7">
                        <span><font class="blackfnt"><b>Checked By</b> </font></span><br />
                    </td>
                    <td align="Right" colspan="8">
                        <span><font class="blackfnt"><b>Authorised Singatory</b> </font></span><br />
                    </td>
                </tr>
            </table>
            <%--<table id="tblbillGrid3" runat="server" visible="false" style="width: 7.5in" border="1">
                
            </table>
            <table id="tblbillGrid4" runat="server" visible="false" style="width: 7.5in" border="1">
                <tr>
                    <td colspan="2">
                        <font>
                            <asp:GridView ID="BillViewGridDetail" ShowFooter="true" CssClass="boxbg" PageSize="1000"
                                AutoGenerateColumns="false" HeaderStyle-CssClass="bgwhite" BackColor="white"
                                HeaderStyle-Font-Bold="true" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!"
                                Visible="true" Style="width: 100%" OnRowDataBound="BillViewGrid_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR. NO.">
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno1" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Booking">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocket_Dt" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DocketDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblFrom3" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"FromCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GR NO.">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblLRNo1" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DocketNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            No.<br />
                                            of<br />
                                            Pkgs
                                        </HeaderTemplate>
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPkgs3" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"PKGSNO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalpkgs" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Destination">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblbTo3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="State Region">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblblRegion" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount">
                                        <HeaderStyle Wrap="true" />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblamount" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Rate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotaFreight" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Sub<br />
                                            total
                                        </HeaderTemplate>
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblSubtotal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Subtotal") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalSubtotal" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Svc Tax">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblservicetax" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"servicetax") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalservicetax" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Cess+<br />
                                            High.<br />
                                            Cess
                                        </HeaderTemplate>
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lblcess" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"CESS") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotalCess" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total">
                                        <HeaderStyle />
                                        <ItemStyle />
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotal" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Total") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooTotaltotal" runat="server" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgwhite" Font-Bold="true" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="bgwhite" Font-Bold="true" HorizontalAlign="Right" />
                            </asp:GridView>
                        </font>
                    </td>
                </tr>
            </table>
            <table id="tblbillGrid5" runat="server" visible="false" style="width: 7.5in" border="1">
                <tr>
                    <td align="left" colspan="23">
                        <span><font class="blackfnt"><b>Checked By</b> </font></span>
                    </td>
                    <td align="Right" colspan="23">
                        <span><font class="blackfnt"><b>Authorised Singatory</b> </font></span>
                    </td>
                </tr>
            </table>--%>
        </div>
    </div>
</asp:Content>
