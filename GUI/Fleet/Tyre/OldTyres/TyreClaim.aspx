<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreClaim.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreClaim" %>

<%@ Register TagPrefix="UC5" TagName="UCMyReceiptControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">

        function CheckVendor() {
            debugger;
            //alert("hi@@@")
            // var currentTime = new Date();
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");
            alert(GV_TyreClaim.rows.length);

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";
                var txtClaim = document.getElementById(pref + "txtClaim");

                var Search_Char = "~"
                if (txtClaim.value.indexOf(Search_Char) == -1) {
                    alert("Invalid Vendor Name~Code Format");
                    txtClaim.focus();
                    return false
                }
                if (txtClaim.value == "") {
                    alert("Please enter vendor code.");
                    return false;
                }
            }
        }

        function OnSubmitStep() {
            debugger;
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";
                var txtClaim = document.getElementById(pref + "txtVendor");
                var txtClaimDT = document.getElementById(pref + "txtClaimDT");

                var Search_Char = "~";

                if (txtClaim.value.indexOf(Search_Char) == -1) {
                    alert("Invalid Vendor Name~Code Format");
                    txtClaim.value = "";
                    txtClaim.focus();
                    return false
                }

                if (txtClaim.value == "") {
                    alert("Please enter vendor code.");
                    txtClaim.value = "";
                    return false;

                }
                if (txtClaimDT.value == "") {
                    alert("Please enter Claim Date.");
                    return false;
                }
            }
        }

        function OnSubmit() {

            var GV_TyreClaim2 = document.getElementById("ctl00_MyCPH1_GV_TyreClaim2");

            for (i = 2; i <= GV_TyreClaim2.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim2$ctl0" + i + "$";
                var ddlAction = document.getElementById(pref + "ddlAction");
                var txtClaimAmt = document.getElementById(pref + "txtClaimAmt");
                var txtReason = document.getElementById(pref + "txtReason");

                if (ddlAction.value == "P") {
                    if (txtClaimAmt.value == "") {
                        alert("Please enter Vendor");
                    }
                }
                else {
                    if (txtReason.value == "") {
                        alert("Please enter Sale Amount");
                    }
                }
            }

        }
    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Claim</asp:Label>
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
<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>--%>
            <table width="40%" cellpadding="0" cellspacing="0" border="1">
                <tr class="bgwhite" align="left" id="trClaim" runat="server">
                    <td>
                        <asp:GridView ID="GV_TyreClaim" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                            Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                            OnRowDataBound="GV_TyreClaim_RowDataBound" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                            FooterStyle-CssClass="bgwhite" PagerSettings-Mode="NumericFirstLast" PageSize="10"
                            SelectedIndex="1">
                            <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="SelectAll" AutoPostBack="true" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label241" runat="server" Text="Truck</br> Number"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTruckNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_VEHNO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblvhno2" Text="System </br>Generated </br>Tyre No." runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSysTyreNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_ID") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
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
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
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
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRemark" Text="Remarks" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemark" runat="server" Enabled="false" BorderStyle="Groove" Width="175px"
                                            Style="text-align: center" Text='<%# Bind("Remark") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblClaimVend" Text="Claim With" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtClaim" runat="server" BorderStyle="Groove" Text="" Style="text-align: left"></asp:TextBox>
                                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                            ServiceMethod="AutoVendor" ServicePath="../../services/WebService.asmx" TargetControlID="txtClaim">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblclaimDT" Text="When sent on Claim" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtClaimDT" runat="server" BorderStyle="Groove" Text="" Style="text-align: left"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtClaimDT"
                                            runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr align="right">
                    <td>
                        <asp:Button ID="btnStep" runat="server" Text="Step-1" OnClick="btnStep_Click" />
                    </td>
                </tr>
                <tr id="trClaim2" runat="server">
                    <td>
                        <br>
                            <br>
                        <br></br>
                        <asp:GridView ID="GV_TyreClaim2" runat="server" AutoGenerateColumns="false" 
                            BorderWidth="1" CellPadding="0" CellSpacing="0" CssClass="boxbg" 
                            EmptyDataText="No Data Found ...." FooterStyle-CssClass="bgwhite" 
                            HeaderStyle-CssClass="bgbluegrey" PagerSettings-Mode="NumericFirstLast" 
                            PageSize="10" SelectedIndex="1" Visible="true" Width="100%">
                            <Columns>
                                <%-- <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>                                
                                <asp:CheckBox ID="chkSelectAll" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label241" runat="server" Text="Truck&lt;/br&gt; Number"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTruckNo" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("TYRE_VEHNO") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblvhno2" runat="server" 
                                            Text="System &lt;/br&gt;Generated &lt;/br&gt;Tyre No."> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSysTyreNo" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("TYRE_ID") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblmodel" runat="server" Text="Model"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtModel" runat="server" BorderStyle="Groove" Enabled="false" 
                                            onfocus="this.blur()" Style="text-align: center" Text='<%# Bind("MODEL") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPattern" runat="server" Text="Pattern"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPattern" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("PATTERN") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblsize" runat="server" Text="Size"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSize" runat="server" BorderStyle="Groove" Enabled="false" 
                                            onfocus="this.blur()" Style="text-align: center" Text='<%# Bind("SIZE") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblType" runat="server" Text="Tyre &lt;/br&gt;Type"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTyreType" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("TYRE_TYPE") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblMFG" runat="server" Text="Tyre&lt;/br&gt; MFG"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtMFG" runat="server" BorderStyle="Groove" Enabled="false" 
                                            onfocus="this.blur()" Style="text-align: center" Text='<%# Bind("MFG") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label12345" runat="server" Text="Fittment&lt;/br&gt; Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFittment_DT" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("Fittment_DT") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lbl124" runat="server" Text="Removal&lt;/br&gt; Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemovalDT" runat="server" BorderStyle="Groove" 
                                            Enabled="false" onfocus="this.blur()" Style="text-align: center" 
                                            Text='<%# Bind("TYRE_REMOVE_DT") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblDist" runat="server" Text="Distance&lt;/br&gt;Covered">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDist" runat="server" BorderStyle="Groove" Enabled="false" 
                                            onfocus="this.blur()" Style="text-align: right" 
                                            Text='<%# Bind("Dist_Covered") %>'></asp:TextBox>
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
                                        <asp:TextBox ID="txtRemark" runat="server" BorderStyle="Groove" Enabled="false" 
                                            Text='<%# Bind("Remark") %>' Width="175px"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblClaimVend" runat="server" Text="Claim With"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtClaim" runat="server" BorderStyle="Groove" Enabled="false" 
                                            Style="text-align: center" Text='<%# Bind("VendorCode") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblclaimDT" runat="server" Text="When sent on Claim"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtClaimDT" runat="server" BorderStyle="Groove" 
                                            Enabled="false" Style="text-align: center" Text='<%# Bind("Claim_DT") %>'></asp:TextBox>
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
                                        <asp:DropDownList ID="ddlAction" runat="server" AutoPostBack="true" 
                                            OnSelectedIndexChanged="ddlAction_SelectedIndexChanged">
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
                                    <ItemTemplate> <%--onkeypress="javascript:validFloat(event,this.getAttribute('id'))" --%>
                                        <asp:TextBox ID="txtClaimAmt" runat="server" AutoPostBack="true"                                            
                                            OnTextChanged="TextChanged_ClaimAmt" Style="text-align: right"></asp:TextBox>
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
                                        <asp:TextBox ID="txtReason" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br></br>
                        </br>
                        </br>
                    </td>
                </tr>
                <tr id="trPayment" runat="server">
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
                <%--        <tr>
            <td>
                <br>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <UC6:UCMyReceiptControl_1 ID="UCMyReceiptControl1" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br>
            </td>
        </tr>--%>
                <asp:HiddenField ID="hdftotClaimAmt" runat="server" />
            </table>
<%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
