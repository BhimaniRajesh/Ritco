<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;           
     }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Trail Balance Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td  valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt"><b>Select Voucher Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="3">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Voucher Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="Tr1" visible="false" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Account" runat="server"></asp:Label></td>
                            <td align="left" colspan="2" valign="top">
                                <asp:DropDownList ID="DLLAcc" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Group Wise" Selected Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Vendor Wise" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Employee Wise" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Driver Wise" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="Account Wise" Value="6"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rpttyp_SUB" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Ledger Wise" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Transaction Wise" Value="3"></asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="center">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select " runat="server"></asp:Label>
                                <asp:UpdatePanel ID="UP1" runat="server">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="RD_CUST_VEND" RepeatDirection="horizontal" CssClass="blackfnt" 
                                            runat="server" OnSelectedIndexChanged="RD_CUST_VEND_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Text="Customer" Selected="True" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Vendor" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Employee" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Driver" Value="4"></asp:ListItem>
                                        </asp:RadioButtonList></ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td colspan="2" align="Left">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CUST_VEND" Width="250" Height="100" SelectionMode="multiple" runat="server" CssClass="blackfnt">
                                        </asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <%--<asp:ListItem Text="All" Value="All" Selected="True">
                                </asp:ListItem>--%>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Account" runat="server"></asp:Label></td>
                            <td colspan="2" align="Left">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CAT" Width="150" Height="80" SelectionMode="Multiple" runat="server"
                                            OnSelectedIndexChanged="LT_CAT_SelectedIndexChanged" AutoPostBack="true" CssClass="blackfnt">
                                        </asp:ListBox>
                                        <asp:ListBox ID="LT_ACC" Width="280" Height="100" SelectionMode="Multiple" runat="server"
                                            CssClass="blackfnt">
                                            <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                        </asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Format" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return OnSub_DATACHECK();"--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
