<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ClaimResult.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyres_ClaimResult" %>

<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
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

        function OnAction() {

            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";

                var ddlAction = document.getElementById(pref + "ddlAction");
                var txtClaimAmt = document.getElementById(pref + "txtClaimAmt");
                var txtReason = document.getElementById(pref + "txtReason");

                if (ddlAction.value != "0") {
                    if (ddlAction.value == "P") {
                        //alert("ppp");
                        txtClaimAmt.disabled = false;
                        txtReason.disabled = true;
                        txtReason.value = "";
                        txtClaimAmt.focus();
                    }
                    else {
                        // alert("RRRR");
                        txtClaimAmt.disabled = true;
                        txtReason.disabled = false;
                        txtClaimAmt.value = "";
                        txtReason.focus();
                    }
                }
                else {
                    txtClaimAmt.disabled = true;
                    txtReason.disabled = true;
                }
            }

        }

        function FillPayment() {
            var ClaimAmt = 0.00;

            var txtAmtApplA = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtAmtApplA");
            var txtNetPay = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_txtNetPay");
            var hdftotClaimAmt = document.getElementById("ctl00_MyCPH1_hdftotClaimAmt");

            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");
            var Count = 0;

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";
                var ddlAction = document.getElementById(pref + "ddlAction");
                var txtClaimAmt = document.getElementById(pref + "txtClaimAmt");
                var txtReason = document.getElementById(pref + "txtReason");

                if (ddlAction.value == "P") {
                    if (parseFloat(txtClaimAmt.value) != "") {
                        ClaimAmt = ClaimAmt + parseFloat(txtClaimAmt.value);
                        txtAmtApplA.value = ClaimAmt;
                        txtNetPay.value = ClaimAmt;
                        hdftotClaimAmt.value = ClaimAmt;
                    }
                }
            }
        }


        function OnSubmit() {
            //debugger;
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");
            var Count = 0, claimAmt = 0;

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";
                var ddlAction = document.getElementById(pref + "ddlAction");
                var chkSelect = document.getElementById(pref + "chkSelect");
                var txtClaimAmt = document.getElementById(pref + "txtClaimAmt");
                var txtReason = document.getElementById(pref + "txtReason");


                if (chkSelect.checked == true) {
                    if (ddlAction.value == "0") {
                        alert("Please select Action.");
                        ddlAction.value = "0";
                        ddlAction.focus();
                        return false;
                    }
                    if (ddlAction.value == "P") {
                        if (txtClaimAmt.value == "") {
                            alert("Please enter Claim Amount.");
                            txtClaimAmt.value = "";
                            txtClaimAmt.focus();
                            return false;
                        }
                        else {
                            claimAmt = claimAmt + parseFloat(txtClaimAmt.value);
                        }
                    }
                    if (ddlAction.value == "R") {

                        if (txtReason.value == "") {
                            alert("Please enter Reason.");
                            txtReason.focus();
                            return false;
                        }
                    }

                    Count = Count + 1;
                }
            }
            if (Count == 0) {
                alert("Select At least one Tyre ID.");
                return false;
            }

            var ddlPayMode = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_ddlPayMode");
            var ddrCashcode = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_ddrCashcode");
            var ddrBankaccode = document.getElementById("ctl00_MyCPH1_UCMyPaymentControl1_ddrBankaccode");

            if (claimAmt != 0) {
                if (ddlPayMode.value == "-1") {
                    alert("Please select Payment mode");
                    ddlPayMode.focus();
                    return false;
                }
                //alert(ddlPayMode.value);

                if (ddlPayMode.value == "cash") {
                    if (ddrCashcode.value == "") {
                        alert("Please select cash mode.");
                        ddrCashcode.focus();
                        return false;
                    }
                }
                if (ddlPayMode.value == "Bank") {
                    if (ddrBankaccode.value == "") {
                        alert("Please select Bank Acount.");
                        ddrBankaccode.focus();
                        return false;
                    }
                }
            }
        }

        //--------------------------------------- For Select All Checkbox

        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreClaim') > -1)) {
                        //if(document.forms[0].elements[i].enabled){
                        //alert(document.forms[0].elements[i].name);
                        document.forms[0].elements[i].checked = true;
                        //}
                    }
                }
            }
            else {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreClaim') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
        }

    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Claim of Tyre</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table id="tblGrid" width="800px" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:GridView ID="GV_TyreClaim" runat="server" AutoGenerateColumns="false" BorderWidth="1"
                    OnRowDataBound="RowDataBound_GV_TyreClaim" CellPadding="0" CellSpacing="0" CssClass="boxbg"
                    EmptyDataText="No Data Found ...." FooterStyle-CssClass="bgwhite" HeaderStyle-CssClass="bgbluegrey"
                    PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1" Visible="true"
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label241" runat="server" Text="Claim No."></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaimID" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("CLAIM_REMOLD_SALE_ID") %>'></asp:TextBox>
                                <asp:HiddenField ID="hdfSR_NO" runat="server" Value='<%# Bind("SR_NO") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label241" runat="server" Text="Truck&lt;/br&gt; Number"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtTruckNo" runat="server" BorderStyle="Groove" Enabled="false"
                                    onfocus="this.blur()" Style="text-align: center" Text='<%# Bind("TYRE_VEHNO") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblvhno2" runat="server" Text="Tyre No."> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSysTyreNo" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("TYRE_No") %>'></asp:TextBox>
                                <asp:HiddenField ID="hdfSysTyreID" runat="server" Value='<%# Bind("TYRE_ID") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblmodel" runat="server" Text="Model"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtModel" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("MODEL") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblPattern" runat="server" Text="Pattern"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtPattern" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("PATTERN") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblsize" runat="server" Text="Size"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSize" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("SIZE") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblType" runat="server" Text="Tyre &lt;/br&gt;Type"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtTyreType" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("TYRE_TYPE") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblMFG" runat="server" Text="Tyre&lt;/br&gt; MFG"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtMFG" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("MFG") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label12345" runat="server" Text="Fittment&lt;/br&gt; Date"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtFittment_DT" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("Fittment_DT") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lbl124" runat="server" Text="Removal&lt;/br&gt; Date"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtRemovalDT" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: center" Text='<%# Bind("TYRE_REMOVE_DT") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblDist" runat="server" Text="Distance&lt;/br&gt;Covered">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtDist" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                    Style="text-align: right" Text='<%# Bind("Dist_Covered") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <%--          <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
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
                                <asp:Label ID="lblRemark" runat="server" Text="Remarks"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtRemark" runat="server" BorderStyle="Groove" Text='<%# Bind("Remark") %>'
                                    Width="175px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblClaimVend" runat="server" Text="Claim With"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaim" runat="server" BorderStyle="Groove" Style="text-align: center"
                                    Text='<%# Bind("VendorCode") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblclaimDT" runat="server" Text="When sent on Claim"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaimDT" runat="server" BorderStyle="Groove" Style="text-align: center"
                                    Text='<%# Bind("Claim_DT") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblClaimPassRej" runat="server" Text="Claim Passed/Reject">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%--AutoPostBack="true" OnSelectedIndexChanged="ddlAction_SelectedIndexChanged"--%>
                                <asp:DropDownList ID="ddlAction" runat="server" Width="100px" onchange="javascript:OnAction()">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Passed" Value="P"></asp:ListItem>
                                    <asp:ListItem Text="Reject" Value="R"></asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblClaimAmt" runat="server" Text="Claim Amount"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaimAmt" runat="server" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    Style="text-align: right"></asp:TextBox><%--onBlur="javascript:FillPayment()" AutoPostBack="true"  OnTextChanged="TextChanged_ClaimAmt"--%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblClaimRej" runat="server" Text="Reason of Rejection">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtReason" runat="server" BorderStyle="Groove"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
    <table  id="tblPayment" width="720px" border="1" runat="server">
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                    runat="server" Visible="true">
                    <ContentTemplate>
                        <UC5:UCMyReceiptControl ID="UCMyPaymentControl1" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                    OnClientClick="javcascript:return OnSubmit()" />
                <asp:HiddenField ID="hdftotClaimAmt" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
