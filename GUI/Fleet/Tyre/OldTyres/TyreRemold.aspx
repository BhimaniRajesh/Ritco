<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreRemold.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreRemold" %>

<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">

        function OnSubmit() {
            var GV_TyreRemold = document.getElementById("ctl00_MyCPH1_GV_TyreRemold");

            var ddlVendor = document.getElementById("ctl00_MyCPH1_ddlVendor");
            var txtRemoldDT = document.getElementById("ctl00_MyCPH1_txtRemoldDT");
            var Count = 0;

            if (ddlVendor.value == "0") {
                alert("Please select Vendor.");
                ddlVendor.focus();
                return false;
            }
            if (txtRemoldDT.value == "") {
                alert("Please enter Remold Date.");
                txtRemoldDT.value = "";
                txtRemoldDT.focus();
                return false;
            }
            for (i = 2; i <= GV_TyreRemold.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreRemold$ctl0" + i + "$";
                var chkSelect = document.getElementById(pref + "chkSelect");

                if (chkSelect.checked == true) {
                    Count = Count + 1;
                }
            }
            if (Count == 0) {
                alert("Select At least one Tyre ID for Remold.");
                return false;
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

    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Remold</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
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
    <table width="40%" cellpadding="0" cellspacing="0" border="1">
        <tr class="bgbluegrey">
            <td colspan="2" align="center">
                <asp:Label ID="Label3" Font-Bold="true" runat="server" Text="Remold Tyre"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Select Vendor"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlVendor" Width="200px" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Enter Date"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtRemoldDT" Width="200px" runat="server"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtRemoldDT"
                    runat="server" />
            </td>
        </tr>
        <tr class="bgwhite" align="left">
            <td colspan="2">
                <br />
                <asp:GridView ID="GV_TyreRemold" BorderWidth="1" CellSpacing="0" CellPadding="0"
                    runat="server" Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                    OnRowDataBound="GV_TyreSale_RowDataBound" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
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
<%--                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
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
                               <asp:HiddenField ID="hdfTyreID" runat="server" Value='<%# Bind("TYRE_ID") %>' />
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
                                <asp:Label ID="lbl124" runat="server" Text="Removal</br> Date"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
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
                        <%-- <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblVendorNM" Text="Vendor Name" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtVendorNM" runat="server" BorderStyle="Groove" Style="text-align: center"></asp:TextBox>
                                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                            ServiceMethod="AutoVendor" ServicePath="../../services/WebService.asmx" TargetControlID="txtVendorNM">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRemoldDT" Text="Remold Date" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemoldDT" runat="server" BorderStyle="Groove" Width="100px" Text="">
                                        </asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtRemoldDT"
                                            runat="server" />
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
                                        <asp:DropDownList ID="ddlRemoldRej" runat="server" OnSelectedIndexChanged="ddlRemoldRej_SelectedIndexChanged"
                                            AutoPostBack="true">
                                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Remold" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="Reject" Value="N"></asp:ListItem>
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
                                        <asp:TextBox ID="txtAmount" runat="server" BorderStyle="Groove" Text="" Style="text-align: right"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblClaimRej" Text="Reason of Rejection" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtReason" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr align="center" class="bgbluegrey">
            <td colspan="2">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                    OnClientClick="javascript:return OnSubmit()" />
            </td>
        </tr>
    </table>
</asp:Content>
