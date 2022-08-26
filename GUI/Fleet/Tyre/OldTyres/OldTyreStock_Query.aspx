<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="OldTyreStock_Query.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyreStock_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        var ServiceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
        var txtVendor, hdnVendor, txtVehicleNo, hdnVehicleNo;
        $(document).ready(function () {
            txtVehicleNo = $('#' + '<%=txtVehicleNo.ClientID%>')
            hdnVehicleNo = '<%=hdnVehicleNo.ClientID%>';
            InitializedAutocomplete();
            //var prm = Sys.WebForms.PageRequestManager.getInstance();
            //if (prm != null) {
            //    prm.add_endRequest(function (sender, e) {
            //        if (sender._postBackSettings.panelsToUpdate != null) {
            //            InitializedAutocomplete();
            //        }
            //    });
            //};
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function EndRequestHandler(sender, args) {
                txtVehicleNo = $('#' + '<%=txtVehicleNo.ClientID%>');
                hdnVehicleNo = '<%=hdnVehicleNo.ClientID%>';
                InitializedAutocomplete();
            }

        });

        function InitializedAutocomplete() {

            // var txtVendor, hdnVendor, txtVehicleNo = $('#' + '<%=txtVehicleNo.ClientID%>'), hdnVehicleNo = '<%=hdnVehicleNo.ClientID%>';
            AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle", []);
        }

        //--------------------------------------- For Select All Checkbox
        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_OldTyre') > -1)) {
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
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_OldTyre') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
        }

        function OnSubmit() {
            //  var ddlAction = document.getElementById("ctl00$MyCPH1$ddlAction");
            debugger;

            var GV_OldTyre = document.getElementById("ctl00_MyCPH1_GV_OldTyre");

            for (i = 2; i <= GV_OldTyre.rows.length; i++) {
                pref = "ctl00$MyCPH1$GV_OldTyre$ctl0" + i + "$";
                var chkSelect = document.getElementById(pref + "chkSelect");

                if (chkSelect.checked == false) {
                    alert("Please select at least one Tyre ID");
                    return false;
                }
            }

        }
        
    </script>

    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Old Tyre Stock</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <table width="500px" border="0" cellpadding="0" cellspacing="0">
                <tr class="bgbluegrey">
                    <td align="center" colspan="2">
                        <asp:Label ID="Label4" Text="Search Criteria" runat="server" Font-Bold="true" Style="text-align: center">
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" Text="Select Action" runat="server" Font-Bold="true" Style="text-align: center">
                        </asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                     <UserControl:UserMessage runat="server" ID="UserMessage" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAction" runat="server" Width="175px" OnSelectedIndexChanged="ddlAction_SelectedIndexChanged"
                            AutoPostBack="true">
                            <asp:ListItem Text="Internal" Value="I"></asp:ListItem>
                            <asp:ListItem Text="Sale" Value="S"></asp:ListItem>
                            <asp:ListItem Text="Claim" Value="C"></asp:ListItem>
                            <asp:ListItem Text="Remold" Value="R"></asp:ListItem>
                            <asp:ListItem Text="CPKM" Value="K"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Vehicle No</b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtVehicleNo" runat="server"></asp:TextBox>
                        <asp:HiddenField runat="server" ID="hdnVehicleNo" />
                    </td>
                </tr>
                <tr id="trsearch" runat="server">
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSearch" runat="server" Text="Search Tyre" OnClick="btnSearch_Click" />
                    </td>
                </tr>
            </table>
            <br />

            <br />
            <div id="divList" runat="server" visible="false">
                <table width="800px" cellpadding="0" cellspacing="0" border="1">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Old Tyre Stock"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite" align="left">
                        <td>
                            <asp:GridView ID="GV_OldTyre" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                                Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                                AllowPaging="true" OnPageIndexChanged="gwTyreList_PageIndexChanged" OnPageIndexChanging="gwTyreList_PageIndexChanging"
                                Width="100%" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgbluegrey"
                                PagerSettings-Mode="NumericFirstLast" PageSize="25" SelectedIndex="1">
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
                                    <asp:TemplateField HeaderText="" ItemStyle-Width="5px" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsr" Text="Sr.</br>No" runat="server" Style="text-align: center">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" runat="server" Style="text-align: center">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="Label12345" runat="server" Text="Removal</br> Date"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemovalDT" runat="server" Width="80px" BorderStyle="Groove"
                                                Text='<%# Bind("TYRE_REMOVE_DT") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblvhno2" Text="Tyre No." runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSysTyreNo" Width="80px" runat="server" BorderStyle="Groove"
                                                Text='<%# Bind("TYRE_NO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                            <asp:HiddenField ID="hdfTYRE_ID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblVehno" Text="Vehicle No." runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtVehNo" Width="80px" runat="server" BorderStyle="Groove"
                                                Text='<%# Bind("TYRE_VEHNO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
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
                                            <asp:TextBox ID="txtModel" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                                Text='<%# Bind("MODEL") %>' Style="text-align: center"></asp:TextBox>
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
                                            <asp:TextBox ID="txtSize" runat="server" BorderStyle="Groove" onfocus="this.blur()"
                                                Text='<%# Bind("SIZE") %>' Style="text-align: center"></asp:TextBox>
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
                                            <asp:TextBox ID="txtPattern" runat="server" BorderStyle="Groove"
                                                Text='<%# Bind("PATTERN") %>' Style="text-align: center" onfocus="this.blur()"></asp:TextBox>
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
                                            <asp:TextBox ID="txtTyreType" runat="server" Width="60px" BorderStyle="Groove"
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
                                            <asp:TextBox ID="txtMFG" Width="60px" runat="server" BorderStyle="Groove"
                                                onfocus="this.blur()" Text='<%# Bind("MFG") %>' Style="text-align: center"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblDist" Text="Distance</br>Covered" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDist" runat="server" Width="60px" BorderStyle="Groove"
                                                onfocus="this.blur()" Text='<%# Bind("Dist_Covered") %>' Style="text-align: right"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackboldfnt" />
                                        <HeaderTemplate>
                                            <asp:Label ID="lblCost" Text="Per </br>KM Cost" runat="server">
                                            </asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPerKMCost" runat="server" Width="60px" BorderStyle="Groove"
                                                Text='<%# Bind("CostPerKM") %>' Style="text-align: right" onfocus="this.blur()"></asp:TextBox>
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
                                            <asp:TextBox ID="txtRemark" runat="server" Enabled="false" Wrap="false" BorderStyle="Groove"
                                                Width="300px" Text='<%# Bind("Remark") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr align="center" class="bgbluegrey" id="trSubmit" runat="server">
                        <td>
                            <%--</br>OnClientClick="javascript:return CheckAction()" --%>
                            <asp:Button ID="btnSubmit" runat="server" Text="" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
		<Triggers>
     <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"/> 
    </Triggers>
		
    </asp:UpdatePanel>
</asp:Content>
