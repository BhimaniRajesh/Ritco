<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Payment_1.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function nwOpen() {
            window.open("popupLoc.aspx", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function Submit() {
            FRM_Name = "ctl00_MyCPH1_"
            var PO_NO = document.getElementById(FRM_Name + "txtpono").value
            var PO_Vendor = document.getElementById(FRM_Name + "Txt_Vendor").value
            
            if (PO_NO == "") {
                if (document.getElementById(FRM_Name + 'DT_radDate_0').checked) {

                    if (document.getElementById(FRM_Name + 'DT_txtDateFrom').value == "") {
                        alert("Plz Enter From date")
                        document.getElementById(FRM_Name + 'DT_txtDateFrom').focus();
                        return false;
                    }
                    if (document.getElementById(FRM_Name + 'DT_txtDateTo').value == "") {
                        alert("Plz Enter To date")
                        document.getElementById(FRM_Name + 'DT_txtDateTo').focus();
                        return false;
                    }
                }
            }
            if (PO_Vendor == "" && PO_NO == "") {

                if (document.getElementById(FRM_Name + 'Txt_Vendor').value == "") {
                    alert("Plz Select Enter Vendor Name~Code Format")
                    document.getElementById(FRM_Name + 'Txt_Vendor').focus();
                    return false;
                }
                var Search_Char = "~"
                if (document.getElementById(FRM_Name + 'Txt_Vendor').value.indexOf(Search_Char) == -1) {
                    alert("Invalid Vendor Name~Code Format");
                    document.getElementById(FRM_Name + 'Txt_Vendor').focus();
                    return false
                }
            }
        }
    
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>PO Bill Entry Payment</b></font></a>
                <b>&gt; </b><font class="bluefnt"><b>Payments </b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left" style="width: 9.5in;">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center">
                            <font class="blackfnt">Select Transaction Date</font>
                        </td>
                        <td align="left" colspan="2">
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 2in">
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter Vendor" runat="server" Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="Txt_Vendor" runat="server" Width="250" BorderStyle="Groove" CssClass="blackfnt"
                                onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"></asp:TextBox>
                            <div id="Abc" runat="server" class="boxbg" />
                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True"
                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                MinimumPrefixLength="1" ServiceMethod="GetVendor" ServicePath="../AtlasAutoComplete.asmx"
                                TargetControlID="Txt_Vendor">
                            </ajaxToolkit:AutoCompleteExtender>
                            <%--<atlas:autocompleteextender id="Ext1" runat="server" dropdownpanelid="Abc">
                              <atlas:AutoCompleteProperties TargetControlID="Txt_Vendor" ServicePath="../AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetVendor" MinimumPrefixLength="1" Enabled="true" />
                              </atlas:autocompleteextender>--%>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" style="width: 2in" colspan="3">
                            <strong><font class="blackfnt">OR</font></strong>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label7" CssClass="blackfnt" Text="Enter Bill NO " runat="server" Width="213px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtpono" runat="server" Width="150px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="3">
                            <br />
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell>
                                                <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                                            <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <br />
                        </td>
                    </tr>
                </table>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div style="width: 9.5in" align="center">
            <asp:Button ID="Button3" runat="server" Text="Submit" Width="150" OnClick="Button3_Click"
                CssClass="blackfnt" />
        </div>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
