<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query_BA_BillEntry.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_ver1_Query_BA_BillEntry" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

function OnSub_DATACHECK()
     {
             var cboVendor=document.getElementById("ctl00_MyCPH1_cboVendor");
      var cboDocType=document.getElementById("ctl00_MyCPH1_cboDocType");
      var ddlRouteMode=document.getElementById("ctl00_MyCPH1_ddlRouteMode");
     
     //alert("HIii")
     
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;  
            
                
            
            if(cboVendor.value=="")
	        {
	         alert("Please Select Vendor!!!")
	         cboVendor.focus();
	         return false;
	        }
	        if(cboDocType.value=="")
	        {
			        alert("Please select Type!!!")
			        cboDocType.focus();
			        return false;
	        }
	        if(ddlRouteMode.value=="")
	        {
			        alert("Please select Route Type!!!")
			        ddlRouteMode.focus();
			        return false;
	        }       
     }
    </script>

    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                            class="blklnkund"><strong> Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>BA Bill Entry</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Sales Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Booking Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#FFFFFF">
                                <font class="blackfnt">Select Vendor </font>
                            </td>
                            <td bgcolor="#FFFFFF" colspan="3" align="left">
                                <asp:DropDownList ID="cboVendor" CssClass="blackfnt" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#FFFFFF">
                                <font class="blackfnt">Select Type</font></td>
                            <td bgcolor="#FFFFFF" colspan="3" align="left">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboDocType" CssClass="blackfnt" runat="server">
                                            <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                                            <asp:ListItem Text="For Booking" Value="bkg"></asp:ListItem>
                                            <asp:ListItem Text="For Delivery" Value="dly"></asp:ListItem>
                                        </asp:DropDownList></ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td valign="top">
                                <font class="blackfnt">Select Mode Type</font></td>
                            <td valign="top" align="left" colspan="3">
                                <asp:DropDownList ID="ddlRouteMode" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="--Select--" Value=""></asp:ListItem>
                                    <asp:ListItem Text="ALL(W/o-Road)" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Road" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server"
                                    Text="Show" Width="75px" />
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
