<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_SALES_SUMMAREY_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>
    <script language="javascript" src="./../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function ChkRadio(obj)
	{
	      
	     document.getElementById('ctl00_MyCPH1_divdate').style.display = "none";
	     document.getElementById('ctl00_MyCPH1_divyrtyp').style.display = "none";
	     if (document.getElementById("ctl00_MyCPH1_rdMonth_9").checked==true)
         {
            document.getElementById('ctl00_MyCPH1_divdate').style.display = "block";
         }
         
          if (document.getElementById("ctl00_MyCPH1_rdMonth_2").checked==true )
         {
            document.getElementById('ctl00_MyCPH1_divyrtyp').style.display = "block";
         }
         if (document.getElementById("ctl00_MyCPH1_rdMonth_3").checked==true )
         {
            document.getElementById('ctl00_MyCPH1_divyrtyp').style.display = "block";
         }
         if (document.getElementById("ctl00_MyCPH1_rdMonth_4").checked==true )
         {
            document.getElementById('ctl00_MyCPH1_divyrtyp').style.display = "block";
         }
         if (document.getElementById("ctl00_MyCPH1_rdMonth_5").checked==true )
         {
            document.getElementById('ctl00_MyCPH1_divyrtyp').style.display = "block";
         }
         
	}
	function YearChange()
	{	
	     ddYear=document.getElementById("ctl00_MyCPH1_ddYear"); 
	  
	     if(ddYear.value=="<%=System.DateTime.Today.ToString("yyyy")%>")
	       {
    	        document.getElementById("ctl00_MyCPH1_rdMonth_0").disabled=false
	            document.getElementById("ctl00_MyCPH1_rdMonth_1").disabled=false
	            document.getElementById("ctl00_MyCPH1_rdMonth_6").checked=false
	            document.getElementById("ctl00_MyCPH1_rdMonth_0").checked=true
	       }
	       else
	        {
    	        document.getElementById("ctl00_MyCPH1_rdMonth_0").disabled=true
	            document.getElementById("ctl00_MyCPH1_rdMonth_1").disabled=true
	            document.getElementById("ctl00_MyCPH1_rdMonth_0").checked=false
	            document.getElementById("ctl00_MyCPH1_rdMonth_6").checked==true 
	       }
	}
	function cust(ID)
    {         
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
         var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
         winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    </script>
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Sales Summary report</strong> </font>
            </td>
        </tr>       
        <tr>
            <td align="right">
                <PRBAR:PRB ID="PB" runat="server" />
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr id="TRRPV1" runat="server" style="display: block">
            <td align="Left">
                <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                    <tr class="bgbluegrey">
                        <td colspan="5" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="center">
                            <asp:Label ID="lblselmonthCri" CssClass="blackfnt" Text="Select Year" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddYear" onChange="Javascript:YearChange();" runat="server">
                            </asp:DropDownList>
                            <div id="divyrtyp" style="display: none" runat="server">
                                <asp:RadioButtonList ID="RTY_TY_YR" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Selected="True" Text="Calender Year" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Financial Year" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </td>
                        <td align="left" colspan="2">
                            <asp:RadioButtonList ID="rdMonth" RepeatColumns="3" RepeatDirection="Horizontal"
                                onClick="javascript:ChkRadio(this);" runat="server" CssClass="blackfnt">
                                <asp:ListItem Text="Current Month" Selected="true" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Previous  Month" Value="2"></asp:ListItem>
                                <asp:ListItem Text="First  Quarter" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Sencond Quarter" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Third  Quarter" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Fourth Quarter" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Year" Value="7"></asp:ListItem>
                                <asp:ListItem Text="Today" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Last Week (including today)" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Date Range" Value="10"></asp:ListItem>
                            </asp:RadioButtonList>
                            <div id="divdate" style="display: none" runat="server">
                                <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                    MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                    name="anchor1" id="anchor1">
                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                </a>
                                <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                    MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                    name="anchor2" id="a1">
                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <tr id="Tr1" runat="server" style="background-color: white; display: block;">
                        <td align="left">
                            <font class="blackfnt">Select
                                <asp:DropDownList ID="DT_TYPE" runat="server">
                                    <asp:ListItem Text="Origin" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Destination" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                                Location</font>
                        </td>
                        <td align="left" colspan="2">
                            <Location:HR ID="Fromlc" runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="center">
                            Select Customer
                        </td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr id="Tr2" runat="server" style="background-color: white; display: block;">
                        <td align="RIght" colspan="3">
                            <asp:Button ID="btnlist" runat="server" Text="Step -1 " CssClass="blacknt" OnClick="btnShow_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
