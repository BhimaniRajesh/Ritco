<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_Operations_FM_Scan_Report_Result" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function OpenPopupWindow(strDocketNo)
    {
        //debugger
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "../ViewFMScannedDocument.aspx?DocName=" + strDocketNo    
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    </script>

    <div align="left">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>Scaned Documents</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="blackfnt">
                    <table border="0" runat="server" id="TBL_CRI" horizontalalign="left" cellpadding="3"
                        cellspacing="1" style="width: 7.0in;" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Label runat="server" ID="lblHeader" Text="Document Scaned" Font-Bold="true"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Type</td>
                            <td>
                                <asp:Label runat="server" ID="lblDocType"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Date</td>
                            <td>
                                <asp:Label runat="server" ID="lblDate"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Region</td>
                            <td>
                                <asp:Label runat="server" ID="lblRO"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Location</td>
                            <td>
                                <asp:Label runat="server" ID="lblLO"></asp:Label></td>
                        </tr>                        
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Documents </td>
                            <td>
                                <asp:Label runat="server" ID="lblDocNos"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:Button ID="btnXLS" runat="server" Text="Download XLS" OnClick="btnXLS_Click" />
                    <asp:Button ID="btnCSV" runat="server" Text="Download CSV" OnClick="btnCSV_Click" />
                    <br />
                    <br />
                </td>
            </tr>
            <tr id="trDocket" runat="server">
                <td>
                    <asp:GridView ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2" GridLines="None"
                        HeaderStyle-CssClass="dgHeaderStyle" AllowPaging="true" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" PageSize="25"
                        AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" OnRowDataBound="GV_D_RowDataBound"
                        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                            runat="server">
                                        </asp:Label>
                                    </center>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label CssClass="dgHeaderStyle" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Origin - Destination">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "loc")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From - To">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfrom_to_val" Text='<% #DataBinder.Eval(Container.DataItem, "from_to")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dely. Date">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldely_date_val" Text='<% #DataBinder.Eval(Container.DataItem, "dely_date")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amt">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldkttot_val" Text='<% #DataBinder.Eval(Container.DataItem, "dkttot")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="balckfnt" HeaderText="" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                        <font cssclass="Blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "View_st") %></a>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" CssClass="bgpink" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="white" Wrap="false" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" BackColor="white" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <EmptyDataRowStyle Width="800px" BackColor="white" />
                        <HeaderStyle CssClass="dgHeaderStyle" HorizontalAlign="center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr id="trdg_bill" runat="server">
                <td>
                    <asp:GridView ID="dg_bill" runat="server" AutoGenerateColumns="False" CellSpacing="1"
                        GridLines="None" CellPadding="2" HeaderStyle-CssClass="dgHeaderStyle" AllowPaging="true"
                        PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg" PageSize="25"
                        PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                        EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr No">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="Lbl_Srno" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill No">
                                <ItemTemplate>
                                    <asp:Label ID="Lbl_Billno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "billno")  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Manual Bill No">
                                <ItemTemplate>
                                    <asp:Label ID="Lbl_Manualbillno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "manualbillno")  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Billdate" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "bgndt")  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Billing Party">
                                <ItemTemplate>
                                    <asp:Label ID="Lbl_Billingparty" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "ptmsnm")  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Amount">
                                <ItemTemplate>
                                    <asp:Label ID="Lbl_Billamountno" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "billamt")  %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" Wrap="false" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Submission Location">
                                <ItemTemplate>
                                    <asp:Label ID="Lbl_Submissionlocation" runat="server" Text='<% #DataBinder.Eval(Container.DataItem, "loc")  %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                        <font cssclass="Blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "View_st") %>
                                        </font></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="White" Wrap="false" />
                        <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" />
                        <PagerStyle HorizontalAlign="Center" BackColor="White" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <HeaderStyle CssClass="dgHeaderStyle" HorizontalAlign="center" />
                        <EmptyDataRowStyle Width="800px" BackColor="white" />
                    </asp:GridView>
                </td>
            </tr>
            <tr id="trdg_coddod" runat="server">
                <td>
                    <asp:GridView ID="dg_coddod" runat="server" CellSpacing="1" CellPadding="2" GridLines="None"
                        HeaderStyle-CssClass="dgHeaderStyle" AllowPaging="true" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" PageSize="25"
                        AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" OnRowDataBound="GV_D_RowDataBound"
                        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="hidDocumentNo" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentNo")  %>' />
                                    <asp:HiddenField ID="hidDocumentDate" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "DocumentDate")  %>' />
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label CssClass="dgHeaderStyle" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Document No">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDocumentno" Text='<% #DataBinder.Eval(Container.DataItem, "DocumentNo")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Document Date">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDocumentDt" Text='<% #DataBinder.Eval(Container.DataItem, "DocDT")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Origin - Destination">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblorgdest_val" Text='<% #DataBinder.Eval(Container.DataItem, "loc")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From - To">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblfrom_to_val" Text='<% #DataBinder.Eval(Container.DataItem, "from_to")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dely. Date">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldely_date_val" Text='<% #DataBinder.Eval(Container.DataItem, "dely_date")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amt">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldkttot_val" Text='<% #DataBinder.Eval(Container.DataItem, "dkttot")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="balckfnt" HeaderText="" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DocumentName") %>')">
                                        <font cssclass="Blackfnt">
                                            <%#DataBinder.Eval(Container.DataItem, "View_st") %></a>
                                </ItemTemplate>
                                <HeaderStyle Font-Bold="true" CssClass="bgpink" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle BackColor="white" Wrap="false" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="#f7f7f7" Wrap="false" HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" BackColor="white" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <EmptyDataRowStyle Width="800px" BackColor="white" />
                        <HeaderStyle CssClass="dgHeaderStyle" HorizontalAlign="center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:Button ID="btnXLS_1" runat="server" Text="Download XLS" OnClick="btnXLS_Click" />
                    <asp:Button ID="btnCSV_1" runat="server" Text="Download CSV" OnClick="btnCSV_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
