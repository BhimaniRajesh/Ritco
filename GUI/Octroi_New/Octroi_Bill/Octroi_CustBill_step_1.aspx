<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Octroi_CustBill_step_1.aspx.cs" Inherits="GUI_Octroi_New_Octroi_Bill_Octroi_CustBill_step_1"
    Title="Untitled Page" %>

<%@ Register TagName="OctDetail" TagPrefix="Oct" Src="~/GUI/Octroi_New/OctroiBillDetailsControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../octroi.js"></script>

    <script language="javascript" type="text/javascript">
   var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
	 
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
    </script>

    <br />
    <%--<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
        <img alt="back" src="../../images/back.gif" border="0" />
    </a>
</div>   --%>
    <table border="0" cellpadding="1" cellspacing="1" width="900">
        <tr>
            <td align="left">
                <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="90%">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <strong>Prepare Octroi Bill</strong>
                        </td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="90%">
                    <tr style="background-color: White">
                        <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                            &nbsp;Bill No
                        </td>
                        <td class="blackfnt" nowrap style="text-align: left; width: 228px;">
                            <span style="color: #ff0000">&nbsp;&lt;System Generated&gt;</span>
                        </td>
                        <td class="blackfnt" nowrap style="text-align: left; width: 118px;">
                            &nbsp;Bill Date
                        </td>
                        <td colspan="2" width="130" class="blackfnt" nowrap style="text-align: left">
                            &nbsp;<asp:TextBox ID="txtBillDate" runat="server" onblur="javascript:isValidDate(this)"
                                Width="80px" BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillDate,'anchor1','dd/MM/yyyy'); return false;"
                                id="anchor1" name="anchor1">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                            &nbsp;Billing Party Code
                        </td>
                        <td nowrap colspan="4">
                            &nbsp;<asp:TextBox ID="txtPartyCode" runat="server" Width="450" BorderStyle="Groove"
                                CssClass="blackfnt"></asp:TextBox>
                            <div id="Abc" runat="server" class="boxbg" />
                            <%-- <atlas:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
                            <atlas:AutoCompleteProperties TargetControlID="txtPartyCode" ServicePath="../AtlasAutoComplete.asmx"                                         
                            ServiceMethod="GetCustomer" MinimumPrefixLength="1" Enabled="true" />
                            </atlas:AutoCompleteExtender>--%>
                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                ServiceMethod="GetCustomer" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                TargetControlID="txtPartyCode">
                            </ajaxToolkit:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                            &nbsp;Billing Party Address
                        </td>
                        <td colspan="4" class="blackfnt" nowrap style="text-align: left">
                            &nbsp;<strong><asp:Label ID="lblPartyAdd" runat="server"></asp:Label></strong>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left; width: 133px;" nowrap class="blackfnt">
                            &nbsp;Prepared at location
                        </td>
                        <td class="blackfnt" style="text-align: left; width: 228px;">
                            &nbsp;<strong><asp:Label ID="lblPreparedLoc" runat="server"></asp:Label></strong>
                        </td>
                        <td style="text-align: left; width: 118px;" nowrap class="blackfnt">
                            &nbsp;Bill Submission At
                        </td>
                        <td colspan="2">
                            &nbsp;<asp:TextBox ID="txtBillSubAt" runat="server" Width="200" BorderStyle="Groove"
                                CssClass="blackfnt"></asp:TextBox>
                            <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                            <div id="Div2" runat="server" class="boxbg" />
                            <%--<atlas:autocompleteextender id="AutoCompleteExtender1" runat="server" dropdownpanelid="Div2">
                            <atlas:AutoCompleteProperties TargetControlID="txtBillSubAt" ServicePath="../AtlasAutoComplete.asmx" 
                                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                            </atlas:autocompleteextender>--%>
                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                                MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                TargetControlID="txtBillSubAt">
                            </ajaxToolkit:AutoCompleteExtender>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left; width: 133px;" class="blackfnt">
                            &nbsp;Prepared For Location
                        </td>
                        <td style="text-align: left; width: 228px;" class="blackfnt">
                            &nbsp;<strong><asp:Label ID="lblPreparedFor" runat="server"></asp:Label></strong>
                        </td>
                        <td style="text-align: left; width: 118px;" class="blackfnt">
                            &nbsp;Bill Collection At
                        </td>
                        <td colspan="2">
                            &nbsp;<asp:TextBox ID="txtBillColAt" runat="server" Width="200" BorderStyle="Groove"
                                CssClass="blackfnt"></asp:TextBox>
                            <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                            <div id="Div3" runat="server" class="boxbg" />
                            <%--<atlas:autocompleteextender id="AutoCompleteExtender2" runat="server" dropdownpanelid="Div3">
                            <atlas:AutoCompleteProperties TargetControlID="txtBillColAt" ServicePath="../AtlasAutoComplete.asmx" 
                                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                            </atlas:autocompleteextender>--%>
                            
                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True"
                                MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                TargetControlID="txtBillColAt">
                            </ajaxToolkit:AutoCompleteExtender>
                            
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td>
                            <font class="blackfnt">Manual Billno.</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtManualbillno" runat="server" MaxLength="50" onchange="javascript:this.value=this.value.toUpperCase()"
                                Width="200" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                        </td>
                        <td>
                            <font class="blackfnt"></font>
                        </td>
                        <td colspan="2">
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left; width: 133px;">
                            &nbsp;Bill Amount
                        </td>
                        <td align="left" style="width: 228px">
                            &nbsp;<asp:TextBox ID="txtBillAmt" runat="server" Enabled="false" Width="80" MaxLength="10"
                                Text="0.00" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 118px">
                            &nbsp;Due Date
                        </td>
                        <td colspan="2" align="left">
                            &nbsp;<asp:TextBox ID="txtDueDate" runat="server" onblur="javascript:isValidDate(this)"
                                Width="80" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDueDate,'anchor2','dd/MM/yyyy'); return false;"
                                id="a1" name="anchor2">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td>
                            <font class="blackfnt">Special Instruction</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="300" Rows="2" TextMode="MultiLine"
                                onchange="javascript:this.value=this.value.toUpperCase()" BorderStyle="Groove"
                                CssClass="blackfnt"></asp:TextBox>
                        </td>
                        <td>
                            <font class="redfnt"><b>Credit Days</b></font>
                        </td>
                        <td colspan="2">
                            <font class="redfnt">
                                <asp:Label ID="Lbl_Credit_days" runat="server" Text="0.00" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td>
                            <font class="redfnt"><b>Credit Limit</b></font>
                        </td>
                        <td>
                            <font class="redfnt">
                                <asp:Label ID="Lbl_Credit_Limit" runat="server" Text="" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                            </font>
                        </td>
                        <td>
                            <font class="redfnt"><b>OutStanding Amount(As On Date)</b></font>
                        </td>
                        <td colspan="2" align="left">
                            <font class="redfnt">
                                <asp:Label ID="Lbl_Outstanding_amt" runat="server" Text="" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                            </font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellpadding="1" cellspacing="1" width="90%">
                    <tr style="background-color: White">
                        <td colspan="5" class="blackfnt" style="text-align: left; width: 186px;">
                            <Oct:OctDetail ID="OctDetails" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table cellspacing="1" class="boxbg" width="90%">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:HiddenField ID="Hnd_Mindate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_Maxdate" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_Server_dt" runat="server"></asp:HiddenField>
                            <asp:HiddenField ID="Hnd_BillGen_Loc_BasedOn" runat="server"></asp:HiddenField>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return CheckData();"
                                BorderStyle="Solid" BorderWidth="1px" Text="Confirm Bill Generation" Width="150px"
                                OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
