<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Payment_1.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
  
   function nwOpen()
        {
            window.open("popupLoc.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
         function Submit()
        {
         FRM_Name="ctl00_MyCPH1_"
         var Billno=document.getElementById(FRM_Name+"Txt_Billno").value 
         var Vendor_Billno=document.getElementById(FRM_Name+"Txt_V_Billno").value 
         var Txt_Vendor=document.getElementById(FRM_Name+"Txt_Vendor").value 
        
            if(Billno=="" && Vendor_Billno)
            {
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
            if(Txt_Vendor == "" && Txt_Vendor =="")
            {
               
                if(document.getElementById(FRM_Name+'Txt_Vendor').value=="")
                {
                        alert("Plz Select Enter Vendor Name~Code Format")
                        document.getElementById(FRM_Name+'Txt_Vendor').focus();
                        return false;
                }
                var Search_Char="~"
		        if (document.getElementById(FRM_Name+'Txt_Vendor').value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid Vendor Name~Code Format");
		           document.getElementById(FRM_Name+'Txt_Vendor').focus();
		           return false
		        }
            }
        }
    
    </script>

    <br />
    <div align="left">
        <table width="900">
            <tr>
                <td>
                    <table cellspacing="1" width="100%" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>
                                    <asp:Label Font-Bold="true" ID="Trn_Title1" runat="server" CssClass="blackfnt" Text="Bill Entry Payments"></asp:Label>
                                </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" height="16">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b></b></font>
                            </td>
                        </tr>
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
                                <%--<atlas:AutoCompleteExtender ID="Ext1" runat="server" DropDownPanelID="Abc">
                                    <atlas:AutoCompleteProperties TargetControlID="Txt_Vendor" ServicePath="../AtlasAutoComplete.asmx"
                                        ServiceMethod="GetVendor" MinimumPrefixLength="1" Enabled="true" />
                                </atlas:AutoCompleteExtender>--%>
                                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                    ServiceMethod="GetVendor" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                    TargetControlID="Txt_Vendor">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="3">
                                <strong><font class="blackfnt"><b>OR</b></font></strong>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label7" CssClass="blackfnt" Text="Enter Bill NO " runat="server" Width="213px"></asp:Label>
                            </td>
                            <td align="left" colspan="2" valign="top" style="height: 24px;">
                                <asp:TextBox ID="Txt_Billno" runat="server" Width="150px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="3">
                                <strong><font class="blackfnt"><b>OR</b></font></strong>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Enter Vendor Bill NO " runat="server"
                                    Width="213px"></asp:Label>
                            </td>
                            <td align="left" colspan="2" valign="top" style="height: 24px;">
                                <asp:TextBox ID="Txt_V_Billno" runat="server" Width="150px" BorderStyle="Groove"
                                    CssClass="blackfnt"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <asp:Button ID="Button3" runat="server" Text="Submit" BorderStyle="Groove" Width="150"
                                    OnClick="Button3_Click" CssClass="blackfnt" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
