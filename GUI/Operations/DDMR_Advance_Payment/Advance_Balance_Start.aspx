<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Advance_Balance_Start.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_Main" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../Finance/VendorPayment_Ver1/VendorPayment.js"></script>

    <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1");
    cal.setCssPrefix("TEST");
    cal.showNavigationDropdowns();
    </script>

    <script language="JavaScript" type="text/javascript">
        Frm_Name="ctl00_MyCPH1_"
        function Check_Submit_Data()
        {
            if (document.getElementById(Frm_Name+'txtDocNo').value=="" && document.getElementById(Frm_Name+'txtManualNo').value=="")
            {
                if(document.getElementById(Frm_Name+'DT_radDate_0').checked)
                {
                    if(document.getElementById(Frm_Name+'DT_txtDateFrom').value=="")
                    {
                        alert("Plz Enter From date")
                        document.getElementById(Frm_Name+'DT_txtDateFrom').focus();
                        return false;
                    }
                    if(document.getElementById(Frm_Name+'DT_txtDateTo').value=="")
                    {
                        alert("Plz Enter To date")
                        document.getElementById(Frm_Name+'DT_txtDateTo').focus();
                        return false;
                    }
                }
		    }
		    var Search_Char="~"
		    if (document.getElementById(Frm_Name+'Txt_Vendor').value.indexOf(Search_Char)==-1)
		    {
		               alert("Plz Enter Vendor :- Name~Code Format");
		               document.getElementById(Frm_Name+'Txt_Vendor').focus();
		               return false
		    }
		    if (document.getElementById(Frm_Name + 'Chk_DocType_0').checked == false)
		    {
                alert("Plz Select At Least One Document Type")
                document.getElementById(Frm_Name+'Chk_DocType_0').focus();
                return false;
            }
        }
    </script>

    <br />
    <div align="left">
        <table border="0" style="width: 9.5in">
            <tr>
                <td>
                    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="100%">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>
                                    <asp:Label Font-Bold="true" ID="Trn_Title1" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" height="16">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b></b></font>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>
                                    <asp:Label Font-Bold="true" ID="Trn_Title" runat="server" CssClass="blackfnt" Text=""></asp:Label></b>
                                </font>
                                <asp:HiddenField ID="Hnd_Trn_Typ" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Transaction Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">Enter Vendor </font>
                            </td>
                            <td style="width: 339px" nowrap>
                                <asp:TextBox ID="Txt_Vendor" runat="server" Width="350" BorderStyle="Groove" CssClass="blackfnt"
                                    onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor')"></asp:TextBox>
                                <div id="Abc" runat="server" class="boxbg" />
                              <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                    ServiceMethod="GetVendor" ServicePath="AtlasAutoComplete.asmx" TargetControlID="Txt_Vendor">
                                </ajaxToolkit:AutoCompleteExtender>
                                <font class="redfnt">Plz Type Initial Character OF Vendor Name </font>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td valign="top" colspan="4" align="center">
                                <font class="blackfnt"><b>OR</b> </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td valign="top">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocument" runat="server" Text="System Document Number"></asp:Label>
                                </font>
                            </td>
                            <td valign="top" align="left">
                                <asp:TextBox ID="txtDocNo" runat="server" Width="250px" TextMode="MultiLine" Rows="3"  onblur="this.value=this.value.toUpperCase()"  BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox><font
                                    class="blackfnt">(If Multiple - Separated By Comma)</font>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td valign="top" colspan="4" align="center">
                                <font class="blackfnt"><b>OR</b> </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td valign="top">
                                <font class="blackfnt">
                                    <asp:Label ID="Label1" runat="server" Text="Manual Document Number"></asp:Label>
                                </font>
                            </td>
                            <td valign="top" align="left">
                                <asp:TextBox ID="txtManualNo" runat="server"  Width="250px" TextMode="MultiLine" Rows="3" onblur="this.value=this.value.toUpperCase()" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox><font
                                    class="blackfnt">(If Multiple - Separated By Comma)</font>
                            </td>
                        </tr>
                        <%--<tr bgcolor="#FFFFFF" id="Tr_Route_Typ" runat="server">
                            <td valign="top">
                                <font class="blackfnt">Select Route Type</font></td>
                            <td valign="top" align="left">
                                <asp:DropDownList ID="ddlRouteMode" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value=""></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr bgcolor="#FFFFFF" id="Tr_Doc_Typ" runat="server">
                            <td valign="top">
                                <font class="blackfnt">Select Document Type</font></td>
                            <td valign="top" align="left">
                                <asp:CheckBoxList ID="Chk_DocType" runat="server" RepeatDirection="Horizontal"  >
                                    <%--<asp:ListItem Text="THC" Value="T"> </asp:ListItem>
                                    <asp:ListItem Text="PRS" Value="P"></asp:ListItem>
                                    <asp:ListItem Text="DRS" Value="D"></asp:ListItem>--%>
                                    <asp:ListItem Text="DDMR" Value="DDMR" Selected="True"></asp:ListItem>
                               </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td valign="top" align="center" colspan="4">
                                <asp:Button ID="btnsubmit1" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnShow_Click" />
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
