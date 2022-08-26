<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingFuelBills.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_PendingFuelBills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js?v1"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>


    <script type="text/javascript" language="javascript">
		
		
		function validFloat1(e,txtid)
		{	
		
			var code;
			var tb=document.getElementById(txtid);
			var txt=tb.value;
		  
			if (!e) var e = window.event;
			if (e.keyCode) {
				code = e.keyCode;}
			else if (e.which) 
				{code = e.which;}
			else 
				{return true;}
			
			
			if(code==45)
				{code=0;return false;}
			
			if(code==13 || code==8 || code==9)
				{return true;}
				
			 if(code==46)
				  {if(txt.indexOf('.')!=-1)
					{code=0;}}
				
			if((code<46 || code>57) || code==47)
				{code=0;return false;}
		}

		
        function OpenRate() {

            var ddVendorName = $("#ctl00_MyCPH1_ddVendorName")

            window.open("../../Fleet/Webadmin/FuelRateMaster/FuelRateUpdation_SubmitForValidation.aspx?VendorCode=" + ddVendorName.val(), "_blank");
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
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
        /*  function CheckEmpty()
        {
            var rate = document.getElementById("ctl00_MyCPH1_txtBillNo").value;

            if (rate == "") {
                alert("Please enter Bill No to Continue");
                document.getElementById("ctl00_MyCPH1_txtBillNo").focus();
                return false;
            }

            else {
                return true;
            }
        }
        
            function calculation(c, d) {
                alert("fweignb");
                if (document.getElementById(d).checked == true) {

                    var rows1 = document.getElementById("ctl00_MyCPH1_dgGeneral").rows.length;
                    if (rows1 <= 9) {
                        var id1 = "ctl00_MyCPH1_dgGeneral_ctl0" + rows1 + "_lblTotal"
                    }
                    else {
                        var id1 = "ctl00_MyCPH1_dgGeneral_ctl" + rows1 + "_lblTotal"
                    }

                    alert(document.getElementById(c).value)
                    document.getElementById("ctl00_MyCPH1_lblTotal").value = parseFloat(document.getElementById("ctl00_MyCPH1_lblTotal").value) + parseFloat(document.getElementById(c).value);
                }
                else if (document.getElementById(d).checked == false) {
                    document.getElementById("ctl00_MyCPH1_lblTotal").value = parseFloat(document.getElementById("ctl00_MyCPH1_lblTotal").value) - parseFloat(document.getElementById(c).value);
                }
            }
            */
        function calculateTotal(chk) {

            var txtTotalQuantity = $("#ctl00_MyCPH1_txtTotalQuantity");    
            var txtvalue = parseFloat($("#ctl00_MyCPH1_dgGeneral span[id*='lblTotal']").text());
            var txtFinalAmountvalue = parseFloat($("#ctl00_MyCPH1_dgGeneral span[id*='lblFinalAmountTotal']").text());
            txtvalue = 0;
            var Qty = 0
            txtFinalAmountvalue = 0;
            $("[id*=ctl00_MyCPH1_dgGeneral] tr").each(function () {

                try {
                    if ($(this).find("input[id$=chkbxCheck]").is(":checked") == true) {
                        txtvalue = parseFloat(txtvalue) + parseFloat($(this).find("span[id*='lblAmount']").text());
                        txtFinalAmountvalue = parseFloat(txtFinalAmountvalue) + parseFloat($(this).find("span[id*='lblFinalAmount']").text());
                        Qty = parseFloat(Qty) + parseFloat($(this).find("span[id*='lblQuantity']").text());
                    }
                } catch (e) {
                    alert(e)
                }
            });
            
            txtTotalQuantity.val(Qty);
            CalculateFuelDiscount();
            //$("#ctl00_MyCPH1_dgGeneral span[id*='lblAmount']").each(function (index) {

            //    if (chk.checked == true) {
            //        if ($.trim($(this).text()) != "")
            //            if (!isNaN($(this).text()))
            //                txtvalue = txtvalue + parseFloat($(this).text());
            //    } else {
            //        if ($.trim($(this).text()) != "")
            //            if (!isNaN($(this).text()))
            //                txtvalue = txtvalue - parseFloat($(this).text());
            //    }

            //});
            $("#ctl00_MyCPH1_dgGeneral span[id*='lblTotal']").text(txtvalue);
            $("#ctl00_MyCPH1_dgGeneral span[id*='lblFinalAmountTotal']").text(txtFinalAmountvalue);
            CalculateFuelDiscount();

        }
        function CalculateFuelDiscount() {
            var txtDiscountRate = $("#ctl00_MyCPH1_txtDiscountRate");
            var txtFuleDiscount = $("#ctl00_MyCPH1_txtFuleDiscount");
            var txtTotalQuantity = $("#ctl00_MyCPH1_txtTotalQuantity").val();
            if (txtTotalQuantity.trim() != "" || txtTotalQuantity != "0") {
                if (txtDiscountRate.val() == "") {
                    txtDiscountRate.val(0);
                }
                txtFuleDiscount.val(parseFloat(txtDiscountRate.val()) * parseFloat(txtTotalQuantity));
            } else {
                $("#ctl00_MyCPH1_txtTotalQuantity").val(0);
                txtFuleDiscount.val(0);
            }
            CalculateNetAmount();
        }
        function CalculateNetAmount() {
            //var Total = $("#ctl00_MyCPH1_dgGeneral span[id*='lblTotal']").text();
            var lblFinalAmountTotal = $("#ctl00_MyCPH1_dgGeneral span[id*='lblFinalAmountTotal']").text();
            var FuleDiscount = $("#ctl00_MyCPH1_txtFuleDiscount").val();
            var SpecialDiscount = $("#ctl00_MyCPH1_txtSpecialDiscount").val();
            if (SpecialDiscount.trim() != "" || SpecialDiscount != "0") {
                $("#ctl00_MyCPH1_txtNetBillAmount").val(Math.round(parseFloat(lblFinalAmountTotal) - parseFloat(FuleDiscount) - parseFloat(SpecialDiscount)));
            } else {
                $("#ctl00_MyCPH1_txtNetBillAmount").val(0);
            }
        }

        function ValidateSubmit() {
            var cnt = 0;
            var Remarks = $("#ctl00_MyCPH1_txtRemarks").val();
            var SpecialDiscount = $("#ctl00_MyCPH1_txtSpecialDiscount").val();
            $("[id*=ctl00_MyCPH1_dgGeneral] tr").each(function () {

                try {
                    if ($(this).find("input[id$=chkbxCheck]").is(":checked") == true) {
                        cnt = cnt + 1;
                    }
                } catch (e) {
                    alert(e)
                    return false;
                }
            });
            if (cnt == 0) {
                alert("Please Select atleast one fuel slip.!");
                return false;
            }
            if (SpecialDiscount != "0") {
                if (Remarks.trim() == "") {
                alert("Please enter Remarks.!");
                return false;
                }
            }

            if (!confirm("Are you sure you want to submit??")) {
                return false;
            }
            return true;
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
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Fuel Bills
                                        </asp:Label>
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

                                    <td align="left" valign="top">
                                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" runat="server" Width="261px" CssClass="input" OnSelectedIndexChanged="ddVendorName_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:Button ID="btnRateHistory" Text="Rate history" runat="server" OnClientClick="javascript:OpenRate();" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="ShowPendingBills" />
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

                <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" ShowFooter="true" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField runat="server" HeaderText="Options" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxCheck" onclick="javascript:calculateTotal(this)" />
                                                    /
                                                    <asp:Button Text="Edit" ID="btnEdit" OnClientClick="javascript:return Edit_Alert()" runat="server" Enabled="false" OnClick="btnEdit_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="FillingDate" ItemStyle-HorizontalAlign="Left" HeaderText="Filling Date" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Vehicle No" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="TripsheetNo" HeaderText="Tripsheet No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Vendor Code" />
                                            <asp:BoundField DataField="TripsheetOpenDate" HeaderText="Tripsheet Open Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="City" />
                                            <asp:BoundField DataField="VendorCity" HeaderText="Vendor City" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="PeriodTo" />
                                            <asp:BoundField DataField="FuelType" HeaderText="Fuel Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" />
                                            <asp:BoundField DataField="UserSlipNo" HeaderText="User Slip No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:BoundField DataField="UserSlipDate" HeaderText="User Slip Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <%--<asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:TemplateField HeaderText="Quantity">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:TemplateField HeaderText="Rate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Rate")%>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" Text="Total Amount" Font-Bold="true"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:TemplateField HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount")%>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblTotal" Text="0" Font-Bold="true"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIGST" runat="server" Text='<%# Eval("IGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSGST" runat="server" Text='<%# Eval("SGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCGST" runat="server" Text='<%# Eval("CGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFinalAmount" runat="server" Text='<%# Eval("TotalAmount")%>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblFinalAmountTotal" Text="0" Font-Bold="true"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Remark" HeaderText="Remark" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                                <HeaderTemplate>
                                                    <asp:Label ID="lbl_Upload" CssClass="blackfnt" Text="Upload" runat="server"></asp:Label>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:FileUpload ID="fileupload" runat="server" Style="text-align: Left;"
                                                        BorderStyle="Groove" CssClass="blackfnt" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>

                        <td width="100%" id="tdAmount" runat="server">
                            <table cellspacing="1" cellpadding="3" border="1" class="dgRowStyle" width="100%">
                                <tr style="background-color: white">
                                    <td colspan="1" style="font-weight: bold">Discount Rate(Paise):
                                        <asp:TextBox runat="server" ID="txtDiscountRate" onfocus="this.blur();" BorderStyle="None" Font-Bold="true" />
                                    </td>
                                    <td colspan="1" style="font-weight: bold">Total Quantity:
                                        <asp:TextBox runat="server" ID="txtTotalQuantity" onkeypress="javasccript: return validFloat(event,this.id);" onblur="javascript:CalculateFuelDiscount();" Text="0" />
                                    </td>
                                    <td colspan="2" style="font-weight: bold">Fuel Discount:
                                        <asp:TextBox runat="server" ID="txtFuleDiscount" Text="0" onfocus="this.blur();" BorderStyle="None" Font-Bold="true" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="1" align="right"></td>
                                    <td colspan="1" style="font-weight: bold">Remarks:
                                        <asp:TextBox runat="server" TextMode="MultiLine" Rows="3" ID="txtRemarks" MaxLength="500" autocomplete="off" onpaste="return false" />
                                    </td>
                                    <td colspan="1" style="font-weight: bold">Special Discount:
                                        <asp:TextBox runat="server" ID="txtSpecialDiscount" onblur="javascript:CalculateNetAmount();" onkeypress="javasccript: return validFloat1(event,this.id);" Text="0" />
                                    </td>

                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="2" align="right"></td>
                                    <td colspan="1" style="font-weight: bold">Net Bill amount:
                                        <asp:TextBox runat="server" ID="txtNetBillAmount" onfocus="this.blur();" Font-Bold="true" BorderStyle="None" Text="0" />
                                    </td>

                                </tr>
                            </table>

                        </td>
                    </tr>

                    <tr id="trCancel">
                        <td align="right">
                            <asp:Button runat="server" Text="Submit" ID="btnSubmitBills" OnClientClick="javascript: return ValidateSubmit();" OnClick="btnSubmitBills_Click" />
                            <%--OnClientClick="reurn CheckEmpty()"--%>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">
                            <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnSubmitBills" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>








