<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreSale.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreSale" %>

<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<%--MyReceiptControl.ascx  MyPaymentControl.ascx--%>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
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

        ////        function CheckVendor() {
        ////            debugger;
        ////            // var currentTime = new Date();
        ////            var GV_TyreSale = document.getElementById("MyCPH1_GV_TyreSale");
        ////            // alert(GV_TyreSale.rows.length);

        ////            for (i = 0; i <= GV_TyreSale.rows.length; i++) {
        ////                pref = "MyCPH1_GV_TyreSale_";
        ////                var txtVendor = document.getElementById(pref + "txtVendor_" + i);
        ////                alert(txtVendor.value);
        ////                var Search_Char = "~";
        ////                if (txtVendor.value.indexOf(Search_Char) == -1) {
        ////                    alert("Invalid Vendor Name~Code Format");
        ////                    txtVendor.value = "";
        ////                    txtVendor.focus();
        ////                    return false;
        ////                }
        ////            }
        ////        }

        function CheckVendor() {
            //debugger;
            var GV_TyreSale = document.getElementById("ctl00_MyCPH1_GV_TyreSale");


            //alert(GV_TyreSale.rows.length);
            if (GV_TyreSale.rows.length != 0) {
                // alert(GV_TyreDetails.rows.length);
                for (i = 0; i <= GV_TyreSale.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GV_TyreSale$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GV_TyreSale$ctl" + j + "$";
                    }
                    var chkSelect = document.getElementById(pref + "chkSelect");
                    var txtVendor = document.getElementById(pref + "txtVendor");
                    //alert(txtVendor.value);
                    var Search_Char = "~";
                    if (chkSelect.checked == true) {
                        if (txtVendor.value != "") {
                            if (txtVendor.value.indexOf(Search_Char) == -1) {
                                alert("Invalid Vendor Code~Name Format");
                                txtVendor.value = "";
                                txtVendor.focus();
                                return false;
                            }
                        }
                        if (txtVendor.value == "") {
                            alert("Please enter Vendor name.");
                            txtVendor.value = "";
                            txtVendor.focus();
                            return false;
                        }
                    }
                }

               
            }
        }

        function OnSubmit() {
            ////            var GV_TyreSale = document.getElementById("ctl00_MyCPH1_GV_TyreSale");

            ////            for (i = 2; i <= GV_FuelRequest.rows.length; i++) {
            ////                pref = "ctl00$MyCPH1$GV_TyreSale$ctl0" + i + "$";
            ////                var txtVendor = document.getElementById(pref + "txtVendor");
            ////                var txtSaleAmt = document.getElementById(pref + "txtSaleAmt");

            ////                if (txtVendor.value == "") {
            ////                    alert("Please enter Vendor");
            ////                }
            ////                if (txtSaleAmt.value == "") {
            ////                    alert("Please enter Sale Amount");
            ////                }

            ////            }

            var GV_TyreSale = document.getElementById("ctl00_MyCPH1_GV_TyreSale");

            //alert(GV_TyreSale.rows.length);
            if (GV_TyreSale.rows.length != 0) {
                // alert(GV_TyreDetails.rows.length);
                for (i = 0; i <= GV_TyreSale.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GV_TyreSale$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GV_TyreSale$ctl" + j + "$";
                    }
                    var chkSelect = document.getElementById(pref + "chkSelect");
                    var txtSaleAmt = document.getElementById(pref + "txtSaleAmt");
                    var txtVendor = document.getElementById(pref + "txtVendor");
                    //alert(txtVendor.value);
                    var Search_Char = "~";
                    if (chkSelect.checked == true) {
                        if (txtSaleAmt.value == "") {
                            alert("Please enter Sale Amount.");s
                            txtSaleAmt.value = "";
                            txtSaleAmt.focus();
                            return false;
                        }
                        if (txtVendor.value == "") {
                            alert("Please enter Vendor name.");
                            txtVendor.value = "";
                            txtVendor.focus();
                            return false;
                        }
                    }
                }
                if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "-1") {
                    alert("Please select Payment mode");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').focus();
                    return false;
                }
            }
        }
    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Sale</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            <table width="700PX" cellpadding="0" cellspacing="0" border="0">
                <%--                <tr>
                    <td>
                        <table width="500px" border="1">
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" Font-Bold="true" runat="server" Text="Select Vendor"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlVendor" Width="200px" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Enter Date"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSaleDT" Width="200px" runat="server"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtSaleDT"
                                        runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>--%>
                <tr class="bgwhite" align="left">
                    <td>
                        <asp:GridView ID="GV_TyreSale" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                            Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                            Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                            PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1" OnRowDataBound="GV_TyreSale_OnRowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <%--OnCheckedChanged="SelectAll" AutoPostBack="true"--%>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" Checked="true" OnCheckedChanged="SelectAll"
                                            AutoPostBack="true" TabIndex="1" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="true" OnCheckedChanged="CheckedChanged_Select"
                                            AutoPostBack="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label241" runat="server" Text="Truck</br> Number"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTruckNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_VEHNO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblvhno2" Text="Tyre No." runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSysTyreNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_NO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        <asp:HiddenField ID="hdfTyre_Id" runat="server" Value='<%# Bind("TYRE_ID") %>' />
                                        <%--<asp:HiddenField ID="hdfSRNO" runat="server" Value='<%# Bind("SR_NO") %>'  />--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblmodel" Text="Model" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtModel" runat="server" Enabled="false" BorderStyle="Groove" onfocus="this.blur()"
                                            Text='<%# Bind("MODEL") %>' Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPattern" Text="Pattern" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPattern" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("PATTERN") %>' Style="text-align: center" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblsize" Text="Size" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSize" runat="server" Enabled="false" BorderStyle="Groove" onfocus="this.blur()"
                                            Text='<%# Bind("SIZE") %>' Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblType" Text="Tyre </br>Type" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTyreType" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_TYPE") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblMFG" Text="Tyre</br> MFG" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtMFG" runat="server" Enabled="false" BorderStyle="Groove" onfocus="this.blur()"
                                            Text='<%# Bind("MFG") %>' Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label12345" runat="server" Text="Fittment</br> Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%--Text='<%# Bind("Fuel_Req_ID") %>'--%>
                                        <asp:TextBox ID="txtFittment_DT" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("Fittment_DT") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lbl124" runat="server" Text="Removal</br> Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%--Text='<%# Bind("Fuel_Req_ID") %>'--%>
                                        <asp:TextBox ID="txtRemovalDT" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_REMOVE_DT") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblDist" Text="Distance</br>Covered" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDist" runat="server" Enabled="false" BorderStyle="Groove" onfocus="this.blur()"
                                            Text='<%# Bind("Dist_Covered") %>' Style="text-align: right"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <%--                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblStatus" Text="Status" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>                                       
                                        <asp:TextBox ID="txtStatus" runat="server" Enabled="false" BorderStyle="Groove" Style="text-align: right"
                                            onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRemark" Text="Remarks" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemark" runat="server" Enabled="false" BorderStyle="Groove" Width="175px"
                                            Text='<%# Bind("Remark") %>' Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblsale" Text="Sale</br>Amount" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSaleAmt" runat="server" BorderStyle="Groove" OnTextChanged="txtSaleAmt_TextChanged"
                                            TabIndex="1" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            Text="" AutoPostBack="true" Style="text-align: right"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSold" Text="Sold To" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtVendor" runat="server" BorderStyle="Groove" Text="" TabIndex="2"></asp:TextBox>
                                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                            ServiceMethod="AutoVendor" ServicePath="../../AtlasAutoComplete.asmx" TargetControlID="txtVendor">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblMobNo" Text="Mobile</BR>No." runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtMobileNo" runat="server" BorderStyle="Groove" MaxLength="12"
                                            onkeypress="javascript:return validInt(event);" TabIndex="3" Text="" Style="text-align: left"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="Payment_Row3" runat="server">
                    <td>
                        <br />
                        <table border="0" cellspacing="1" cellpadding="4" width="800" align="left" class="boxbg">
                            <caption>
                                <font class="blackfnt">Note : Please enter the payment details if Net Payable amount
                                    &gt;0 . </font>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <font class="blackfnt"><b>Payment Details</b></font>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF">
                                    <td align="center" colspan="4">
                                        <UC5:UCMyReceiptControl ID="UCMyPaymentControl1" runat="server" />
                                    </td>
                                </tr>
                                <tr align="center" class="bgwhite">
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                                    </td>
                                </tr>
                            </caption>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="../../../images/loading.gif" alt="" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                    opacity: .50; -moz-opacity: .50;" runat="server">
                                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                        left: 50%;" ID="Panel2" runat="server">
                                    </asp:Panel>
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <asp:HiddenField ID="hdftotSaleAmt" runat="server" />
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
