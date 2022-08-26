<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_OUTSTD_BILL_MR_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function Chk(obj){
//alert(obj.value)
var txtcustcd=document.getElementById("ctl00_MyCPH1_txtasondt_to");
var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
var cboRO_Lo=document.getElementById("ctl00_MyCPH1_cboRO_Lo");
var cboRO=document.getElementById("ctl00_MyCPH1_cboRO");
//       var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
//        var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
	if (document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true )
	{
		//alert("HI")
		//document.form1.cboLocation_TO.disabled=true
		
		txtcustcd.disabled=false 
		document.getElementById("ctl00_MyCPH1_radDate_0").disabled=true
		document.getElementById("ctl00_MyCPH1_radDate_1").disabled=true
		document.getElementById("ctl00_MyCPH1_radDate_2").disabled=true
		document.getElementById("ctl00_MyCPH1_radDate_3").disabled=true
		txtDateFrom.disabled=true
		txtDateTo.disabled=true
		cboRO_Lo.disabled=true
		cboRO.disabled=true
		
	}
	else 
	{
	//alert("HI---")
	//document.form1.cboLocation_TO.disabled=false
		txtcustcd.disabled=true
		document.getElementById("ctl00_MyCPH1_radDate_0").disabled=false
		document.getElementById("ctl00_MyCPH1_radDate_1").disabled=false
		document.getElementById("ctl00_MyCPH1_radDate_2").disabled=false
		document.getElementById("ctl00_MyCPH1_radDate_3").disabled=false
		txtDateFrom.disabled=false
		txtDateTo.disabled=false
		cboRO_Lo.disabled=false
		cboRO.disabled=false
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
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                </td>
            </tr>
            <tr id="ROWLO" visible="true" runat="server" style="background-color: white">
                <td align="left" colspan="2">
                    <asp:Label ID="Label8" CssClass="blackfnt" Text="Select RO" runat="server" Width="100%"></asp:Label>
                </td>
                <td align="left" colspan="5" valign="top">
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged">
                                <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <%--<td align="left" valign="top">
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_TO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO">
                                <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>--%>
            </tr>
            <tr style="background-color: white">
                <td colspan="2" align="left">
                    <asp:Label ID="Label7" CssClass="blackfnt" Text="Select Location" runat="server"
                        Width="102px"></asp:Label>
                </td>
                <td align="left" colspan="5" valign="top">
                    <asp:UpdatePanel ID="updatepanel8" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo" runat="server" Mode="Conditional" RenderMode="Inline"
                                Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <tr style="background-color: white">
                    <td colspan="2" align="left">
                        <font class="blackfnt">Enter Customer</font>
                    </td>
                    <td colspan="5" align="left">
                        <asp:TextBox ID="txtcustcd" runat="server"></asp:TextBox></td>
                </tr>
                <tr style="background-color: white">
                    <td colspan="2" align="left">
                        <font class="blackfnt">As On Date</font>
                    </td>
                    <td colspan="5" align="left">
                        <asp:TextBox ID="txtasondt" Width="60"
                            MaxLength="10" runat="server"></asp:TextBox> <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt,'anchor3','dd/MM/yyyy'); return false;"
                            name="anchor3" id="a3"><img src="./../../images/calendar.jpg" border="0"></img>
                        </a>
                        <asp:Label  CssClass="blackfnt" runat="server" Text=" To"></asp:Label>
                        <asp:TextBox ID="txtasondt_to" Width="60" Enabled="false"
                            MaxLength="10" runat="server"></asp:TextBox> <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt_to,'anchor4','dd/MM/yyyy'); return false;"
                            name="anchor4" id="a4"><img src="./../../images/calendar.jpg" border="0"></img>
                        </a>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label><%--
                        <asp:DropDownList ID="seldate" runat="server">
                        <asp:ListItem Text="Document Date" Value="docdt"></asp:ListItem>
                        <asp:ListItem Text="Entry Date" Value="docdt_entry"></asp:ListItem></asp:DropDownList>--%>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            Width="210px">
                            <asp:ListItem  Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Selected="True" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                             <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
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
                <%--<td align="left" valign="top">
                    <asp:UpdatePanel ID="updatepanel9" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo_TO" runat="server"  Mode="Conditional"
                                RenderMode="Inline" Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO_TO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>--%>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:RadioButtonList ID="RadioRPT_SUBTYP" RepeatDirection="horizontal" CssClass="blackfnt"
                        runat="server">
                        <asp:ListItem Selected="True" Text="Bill " Value="1"></asp:ListItem>
                        <asp:ListItem Text="MR" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:RadioButtonList onClick="javascript:Chk(this);" ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                        runat="server">
                        <asp:ListItem Selected="True" Text="Location Wise " Value="L"></asp:ListItem>
                        <asp:ListItem Text="Customer Wise" Value="C1"></asp:ListItem>
                        <asp:ListItem Text="Customer Wise(All India)" Value="C2"></asp:ListItem>
                    </asp:RadioButtonList>
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
