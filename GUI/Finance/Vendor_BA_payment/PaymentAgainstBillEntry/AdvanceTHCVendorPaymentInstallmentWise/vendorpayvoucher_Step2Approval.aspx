<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="vendorpayvoucher_Step2Approval.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_vendorpayvoucher_Step2Approval" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl_Fa.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var Form_name = "ctl00$MyCPH1$"
        frm_name = "ctl00$MyCPH1$"
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
        var Fromdate = "<%=Fromdt%>"
        var Todate = "<%=Todt%>"
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1
        Frmnae = "ctl00$MyCPH1$"
        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to

        function fsubmit() {
            var mTotalRecords = "<%=intTotalRecords%>"

            var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"

            var mDerivedControlName = "";
            var mCurrPaymentControlName = "";
            var mBillDateControlName = "";

            var mnetamtControlName = "";
            var mAdvpaidControlName = "";
            var TotNetPayment = 0;
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";

            var mBillDate = "";
            for (var i = 0; i < mTotalRecords; i++) {
                var CurrPayment = 0;
                j = i + 2;
                if (i < 10) {
                    mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$chkBill"
                    mBillDateControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$mVendorBill_DT"
                    mnetamtControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$nettotamt"

                }
                else {
                    mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$chkBill"
                    mBillDateControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$mVendorBill_DT"
                    mnetamtControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$nettotamt"
                }
                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        if (mSelection == 0) {
                            mSelection = 1;
                        }
                        else {
                            mSelection = mSelection + 1
                        }
                        TotNetPayment = parseFloat(TotNetPayment) + parseFloat(CurrPayment);
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);

                        var balamt = "";
                    }
                }
            }
            //if (mSelection == 0) {
            //    alert("Select atleast one Bill to prepare payment voucher!");
            //    return false;
            //}
			
			if ($("input[type='checkbox'][id*='chkBill']:checked").length == 0) {
                alert("Select atleast one Bill to prepare payment voucher!");
                return false;
            }
			
            if (confirm("Do you want to submit") == false) {
                return false;
            }
            click_count = parseFloat(document.getElementById(Form_name + "click_count").value)
            if (click_count > 0) {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else {
                click_count = click_count + 1
                document.getElementById(Form_name + "click_count").value = click_count
            }

        }
        function OpenPopup(thcno) {
            window.open("../PendingTHCAdvanceCheque/AdvanceTHCView.aspx?thcno=" + thcno, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");

        }
    </script>
    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank"
                style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <p align="left"><font class="blackfnt"><b>You Selected</b></font></p>
        <table>
            <tr>
                <td>
                    <asp:HiddenField ID="click_count" Value="0" runat="server" />
                    <table border="0" cellpadding="3" cols="1" style="width: 9.5in" bgcolor="#808080" cellspacing="1" align="left" class="boxbg">

                        <tr bgcolor="#FFFFFF" id="BillDtRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Agent Bill Date </font></td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblAgentBillDate" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="VendorRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Vendor</font>
                            </td>
                            <td>
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendor1" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Payment Voucher Summary</b></font></b></td>
                        </tr>
                    </table>

                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in" align="left" class="boxbg">
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Vendor</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%" colspan="3">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendor" runat="server"></asp:Label>
                                    </font>
                                </div>

                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center"><font class="blackfnt"><b>Vendor Bill Details</b> </font></td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <!-- DataGrid -->
                    <asp:GridView ID="BillDetail" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                        AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"
                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"
                        EmptyDataText="No Records Found..." Style="width: 9.5in" OnRowCreated="BillDetail_RowCreated">
                        <Columns>
                            <asp:TemplateField FooterStyle-CssClass="bgbluegrey">
                                <ItemTemplate>
                                    <center>
                                        <asp:CheckBox ID="chkBill" runat="server" />
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Entry Number" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <font class="blackfnt">
                                        <asp:Label ID="BILLNO" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="vendorcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorcode") %>' />
                                        <asp:HiddenField ID="vendorname" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorname") %>' />
                                        <asp:HiddenField ID="Acccode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Acccode") %>' />

                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                           <%-- <asp:BoundField DataField="ThcNo" HeaderText="Thc No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                             <asp:TemplateField HeaderText="Thc No." HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <font class="blackfnt">
                                                 <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "ThcNo") %>')">
                                                         <%#DataBinder.Eval(Container.DataItem, "ThcNo")%></a>
                                                <asp:Label ID="THCNo" Text='<%# DataBinder.Eval(Container.DataItem,"ThcNo") %>' runat="server" Visible="false"></asp:Label>
                                            </font>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                            <asp:BoundField DataField="ThcDate" HeaderText="Thc Date" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vehno" HeaderText="Vehicle No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OthAdvReferenceNo" HeaderText="Reference No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OthAdvUnit" HeaderText="Unit" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <font class="blackfnt">
                                        <asp:Label ID="Label1" Text='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="nettotamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' />
                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" HorizontalAlign="Right" />
                    </asp:GridView>

                    <br />
                </td>
            </tr>

            <tr>
                <td>
                    <div align="left">
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
    </div>
</asp:Content>

