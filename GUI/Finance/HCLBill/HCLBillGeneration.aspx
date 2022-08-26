<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillGeneration.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillGeneration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="HCLBillGeneration.js?V107" type="text/javascript"></script>

    <script>
        var serviceUrl = '<%=ResolveClientUrl("~/RestService/HCLMasterService.svc")%>';
        var BranchSession = '<%= SessionUtilities.CurrentBranchCode %>';
        var EntryBySession = '<%= SessionUtilities.CurrentEmployeeID %>';
        var CompanyCodeSession = '<%= SessionUtilities.DefaultCompanyCode %>';
        var FinyearSession = '<%= SessionUtilities.FinYear %>';
    </script>
    <div style="width: 800px;">
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
            <tr class="hrow">
                <td colspan="10" align="center">
                    <b>HCL Bill Generation</b>
                    <UserControl:UserMessage runat="server" ID="UserMessage" />
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="10">
                    <table cellspacing="0" cellpadding="0" style="width: 400px" id="tblRate">
                        <tr class="hrow">
                            <th><b>Document Name</b></th>
                            <th><b>Type</b></th>
                            <th><b>Rate</b></th>
                        </tr>
                        <tr class="nrow">
                            <td>Outgoing THC</td>
                            <td>
                                <asp:DropDownList ID="ddlOTHCRateType" runat="server"></asp:DropDownList></td>
                            <td>
                                <asp:TextBox ID="txtOTHCRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="50"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td>Incoming THC</td>
                            <td>
                                <asp:DropDownList ID="ddlITHCRateType" runat="server"></asp:DropDownList></td>
                            <td>
                                <asp:TextBox ID="txtITHCRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="50"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td>DDMR</td>
                            <td>
                                <asp:DropDownList ID="ddlDDMRRateType" runat="server"></asp:DropDownList></td>
                            <td>
                                <asp:TextBox ID="txtDDMRRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="50"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td>MR</td>
                            <td>
                                <asp:DropDownList ID="ddlMRRateType" runat="server"></asp:DropDownList></td>
                            <td>
                                <asp:TextBox ID="txtMRRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="50"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="hrow">
                            <td colspan="4" align="center">
                                <input type="button" id="btnApply" value="Apply For All" onclick="ApplyAll()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="10"><b>Vendor Name</b>
                    <asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="10">
                    <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                        <HeaderTemplate>
                            <table id="Dochead" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="100%">
                                <thead>
                                    <tr class="hrow">
                                        <th>
                                            <asp:CheckBox ID="chkAll" runat="server" /></th>
                                        <th><b>Sr. No</b></th>
                                        <th><b>Document Name</b></th>
                                        <th><b>Actual Total Wgt</b></th>
                                        <th><b>Total PKG</b></th>
                                        <th><b>Type</b></th>
                                        <th><b>Rate</b></th>
                                        <th><b>Amount</b></th>
                                        <th><b>Remarks</b></th>
                                    </tr>
                                </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr class="nrow">
                                    <td>
                                        <asp:CheckBox ID="chkDoc" runat="server" OnClick="CalulateTotal(this)" />
                                    </td>
                                    <td>
                                        <label id="lblSrno"></label>
                                    </td>
                                    </td>
                                <td>
                                    <asp:Label ID="lblDocNo" runat="server" Text='<%# Eval("DocumentNo") %>'></asp:Label>
                                    <asp:HiddenField ID="hdnDocType" runat="server" Value='<%# Eval("DocumentType") %>' />
                                </td>
                                    <td>
                                        <asp:Label ID="lblActWgt" runat="server" Text='<%# Eval("TOTWeight") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTotPkg" runat="server" Text='<%# Eval("TOTPKG") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDetRateType" runat="server"></asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="50" onBlur="SetEditFlag(this)"></asp:TextBox>
                                        <asp:HiddenField ID="hdnIsEdited" runat="server" Value="0" />
                                        <asp:HiddenField ID="HdnOldRate" runat="server" Value="0" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAmount" runat="server" Enabled="false" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" Width="70"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                            </tbody>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr class="nrow">
                <td align="right">
                    <table cellpadding="0" cellspacing="0" width="250px">
                        <tr>
                            <td><b>Total Amount</b></td>
                            <td>
                                <asp:TextBox ID="txtTotAmount" runat="server" Enabled="false" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Rebate</b></td>
                            <td>
                                <asp:TextBox ID="txtRebate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" onBlur="CalulateRebate()"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td><b>Net Amount</b></td>
                            <td>
                                <asp:TextBox ID="txtNetAmount" runat="server" Enabled="false" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="hrow">
                <td colspan="10" align="center">
                    <%--<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript:return OnSubmit();"/>--%>
                    <input type="button" value="Submit" onclick="javascript: return OnSubmit();" id="btnSubmit" />
                    <asp:HiddenField ID="hidClickCount" runat="server" Value="0" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
