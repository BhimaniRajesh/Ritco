<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_DocketGST_Register_Query" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var serviceUrl = '<%=ResolveClientUrl("~/services/GSTCommonService.asmx")%>';
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function OnSub_DATACHECK() {
            if (!DateCheck())
                return false;
        }

        function OnCustomerChange() {
            <%--if ($('#<%= txtCustomer.ClientID %>').val() == "") {
                $('#<%= hdnCustomerCode.ClientID%>').val("");
            }--%>
        }
        $(document).ready(function () {
            AutoCompleteByAjaxVer2($('#<%= txtCustomer.ClientID %>'), serviceUrl + '/CustomerAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
                   'searchText', 'l', 'l', 'v', 'l', 'v', '<%= hdnCustomerCode.ClientID%>', 'No entries found!', 2, null, false);
        });
    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                            &gt; </strong><strong>CN GST Report</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
       
        <tr>
            <td height="300" valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select CN GST Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left"  >
                                <asp:DropDownList ID="ddlDateType" runat="server" width="200px">
                                    <asp:ListItem Text="Booking Date" Value="BD" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Entry Date" Value="ED"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                               <font class="blackfnt">Select Pay Basis :</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlPayBasis" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Customer :</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox Text="" ID="txtCustomer" runat="server" Width="250" onblur="OnCustomerChange()"></asp:TextBox>
                                <asp:HiddenField ID="hdnCustomerCode" runat="server" />
                            </td>
                        </tr>

                        <tr bgcolor="white" align="center">
                            <td colspan="4">
                                <font class="blackboldfnt">OR </font>
                            </td>
                        </tr>
                        <tr id="Tr111" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label111" CssClass="blackfnt" Text="CN Number :" runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:TextBox Text="" ID="txtdocno" runat="server" Width="250"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>

                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>
</asp:Content>
