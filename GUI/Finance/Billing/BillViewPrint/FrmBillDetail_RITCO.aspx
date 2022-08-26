<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmBillDetail_RITCO.aspx.cs" Inherits="GUI_Finance_Billing_BillViewPrint_FrmBillDetail_RITCO" %>

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
            window.open("BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
        }
    function OpenPopupPRRL(Bill_Number)
        { 
            window.open("BillNo_Popup_PRRL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
        }
    function OpenPopupEXL(Bill_Number) 
        { 
            window.open("BillNo_Popup_EXL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
        }
    function OpenPopupRCI(Bill_Number) 
        { 
            window.open("BillNo_Popup_RCI.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }    
    function OpenPopupUFL(Bill_Number) 
        { 
            window.open("BillNo_Popup_UFL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
	function OpenPopupWindowBillView(BillNumber, BillType, Version) {
            var billTyp = "";
            if (BillType == "1" || BillType == "2" || BillType == "3")
                billTyp = "F";
            if (BillType == "7")
                billTyp = "G";
            if (Version == "1" && billTyp != '') {
                window.open("../../Billing_GST/BillGSTViewPrint/BillGST_ViewPrint.aspx?BillNo=" + BillNumber + "&BillType=" + billTyp, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
            if (Version == "2" && billTyp != '') {
                window.open("../../Billing_GST/BillGSTViewPrint/BillGST_ViewPrintVer1.aspx?BillNo=" + BillNumber + "&BillType=" + billTyp, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
        }
		function OpenPopupWindowBillViewPrint(BillNumber, BillType, Version) {
            var billTyp = "";
            if (BillType == "1" || BillType == "2" || BillType == "3")
                billTyp = "F";
            if (BillType == "7")
                billTyp = "G";
            if (Version == "1" && billTyp != '') {
                window.open("../../Billing_GST/BillGSTViewPrint/BillGST_ViewPrint.aspx?BillNo=" + BillNumber + "&BillType=" + billTyp, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
            if (Version == "2" && billTyp != '') {
                window.open("../../Billing_GST/BillGSTViewPrint/BillingViewPrintVer1.aspx?BillNo=" + BillNumber + "&BillType=" + billTyp, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            }
        }
    </script>

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
                    <img src="../../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div style="width: 10.5in;" align="center">
        <table id="tblall" runat="server" border="0" cellpadding="3" colspan="2" bgcolor="#ffffff"
            cellspacing="1" class="boxbg">
            <tr bgcolor="#ffffff" class="bgbluegrey">
                <td align="center" style="height: 25px" colspan="3">
                    <font class="blackfnt"><b>You Selected</b></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="height: 25px; width: 29%;">
                    <font class="blackfnt"><b>Bill Status Date Range</b></font></td>
                <td align="left" style="height: 25px">
                    <font class="blackfnt">
                        <asp:Label ID="lbldaterange" runat="server"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 29%">
                    <font class="blackfnt"><b>Bill Status</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblbillstatus" runat="server"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 29%">
                    <font class="blackfnt"><b>Bill Type</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblbilltype" runat="server"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td class="blackfnt" align="left">
                    <strong>Customer Code</strong></td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblccode" runat="server"></asp:Label></td>
            </tr>
        </table>
        <br />
        <table id="tblbillno" runat="server" border="0" cellpadding="3" colspan="2" bgcolor="#ffffff"
            cellspacing="1" class="boxbg">
            <tr bgcolor="#ffffff" class="bgbluegrey">
                <td align="center" style="height: 25px" colspan="3">
                    <font class="blackfnt"><b>You Selected</b></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="height: 25px; width: 29%;">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lbldbillno" Text="System Bill No" runat="server" Width="100%"></asp:Label>
                        <asp:Label ID="lbldmbillno" Text="Manual Bill No" runat="server" Width="100%"></asp:Label>
                    </b></font>
                </td>
                <td align="left" style="height: 25px">
                    <font class="blackfnt">
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
                <asp:TemplateField HeaderText="Covering Letter">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(PRRL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupPRRL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(EXL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupEXL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(RCI)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupRCI('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(UFL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupUFL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Details">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbilldtl" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls1"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Portrait">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkportrait" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls2"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="W/O Invoice">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbillwoinv" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls3"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="W/O Unloading Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblBillNew1" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls4"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="With Unloading Date">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblBillNew11" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls5"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
				<asp:TemplateField HeaderText="GST Bill View" ControlStyle-Width="90px">
					<HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" CssClass="blackfnt" />
					<ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
					<ItemTemplate>
						<a href="JavaScript:OpenPopupWindowBillView('<%#DataBinder.Eval(Container.DataItem, "BILLNO") %>','<%#DataBinder.Eval(Container.DataItem, "paybas") %>','2')">
							<font class="blackfnt">
								<%#DataBinder.Eval(Container.DataItem, "BILLNO")%></a>
					</ItemTemplate>
                </asp:TemplateField>
				<asp:TemplateField HeaderText="Bill View Print" ControlStyle-Width="90px">
                    <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowBillViewPrint('<%#DataBinder.Eval(Container.DataItem, "BILLNO") %>','<%#DataBinder.Eval(Container.DataItem, "paybas") %>','2')">
                            <font class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "BILLNO")%></a>
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
        &nbsp;
        <table border="1" id="tblxls1" visible="false" runat="server">
            <tr>
                <td align="left" class="blackfnt">
                </td>
            </tr>
            <tr>
                <td align="left" class="blackfnt">
                </td>
            </tr>
            <tr align="left">
                <td colspan="3" class="blackfnt" style="height: 32px">
                    <font class="blackfnt">Service Tax No:DLI/ST/CH/27/2002/Centralised Registration</font></td>
            </tr>
            <tr>
                <td class="blackfnt" align="left" colspan="3" style="height: 21px">
                    <font class="blackfnt">PAN : AAACR6342M</font></td>
            </tr>
            <tr align="left">
                <td class="blackfnt" style="width: 1874px; height: 21px;">
                    <asp:Label ID="lblpartyname" runat="server" Text="" Width="296px"></asp:Label>
                    <asp:Label ID="lbldash" runat="server" Text=" : " Width="1px"></asp:Label>
                    <asp:Label ID="lblpbillno" runat="server" Text="" Width="302px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="blackfnt" style="width: 1874px">
                    <asp:GridView ID="GrdXLS1" OnRowDataBound="GrdXLS1_RowDataBound" PagerStyle-Mode="NumericPages" ShowFooter="true"
                        CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrno" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GIN/Inward/Control No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblInwardNo" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Document Ref. No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDocumentNo1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ctr_no") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Part No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblPartNo" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"orgncd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblto" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"reassign_destcd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mode">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="TOTAL" runat="server" CssClass="blackboldfnt" Text="TOTAL"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pkgs">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="totlblPkgs" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Charge Wt.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"chrgwt") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="totlblchargewt" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblrate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"frt_rate") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="totlblrate" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Basic Freight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="totlblfreight" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="D.C.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dktchg") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblDC" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Collection Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldccharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dccharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblDCC" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Delivery Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblddcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ddcharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblDDCharge" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="FOV">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfov" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"FOVCharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblFOV" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Other Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblotchg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"OtherCharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblOtherCharge" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblTotal" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            
                            
                            
                            <asp:TemplateField HeaderText="Bill No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'></asp:Label>
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot2" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"bgndt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Location">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot3" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BBRCD") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Type">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot4" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PAYBAS") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Party">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot5" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PartyCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Amount">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbillamount" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BILLAMT") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblBillAmount" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="STax + Cess + HCess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblstaxcesshcess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SVCTAX") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblStax" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gatepass No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot8" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"gatepassno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gatepass Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot81" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"gatepassdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Destination">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot9" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"REASSIGN_DESTCD") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From Location">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot10" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"From_Loc") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To Location">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"TO_Loc") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Basic Freight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblBasicFreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblbasicfreight" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sub Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsubtotal" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SubTotal") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblSubTotal" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Weight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblActualWeight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ACTUWT") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:Label ID="totlblActualWeight" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Siad TO Contains">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot15" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"prodcd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Freight Diff.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblFreightdiff" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight_diff") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblfreightDiff" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldktcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketCharges") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblDocketCharge" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Misc./Prev.Ch.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblMiscChrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"MiscCharges") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblMisc" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Demmerage Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDemmerageCharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DemmCharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblDemmerageCharge" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SurCharge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblSurCharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SurCharge") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblSurCharge" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Labour">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblLabour" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Labour") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblLabour" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cartage">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblCartage" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Cartage") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:Label ID="totlblCartage" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            
                            
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <br />
        <table visible="false" runat="server" id="tblxls2" width="500" border="1" cellspacing="0"
            cellpadding="0">
            <tr>
                <td colspan="2" rowspan="2" align="left">
                     <img alt="" src="http://124.153.78.155/ritco/GUI/images/ritco_new.gif"/>
                </td>
                <td height="26" nowrap>
                    &nbsp;</td>
                <td height="26" colspan="8" nowrap>
                    <div align="left">
                        <font class="blackfnt"><strong>Attachment
                            <br>
                            of Bill No.</strong></font><font class="blackfnt"> :-&nbsp;</font><font class="blackfnt"><asp:Label
                                ID="lblABillNo" runat="server"></asp:Label>
                            </font>
                    </div>
                </td>
                <td>
                    &nbsp;</td>
                <td colspan="2">
                    <font class="blackfnt">Page No </font>
                </td>
                <td width="56">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="29">
                    &nbsp;</td>
                <td width="26">
                    &nbsp;</td>
                <td width="22">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="38">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="15" style="height: 268px">
                    <asp:GridView ID="GrdXLS2" OnRowDataBound="GrdXLS2_RowDataBound" PagerStyle-Mode="NumericPages"
                        CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                        <Columns>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno111" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"InvoiceNumber") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GIN/Inward/Control No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno1" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Document Ref. No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDocumentNo2" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ctr_no") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Part No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno11" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"orgncd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblto" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"reassign_destcd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mode">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pkgs">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Weight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"chrgwt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblrate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"frt_rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Freight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="D.C.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DKTCHG") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Coll. Chrg">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldccharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dccharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DD. Chrg.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblddcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ddcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FOV">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfov" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"FOVCharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Other Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblotchg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"OtherCharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SubTotal") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
           
            <tr>
                <td class="blackfnt" align="right" colspan="14" style="height: 31px">
                    <strong>Subtotal</strong></td>
                <td class="blackfnt" style="height: 31px">
                    <asp:Label ID="lblsubtotal" runat="server" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="14" style="height: 31px">
                    <div align="right">
                        <font class="blackfnt"><strong>Service Tax @12%&nbsp;&nbsp;</strong></font></div>
                </td>
                <td style="height: 31px">
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lblservicetax" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="right">
                        <font class="blackfnt"><strong>Cess @2% on service tax&nbsp;&nbsp;</strong></font></div>
                </td>
                <td>
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lblcessontax" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="right">
                        <font class="blackfnt"><strong>High Edu. Cess @1%&nbsp;&nbsp;</strong></font></div>
                </td>
                <td>
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lblhigheducess" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="right">
                        <font class="blackfnt"><strong>Total&nbsp;&nbsp;</strong></font></div>
                </td>
                <td nowrap>
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lbltotal" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14" style="height: 21px">
                    <div align="center">
                        <font class="blackfnt"><strong>Total&nbsp;
                            <asp:Label ID="lbltotalinword" runat="server"></asp:Label>
                        </strong></font>
                    </div>
                </td>
                <td style="height: 21px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="4">
                    <font class="blackfnt">Other Charges</font>
                </td>
                <td colspan="3">
                    <asp:Label ID="lblOtherCharges" runat="server"></asp:Label></td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Cod/Dod&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblcoddod" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    <div align="left">
                        <font class="blackfnt"></font>
                    </div>
                </td>
                <td>
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Handl. Charges&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblhandlecharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 21px">
                    <div align="left">
                        <font class="blackfnt">Crit. St. Chrges&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3" style="height: 21px">
                    <font class="blackfnt">
                        <asp:Label ID="lblstatechrg" runat="server"></asp:Label></font></td>
                <td colspan="7" style="height: 21px">
                    &nbsp;</td>
                <td style="height: 21px">
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Sunday/Holi. Chg&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblholidaychrg" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">'N' Form chrgs&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblnformcharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
            <td>
                    <div align="left">
                        <font class="blackfnt">To pay Coll.&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblfodcharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Other&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblothercharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="15">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="15">
                    <font class="blackfnt">* T = Train , A = Air , R = Road Transport , E = Express </font>
                </td>
            </tr>
            <tr>
                <td>
                    <font class="blackfnt">Remarks :</font>
                </td>
                <td colspan="14" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblRemarks" runat="server"></asp:Label></font>
                </td>
            </tr>
        </table>
        
        <table visible="false" runat="server" id="tblbulk" border="0" cellspacing="0"
            cellpadding="0">
            <tr bgcolor="#FFFFFF">
                <td align="left" colspan="8">
                 <img alt="" src="http://124.153.78.155/ritco/GUI/images/ritco_new.gif"/>
                </td>
                <td valign="top" align="left" >
                
                    <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 7.0in">
                        <tr bgcolor="#FFFFFF">
                            <td align="right" colspan="4">
                                <font class="blackfnt" size="2">
                                    <h3>
                                        <b><asp:Label ID="title" runat="server" Font-Size="16" Text="RITCO Logistics Pvt. Ltd."></asp:Label></b>
                                    </h3>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" >
                            <td align="right" colspan="4">
                                <font class="blackfnt" size="3"><asp:Label ID="Label4" runat="server" Font-Size="10" Text="Corp. Office : Ritco House"></asp:Label></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" >
                            <td align="right" colspan="4">
                                <font class="blackfnt" size="3"><asp:Label ID="Label7" runat="server" Font-Size="10" Text="336, Udyog Vihar, Gurgaon - 122016 (Haryana)"></asp:Label></font>
                            </td>
                        </tr>
                         <tr bgcolor="#FFFFFF" >
                            <td align="right" colspan="4">
                                <font class="blackfnt" size="3"><asp:Label ID="Label8" runat="server" Font-Size="10" Text="Phone : 0124 - 3917881, 3919191"></asp:Label></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" >
                            <td align="right" colspan="4">
                                <font class="blackfnt" size="3"><asp:Label ID="Label9" runat="server" Font-Size="10" Text="Fax : 0124 - 3017777, 3917854"></asp:Label></font>
                            </td>
                        </tr>
                        
                    </table>
                </td>
                
                
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" colspan="9">
                </td>
                </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" colspan="8">
                    <font class="blackfnt" size="3"></font>
                    <font class="blackfnt" size="3"><asp:Label ID="lblCustName111" runat="server"></asp:Label></font><br />
                    <font class="blackfnt" size="3"></font>
                    <font class="blackfnt" size="3"><asp:Label ID="Label5" runat="server" Visible="false"></asp:Label></font><br />
                    <font class="blackfnt" size="3"></font>
                    <font class="blackfnt" size="3"><asp:Label ID="Label6" runat="server" Visible="false"></asp:Label></font><br />
                    <font class="blackfnt" size="3"><b>M/s  </b></font>
                    <font class="blackfnt" size="3"><asp:Label ID="lblCustName" Font-Bold="true" runat="server"></asp:Label></font>
                </td>
                
                <td align="right" colspan="1">
                <table border="1" cellpadding="2" cellspacing="1" class="boxbg">
                 <tr bgcolor="#FFFFFF">
                 <td align="left" colspan="4">
                 <font class="blackfnt"><asp:Label ID="Label13" runat="server" Font-Size="10" Text="Bill No :"></asp:Label></font>
                    <font class="blackfnt"><asp:Label ID="lblBillNox" runat="server" Font-Size="10"></asp:Label></font><br />
                    <font class="blackfnt" size="3"><asp:Label ID="Label10" runat="server" Font-Size="10" Text="Bill Date :"></asp:Label></font>
                    <font class="blackfnt" size="3"><asp:Label ID="lblBillDt" runat="server" Font-Size="10"></asp:Label></font><br />
                    <font class="blackfnt" size="3"><asp:Label ID="Label11" runat="server" Font-Size="10" Text="Manual Bill No:"></asp:Label></font>
                    <font class="blackfnt" size="3"><asp:Label ID="lblManualBillNo" runat="server"></asp:Label></font><br />
                     <font class="blackfnt" size="3"><asp:Label ID="Label12" runat="server" Font-Size="10" Text="Product :"></asp:Label></font>
                    <font class="blackfnt" size="3"><asp:Label ID="lblProduct" runat="server" Font-Size="10"></asp:Label></font>
                 </td>
                 </tr>
                    
                    </table>
                </td>
                
            </tr>
           
            <tr bgcolor="#FFFFFF">
                <td align="left" colspan="9">
                </td>
                </tr>
             <tr id="grd1" runat="server" visible="false">
                <td colspan="9">
                    <asp:GridView ID="GridView1" PagerStyle-Mode="NumericPages" ShowFooter="true"
                        CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrno1" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LR No">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblLRNumber" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LR Date">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblLRDate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <%-- <asp:TemplateField HeaderText="Name Of Party">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblNameOfParty" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Cnee") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Destination">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDestination1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Destination") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Truck No">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblTruckNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"VehicleNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DCPI No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDoNumber" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblInvoice_Number" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"InvoiceNo") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle Font-Bold="true" Font-Size="12"/>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Total"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grade">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblGrade" runat="server" CssClass="blackfnt"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate P/Tn">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblRateTn" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ChargeWeight") %>'></asp:Label>
                                </ItemTemplate>
                               <FooterStyle Font-Bold="true" Font-Size="12"/>
                                 <FooterTemplate>
                                    <asp:Label ID="lblTotQty" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unload/Other">
                                <HeaderStyle CssClass="blackfnt" />
                               <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                               
                                    <asp:Label ID="lblUnloadOther" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"UnLoadingCharge") %>'></asp:Label>
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblAmount11" runat="server" CssClass="blackfnt"  Text='<%# DataBinder.Eval( Container.DataItem,"Amount") %>'></asp:Label>
                                </ItemTemplate>
                              <FooterStyle Font-Bold="true" Font-Size="12"/>
                               <FooterTemplate>
                                    <asp:Label ID="lblTotal" runat="server" CssClass="blackfnt"></asp:Label>
                               </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <tr id="grd2" runat="server" visible="false">
                <td colspan="9">
                    <asp:GridView ID="GridView2" PagerStyle-Mode="NumericPages" ShowFooter="true"
                        CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!" OnRowDataBound="GridView2_RowDataBound">
                        <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrno11" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LR No">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblLRNumber11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LR Date">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblLRDate11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocketDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <%-- <asp:TemplateField HeaderText="Name Of Party">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblNameOfParty11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Cnee") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Destination">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDestination111" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Destination") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Truck No">
                                <HeaderStyle CssClass="blackfnt" />
                                 <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblTruckNo11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"VehicleNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DCPI No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDoNumber11" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno1111" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"InvoiceNo") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle Font-Bold="true" Font-Size="12"/>
                                <FooterTemplate>
                                    <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" CssClass="blackfnt" Text="Total"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UnLoad Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblUnloadDate11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"THC_ArrivalDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Grade">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblGrade11" runat="server" CssClass="blackfnt"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate P/Tn">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblRateTn11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblQty11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ChargeWeight") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle Font-Bold="true" Font-Size="12"/>
                                 <FooterTemplate>
                                    <asp:Label ID="lblTotQtyNew" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unload/Other">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblUnloadOther11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"UnLoadingCharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblAmount1111" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterStyle Font-Bold="true" Font-Size="12"/>
                                 <FooterTemplate>
                                    <asp:Label ID="lblTotalNew" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" colspan="9">
                </td>
                </tr>
            <tr>
                <td colspan="9">
                    <font class="blackfnt"><b>In Words : </b>
                        <asp:Label ID="lbl_Inwords" runat="server" Font-Bold="true" Width="100%"></asp:Label></font>
                </td>
            </tr>
             <tr bgcolor="#FFFFFF">
                <td align="left" colspan="9">
                </td>
                </tr>
            <tr>
                
                <td align="right" colspan="9">
                    <b><font class="blackfnt">For RITCO Logistics Ltd. </font><font class="blackfnt">
                        <asp:Label ID="Label3" runat="server"></asp:Label></font><br /><br /><br />
                        <font class="blackfnt">Authorised Signatory</font></b>
                </td>
            </tr>
            <%--<tr>
                <td colspan="9">
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr>
                <td colspan="9">
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr>
                <td colspan="9">
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr>
                <td colspan="9">
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr>
                
                <td align="right" colspan="9">
                    <font class="blackfnt">Authorised Signatory</font>
                </td>
            </tr>--%>
        </table>
    </div>
    &nbsp;
</asp:Content>
