<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_WorkDone_Testing_Result" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopupWindow(arg1,arg2)
    {
        if(arg2=="0")
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../Octroi_Bill/PrepareOctBill_ViewPrint.aspx?billno=" + arg1 + "&printyn=" + arg2
            winNew = window.open(strPopupURL, "_blank", strWinFeature)            
        }
        else
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../Octroi_Bill/PrepareOctBill_ViewPrint1.aspx?billno=" + arg1 + "&printyn=" + arg2
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }        
    }       
    </script>

    <div style="width: 10.5in;">
        <table align="left">
            <tr>
                <td>
                    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                        <%--style="width: 10.5in"--%>
                        <tr>
                            <td height="30">
                                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                                    class="blklnkund"><strong>Octroi </strong></font><font class="bluefnt"><strong>&gt;
                                    </strong><strong>Octroi Bill View & Print</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue">
                                <img src="./../../images/clear.gif" width="2" height="1"></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <%--<a href="javascript:window.history.go(-1)" title="back">
                                    <img alt="Back" src="./../../images/back.gif" border="0">
                                </a>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <table id="tblall" runat="server" align="left" border="0" cellpadding="3" colspan="2"
                        bgcolor="#ffffff" cellspacing="1" class="boxbg">
                        <tr bgcolor="#ffffff" class="bgbluegrey">
                            <td align="center" style="height: 25px" colspan="3">
                                <font class="blackfnt"><b>You Selected</b></font></td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left" style="width: 40%;">
                                <font class="blackfnt"><b>Date Range</b></font></td>
                            <td align="left" style="width: 60%;">
                                <font class="blackfnt">
                                    <asp:Label ID="lbldaterange" runat="server" Width="300px"></asp:Label>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Customer Code</b></font></td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblCustCode" runat="server" Width="300px"></asp:Label>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><b>Octroi Bill No.</b></font></td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblBillNo" runat="server" Width="300px"></asp:Label>
                                </font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:GridView ID="GrdLoadUnload" Style="width: 10in" OnPageIndexChanging="PageIndexChanged_Click"
                        PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="50" AutoGenerateColumns="false"
                        HeaderStyle-CssClass="bgbluegrey" BackColor="white" runat="server" SelectedIndex="1"
                        Width="686px" EmptyDataText="No Bills Found For Given Details !!" EmptyDataRowStyle-CssClass="blackfnt"
                        EmptyDataRowStyle-Font-Bold="true">
                        <Columns>
                            <asp:TemplateField HeaderText="Bill Number">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblbillno" Visible="false" CssClass="blackfnt" Font-Underline="true"
                                        Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>' runat="server"></asp:LinkButton>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "BillNo") %>',0)">
                                        <font cssclass="Blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Billing Branch">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillBranch") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Submission Branch">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillSub") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Collection Branch">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillCol") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Party Name">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpartycode" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Party") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Generation Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblgendate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillDt") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Submission Date">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsubdate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SubDt") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Date">
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblduedate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DueDt") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Bill Amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbillamt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillAmt") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Covering Letter">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblCover" Visible="false" CssClass="blackfnt" Font-Underline="true"
                                        Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>' runat="server"></asp:LinkButton>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "BillNo") %>',1)">
                                        <font cssclass="Blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Bill Annexure">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbilldetail" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>'
                                        runat="server" OnClick="xls"></asp:LinkButton>
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
            <tr>
                <td align="left">
                    <table border="1" id="tblxls1" visible="false" runat="server">
                        <tr>
                            <td class="blackfnt" style="width: 1874px">
                                <asp:GridView ID="GrdXLS1" PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="50"
                                    AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
                                    runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SRNo.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CN No">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DOCKNO") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Decl. Value">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"DECLVAL") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reciept No.">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblInwardNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"RECPTNO") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reciept Date">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblDocumentNo1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"RECPTDT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Octroi Amt.">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblPartNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"OCTAMT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Octroi(%)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"oct_percentage") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Clearance Charges">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"clearance_chrg") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Processing Charges(%)">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblto" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"processing_per") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Processing Charges">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"process_chrg") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Other Charges">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"OTCHG") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="S.Tax">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"SVRCAMT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cess">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblrate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"CESSAMT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Higher Edu. Cess">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblfreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Hedu_Cess") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total">
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DKTTOT") %>'></asp:Label>
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
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
