<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RemoldBillPayment.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyres_RemoldBillPayment" %>

<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">

        function validFloat(event, txtid) {
            var tb = document.getElementById(txtid);
            var txt = tb.value;
            if (event.keyCode == 13)
                return true;
            if (event.keyCode == 46)
                if (txt.indexOf('.') != -1)
                    event.keyCode = 0;

            if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
            { event.keyCode = 0; return false; }
        }

        //        var cal = new CalendarPopup("testdiv1");
        //        cal.setCssPrefix("TEST");
        //        cal.showNavigationDropdowns();

        //function calulatePendingAmt(row_Index, txtPaidAmt, txtPendingAmt, txtCurrentAmt) {
        function calulatePendingAmt() {
            //alert("hiii*");
            var Count = 0, Tot_CurrAmt = 0;
            var GV_RemoldBill = document.getElementById("ctl00_MyCPH1_GV_RemoldBill");
            var hdf_TotalAmt = document.getElementById("ctl00_MyCPH1_hdf_TotalAmt");

            var rows = document.getElementById("ctl00_MyCPH1_GV_RemoldBill").rows.length;

            var txtAmtApplA = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtAmtApplA");
            var txtNetPay = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtNetPay");
            //alert("rows* :" + rows);
            if (rows < 10) {
                var id = "ctl00_MyCPH1_GV_RemoldBill_ctl0" + rows + "_txtTotal"
            }
            else {
                var id = "ctl00_MyCPH1_GV_RemoldBill_ctl" + rows + "_txtTotal"
            }
            //alert("id=" + document.getElementById(id).value);

            var pref = "";
            for (i = 2; i < GV_RemoldBill.rows.length; i++) {
                //pref = "ctl00$MyCPH1$GV_RemoldBill$ctl0" + i + "$";
              

                if (i < 10) {
                    pref = "ctl00_MyCPH1_GV_RemoldBill_ctl0" + i + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_GV_RemoldBill_ctl" + i + "_";
                }

                var chkSelect = document.getElementById(pref + "chkSelect");
                var txtPaidAmt = document.getElementById(pref + "txtPaidAmt");
                var txtPendingAmt = document.getElementById(pref + "txtPendingAmt");
                var txtTotAmt = document.getElementById(pref + "txtTotAmt");
                var txtCurrentAmt = document.getElementById(pref + "txtCurrentAmt");
                var txtTotal = document.getElementById(pref + "txtTotal");

                var Advpaid = document.getElementById(pref + "Advpaid");
                var pendingamt = document.getElementById(pref + "pendingamt");

                //alert("txtPaidAmt=" + txtPaidAmt.value);
                // alert("txtPendingAmt=" + txtPendingAmt.value);
                //ctl00_MyCPH1_GV_RemoldBill_ctl02_txtCurrentAmt
                //alert("@@@txtCurrentAmt : " + txtCurrentAmt.value);
                //alert("*CurrentAmt : " + txtCurrentAmt.value);
                if (txtCurrentAmt.value != "") {
                    if (parseFloat(txtCurrentAmt.value) > parseFloat(txtPendingAmt.value)) {
                        alert("current amount should be not be greater than " + txtPendingAmt.value);
                        txtCurrentAmt.value = "0";
                        Tot_CurrAmt = Tot_CurrAmt + parseFloat(txtCurrentAmt.value);
                        document.getElementById(id).value = Tot_CurrAmt;
                        hdf_TotalAmt.value = document.getElementById(id).value;
                        txtAmtApplA.value = document.getElementById(id).value;
                        txtNetPay.value = document.getElementById(id).value;
                        //txtCurrentAmt.focus();
                        return false;
                    }
                    else {
                        //alert("txtCurrentAmt=" + txtCurrentAmt.value);
                        //alert("Tot_CurrAmt =" + Tot_CurrAmt);
                        Tot_CurrAmt = Tot_CurrAmt + parseFloat(txtCurrentAmt.value);
                        document.getElementById(id).value = Tot_CurrAmt;
                        hdf_TotalAmt.value = document.getElementById(id).value;
                        txtPendingAmt.value = parseFloat(txtTotAmt.value) - parseFloat(txtCurrentAmt.value);
                        txtAmtApplA.value = document.getElementById(id).value;
                        txtNetPay.value = document.getElementById(id).value;
                        //alert(Tot_CurrAmt);
                    }
                }
            }
        }

        function CheckOnSubmit() {

            var Count = 0;
            var GV_RemoldBill = document.getElementById("ctl00_MyCPH1_GV_RemoldBill");

            var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");

            if (txtVoucherDate.value == "") {
                alert("Please enter Voucher date.");
                txtVoucherDate.focus();
                return false;
            }

            var pref=""
            for (i = 2; i < GV_RemoldBill.rows.length; i++) {
                //pref = "ctl00$MyCPH1$GV$RemoldBill$ctl0" + i + "$";
                if (i < 10)
                {
                    pref = "ctl00_MyCPH1_GV_RemoldBill_ctl0" + i + "_";
                }
                else
                {
                    pref = "ctl00_MyCPH1_GV_RemoldBill_ctl" + i + "_";
                }
                
                var chkSelect = document.getElementById(pref + "chkSelect");
                var txtPaidAmt = document.getElementById(pref + "txtPaidAmt");
                var txtPendingAmt = document.getElementById(pref + "txtPendingAmt");
                var txtTotAmt = document.getElementById(pref + "txtTotAmt");
                var txtCurrentAmt = document.getElementById(pref + "txtCurrentAmt");
                var txtTotal = document.getElementById(pref + "txtTotal");

                var Advpaid = document.getElementById(pref + "Advpaid");
                var pendingamt = document.getElementById(pref + "pendingamt");

                if (chkSelect.checked == true) {
                    Count = Count + 1;
                    if (txtCurrentAmt.value == "") {
                        alert("please enter Current Amount.");
                        txtCurrentAmt.value = "0";
                        txtCurrentAmt.focus();
                        return false;
                    }

                    if ( parseFloat(txtCurrentAmt.value)<=0) {
                        alert("Current Amount should be greater than ZERO");
                        txtCurrentAmt.focus();
                        return false;
                    }
                }
            }
            if (Count == 0) {
                alert("Select At least One Fuel Request.");
                return false;
            }

            document.getElementById("ctl00_MyCPH1_btnSubmit").style.visibility = "hidden";
            //alert("Submit");
            //return false;
        }

    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Remold Tyre Bill Payment</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table width="900px" border="1">
        <tr class="bgbluegrey">
            <td colspan="4" align="center">
                <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="Remold Tyre Bill Payment"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Payment Voucher No."></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVoucherNo" runat="server" Text="Sys Gen" ForeColor="Red" BorderStyle="None"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Voucher Date"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVoucherDate" runat="server"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtVoucherDate"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="Vendor Name & Code"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVendorNM" runat="server" BorderStyle="None" Width="200px" onfocus="this.blur()"></asp:TextBox>
                <asp:HiddenField ID="hdfVendorCD" runat="server" />
                <asp:HiddenField ID="hdfVendorName" runat="server" />
            </td>
            <td>
                <asp:Label ID="Label5" runat="server" Text="Vendor Pan No."></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVendorPan_No" runat="server" BorderStyle="None" Width="300px"
                    onfocus="this.blur()"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <br />
                <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GV_RemoldBill" runat="server" AutoGenerateColumns="false" BorderWidth="1"
                            OnRowDataBound="RowDataBound_GV_RemoldBill" CellPadding="0" CellSpacing="0" CssClass="boxbg"
                            ShowFooter="true" EmptyDataText="No Data Found ...." FooterStyle-CssClass="bgwhite"
                            HeaderStyle-CssClass="bgbluegrey" PagerSettings-Mode="NumericFirstLast" PageSize="10"
                            SelectedIndex="1" Visible="true" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite"
                                    FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label241" runat="server" Text="Bill No."></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBillNo" runat="server" Width="150px" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: center" Text='<%# Bind("BILLNO") %>'></asp:TextBox>
                                        <asp:HiddenField ID="hdfBILLNO" runat="server" Value='<%# Bind("BILLNO") %>' />
                                        <asp:HiddenField ID="hdfVENDORCODE" runat="server" Value='<%# Bind("VENDORCODE") %>' />
                                        <asp:HiddenField ID="hdfVendorNM" runat="server" Value='<%# Bind("VENDORNAME") %>' />
                                        <asp:HiddenField ID="hdfVendorPAN" runat="server" Value='<%# Bind("PAN_NO") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblvhno2" runat="server" Text="Bill Date"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBillDT" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: center" Text='<%# Bind("VendorBill_DT") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblmodel" runat="server" Text="Bill Amount"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBillAmt" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: right" Text='<%# Bind("netamt") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPattern" runat="server" Text="Paid Amount"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPaidAmt" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: right" Text='<%# Bind("Advpaid") %>'></asp:TextBox>
                                        <asp:HiddenField ID="hdfPaidAmt" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblsize" runat="server" Text="Pending Amount"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPendingAmt" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: right" Text='<%# Bind("pendamt") %>'></asp:TextBox>
                                        <asp:HiddenField ID="hdfPendingAmt" runat="server" Value='<%# Bind("pendamt") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblType" runat="server" Text="Total Amount"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTotAmt" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                            Style="text-align: right" Text='<%# Bind("netamt") %>'></asp:TextBox>
                                        <asp:HiddenField ID="Advpaid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>' />
                                        <asp:HiddenField ID="pendingamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>' />
                                        <asp:HiddenField ID="vendorcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorcode") %>' />
                                        <asp:HiddenField ID="vendorname" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorname") %>' />
                                        <asp:HiddenField ID="Acccode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Acccode") %>' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="Label6" runat="server" Text="Total"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite" FooterStyle-CssClass="bgbluegrey">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblMFG" runat="server" Text="Current Amount"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtCurrentAmt" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            BorderStyle="Groove" Style="text-align: right" Text=""></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtTotal" runat="server" BorderStyle="Groove" Text="0" ReadOnly="true"
                                            Style="text-align: right"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="center" colspan="4">
                <asp:Label ID="Label7" runat="server" Text="Payment Details" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                    runat="server" Visible="true">
                    <ContentTemplate>
                        <UC5:UCMyReceiptControl ID="UCMyPaymentControl1" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="center" colspan="4">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                    OnClientClick="javascript:return CheckOnSubmit()" />
                <asp:HiddenField ID="hdf_TotalAmt" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
