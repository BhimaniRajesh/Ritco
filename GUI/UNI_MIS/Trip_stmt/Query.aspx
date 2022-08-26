<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Trip_stmt_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function Chk(obj){
//alert(obj.value)
var cboStatus=document.getElementById("ctl00_MyCPH1_cboStatus");
//       var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
//        var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
	if (document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true )
	{
		//alert("HI")
		//document.form1.cboLocation_TO.disabled=true
		
		cboStatus.disabled=false
		
	}
	else 
	{
	//alert("HI---")
	//document.form1.cboLocation_TO.disabled=false
		cboStatus.disabled=true
		
	}
	}
	function DateCheck()
{
     var Selection=document.getElementById("ctl00_MyCPH1_radDate_0");
     var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
     var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
     
      var txtcustcd=document.getElementById("ctl00_MyCPH1_txtcustcd");
       var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
        var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
     
     /*if(document.getElementById("ctl00_MyCPH1_radDate_0").checked==true)
     {
     txtvendcd.disabled=true
      DLLOrder.disabled=false
       txtcustcd.disabled=false
     }
     else if(document.getElementById("ctl00_MyCPH1_radDate_1").checked==true)
     {
     txtvendcd.disabled=true
      DLLOrder.disabled=false
       txtcustcd.disabled=false
     }
     else if(document.getElementById("ctl00_MyCPH1_radDate_2").checked==true)
     {
     txtvendcd.disabled=false
      DLLOrder.disabled=true
       txtcustcd.disabled=true
     }*/
     
     //alert(document.getElementById("ctl00_MyCPH1_radDate_0").checked)
     if (document.getElementById("ctl00_MyCPH1_radDate_0").checked==true)
     {
        if(txtDateFrom.value=="")
		 {
		  alert("Please enter the From Date")
		  txtDateFrom.focus();
		  return false;
		 }
		 if(txtDateFrom.value!="")
							 {
									if (ValidateForm(txtDateFrom)==false)
									{
									 return false;
									}
							 }
		 if(txtDateTo.value=="")
		 {
		  alert("Please enter the To Date")
		  txtDateTo.focus();
		  return false;
		 }
		 
		 if(txtDateTo.value!="")
							 {
									if (ValidateForm(txtDateTo)==false)
									{
									 return false;
									}
							}
     
     }
}

    </script>

    <br />
    <br />
    <br />
    <div align="left">
        <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="7" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select  Criteria </asp:Label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                        Width="210px">
                        <asp:ListItem  Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                        <asp:ListItem Selected="True" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                        <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                    </asp:RadioButtonList>
                </td>
                <td valign="top" colspan="5">
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
                </td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt">Route Start Location</font>
                </td>
                <td colspan="5" align="left">
                    <asp:TextBox ID="txtxstloc" Width="80" runat="server"></asp:TextBox></td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt">Route End Location</font>
                </td>
                <td colspan="5" align="left">
                    <asp:TextBox ID="txtxendloc" Width="80" runat="server"></asp:TextBox></td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt">EnRoute Location</font>
                </td>
                <td colspan="5" align="left">
                    <asp:TextBox ID="txtxenrouteloc" Width="80" runat="server"></asp:TextBox></td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt">Select Mode</font>
                </td>
                <td colspan="5" align="left">
                    <asp:DropDownList ID="DDLMode" runat="server" CssClass="blackfnt">
                        <asp:ListItem Value="All">---All---</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt">Enter No. (Separated Comma If Multiple)</font>
                </td>
                <td colspan="5" align="left">
                    <asp:TextBox width="150" ID="txtthcnos" runat="server"></asp:TextBox></td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:RadioButtonList onClick="javascript:Chk(this);" ID="rpttyp" RepeatDirection="horizontal"
                        CssClass="blackfnt" runat="server">
                        <asp:ListItem Selected="True" Text="TimeLine Track" Value="1"></asp:ListItem>
                        <asp:ListItem Text="DMRV" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Route Movement Report" Value="3"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:DropDownList Enabled="false" ID="cboStatus" runat="server" CssClass="blackfnt">
                        <asp:ListItem Value="B">Both</asp:ListItem>
                        <asp:ListItem Value="Y">Completed</asp:ListItem>
                        <asp:ListItem Value="N">Non-Completed</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();s"
                        runat="server" Text="Show" Width="75px" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
