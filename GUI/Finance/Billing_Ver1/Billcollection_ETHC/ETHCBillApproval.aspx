<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ETHCBillApproval.aspx.cs" Inherits="GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="../../Js/moment.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript">
        $(document).ready(function () {
            $("[id*='RdHCLApproval']").click(function () {
                //set name for all to name of clicked 
                $("[id*='RdHCLApproval']").not(this).attr("checked", false);
            });
        });
    </script>
    <script language="javascript">
        function OnApprove() {
            try {
                if (!confirm("Are You Sure to Submit"))
                    return false;
                var hidClickCount = $("input[id$=hidClickCount]").val();
                if (hidClickCount > 0) {
                    throw new Error("Sorry... You cannot click twice !!!")
                }
                else {
                    hidClickCount = hidClickCount + 1;
                    hidClickCount = $("input[id$=hidClickCount]").val(hidClickCount);
                }
                return true;
            }
            catch (e) { alert(e.message); return false; }
        }
        function OnReject() {
            try {
                var txtRemarks = $("#" + '<%=txtRemarks.ClientID%>');
                if (txtRemarks.val() == "") {
                    alert("Please Enter Rejection Remarks");
                    txtRemarks.focus();
                    return false;
                }
                return true;
            }
            catch (e) { alert(e.message); return false; }
        }
    </script>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 50%" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="2" align="center">
                <b>External THC Balance Pending For Approval Step 2</b>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table class="stbl" cellspacing="1" cellpadding="3" id="Table2" runat="server">
        <tr class="nrow">
            <td colspan="10">
                <asp:GridView align="Left" ID="dockdata" Width="100%" runat="server" BorderWidth="0"
                    CellSpacing="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found..." OnRowDataBound="dockdata_RowDataBound">
                    <Columns>
                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                Srno.
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                    <asp:Label ID="LblSrno" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="lblBillno" CssClass="blackfnt" Text="Billno" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblBillnumber" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Billno") %>' runat="server"></asp:Label>
                                <asp:HiddenField ID="Hnd_Billno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Billno") %>' />
                                <asp:HiddenField ID="Hnd_SCHG" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHGCODE") %>' />
                                <asp:HiddenField ID="hdn_chargeValue" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CHGValue") %>' />
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
                                <asp:Label ID="pendamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"PendingAmount") %>'></asp:Label>
                                <asp:HiddenField ID="txtpendamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PendingAmount") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="lblCollectionAmt" CssClass="blackfnt" Text="Collection Amt." runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="collectionAmt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"CollectionAmount") %>'></asp:Label>
                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="lblBalanceAmt" CssClass="blackfnt" Text="Balance Amt." runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="BalanceAmt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"BalanceAmount") %>'></asp:Label>
                                
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Tds" HeaderText="TDS" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_1" CssClass="blackfnt" Text="Chg1" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG1" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_2" CssClass="blackfnt" Text="Chg2" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG2" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_3" CssClass="blackfnt" Text="Chg3" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG3" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_4" CssClass="blackfnt" Text="Chg4" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG4" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_5" CssClass="blackfnt" Text="Chg5" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG5" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_6" CssClass="blackfnt" Text="Chg6" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG6" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_7" CssClass="blackfnt" Text="Chg7" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG7" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_8" CssClass="blackfnt" Text="Chg8" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG8" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_9" CssClass="blackfnt" Text="Chg9" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG9" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_Chg_10" CssClass="blackfnt" Text="Chg10" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="CHG10" runat="server" Text="0.00"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="Lbl_MIsc" CssClass="blackfnt" Text="Misc.(+)" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Lbl_MiscCharge" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"MiscCharge") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label ID="lblnetamt" CssClass="blackfnt" Text="Net Recd. Amount  " runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                    <asp:Label ID="totalamt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"NETAMT") %>' runat="server"></asp:Label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Detention" HeaderText="Detention" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DetentionRemarks" HeaderText="Remarks" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Labour" HeaderText="Labour" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LabourRemarks" HeaderText="Remarks" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TDSdeducted" HeaderText="TDS already deducted" ItemStyle-BackColor="white"
                            ItemStyle-Wrap="false">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                        </asp:BoundField>
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
    <br />
    <br />
    <table class="stbl" cellspacing="1" cellpadding="3" id="Table1" runat="server">
        <tr class="nrow">
            <td><b>Payment Mode :</b>
            </td>
            <td>
                <asp:Label ID="lblPayMode" runat="server" ></asp:Label>
            </td>
            <td><b>Instrument No.</b></td>
            <td>
                <asp:Label ID="lblInstrumentNo" runat="server" ></asp:Label>
            </td>
            <td><b>Instrument Amount :</b></td>
            <td>
                <asp:Label ID="lblInstrumentAmount" runat="server" ></asp:Label>
            </td>
            <td><b>Instrument Date :</b></td>
            <td>
                <asp:Label ID="lblInstrumentDate" runat="server" ></asp:Label>
            </td>
            <td><b>Deposited in Bank :</b></td>
            <td>
                <asp:Label ID="lblDepositedBank" runat="server" ></asp:Label>
            </td>
            <td><b>Received From Bank :</b></td>
            <td>
                <asp:Label ID="lblReceivedBank" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr class="nrow">
            <td>Remarks</td>
            <td colspan="12">
                <asp:TextBox ID="txtRemarks" TextMode="MultiLine" runat="server"></asp:TextBox></td>
        </tr>
        <tr class="hrow">
            <td colspan="12" align="center">
                <asp:Button ID="btnApprove" runat="server" Text="OK" OnClientClick="javascript: return OnApprove();" OnClick="btnApprove_Click"/>
                <asp:Button ID="btnReject" runat="server" Text="Reject" OnClientClick="javascript: return OnReject();" OnClick="btnReject_Click"/>
                <asp:HiddenField ID="hidClickCount" runat="server" />
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

