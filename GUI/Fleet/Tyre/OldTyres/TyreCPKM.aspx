<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreCPKM.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyreStock_TyreCPKM" %>

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


       

        function OnSubmitStep() {
            //debugger;
            var GV_TyreClaim = document.getElementById("ctl00_MyCPH1_GV_TyreClaim");

            var ddlVendor = document.getElementById("ctl00_MyCPH1_ddlVendor");
            var txtClaimDT = document.getElementById("ctl00_MyCPH1_txtClaimDT");
            var hf_ServerDt = document.getElementById("ctl00_MyCPH1_hf_ServerDt");

            var Count = 0;

            if (ddlVendor.value == "0") {
                alert("Please select Vendor.");
                ddlVendor.focus();
                return false;
            }
           
        }

       

        function AmontCalculation(e) {

            var CurrentRow = $(e).closest('tr');

            var txtRate = $(e).closest('tr').find('input[id*="txtRate"]');
            var txtTotalRate = $(e).closest('tr').find('input[id*="txtTotalRate"]');
            var hdnTotalRate = $(e).closest('tr').find('input[id*="hdnTotalRate"]');

            if (txtRate.val() != '') {
                var KMS = 0, NetKMS = 0, Amount = 0, NetAmount = 0, RebateAmt = 0, IGST = 0, CGST = 0, tyre = 0

            }

            var SubTotal = 0;
            $("input[id*='txtRate']").each(function (data) {
                var txtRate = $(this);
                var chkVehicleNo = $('#' + $(this).attr('id').replace("txtRate", "chkSelect"));
                var hdnNoofTyre = $('#' + $(this).attr('id').replace("txtRate", "hdnNoofTyre"));

                tyre = hdnNoofTyre.val();
                if (txtRate.val() != '') {
                    SubTotal = SubTotal + parseFloat(txtRate.val());
                }
                else {
                    SubTotal = SubTotal + 0;
                }
            });
            $(".GetThisLabelValue").val(SubTotal);
            $("input[type=hidden][id*=hdnTotalRate]").val(SubTotal);

           
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
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            <table width="500px" cellpadding="0" cellspacing="0" border="1">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Label ID="Label3" Font-Bold="true" runat="server" Text="CPKM Of Tyre"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="500px" border="1" runat="server" id="thhh" visible="false">

                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Enter Date"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClaimDT" Width="200px" runat="server"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtClaimDT"
                                        runat="server" />
                                    <asp:HiddenField ID="hf_ServerDt" runat="server" />
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
                            SelectedIndex="1" ShowFooter="true">
                            <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="LabelSr" Width="50px" runat="server" Text="Sr No."></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label241" runat="server" Text="Truck Number"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTruckNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("VEHNO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblvhno2" Text="Tyre No." runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSysTyreNo" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_NO") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                        <asp:HiddenField ID="hdnNoofTyre" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Nooftyre") %>' />
                                        <asp:HiddenField ID="hdfTYRE_ID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
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
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
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
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
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
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblType" Text="Tyre Type" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTyreType" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_TYPE") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblMFG" Text="Tyre MFG" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtMFG" runat="server" Enabled="false" BorderStyle="Groove" onfocus="this.blur()"
                                            Text='<%# Bind("MFG") %>' Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="Label12345" runat="server" Text="Fittment Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFittment_DT" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("Fittment_DT") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lbl124" runat="server" Text="Removal Date"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemovalDT" runat="server" Enabled="false" BorderStyle="Groove"
                                            Text='<%# Bind("TYRE_REMOVE_DT") %>' onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRemark" Text="Remarks" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemark" runat="server" Enabled="false" BorderStyle="Groove" Width="175px"
                                            Style="text-align: center" Text='<%# Bind("Remark") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <FooterStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal" Text="Total" runat="server">
                                        </asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                                    <HeaderStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRate" Text="Value" runat="server">
                                        </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRate" runat="server" onchange="return AmontCalculation(this);" BorderStyle="Groove" Width="175px"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <FooterTemplate>
                                        <asp:HiddenField ID="hdnTotalRate" runat="server"></asp:HiddenField>
                                        <asp:TextBox ID="txtTotalRate" Enabled="false" CssClass="GetThisLabelValue" runat="server" BorderStyle="Groove" Width="175px"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="500px" cellpadding="0" cellspacing="0" border="1">
                            <tr class="bgbluegrey">
                                <td class="blackboldfnt"><center>Vendor</center></td>
                                <td class="blackboldfnt"><center>Total Rate</center></td>
                                <td class="blackboldfnt"><center>Final Rate</center></td>
                                <td class="blackboldfnt"><center>No. Of Tyre</center></td>
                                <td class="blackboldfnt"><center>Credit KM</center></td>
                                <td class="blackboldfnt"><center>Free KMS</center></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlVendor" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged" AutoPostBack="true" Width="200px" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtTotalValue" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnTotalValue"/>

                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFinalRate" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnFinalRate"/>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtNofTyre" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnNofTyre"/>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCreditKM" Enabled="false"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCreditKM"/>
                                </td>
                                <td>
                                    <asp:FileUpload runat="server" ID="flUpload" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr align="center" class="bgbluegrey">
                    <td>
                        <asp:Button ID="btnStep" runat="server" Text="Submit" OnClick="btnStep_Click" OnClientClick="javascript:return OnSubmitStep()" />
                    </td>
                </tr>

            </table>
        </ContentTemplate>
		 <Triggers>
            <asp:PostBackTrigger ControlID="btnStep" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
