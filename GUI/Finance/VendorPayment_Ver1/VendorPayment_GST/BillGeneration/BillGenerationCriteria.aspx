<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillGenerationCriteria.aspx.cs"
    Inherits="GUI_Finance_VendorPayment_GST_Billgeneration_BillGenerationCriteria" EnableEventValidation="true" %>

<%@ Register TagPrefix="UserControl" TagName="DateRange" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagPrefix="UserControl" TagName="UserMessage" Src="~/GUI/Common_UserControls/UserMessage.ascx" %>
<%@ Register TagPrefix="UserControl" TagName="ProgressBar" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="JS/BillGenerationCriteria.js"></script>
    <script language="javascript" type="text/javascript">

        var serviceUrl = '<%=ResolveUrl("~/services/WebxCommonService.asmx/")%>';

    </script>

    <div style="width: 900px;">
        <asp:UpdatePanel ID="upSubmit" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
                    <tr class="hrow">
                        <td colspan="2" align="center">
                            <b>Vendor Bill Payment Criteria</b>
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>Transaction Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlTransactionType" onchange="javascript:return OnChangeBillType()" Width="150px">
                                <asp:ListItem Text="Freight Payment" Value="1"></asp:ListItem>
                                <asp:ListItem Text="General Services Payment" Value="2" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                   <%-- <tr class="nrow"  id="trCategory">
                        <td>Select Transaction Category
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlTransactionCategory" />
                        </td>
                    </tr>--%>
                    <tr class="nrow"  id="trDate">
                        <td>Select Transaction Date Range
                        </td>
                        <td align="left">
                            <UserControl:DateRange ID="dtBookingDate" runat="server" />
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>Select Vendor
                        </td>
                        <td>
                            <asp:TextBox ID="txtVendorCode" runat="server" Width="80" CssClass="ltxt" ></asp:TextBox>
                            <asp:TextBox ID="txtVendorName" runat="server" Width="160" Enabled="false" CssClass="ltxt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="nrow" id="trGstCharged">
                        <td>GST Charged
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlGstCharged" onchange="javascript:return OnChangeGstCharged();" Width="150px">
                                <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                <asp:ListItem Text="Intra-State : SGST + CGST" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Intra-UT : UTGST + CGST" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Inter-State : IGST" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Unregistered" Value="4"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="nrow" id="trSupplyState">
                        <td>Select State of Supply
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlSupplyState" onchange="javascript:return OnChangeSupplyState()" Width="150px">
                              <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnSupplyState" runat="server" />
                        </td>
                    </tr>
                    <tr class="nrow" id="trBookingState">
                        <td>Select State of Booking
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlBookingState" onchange="javascript:return OnChangeBookingState()" Width="150px">
                                <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnBookingState" runat="server" />
                        </td>
                    </tr>
                    <tr class="hrow">
                        <td colspan="2" style="text-align: center;">
                            <asp:Button runat="server" ID="btnGetList" Text="Submit"
                                OnClientClick="javascript:return ValidateOnSubmit(); return false;"  />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnFromDate" runat="server" />
                <asp:HiddenField ID="hdnToDate" runat="server" />
                <asp:HiddenField ID="hdnCompanyCode" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
        </div>
        <UserControl:UserMessage ID="uMsgBox" runat="server" />
    </div>
</asp:Content>

