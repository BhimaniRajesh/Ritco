<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillGenerationCriteria.aspx.cs"
    Inherits="GUI_Finance_Billing_GST_Billgeneration_BillGenerationCriteria" EnableEventValidation="true" %>

<%@ Register TagPrefix="UserControl" TagName="DateRange" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagPrefix="UserControl" TagName="UserMessage" Src="~/GUI/Common_UserControls/UserMessage.ascx" %>
<%@ Register TagPrefix="UserControl" TagName="ProgressBar" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="JS/BillGenerationCriteria.js"></script>
    <script language="javascript" type="text/javascript">

        var serviceUrl = '<%=ResolveUrl("~/services/WebxCommonService.asmx/")%>';

    </script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
    </script>
    <div style="width: 900px;">
        <asp:UpdatePanel ID="upSubmit" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
                    <tr class="hrow">
                        <td colspan="2" align="center">
                            <b>Bill Generation Criteria</b>
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>Select Transaction Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlTransactionType" onchange="javascript:return OnChangeBillType()" Width="150px">
                                <asp:ListItem Text="Transaction Billing" Value="1"></asp:ListItem>
                                <asp:ListItem Text="General Billing" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="nrow" id="trCategory">
                        <td>Select Transaction Category
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlTransactionCategory" />
                        </td>
                    </tr>
                    <tr class="nrow" id="trDate">
                        <td>Select Transaction Date Range
                        </td>
                        <td align="left">
                            <UserControl:DateRange ID="dtBookingDate" runat="server" />
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td>Select Customer
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerCode" runat="server" Width="80" CssClass="ltxt"></asp:TextBox>
                            <asp:TextBox ID="txtCustomerName" runat="server" Width="160" Enabled="false" CssClass="ltxt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="nrow" id="trState">
                        <td>Select State
                            <asp:DropDownList runat="server" ID="ddlLocationState" Enabled="false">
                                <asp:ListItem Text="Billing" Value="B"></asp:ListItem>
                                <asp:ListItem Text="Origin" Value="O"></asp:ListItem>
                                <asp:ListItem Text="Destination" Value="D"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlCustomerState" Width="150px">
                                <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                            </asp:DropDownList>

                        </td>
                    </tr>
                    <tr class="nrow" id="trBusinessType">
                        <td>Select Business Type
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlBusinessType" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="hrow">
                        <td colspan="2" style="text-align: center;">
                            <asp:Button runat="server" ID="btnGetList" Text="Submit"
                                OnClientClick="javascript:return ValidateOnSubmit();" />
                            <asp:HiddenField ID="hidBusinessTypeRuleYesNo" runat="server" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnFromDate" runat="server" />
                <asp:HiddenField ID="hdnToDate" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
        </div>
        <UserControl:UserMessage ID="uMsgBox" runat="server" />
    </div>
</asp:Content>

