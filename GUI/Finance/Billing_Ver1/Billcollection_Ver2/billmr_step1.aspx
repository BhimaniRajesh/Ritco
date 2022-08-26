<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="billmr_step1.aspx.cs" Inherits="Finance_Billing_Billcollection_billmr_step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>

    <script language="javascript" type="text/javascript">

        function CheckDocketSelection(txtdocketlist, txtdocketlist_count) {
            var mTotalRecords = "<%=intTotalRecords %>"
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";

            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;
                if (j < 10) {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$chkDock"
                }
                else {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + j + "$chkDock"
                }
                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        if (mSelection == 0) {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            if (mSelection == 0) {
                alert("Select atleast one Bill For Collection!");
                return false;
            }
            txtdocketlist_count.value = mSelection
            txtdocketlist.value = mSelectedDockets;

            return true;
        }        
    </script>
    <div>
        <table width="1000" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 60%"
                        align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Bill Collection</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Billno</font>
                            </td>
                            <td style="width: 339px">
                                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Customer Code and Name</font>
                            </td>
                            <td>
                                <asp:Label ID="lblparty" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Bill Booking Date Range </font>
                            </td>
                            <td>
                                <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Pay Basis</font>
                            </td>
                            <td>
                                <asp:Label ID="lblpaybas" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="2" cellspacing="1" style="width: 100%" align="center">
                        <tr bgcolor="white">
                            <td>
                                <br />
                                <font class="blackfnt"><b>List of Bills for which Bill Can be Collection: </b></font>
                                <br />
                                <asp:GridView align="left" ID="dockdata" runat="server" BorderWidth="0" CellPadding="2"
                                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false"
                                    PageSize="1000" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                    PagerSettings-LastPageText="[Last]" ShowFooter="true" EmptyDataText="No Records Found..."
                                    OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('dockdata','ChkAll','chkDock','N')" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:CheckBox ID="chkDock" runat="server" />
                                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>                                                    
                                                </center>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="Blackfnt" BackColor="white" />
                                            <FooterTemplate>
                                                <center>
                                                    <asp:Label CssClass="blackfnt" ID="dktamt_final" Text='' runat="server">
                                                    </asp:Label>
                                                </center>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-BackColor="white">
                                            <HeaderTemplate>
                                                BillNo</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label CssClass="blackfnt" ID="billno" Text='<%# DataBinder.Eval(Container.DataItem,"billno") %>'
                                                    runat="server">
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="manualbillno" HeaderText="Manual Billno" ItemStyle-Wrap="false"
                                            ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Bbrcdnm" HeaderText="Billing Branch" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ptmsstr" HeaderText="Party Name" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="paybas" HeaderText="Bill Type" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BILLAMT" HeaderText="Bill Amt." ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="pendamt" HeaderText="Unadjusted Amount" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BGNDT" HeaderText="Generation Date" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="bduedt" HeaderText="Due Date" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle />
                                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                    <HeaderStyle CssClass="bgbluegrey" />
                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                    <FooterStyle BackColor="white" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="txtdocketlist" runat="server" />
                    <asp:HiddenField ID="txtdocketlist_count" runat="server" />
                    <asp:HiddenField ID="Hnd_PTMSCD" runat="server" />
                    <center>
                        <asp:Button ID="Button1" runat="server" CssClass="blackfnt" Text="Click Here to Collect Bills"
                            OnClick="Button1_Click" /></center>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>