<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_NET_MIS_CrossingRegister_Result" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function OpenPopupChallan(challanno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operations/Crossing/ViewCrossingChallan.aspx?CrossingChallanNo=" + challanno + ",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    function OpenPopupVoucher(voucherno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operations/Crossing/ViewChallanPayment.aspx?VoucherNo=" + voucherno + ",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>
                </strong>&gt;<strong>Crossing Challan Register Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1">
            </td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0">
                </a>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :</label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                RO :</label>
                        </td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location :</label>
                        </td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Challan No :</label>
                        </td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblChallanNo" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView align="left" ID="dgChallan" runat="server" BorderWidth="0" CellPadding="3"
                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
                    PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    OnRowDataBound="dgDocket_RowDataBound" OnPageIndexChanging="pgChange" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found..." ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SR No" ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Crossing Challan No" ItemStyle-BackColor="white" HeaderStyle-Font-Bold="true">
                            <ItemTemplate>
                                <label class="blackfnt">
                                    <a href="JavaScript:OpenPopupChallan('<%#DataBinder.Eval(Container.DataItem, "CrossingChallanNo") %>')">
                                        <%#DataBinder.Eval(Container.DataItem, "CrossingChallanNo")%>
                                    </a>
                                </label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ChallanDate" HeaderText="Challan Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Vendor" HeaderText="Vendor">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ChallanLocCode" HeaderText="Origin">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField HeaderStyle-Wrap="true" DataField="TotalDkt" HeaderText="Total Dkt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Total Package" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblPackages" Text='<%# DataBinder.Eval(Container.DataItem,"Packages") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotPackages" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Weight" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblWeight" Text='<%# DataBinder.Eval(Container.DataItem,"Weight") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotWeight" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total ToPay" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblToPay" Text='<%# DataBinder.Eval(Container.DataItem,"TotalToPay") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotToPay" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Crossing" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblCrossing" Text='<%# DataBinder.Eval(Container.DataItem,"TotalCrossing") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotCrossing" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Bulky Chrg" HeaderStyle-CssClass="blackfnt"
                            HeaderStyle-Font-Bold="true" FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblBulkyChrg" Text='<%# DataBinder.Eval(Container.DataItem,"TotalBulkyChrg") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotBulkyChrg" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Truck Freight" HeaderStyle-CssClass="blackfnt"
                            HeaderStyle-Font-Bold="true" FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblTruckChrg" Text='<%# DataBinder.Eval(Container.DataItem,"TotalTruckFreight") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotTruckChrg" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Advance Freight" HeaderStyle-CssClass="blackfnt"
                            HeaderStyle-Font-Bold="true" FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblAdvanceChrg" Text='<%# DataBinder.Eval(Container.DataItem,"TotalAdvanceFreight") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotAdvanceChrg" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblNetPayable" Text='<%# DataBinder.Eval(Container.DataItem,"NetPayable") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotNetPayable" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Tax" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblSVCTAX" Text='<%# DataBinder.Eval(Container.DataItem,"ServiceTax") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotServiceTax" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cess" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblCess" Text='<%# DataBinder.Eval(Container.DataItem,"Cess") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotCESS" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="HEdu Cess" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblHEduCess" Text='<%# DataBinder.Eval(Container.DataItem,"Hedu_Cess") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotHEduCess" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>

			<asp:TemplateField HeaderText="SB Cess" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                            FooterStyle-CssClass="bgbluegrey">
                            <ItemTemplate>
                                <right>
                                            <asp:Label ID="lblSBCess" Text='<%# DataBinder.Eval(Container.DataItem,"SBCess") %>'
                                        runat="server"></asp:Label>
                                        </right>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <FooterTemplate>
                                <right>
                                            <asp:Label ID="lblTotSBCess" runat="server"></asp:Label>
                                        </right>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="VoucherType" HeaderText="Voucher Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Paymode" HeaderText="Paymode">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Voucher No" ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <label class="blackfnt">
                                    <a href="JavaScript:OpenPopupVoucher('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>')">
                                        <%#DataBinder.Eval(Container.DataItem, "VoucherNo")%>
                                    </a>
                                </label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                    <FooterStyle CssClass="bgbluegrey" BackColor="White" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                        Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
                <br />
            </td>
        </tr>
        
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
