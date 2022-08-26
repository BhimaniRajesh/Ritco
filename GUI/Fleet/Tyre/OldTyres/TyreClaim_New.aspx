<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreClaim_New.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyreStock_TyreClaim_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">

        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest)
            { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
            // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }


        function CheckVendor(row_Index, txtClaim) {
            // debugger;
            //alert("hi@@@")
            var currentTime = new Date();
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");
            //alert(GV_TyreClaim.rows.length);

            var Search_Char = "~"

            if (txtClaim.value == "") {
                txtClaim.value = "";
                return true;
            }

            if (txtClaim.value.indexOf(Search_Char) == -1) {
                alert("Invalid Vendor Code~Name Format");
                txtClaim.value = "";
                txtClaim.focus();
                return false
            }


            ////            if (txtClaim.value == "") {
            ////                txtClaim.value = "";
            ////                return true;
            ////            }

            ////            for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_GV_TyreClaim").rows.length; intIndex++) {
            ////                if (intIndex < 10) {
            ////                    str_Index = "0" + intIndex;
            ////                }
            ////                else {
            ////                    str_Index = intIndex;
            ////                }
            ////                if (row_Index == intIndex - 2) {
            ////                    continue;
            ////                }
            ////                if (document.getElementById("ctl00_MyCPH1_GV_TyreClaim_ctl" + str_Index + "_txtClaim").value == txtClaim.value) {
            ////                    alert("This Vehicle No is already exist at row " + (intIndex - 1));
            ////                    txtClaim.value = "";
            ////                    txtClaim.focus();
            ////                    return;
            ////                }
            ////            }


            ////            createXMLHttpRequest();
            ////            if (xmlHttpRequest) {
            ////                xmlHttpRequest.onreadystatechange = function () {
            ////                    if (xmlHttpRequest.readyState == 4) {
            ////                        var returnValue = xmlHttpRequest.responseText.split("~");
            ////                        alert(returnValue[0]);

            ////                        if (returnValue[0] == "N") {
            ////                            alert("Please Enter valid Vendor. ");
            ////                            txtClaim.value = "";
            ////                            txtClaim.focus();
            ////                            return false;
            ////                        }
            ////                    }
            ////                }
            ////                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=Check_Vendor&datetime=" + currentTime + "&VENDOR=" + txtClaim.value, false);
            ////                xmlHttpRequest.send(null);
            ////            }
        }

        function OnSubmitStep() {
            //debugger;
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");

            var ddlVendor = document.getElementById("ctl00_MyCPH1_ddlVendor");
            var txtClaimDT = document.getElementById("ctl00_MyCPH1_txtClaimDT");
            var Count = 0;

            if (ddlVendor.value == "0") {
                alert("Please select Vendor.");
                ddlVendor.focus();
                return false;
            }
            if (txtClaimDT.value == "") {
                alert("Please enter Claim Date.");
                txtClaimDT.value = "";
                txtClaimDT.focus();
                return false;
            }

            for (i = 2; i <= GV_TyreClaim.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_TyreClaim$ctl0" + i + "$";
                ////                var txtClaim = document.getElementById(pref + "txtClaim");
                ////                var txtClaimDT = document.getElementById(pref + "txtClaimDT");
                var chkSelect = document.getElementById(pref + "chkSelect");

                var Search_Char = "~";

                //                if (txtClaim.value != "") {
                //                    alert(txtClaim.value);
                //                    if (txtVendor.value.indexOf(Search_Char) == -1) {
                //                        alert("Invalid Vendor Name~Code Format");
                //                        txtClaim.value = "";
                //                        txtClaim.focus();
                //                        return false
                //                    }
                //                }

                if (chkSelect.checked == true) {
                    ////                    if (txtClaim.value == "") {
                    ////                        alert("Please enter vendor code.");
                    ////                        txtClaim.value = "";
                    ////                        txtClaim.focus();
                    ////                        return false;

                    ////                    }
                    ////                    if (txtClaimDT.value == "") {
                    ////                        alert("Please enter Claim Date.");
                    ////                        txtClaimDT.focus();
                    ////                        return false;
                    ////                    }

                    Count = Count + 1;
                }
            }
            if (Count == 0) {
                alert("Select At least one Tyre ID.");
                return false;
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Claim Master</asp:Label>
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
    <table width="500px" cellpadding="0" cellspacing="0" border="1">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Label ID="Label3" Font-Bold="true" runat="server" Text="Claim Of Tyre"></asp:Label>
            </td>
        </tr>
        <tr>
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
                            <asp:TextBox ID="txtClaimDT" Width="200px" runat="server"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtClaimDT"
                                runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table width="500px" cellpadding="0" cellspacing="0" border="1">
        <tr class="bgbluegrey">
            <td>
                <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Tyre Details"></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite" align="left" id="trClaim" runat="server">
            <td>
                <asp:GridView ID="GV_TyreClaim" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                    Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                    OnRowDataBound="GV_TyreClaim_RowDataBound" Width="80%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                    FooterStyle-CssClass="bgwhite" PagerSettings-Mode="NumericFirstLast" PageSize="10"
                    SelectedIndex="1">
                    <Columns>
                        <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <%--<asp:CheckBox ID="chkSelectAll" runat="server" Checked="true" OnCheckedChanged="SelectAll" AutoPostBack="true" />--%>
                                <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" checked="checked" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" Checked="true" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                                <asp:HiddenField ID="hdfTYRE_ID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>' />
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
                        <%--                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
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
                                    Style="text-align: center" Text='<%# Bind("Remark") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <%--                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblClaimVend" Text="Claim</br>With" runat="server">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaim" runat="server" BorderStyle="Groove" Text="" Style="text-align: left"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                    ServiceMethod="AutoVendor" ServicePath="../../../services/WebService.asmx" TargetControlID="txtClaim">
                                </ajaxToolkit:AutoCompleteExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblclaimDT" Text="When</br>sent</br>on Claim" runat="server">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtClaimDT" runat="server" BorderStyle="Groove" Text="" Style="text-align: left"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd MMM yyyy" TargetControlID="txtClaimDT"
                                    runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr align="center" class="bgbluegrey">
            <td>
                <asp:Button ID="btnStep" runat="server" Text="Submit" OnClick="btnStep_Click" OnClientClick="javascript:return OnSubmitStep()" />
            </td>
        </tr>
    </table>
</asp:Content>
