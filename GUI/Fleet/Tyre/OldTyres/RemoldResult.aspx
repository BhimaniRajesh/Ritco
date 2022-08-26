<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RemoldResult.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyres_RemoldResult" %>

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

            var GV_TyreRemold = document.getElementById("ctl00_MyCPH1_GV_TyreRemold");

            for (i = 2; i <= GV_TyreRemold.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreRemold$ctl0" + i + "$";

                var ddlRemoldRej = document.getElementById(pref + "ddlRemoldRej");
                var txtRemoldAmount = document.getElementById(pref + "txtRemoldAmount");
                var txtReason = document.getElementById(pref + "txtReason");

                if (ddlRemoldRej.value != "0") {
                    if (ddlRemoldRej.value == "P") {
                        //alert("ppp");
                        txtRemoldAmount.disabled = false;
                        txtReason.disabled = true;
                        txtReason.value = "";
                        txtRemoldAmount.focus();
                    }
                    else {
                        // alert("RRRR");
                        txtRemoldAmount.disabled = true;
                        txtReason.disabled = false;
                        txtRemoldAmount.value = "";
                        txtReason.focus();
                    }
                }
                else {
                    txtRemoldAmount.value = "";
                    txtReason.value = "";
                    txtRemoldAmount.disabled = true;
                    txtReason.disabled = true;
                }
            }

        }


        //--------------------------------------- For Select All Checkbox

        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreRemold') > -1)) {
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
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreRemold') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
        }


        function OnSubmit() {
            //debugger;
            var GV_TyreRemold = document.getElementById("ctl00_MyCPH1_GV_TyreRemold");
            var hdfNetAmt = document.getElementById("ctl00_MyCPH1_hdfNetAmt");

            var Count = 0, NetAmt = 0;

            for (i = 2; i <= GV_TyreRemold.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreRemold$ctl0" + i + "$";
                var ddlRemoldRej = document.getElementById(pref + "ddlRemoldRej");
                var chkSelect = document.getElementById(pref + "chkSelect");
                var txtRemoldAmount = document.getElementById(pref + "txtRemoldAmount");
                var txtReason = document.getElementById(pref + "txtReason");

                if (chkSelect.checked == true) {
                    if (ddlRemoldRej.value == "0") {
                        alert("Please select Remold/Reject.");
                        ddlRemoldRej.value = "0";
                        ddlRemoldRej.focus();
                        return false;
                    }
                    if (ddlRemoldRej.value == "P") {
                        if (txtRemoldAmount.value == "") {
                            alert("Please enter Remold Amount.");
                            txtRemoldAmount.value = "";
                            txtRemoldAmount.focus();
                            return false;
                        }
                        else {
                            NetAmt = NetAmt + parseFloat(txtRemoldAmount.value);
                            hdfNetAmt.value = NetAmt;
                           // alert(hdfNetAmt.value);
                        }
                    }
                    if (ddlRemoldRej.value == "R") {
                        if (txtReason.value == "") {
                            alert("Please enter Reason of Rejection.");
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

        }

    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update Remold Tyre</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table border="0">
        <tr>
            <td>
                <table width="800px" border="1">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Update Remold Tyre</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="GV_Remold" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                                Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                                Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1">
                                <Columns>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label241" runat="server" Text="SR.No."></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" Style="text-align: center"
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label241" runat="server" Text="Remold No."></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemoldNo" runat="server" BorderStyle="None" Text='<%# Bind("CLAIM_REMOLD_SALE_ID") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                            <asp:HiddenField ID="hdf_RemoldID" runat="server" Value='<%# Bind("CLAIM_REMOLD_SALE_ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblVendorNM" Text="Vendor Name" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtVendorNM" runat="server" BorderStyle="None" Text='<%# Bind("VendorCode") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblremolddt" Text="Remold Date" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemoldDate" runat="server" BorderStyle="None" Text='<%# Bind("ACTION_DT") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lbltyreno" Text="No of Tyres" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTyreNo" runat="server" BorderStyle="None" Text='<%# Bind("NO_OF_TYRE") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lbltyreno" Text="" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnk_Update" runat="server" OnClick="LinkUpdateRemoldTyre">Update</asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <br />
                <table id="tblTyreList" runat="server" border="1">
                    <tr>
                        <td>
                            <asp:GridView ID="GV_TyreRemold" BorderWidth="1" CellSpacing="0" CellPadding="0"
                                runat="server" Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                                OnRowDataBound="GV_TyreRemold_RowDataBound" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite" PagerSettings-Mode="NumericFirstLast" PageSize="10"
                                SelectedIndex="1">
                                <Columns>
                                    <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <%--<asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="SelectAll" AutoPostBack="true" />--%>
                                            <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" checked="checked" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server" Checked="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label241" runat="server" Text="Remold</br>No."></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemoldNo" runat="server" BorderStyle="None" Text='<%# Bind("CLAIM_REMOLD_SALE_ID") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                            <asp:HiddenField ID="hdf_SRNO" runat="server" Value='<%# Bind("SR_NO") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label241" runat="server" Text="Truck</br>No."></asp:Label>
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
                                            <asp:TextBox ID="txtSysTyreNo" runat="server" BorderStyle="None" Text='<%# Bind("TYRE_NO") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                            <asp:HiddenField ID="hdfSysTyre_No" runat="server" Value='<%# Bind("TYRE_ID") %>' />
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
                                            <asp:TextBox ID="txtModel" runat="server" BorderStyle="None" onfocus="this.blur()"
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
                                            <asp:TextBox ID="txtPattern" runat="server" BorderStyle="None" Text='<%# Bind("PATTERN") %>'
                                                Style="text-align: center" onfocus="this.blur()"></asp:TextBox>
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
                                            <asp:TextBox ID="txtSize" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                Text='<%# Bind("SIZE") %>' Style="text-align: center"></asp:TextBox>
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
                                            <asp:TextBox ID="txtMFG" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                Text='<%# Bind("MFG") %>' Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lbl124" runat="server" Text="Fitment</br> Date"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtFitmentDT" runat="server" BorderStyle="None" Text='<%# Bind("Fittment_DT") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lbl124" runat="server" Text="Removal</br> Date"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemovalDT" runat="server" BorderStyle="None" Text='<%# Bind("TYRE_REMOVE_DT") %>'
                                                onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblDist" Text="Distance</br>Covered" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDist" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                Text='<%# Bind("Dist_Covered") %>' Style="text-align: right"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblRemark" Text="Remarks" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemark" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                Text='<%# Bind("Remark") %>' Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblVendorNM" Text="Vendor</br>Name" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtVendorNM" runat="server" onfocus="this.blur()" Text='<%# Bind("VendorNM") %>'
                                                BorderStyle="Groove" Style="text-align: center"></asp:TextBox>
                                            <asp:HiddenField ID="hdfVendorCode" runat="server" Value='<%# Bind("VendorCode") %>'/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblRemoldDT" Text="Remold</br>Date" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemoldDT" runat="server" onfocus="this.blur()" BorderStyle="Groove"
                                                Width="100px" Text='<%# Bind("Action_DT") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsale" Text="Remold/</br>Reject" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlRemoldRej" runat="server">
                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Remold" Value="P"></asp:ListItem>
                                                <asp:ListItem Text="Reject" Value="R"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblSold" Text="Amount" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemoldAmount" runat="server" BorderStyle="Groove" Enabled="false"
                                                Text="" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Style="text-align: right"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblClaimRej" Text="Reason</br>of</br>Rejection" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtReason" runat="server" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                OnClientClick="javcascript:return OnSubmit()" />
                            <asp:HiddenField ID="hdfNetAmt" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
