<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ClaimQuery.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyres_ClaimQuery" %>

<%--<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>--%>
<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript" src="./../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="./../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function CheckVendor() {
            var txtVendor = document.getElementById("ctl00_MyCPH1_txtVendor");
            var Search_Char = "~";
            if (txtVendor.value == "") {
                txtVendor.value = "";
                return true;
            }
            if (txtVendor.value.indexOf(Search_Char) == -1) {
                alert("Invalid Vendor Code~Name Format");
                txtVendor.value = "";
                txtVendor.focus();
                return false
            }
        }
        //      function ChecKOnSubmit()
        //      {
        //      
        //      
        //      }

    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Claim of Tyre</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table border="1" width="800px">
        <tr class="bgbluegrey">
            <td colspan="2" align="center">
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Search Criteria"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Select Date</asp:Label>
            </td>
            <td>
                <%--  <Date:DT ID="DT" EnableTillDate="false" runat="server" />--%>
                <uc1:RPT_Date ID="DT" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Font-Bold="True">Name of Vendor & code</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVendor" Width="300px" runat="server"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                    ServiceMethod="AutoVendor" ServicePath="../../AtlasAutoComplete.asmx" TargetControlID="txtVendor">
                </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="OR"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Enter Claim No."></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtClaimID" runat="server" Width="300px"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    MinimumPrefixLength="1" ServiceMethod="AutoClaimNo" ServicePath="../../AtlasAutoComplete.asmx"
                    TargetControlID="txtClaimID">
                </ajaxToolkit:AutoCompleteExtender>
                <%--<asp:Label
                    ID="Label5" runat="server" Text="(comma seperated)"></asp:Label>--%>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
