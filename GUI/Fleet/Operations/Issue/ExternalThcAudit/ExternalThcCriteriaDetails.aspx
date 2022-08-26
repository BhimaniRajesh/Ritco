<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ExternalThcCriteriaDetails.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcCriteriaDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="ExternalThcAudit.js"></script>
    <script language="javascript" type="text/javascript">

        function CheckExternalThcSelection(txtExternalThclist, txtExternalThclist_count) {
            //debugger;
            var mTotalRecords = "<%=intTotalRecords %>"
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
            //Loop through the records
            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;
                if (j < 10) {
                    mDerivedControlName = "ctl00$MyCPH1$gvExternalThcData$ctl" + "0" + j + "$chkExternalThc"
                }
                else {
                    mDerivedControlName = "ctl00$MyCPH1$gvExternalThcData$ctl" + j + "$chkExternalThc"
                }
                //Populate Docket No.s for Preaparing Loading Sheet
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
                alert("Select Atleast One External Thc Collection!");
                return false;
            }
            txtExternalThclist_count.value = mSelection
            txtExternalThclist.value = mSelectedDockets;
            return true;
        }

    </script>

    <div>
        <table width="1000" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td>
                    <img src="../../../../images/clear.gif" width="15" height="10"></td>
            </tr>

            <tr>
                <td>
                    <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 60%" align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center"><font class="blackfnt"><b>External Thc Audit</b></font></td>

                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Tripsheet No</font></td>
                            <td style="width: 339px">
                                <asp:Label ID="lblTripsheetNo" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left"><font class="blackfnt">Customer Code And Name</font></td>
                            <td>
                                <asp:Label ID="lblparty" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>

                        </tr>
                        <tr bgcolor="white">
                            <td align="left"><font class="blackfnt">Tripsheet Date Range </font></td>
                            <td>
                                <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
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
                                <font class="blackfnt"><b>List Of External THC For Audit: </b></font>
                                <font class="blackfnt" color="red"><b>Check External Thc No for Audit</b></font>
                                <br />
                                <asp:GridView align="left" ID="gvExternalThcData" runat="server" BorderWidth="0" CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                                    AllowSorting="true" AllowPaging="false" PageSize="1000" PagerStyle-HorizontalAlign="left"
                                    CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                    ShowFooter="true"
                                    EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('gvExternalThcData','ChkAll','chkExternalThc','N')" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:CheckBox ID="chkExternalThc" runat="server" />
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
                                            <HeaderTemplate>External THC No</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label CssClass="blackfnt" ID="ExternalTHCNo" Text='<%# DataBinder.Eval(Container.DataItem,"ExternalTHCNo") %>' runat="server">
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="OTripsheetNo" HeaderText="Tripsheet No" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CustomerTypeID" HeaderText="Party Name" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TransporterName" HeaderText="Transporter Name" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FromCity" HeaderText="From City" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ToCity" HeaderText="To City" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TransporterChallanNo" HeaderText="Transporter Challan No" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ChallanDate" HeaderText="Challan Date" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LoadingDate" HeaderText="Loading Date" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ContactNo" HeaderText="ContactNo" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BrokerName" HeaderText="Broker Name" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Weight" HeaderText="Weight" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Nug" HeaderText="Nug" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Commodity" HeaderText="Commodity" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ContractAmount" HeaderText="Contract Amount" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AdvanceAmount" HeaderText="Advance Amount" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AdvanceAmountDriver" HeaderText="Advance Amount Driver" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AdvanceAmountBranch" HeaderText="Advance Amount Branch" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BalanceAmount" HeaderText="Balance Amount" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BalancePayment" HeaderText="Balance Payment" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UploadFileName" HeaderText="Transporter Document" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:TemplateField ItemStyle-BackColor="white">
                                            <ItemTemplate>
                                                  <asp:Label ID="lblMsg" visible="false" runat="server"> </asp:Label>
                                                <asp:LinkButton ID="lnkDownload" Text = "Download" CommandArgument = '<%# Eval("UploadFileName") %>' runat="server" OnClick = "DownloadFile"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="blackfnt"  />
                                        </asp:TemplateField>
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
                    <asp:HiddenField ID="txtExternalThclist" runat="server" />
                    <asp:HiddenField ID="txtExternalThclist_count" runat="server" />
                    <asp:HiddenField ID="Hnd_PTMSCD" runat="server" />
                    <center>
                        <asp:Button ID="btnExternalThcAudit" runat="server" CssClass="blackfnt" Text="Click Here to Audit External Thc" OnClick="Button1_Click" /></center>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
