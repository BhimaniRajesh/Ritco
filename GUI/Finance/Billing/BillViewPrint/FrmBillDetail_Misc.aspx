<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmBillDetail_Misc.aspx.cs" Inherits="GUI_Finance_Billing_BillViewPrint_FrmBillDetail_Misc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopup(strbillno,viewprint)
    {
    var viewprint=viewprint;
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "../Misc/viewPrintpopup.aspx?billno=" + strbillno + "," +viewprint
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function OpenPopup_New(Bill_Number) 
        { 
            window.open("BillNo_Popup.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
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
        <asp:GridView ID="GrdLoadUnload" Style="width: 10in" 
            CssClass="boxbg"
            PageSize="1000" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
            runat="server" SelectedIndex="1" Width="686px" EmptyDataText="No Bills Found For Given Details !!" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true">
            <Columns>
               <%-- <asp:TemplateField HeaderText="Bill Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblbillno" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopup_New('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Bill Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblbillno" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
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
                        <asp:Label ID="lblbilltype" CssClass="blackfnt" Text="Misc"
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
                
                <asp:TemplateField HeaderText="View">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>',0)">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Print">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>',1)">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
</asp:Content>
