<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillAprovalCriteria.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillApproval_BillAprovalCriteria" %>

<%@ Register Src="~/Common_UserControls/RPT_Date.ascx" TagPrefix="MultiCheckCombo" TagName="RPT_Date" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" src="./../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvCPKMBillDT.ClientID%>");
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

    </script>
    <div style="width: 10in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <UserControl:UserMessage runat="server" ID="umsg" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td height="30">
                                        <font class="bluefnt">
                                            <strong>Bill Approval of CPKM</strong> </font>
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
                            <table cellpadding="1" cellspacing="1" border="0" style="width: 80%" class="boxbg">
                                <thead>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CPKM Bill Approval"></asp:Label></td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <b>Vendor</b>
                                        </td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlVendor" Width="200PX">
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
                                        <td colspan="4" align="center">
                                            <asp:Button runat="server" ID="btnSearch" Text="Submit" OnClick="btnSearch_OnClick" />
                                        </td>
                                    </tr>
                                    <tr class="nrow">

                                        <td colspan="4">
                                            <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMBillDT" AutoGenerateColumns="False" CellSpacing="1"
                                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:RadioButton runat="server" ID="rbBill" onclick="RadioCheck(this);" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vendor Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("VendorName") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnVendorCode" Value='<%# Eval("VendorCode") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Month">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblMonth" Text='<%# Eval("Month") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill No.">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillNo" Text='<%# Eval("BillNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill Date">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillDate" Text='<%# Eval("BillDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Vehicle">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNoOfVehicle" Text='<%# Eval("NoOfVehicle") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillAmount" Text='<%# Eval("BillAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>

                                    <tr runat="server" id="trsubbtn" style="display: none" class="bgbluegrey">
                                        <td align="center" colspan="4">
                                            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_OnClick" />
                                        </td>
                                    </tr>
                                </thead>
                            </table>

                        </td>
                    </tr>

                </table>

            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
        </div>
    </div>
</asp:Content>

