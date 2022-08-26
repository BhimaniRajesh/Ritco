<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmBillDetail.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

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
            window.open("BillNo_Popup.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
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
    </script>

    <br />
    <table style="width: 10in;">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Operations</b></font></a>
                <%--href="../rpt_Operation.aspx"--%>
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
                    </b></font></td>
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
        <%--<asp:GridView ID="GrdLoadUnload" Style="width: 10in" OnRowDataBound="GrdLoadUnload_RowDataBound"
            OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
            runat="server" SelectedIndex="1" Width="686px" EmptyDataText="No Bills Found For Given Details !!" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true">
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
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>--%>
        &nbsp;<br />
        <br />
        &nbsp;
        <table border="1" id="tblxls1" visible="false" runat="server">
            <tr>
                <td align="left" class="blackfnt">
                </td>
            </tr>
            <tr>
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
            </tr>
            <tr align="left">
                <td class="blackfnt" style="width: 1874px; height: 21px;">
                    <asp:Label ID="lblpartyname" runat="server" Text="" Width="296px"></asp:Label>
                    <asp:Label ID="lbldash" runat="server" Text=" : " Width="1px"></asp:Label>
                    <asp:Label ID="lblpbillno" runat="server" Text="" Width="302px"></asp:Label>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
                <td class="blackfnt" style="width: 1874px">
                    <asp:GridView ID="GrdXLS1" OnRowDataBound="GrdXLS1_RowDataBound" PagerStyle-Mode="NumericPages"
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
                            <asp:TemplateField HeaderText="Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Consignee">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblconsignee" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"csgenm") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mode Of Trans">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Pcs.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Charge Wt.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"chrgwt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
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
                                    <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dktchg") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="ODA Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblODA" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ODACharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Collection Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldccharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dccharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Delivery Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblddcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ddcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Handling Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblhldchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Critical State Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblstatechrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"state_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sunday/Holiday Delivery Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblhlddlychrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_dlychrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="N-Form Clearance Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblnformchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"nform_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To Pay Collection Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfodcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fodcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Diesel Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldieselcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"diesel_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="COD/DOD">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblcoddod" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"codchg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="S.Tax">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsvctax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"svctax") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblcess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Cessamount") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="High Edu. Cess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblhigheducess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hedu_cess") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="remark">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblremark" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"spl_svc_req") %>'></asp:Label>
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
        </table>
        <br />
        <table visible="false" runat="server" id="tblxls2" width="500" border="1" cellspacing="0"
            cellpadding="0">
            <tr>
                <td colspan="2" rowspan="2">
                    <%--<img src="../../../images/webxpress_logo.gif" width="80" height="20" border="0">--%>
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
                <%--<td width="44" nowrap> <div align="center"><font class=blackfnt><strong>Dkt 
          No.</strong></font></div></td>
      <td nowrap style="width: 50px"> 
        <div align="center"><font class=blackfnt><strong>Dkt Date</strong></font></div></td>
      <td width="25" nowrap> <div align="center"><font class=blackfnt><strong>From</strong></font></div></td>
      <td width="23" nowrap> <div align="center"><font class=blackfnt><strong>To 
          </strong></font></div></td>
      <td width="26" nowrap> <div align="center"><font class=blackfnt><strong>Md</strong></font></div></td>
      <td width="22" nowrap> <div align="center"><font class=blackfnt><strong>Pcs.</strong></font></div></td>
      <td width="23" nowrap> <div align="center"><font class=blackfnt><strong>Wt.</strong></font></div></td>
      <td width="29" nowrap> <div align="center"><font class=blackfnt><strong>Rate</strong></font></div></td>
      <td width="26" nowrap> <div align="center"><font class=blackfnt><strong>Frt</strong></font></div></td>
      <td width="22" nowrap> <div align="center"><font class=blackfnt><strong>D.C.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>Coll.<br>
          Chrg.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>DD. 
          <br>
          Chrg.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>FOV</strong></font></div></td>
      <td width="38" nowrap> <div align="center"><font class=blackfnt><strong>Other</strong></font></div></td>
      <td width="56" nowrap> <div align="center"><font class=blackfnt><strong>Amount</strong></font></div></td>
      --%>
                <td colspan="15" style="height: 268px">
                    <asp:GridView ID="GrdXLS2" OnRowDataBound="GrdXLS2_RowDataBound" PagerStyle-Mode="NumericPages"
                        CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                        <Columns>
                            <%-- <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass = "blackfnt" />
                        <ItemTemplate>
                        <asp:Label ID="lblsrno" CssClass="blackfnt" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="blackfnt" />
                  </asp:TemplateField> --%>
                            <%--<asp:TemplateField>
                                <HeaderStyle CssClass="blackfnt" />
                                <HeaderTemplate>
                                    <asp:Label ID="lblheader" runat="server" CssClass="blackfnt" Text="Inv No."></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Md">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pcs.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Wt.">
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
                            <asp:TemplateField HeaderText="Frt">
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
                            <asp:TemplateField HeaderText="ODA Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblODA" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ODACharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ServiceTax">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblservicetax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"servicetax") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblCessamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"cess") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="HEdu.Cess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblHigherCessamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hedu_cess") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Handling Charges">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblhldchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_chrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Critical State Charges">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblstatechrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"state_chrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Sunday/Holiday Delivery Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblhlddlychrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_dlychrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="N-Form Clearance Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                           <asp:Label ID="lblnformchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"nform_chrg") %>'></asp:Label>                          
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="To Pay Collection Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblfodcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fodcharge") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Diesel Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lbldieselcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"diesel_chrg") %>'></asp:Label>                          
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="COD/DOD">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblcoddod" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"codchg") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="S.Tax">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblsvctax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"svctax") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Cess">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblcess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"cess") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Total">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="remark">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblremark" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"spl_svc_req") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>--%>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
           <%-- <tr>
                <td class="blackfnt" align="right" colspan="14" style="height: 31px">
                    <strong>Subtotal</strong></td>
                <td class="blackfnt" style="height: 31px">
                    <asp:Label ID="lblsubtotal" runat="server" Font-Bold="True"></asp:Label></td>
            </tr>--%>
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
                <td colspan="3">
                    <font class="blackfnt">Other Charges</font>
                </td>
                <td colspan="11">
                    &nbsp;</td>
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
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
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
                <td colspan="4">
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
        </table>
    </div>
    &nbsp;
</asp:Content>
