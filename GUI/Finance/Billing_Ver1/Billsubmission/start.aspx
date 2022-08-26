<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="start.aspx.cs" Inherits="Finance_Billing_Billsubmission_start" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
        FRM_Name="ctl00_MyCPH1_"
       function OnSubmit_Submission()
        {
                        if(document.getElementById(FRM_Name+'txtmanualbillno').value=="" && document.getElementById(FRM_Name+'Billno').value=="")
                        {
				                if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
                                {
                                        alert("Plz Select Enter Customer Name~Code Format")
                                        document.getElementById(FRM_Name+'Txt_Customer').focus();
                                        return false;
                                }
                                var Search_Char="~"
		                        if (document.getElementById(FRM_Name+'Txt_Customer').value.indexOf(Search_Char)==-1)
		                        {
		                           alert("Invalid Customer Name~Code Format");
		                           document.getElementById(FRM_Name+'Txt_Customer').focus();
		                           return false
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
							
					    
		return true;
        }
    </script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <%--</head>
<body>
    <form id="form1" runat="server">--%>
    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center">
                    <font class="blackfnt"><strong>Bill Submission </strong></font>
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
                                <font class="blackfnt"><b>Select Billing Party </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td align="center" style="width: 210px">
                                <span style="font-size: 8pt; font-family: Verdana">Bill Type</span>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="Cbopaybas" runat="server" BorderStyle="Groove" CssClass="blackfnt">
                                    <asp:ListItem Value="All" Selected="true"> All</asp:ListItem>
                                    <asp:ListItem Value="1">PAID Bill</asp:ListItem>
                                    <asp:ListItem Value="2">TBB Bill</asp:ListItem>
                                    <asp:ListItem Value="3">TO PAY Bill</asp:ListItem>
                                    <asp:ListItem Value="6">Octroi Bill</asp:ListItem>
                                    <asp:ListItem Value="7">Misc. Bill/SupplyMentry Bill</asp:ListItem>
                                    <asp:ListItem Value="11">Delivery Bill</asp:ListItem>
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
                                <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                                <div id="Abc" runat="server" class="boxbg" />
                                <%--<atlas:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
                              <atlas:AutoCompleteProperties TargetControlID="Txt_Customer" ServicePath="../AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetCustomer" MinimumPrefixLength="1" Enabled="true" />
                              </atlas:AutoCompleteExtender>--%>
                                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                    ServiceMethod="GetCustomer" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="Txt_Customer">
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
                                <font class="blackfnt">Select Docket Date</font>
                            </td>
                            <td style="width: 600; height: 25px;">
                                <table height="100%" width="100%">
                                    <tr>
                                        <td align="left">
                                            <Date:DT ID="DT" runat="server" />
                                        </td>
                                    </tr>
                                </table>
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
<%--</form>
</body>
</html>
--%>
