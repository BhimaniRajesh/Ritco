<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ApprovalCriteria.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_CreditKmsApproval_ApprovalCriteria" %>

<%@ Register Src="~/Common_UserControls/RPT_Date.ascx" TagPrefix="MultiCheckCombo" TagName="RPT_Date" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../Images/CalendarPopup.js"></script>
    <script language="javascript" src="./../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvCPKMDT.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        function calculateGrandTotal() {
            var txtvalue = 0;
            $("#ctl00_MyCPH1_gvCPKDTdet input[name*='txtValue']").each(function (index) {
                if ($.trim($(this).val()) != "")
                    if (!isNaN($(this).val()))
                        txtvalue = txtvalue + parseFloat($(this).val());
            });
            $("#ctl00_MyCPH1_gvCPKDTdet span[id*='lblValueTotal']").text(txtvalue);
        }
    </script>
    <div style="width: 10in">
        <UserControl:UserMessage runat="server" ID="umsg" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td height="30">
                                <font class="bluefnt">
                                    <strong>Credit KMS Approval For CPKM</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue">
                                <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="1" cellspacing="1" border="0" width="100%" class="boxbg" id="tblCriteria" runat="server">
                        <thead>
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Credit KMS Approval For CPKM"></asp:Label></td>
                            </tr>
                            <tr class="nrow">
                                <td>
                                    <b>Fleet Center</b>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlFleetCenter" Width="200PX">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="nrow">
                                <td>
                                    <b>Date Range</b>
                                </td>
                                <td>

                                    <UserControl:RPT_Date runat="server" ID="RPT_Date" EnableTillDate="true" />
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td align="center" colspan="3">
                                    <b>OR</b>
                                </td>
                            </tr>
                            <tr class="bgwhite">
                                <td>
                                    <b>Vehicle No</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtVehicleNo" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <asp:Button ID="BtnSearch" runat="server" Text="Step 1" OnClick="BtnSearch_Click" />
                                </td>
                            </tr>



                        </thead>
                    </table>

                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="1" cellspacing="1" border="0" width="100%" class="boxbg" id="tblCPKDTHead" runat="server">
                        <thead>
                            <tr class="nrow">

                                <td colspan="4">
                                    <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMDT" AutoGenerateColumns="False" CellSpacing="1"
                                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:RadioButton runat="server" ID="rbVehicle" onclick="RadioCheck(this);" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sr. No.">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblSrno" Text='<%# Eval("Srno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fleet Center">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblFleetCenter" Text='<%# Eval("FleetCenter") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vehicle No.">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblVehicleNo" Text='<%# Eval("VehicleNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           
                                            <asp:TemplateField HeaderText="CPKM Date">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblCPMKDate" Text='<%# Eval("CPMKDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vendor Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("VendorName") %>'></asp:Label>
                                                    <asp:HiddenField ID="HdnVendorCode" runat="server" Value='<%# Eval("VendorCode") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Value">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblTotalValue" Text='<%# Eval("TotalValue") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Credit KMS">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblCreditKms" Text='<%# Eval("CreditKms") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr runat="server" id="trsubbtn" class="bgbluegrey">
                                <td align="center" colspan="4">
                                    <asp:Button runat="server" ID="BtnStep2" CssClass="btn btn-primary" Text="Step 2" OnClick="BtnStep2_Click" />
                                </td>
                            </tr>
                        </thead>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="1" cellspacing="1" border="0" width="100%" style="display: none" class="boxbg" id="tblCPKDTDet" runat="server">
                        <thead>
                            <tr class="nrow">

                                <td colspan="4">
                                    <asp:GridView runat="server" OnRowDataBound="gvCPKDTdet_OnRowDataBound" CssClass="boxbg" ID="gvCPKDTdet" AutoGenerateColumns="False" CellSpacing="1" ShowFooter="true"
                                        HeaderStyle-CssClass="bgbluegrey"  PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr. No.">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblSrno" Text='<%# Eval("Srno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vehicle No.">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblVehicleNo" Text='<%# Eval("VehicleNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tyre No">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblTyreNo" Text='<%# Eval("TyreNo") %>'></asp:Label>
                                                  <asp:HiddenField runat="server" ID="hdnTyreID" Value='<%# Eval("TyreID") %>' />
                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Model">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblModel" Text='<%# Eval("Model") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Pattern">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblPattern" Text='<%# Eval("Pattern") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Size">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblSize" Text='<%# Eval("Size") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tyre Type">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblTyreType" Text='<%# Eval("TyreType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tyre MFG">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblTyreMFG" Text='<%# Eval("TyreMFG") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fittment Date">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblFittmentDate" Text='<%# Eval("FittmentDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Removal Date">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblRemovalDate" Text='<%# Eval("RemovalDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblRemarks" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblTotalvalueText" Text='Total Value' Font-Bold="true"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Value">
                                                <ItemTemplate>
                                                
                                                            <asp:TextBox runat="server" ID="txtValue" Text='<%# Eval("Value") %>'  onblur="javascript:calculateGrandTotal();" onkeypress="javasccript: validFloat(event,this.id);"/>
                                                  <asp:HiddenField runat="server" ID="hdnDetailVendorCode" Value='<%# Eval("VendorCode") %>' />
                                                </ItemTemplate>

                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblValueTotal" Text='<%# Eval("TotalValue") %>' Font-Bold="true"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr class="nrow">

                                <td colspan="4">
                                    <asp:GridView runat="server" CssClass="boxbg" ID="gvTotal" AutoGenerateColumns="False" CellSpacing="1"
                                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
                                        <Columns>

                                            <asp:TemplateField HeaderText="Vendor Name">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("VendorName") %>'></asp:Label>
                                                    <asp:HiddenField ID="HdnVendorCode" runat="server" Value='<%# Eval("VendorCode") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Value">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblTotalValue" Text='<%# Eval("TotalValue") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Final Rate">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblFinalRate" Text='<%# Eval("FinalRate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Credit KM">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblCreditKM" Text='<%# Eval("CreditKM") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Free Kms">
                                                <ItemTemplate>
                                                    <asp:HyperLink Text='View' Target="_blank" NavigateUrl='<%# "~/GUI/Fleet/Operations/Issue/UploadedImages/" + Eval("FilePath") %>' ID="lnkFreeKms" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr runat="server" id="tr1" class="bgbluegrey">
                                <td align="center" colspan="4">
                                    <asp:Button runat="server" ID="btnStep4" CssClass="btn btn-primary" Text="Reject" OnClick="btnStep4_Click" />
                                    <asp:Button runat="server" ID="BtnStep3" CssClass="btn btn-primary" Text="Approved" OnClick="BtnStep3_Click" />
                                </td>
                            </tr>
                        </thead>
                    </table>
                </td>
            </tr>
        </table>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
        </div>
    </div>
</asp:Content>

