<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="Show_OutStanding2.aspx.cs" Inherits="OutStanding_Show_OutStanding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
  
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
          
             
    </script>

    <script language="javascript">

function OpenWindow(flg,lo)
        {
            //debugger
            //var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=240,status=no,left=60,top=270"
            var strURL = "dtl_outstanding.aspx?flg=" + flg +"&lo="+lo    
            //var strPopupURL = "tckdcktpp.aspx?SessEmpCode=" + '<%=Session["empcd"] %>' + "&SessEmpName=" + '<%=Session["cstnm"] %>' + "&strDckNo=" + strDocketNo + "&Destination=" + strDestination 
            winNew = window.open(strURL,"_parent")
        }
    </script>

    <table cellspacing="1" style="width: 11.5in;" align="left" border="0">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_finance.aspx"><font class="blklnkund">
                        <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Customer Outstanding
                            Report </b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <div style="width: 10in" align="center">
        <table align="center" width="365" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="2" style="width: 205">
                    <label class="blackfnt">
                        <b>You Selected</b>
                    </label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Bill Party
                    </label>
                </td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblBillingParty" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Bill Type
                    </label>
                </td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblBillingType" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Age Of O/s</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblageos" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 25px;">
                    <label class="blackfnt">
                        Date By</label></td>
                <td style="width: 343; height: 25px;">
                    &nbsp;
                    <asp:Label ID="lbldatetype" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Date Of Outstanding</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lbldtout" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
        </table>
        <%--</center>--%>
        <br />
        <%-- <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                 Customer Outstanding 
                                                                            </b>    
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                </tr>
                                                            </table>--%>
        <br />
        <br />
        <asp:Panel ID="sasa" runat="server" align="center">
            <table align="center" class="boxbg">
                <tr style="background-color: #ffffff">
                    <td align="right">
                        <asp:GridView align="left" ID="GridView1" Width="8.5in" runat="server" BorderWidth="0"
                            CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                            AllowPaging="true" PageSize="50" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                            ShowFooter="true" FooterStyle-BackColor="white" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
                            AllowSorting="False" OnRowDataBound="GrdLoadUnload_RowDataBound" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                            <PagerStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="c1" HeaderText="Billing Party">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle HorizontalAlign="Left" BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Undue" HeaderText="Undue Amt.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="0-30" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=0&amp;dto=30"
                                    DataTextField="First_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="31-60" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=31&amp;dto=60"
                                    DataTextField="Second_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="61-90" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=61&amp;dto=90"
                                    DataTextField="Third_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="91-181" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=91&amp;dto=180"
                                    DataTextField="forth_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="&gt;181" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=181&amp;dto=500"
                                    DataTextField="Fifth_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="Total" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=-365&amp;dto=365"
                                    DataTextField="Total_amt">
                                    <ControlStyle BackColor="White" Font-Underline="True" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <%--               
                                <asp:BoundField DataField="Total_amt" HeaderText=" Total ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>--%>
                            </Columns>
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" />
                            <FooterStyle BackColor="White" CssClass="boxbg" />
                            <HeaderStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td align="right">
                        <div align="center">
                            <br />
                            <br />
                            <asp:Button ID="btn_gr1" Visible="false" Text="DownLoad XLS" runat="server" Width="170"
                                OnClick="btn_csv_Click" />
                        </div>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td align="right">
                        <div align="center">
                            <asp:GridView align="center" ID="GridView2" runat="server" BorderWidth="0" CellPadding="2"
                                CellSpacing="1" Width="8.5in" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
                                AllowSorting="False" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                ShowFooter="false" EmptyDataText="No Records Found...">
                                <PagerStyle HorizontalAlign="center" />
                                <Columns>
                                    <asp:BoundField DataField="loccode1" HeaderStyle-Font-Bold="true" ItemStyle-Width="3in"
                                        HeaderText="Location Code">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    </asp:BoundField>
                                    <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                                        HeaderText="Generated Rs. ** " DataNavigateUrlFormatString="dtl_outstanding.aspx?flg=G&lo={0}"
                                        ItemStyle-BackColor="white" ControlStyle-BackColor="white" DataTextField="billamt_gen" />
                                    <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                                        HeaderText="To be Submitted at Rs. ** " DataNavigateUrlFormatString="dtl_outstanding.aspx?flg=S&lo={0}"
                                        ItemStyle-BackColor="white" ControlStyle-BackColor="white" DataTextField="billamt_sub" />
                                    <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                                        HeaderText="To be collected Rs. ** " DataNavigateUrlFormatString="dtl_outstanding.aspx?flg=C&lo={0}"
                                        ItemStyle-BackColor="white" ControlStyle-BackColor="white" DataTextField="billamt_coll" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView align="left" ID="GridView3" Width="8.5in" runat="server" BorderWidth="1"
                            CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                            AllowPaging="false" CssClass="boxbg" FooterStyle-CssClass="boxbg" ShowFooter="true"
                            FooterStyle-BackColor="white" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
                            AllowSorting="False" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found...">
                            <PagerStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="c1" HeaderText="Billing Party">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle HorizontalAlign="Left" BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Undue" HeaderText="Undue Amt.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="0-30" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=0&amp;dto=30"
                                    DataTextField="First_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="31-60" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=31&amp;dto=60"
                                    DataTextField="Second_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="61-90" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=61&amp;dto=90"
                                    DataTextField="Third_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="91-181" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=91&amp;dto=180"
                                    DataTextField="forth_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="&gt;181" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=181&amp;dto=500"
                                    DataTextField="Fifth_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="ptmscd" HeaderText="Total" DataNavigateUrlFormatString="BillDtl.aspx?flg=G&amp;lo={0}&amp;dfrm=-365&amp;dto=365"
                                    DataTextField="Total_amt">
                                    <ControlStyle BackColor="White" />
                                    <ItemStyle BackColor="White" />
                                </asp:HyperLinkField>
                                <%--               
                                <asp:BoundField DataField="Total_amt" HeaderText=" Total ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="True" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" />
                                </asp:BoundField>--%>
                            </Columns>
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" />
                            <FooterStyle BackColor="White" CssClass="boxbg" />
                            <HeaderStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td align="right">
                        <div align="center">
                            <asp:Button ID="brngr2" Visible="false" Text="DownLoad XLS" runat="server" Width="170"
                                OnClick="btn_csv_Click2" />
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <br />
    <%--Table for displaying no records found message--%>
    <div style="width: 10in" align="center">
        <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080"
            align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
            <tr style="background-color: #FFFFFF">
                <td colspan="22" align="right">
                    <div align="center">
                        <label style="color: #FF0000;" class="blackfnt">
                            No Record Found
                        </label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
</asp:Content>
