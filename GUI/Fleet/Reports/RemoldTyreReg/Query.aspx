<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyreSale_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function CheckVendor() {
            //debugger;
            var txtVendor = document.getElementById("MyCPH1_txtVendor");
            alert(txtVendor.value);
            var Search_Char = "~";
            if (txtVendor.value.indexOf(Search_Char) == -1) {
                alert("Invalid Vendor Name~Code Format");
                txtVendor.value = "";
                txtVendor.focus();
                return false;
            }

        }

        
    </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Remould Tyre Register"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <hr align="left" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr>
            <td>
                <table width="700px" border="1" align="left" cellpadding="0" cellspacing="0" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Search Criteria"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                    <td>
                    <asp:Label ID="Label6" runat="server" Font-Bold="true" Text="Select Location :"></asp:Label>
                    </td>
                        <td align="left">
                            <Location:LH ID="Fromlc" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Date :"
                                Width="102px"></asp:Label>
                        </td>
                        <td valign="top">
                            <Date:DT ID="DT" runat="server" EnableTillDate="true" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td>
                            <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Enter Vendor :"
                                Width="102px"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtVendor" runat="server" Width="300px" BorderStyle="Groove"></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                ServiceMethod="AutoVendor" ServicePath="../../../services/WebService.asmx" TargetControlID="txtVendor">
                            </ajaxToolkit:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td>
                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Status :"
                                Width="102px"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatus" runat="server" Width="100px">
                                <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Pending" Value="P"></asp:ListItem>
                                <asp:ListItem Text="Settled" Value="S"></asp:ListItem>
                                <asp:ListItem Text="Rejected" Value="R"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
