<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Start.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_Payment_Start" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH1" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="../../../Images/CalendarPopup.js" type="text/javascript"></script>

    <script language="javascript" src="../../../images/commonJs.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function OnSub_DATACHECK() {
            if (!DateCheck())
                return false;
        }

        function Validation() 
        {
            if (!DateCheck())
                return false;

            if (document.getElementById('ctl00_MyCPH1_rdDocketCri').checked == true && document.getElementById('ctl00_MyCPH1_txtPONo').value == '') {
                alert('Please Enter the General PO Number');
                document.getElementById('ctl00_MyCPH1_txtPONo').focus();
                document.getElementById('ctl00_MyCPH1_txtPONo').select();
                return false;
            }

            if (document.getElementById('ctl00_MyCPH1_rdDateRange').checked == true && document.getElementById('ctl00_MyCPH1_txtPartyCode').value == '') 
            {
                alert('Please Select the Vendor Name ~ Code');
                document.getElementById('ctl00_MyCPH1_txtPartyCode').focus();
                document.getElementById('ctl00_MyCPH1_txtPartyCode').select();
                return false;
            }
        }   
    </script>

    <asp:HiddenField ID="hidDocTypeCode" runat="server" />
    <div align="left">
        <br />
        <table cellspacing="1" class="stbl" align="left">
            <tr class="hrow">
                <td colspan="3" align="center">
                    <asp:Label ID="lblQry" CssClass="ffnt" Font-Bold="true" runat="server"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="4">
                    <Location:LH1 ID="Fromlc" runat="server" />
                </td>
            </tr>
            <tr class="nrow">
                <td rowspan="2" style="width: 25px">
                    <asp:RadioButton ID="rdDateRange" GroupName="grpcri" runat="server" />
                </td>
                <td align="left" style="width: 104px">
                    <font class="nfnt">Select Date </font>&nbsp;
                </td>
                <td align="left" style="width: 5in">
                    <Date:DT ID="DT" runat="server" />
                </td>
            </tr>
            <tr class="nrow">
                <td style="width: 104px">
                    <asp:Label ID="lblPartyCode" runat="server" CssClass="nfnt">Enter Party Code</asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPartyCode" runat="server" CssClass="ltxtm" Width="350px"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                        ServiceMethod="GetVendor" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtPartyCode">
                    </ajaxToolkit:AutoCompleteExtender>
                </td>
            </tr>
            <tr bgcolor="white">
                <td valign="middle">
                    <asp:RadioButton ID="rdDocketCri" GroupName="grpcri" runat="server" />
                </td>
                <td style="width: 104px">
                    <asp:Label ID="lblDocketNo" runat="server" CssClass="nfnt"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPONo" runat="server" BorderStyle="groove" CssClass="ltxt"
                        MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td class="frow" colspan="3">
                    <asp:Button ID="btnShow" OnClientClick="Javascript:return Validation();" runat="server"
                        Text="Show" Width="75px" CssClass="fbtn" OnClick="btnShow_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
