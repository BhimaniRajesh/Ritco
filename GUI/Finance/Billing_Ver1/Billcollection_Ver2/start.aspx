<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="start.aspx.cs" Inherits="Finance_Billing_Billsubmission_start" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../BillCollection_Ver2.js"></script>

    <script language="javascript" type="text/javascript">
    var months = new Array("","January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December");
    var client_name="<%=Session["Client"]%>"
    FRM_Name="ctl00_MyCPH1_"
    function OnSubmit_Submission()
    {
        //alert("hi...")
        //alert(document.getElementById(FRM_Name+'Cbopaybas').value)
        if(document.getElementById(FRM_Name+'Cbopaybas').value=="")
        {
            alert("Plz Select Bill Type")
            document.getElementById(FRM_Name+'Cbopaybas').focus();
            return false;
        }
		if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
        {
            alert("Plz Enter Customer Name~Code Format")
            document.getElementById(FRM_Name+'Txt_Customer').focus();
            return false;
        }
        if(document.getElementById(FRM_Name+'txtmanualbillno').value=="" && document.getElementById(FRM_Name+'Billno').value=="")
        {
		    if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
            {
                alert("Plz Enter Customer Name~Code Format")
                document.getElementById(FRM_Name+'Txt_Customer').focus();
                return false;
            }
            var Search_Char="~"
		    if (document.getElementById(FRM_Name+'Txt_Customer').value.indexOf(Search_Char)==-1)
		    {
		        alert("Invalid Customer Name~Code Format");
		        document.getElementById(FRM_Name+'Txt_Customer').focus();
		        return false;
            }
			if(document.getElementById(FRM_Name+'DT_radDate_0').checked)
            {                                     
                if(document.getElementById(FRM_Name+'DT_txtDateFrom').value=="")
                {
                    alert("Plz Enter From date")
                    document.getElementById(FRM_Name+'DT_txtDateFrom').focus();
                    return false;
                }
                if(document.getElementById(FRM_Name+'DT_txtDateTo').value=="")
                {
                    alert("Plz Enter To date")
                    document.getElementById(FRM_Name+'DT_txtDateTo').focus();
                    return false;
                }
            }
        }
		if(document.getElementById(FRM_Name+'txtmanualbillno').value != "")
        {
            if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
            {
                alert("Plz Enter Customer Name~Code Format")
                document.getElementById(FRM_Name+'Txt_Customer').focus();
                return false;
            }
            var Search_Char="~"
		    if (document.getElementById(FRM_Name+'Txt_Customer').value.indexOf(Search_Char)==-1)
		    {
		        alert("Invalid Customer Name~Code Format");
		        document.getElementById(FRM_Name+'Txt_Customer').focus();
		        return false;
            }
        }										    
        return true;
    }
    </script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

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
                    <font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>
                        Module</strong></font></a></b> <strong>&gt; </strong></font><a href="#"><font class="blklnkund">
                            <strong>Finance</strong></font></a> <strong>&gt; </strong><a href=""><font class="blklnkund">
                                <strong>Billing</strong> </font></a>&gt; <font class="bluefnt"><strong>Bill Collection</strong></font>
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
                        height: 383px;" align="center">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="center" colspan="2">
                                <strong><span style="font-size: 8pt; font-family: Verdana">Enter Bills No &nbsp;For
                                    Collection</span></strong>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;">
                                <span style="font-size: 8pt; font-family: Verdana">Bill Number</span>
                            </td>
                            <td style="width: 339px; height: 25px;">
                                <asp:TextBox ID="Billno" runat="server" MaxLength="50" onchange="javascript:this.value=this.value.toUpperCase()"
                                    Columns="25" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;" colspan="2">
                                <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;">
                                <span style="font-size: 8pt; font-family: Verdana">Manual Bill Number</span>
                            </td>
                            <td style="width: 339px; height: 25px;">
                                <asp:TextBox ID="txtmanualbillno" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"
                                    MaxLength="20" Columns="20" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px; height: 25px;" colspan="2">
                                <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span>
                            </td>
                        </tr>
                        <tr class="bgbluegrey" style="height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Select Bills For Collection</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px">
                                <span style="font-size: 8pt; font-family: Verdana">Bill Type</span>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="Cbopaybas" runat="server" BorderStyle="Groove" CssClass="blackfnt" DataTextField="CodeDesc" DataValueField="CodeId">                                    
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px;display:none;">
                            <td align="center" style="width: 210px">
                                <span style="font-size: 8pt; font-family: Verdana">Bill Collection Type</span>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="ddlBillColType" runat="server" BorderStyle="Groove" CssClass="blackfnt">                                    
                                    <asp:ListItem Selected="True" Value="N">Bill Generated After 01 Apr 2011</asp:ListItem>
                                    <asp:ListItem Value="O">Bill Generated Before 01 Apr 2011</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="center">
                                <font class="blackfnt">Enter billing party code </font>
                            </td>
                            <td style="width: 339px">
                                <asp:TextBox ID="Txt_Customer" runat="server" Width="350" BorderStyle="Groove" CssClass="blackfnt"
                                    onblur="javascript:Customer_Location_Blur(this,'Customer','N')"></asp:TextBox>
                                <div id="Abc" runat="server" class="boxbg" />
                                <ajaxToolkit:AutoCompleteExtender ID="extLocation" runat="server" Enabled="True"
                                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                    MinimumPrefixLength="1" ServiceMethod="GetCustomer" ServicePath="../AtlasAutoComplete.asmx"
                                    TargetControlID="Txt_Customer">
                                </ajaxToolkit:AutoCompleteExtender>
                                <font class="redfnt">Plz Type Initial Character OF Customer Name </font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td class="bgbluegrey" colspan="2" align="center">
                                <p align="center">
                                    <font class="blackfnt">Select Bill Generation Date Range</font>
                                </p>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td style="width: 210px; height: 25px;" align="center">
                                <font class="blackfnt">Select Bill Date</font>
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
</asp:Content>
