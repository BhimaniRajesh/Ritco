<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="ExternalThcAuditCriteria.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcAuditCriteria" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar" TagPrefix="pgb" %>
<asp:content id="Content1" contentplaceholderid="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="ExternalThcAudit.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 85%;
                        height: 50px;" align="center">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="center" colspan="2">
                                <strong><span style="font-size: 8pt; font-family: Verdana">External THC Audit</span></strong>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;">
                                <span style="font-size: 8pt; font-family: Verdana">Tripsheet No</span>
                            </td>
                            <td style="width: 339px; height: 25px;">
                                <asp:TextBox ID="txtTripsheetNo" runat="server" MaxLength="50" onchange="javascript:this.value=this.value.toUpperCase()"
                                    Columns="25" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <%--<tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;" colspan="2">
                                <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span>
                            </td>
                        </tr>
                        <tr class="bgbluegrey" style="height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Select External THC For Audit</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="center">
                                <font class="blackfnt">Enter Customer Code</font>
                            </td>
                            <td style="width: 339px">
                                <asp:TextBox ID="Txt_Customer" runat="server" Width="350" BorderStyle="Groove" CssClass="blackfnt"
                                    onblur="javascript:Customer_Location_Blur(this,'Customer','N')"></asp:TextBox>
                                <div id="Abc" runat="server" class="boxbg" />
                                <ajaxtoolkit:autocompleteextender id="extLocation" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetCustomer" servicepath="../../../../Finance/Billing_Ver1/AtlasAutoComplete.asmx"
                                    targetcontrolid="Txt_Customer">
                                </ajaxtoolkit:autocompleteextender>
                                <font class="redfnt">Plz Type Initial Character OF Customer Name </font>
                            </td>
                        </tr>--%>
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="center" colspan="2">
                                <strong><span style="font-size: 8pt; font-family: Verdana">Select Tripsheet Generation Date Range</span></strong>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td style="width: 210px; height: 25px;" align="center">
                                <font class="blackfnt">Select Tripsheet Date</font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td align="center" colspan="2" style="height: 25px">
                                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CausesValidation="False" />
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
</asp:content>
