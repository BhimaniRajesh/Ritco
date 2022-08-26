<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingFuelBillsApproval.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_admin_FuelSlipMaster_PendingFuelBillsApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>

    <script type="text/javascript" language="javascript">
        function Validate() {
            var FuelBillNo = document.getElementById('ctl00_MyCPH1_txtfuelBillNo').value;
            var DateFrom = document.getElementById('ctl00_MyCPH1_txtDateFrom').value;
            //alert(FuelBillNo);
            if (FuelBillNo == '' || DateFrom == '') {
                alert('Please Enter Fuel Bill No OR Select Date Range');
                return false;
            }
        }
        function Edit_Alert() {
            if (confirm('Do you want to send for Date Entry?')) {
                return true;
            }
            else {
                return false;
            }
        }
        function ValidateDate(obj) {
            if (obj.value != "") {
                // alert(isDate(obj.value))
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }

        function ValidateSubmit() {
            var cnt = 0;
            $("[id*=ctl00_MyCPH1_dgGeneral] tr").not(':first').each(function () {

                try {
                    var SpecialDiscount = ($(this).find("input[id$=lblSpecialDiscount]"));
                    var NetAmount = ($(this).find("input[id$=hdnNetAmount]"));
                    var lblNetAmount = ($(this).find("input[id$=lblNetAmount]"));

                    if ($(this).find("input[id$=chkbxCheck]").is(":checked") == true) {
                        cnt = cnt + 1;
                    }

                    if (parseFloat(SpecialDiscount.val()) > parseFloat(NetAmount.val())) {
                        debugger;
                        SpecialDiscount.val('0.00');
                        lblNetAmount.html(NetAmount.val());
                        throw ("Cannot enter speacial discount amount gather then net amount!!");
                        return false;
                    }

                } catch (e) {
                    alert(e)
                    return false;
                }
            });

            if (cnt == 0) {
                alert("Please Select atleast one fuel bill.!");
                return false;
            }

            if ($("#ctl00_MyCPH1_lblNetAmountTotal").val() < 0) {
                alert("Total Amount must be more then zero!")
                return false;
            } 

            if (!confirm("Are you sure you want to submit??")) {
                return false;
            }
            return true;
        }

        function CalulateSpecialDiscount(id) {
            var totamt = "0.00", RoundTotAmt = "0.00"
            var lblSpecialDiscount = $("#" + id);
            $("input[id*='chkbxCheck']").each(function () {
                var lblNetAmount = $("#" + id.replace("lblSpecialDiscount", "lblNetAmount"));
                var hdnNetAmount = $("#" + id.replace("lblSpecialDiscount", "hdnNetAmount"));
                var chq = $("#" + id.replace("lblSpecialDiscount", "chkbxCheck"));
                totamt = parseFloat(hdnNetAmount.val()) - parseFloat(lblSpecialDiscount.val());
                RoundTotAmt = totamt.toFixed(2);
                lblNetAmount.html(RoundTotAmt);
                CalulateTotal(chq);
            });

        }

        function CalulateTotal(id) {
            var chkbxCheck = $(id);
            var lblNetAmountTotalid = '<%= lblNetAmountTotal.ClientID%>';

            var totNetAmount = 0;

            $("input[id*='chkbxCheck']").each(function () {
                var chk = $(this);
                var lblNetAmount = $("#" + chk.attr('id').replace('chkbxCheck', 'lblNetAmount'));
                if (chk.prop('checked')) {
                    totNetAmount = parseFloat(totNetAmount) + parseFloat(lblNetAmount.text());
                }
            });
            $("#" + lblNetAmountTotalid).html(totNetAmount);
        }        
         function ViewDocument(ctrl) {           
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "../../AzureBaseDownloadFile.aspx?DocName=" + ctrl;
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }	
        
    </script>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div align="left" style="width: 75%">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <UserControl:UserMessage runat="server" ID="UserMessage" />
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Fuel Bills Approval
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter Fuel Bill No." runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:TextBox ID="txtfuelBillNo" runat="server" CssClass="input" BorderStyle="Groove" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" colspan="4">
                                        <font class="blackfnt"><b>OR</b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Date Range" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 259px" valign="top">
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                            Width="244px">
                                            <asp:ListItem Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Selected="True" Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td valign="top" align="left" style="width: 359px">
                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDateFrom" runat="server" />

                                        </a>
                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtDateTo" runat="server" />

                                        <br />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                            OnServerValidate="daterange"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="ShowPendingBillsApproval" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--*************************** Gridarea ****************************--%>
                <table border="0" cellspacing="1" cellpadding="3" width="900px">
                    <tr>
                        <td align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>

                <table border="0" cellspacing="1" cellpadding="3" width="100%" runat="server" id="tblDCR">
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField runat="server" HeaderText="Options" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxCheck" OnClick="CalulateTotal(this)" />
                                                    <%--/
                                                    <asp:Button Text="Edit" ID="btnEdit" OnClientClick="javascript:return Edit_Alert()" runat="server" Enabled="false" OnClick="btnEdit_Click" />--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VENDORNAME" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VENDORNAME" />
                                            <asp:HyperLinkField DataTextField="Bill_No" ItemStyle-HorizontalAlign="Left" DataNavigateUrlFields="Bill_No" DataNavigateUrlFormatString="PendingFuelBillApprovalView.aspx?Billno={0}" InsertVisible="false" Target="_blank" HeaderText="Fuel Bill No" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="BillDate" ItemStyle-HorizontalAlign="Left" HeaderText="Bill Date" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="BillDate" />
                                            <%--<asp:BoundField DataField="Billno" ItemStyle-HorizontalAlign="Left" HeaderText="Fuel Bill No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />--%>
                                            <asp:BoundField DataField="TotalLtr" ItemStyle-HorizontalAlign="Left" HeaderText="Fuel Quantity" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="TotalLtr" />
                                            <asp:BoundField DataField="TotalSlips" ItemStyle-HorizontalAlign="Left" HeaderText="Total slips" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="TotalSlips" />
                                            <%-- <asp:BoundField DataField="Rate" ItemStyle-HorizontalAlign="Left" HeaderText="Rs./Ltr.Fuel Rate (As per Filling Date)" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="Rate" />--%>
                                            <asp:TemplateField HeaderText="IGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIGST" runat="server" Text='<%# Eval("IGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSGST" runat="server" Text='<%# Eval("SGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCGST" runat="server" Text='<%# Eval("CGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="TotalAmount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmount" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fuel Discount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFuelDiscount" runat="server" Text='<%# Eval("FuelDiscount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Special Discount">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="lblSpecialDiscount" runat="server" onkeypress="javasccript: return validFloat(event,this.id);" Text='<%# Eval("SpecialDiscount") %>' OnChange="CalulateSpecialDiscount(this.id)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Net Bill Amount">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnNetAmount" runat="server" value='<%# Eval("NetAmount") %>'></asp:HiddenField>
                                                    <asp:Label ID="lblNetAmount" runat="server" Text='<%# Eval("NetAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Upload Bill" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <a href="#" onclick='javascript:ViewDocument("<%# DataBinder.Eval(Container.DataItem,"DocumentName") %>"); return false;'>
                                                        <u><%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString() == "" ? "" : "View Document" %></u>
                                                    </a>                                                    
                                                    </a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr id="TRPayment" runat="server" visible="false">
                        <td align="right" style="width: 100%">Total :
                        </td>
                        <td>
                            <asp:Label ID="lblNetAmountTotal" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="TRPayment1" runat="server" visible="false">
                        <td align="center">Disapproved Remarks :
                        <asp:TextBox ID="txtDisapprovedRemarks" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr id="trCancel">
                        <td align="center">
                            <asp:Button runat="server" Text="Approved" ID="btnSubmitBills" OnClientClick="javasccript: return ValidateSubmit();" OnClick="btnSubmitBills_Click" />
                            <asp:Button ID="btnReject" runat="server" Text="Disapproved" OnClick="btnReject_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>


