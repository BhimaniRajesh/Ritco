<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_UnUsed_missing_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	/*function Chk(obj){
//alert(obj.value)
var txtcustcd=document.getElementById("ctl00_MyCPH1_txtcustcd");
       var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
        var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
	if (document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true || document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true)
	{
		//alert("HI")
		//document.form1.cboLocation_TO.disabled=true
		DLLOrder.disabled=true
		txtvendcd.vendor_code.disabled=true
		txtcustcd.disabled=false
		
	}
	else 
	{
	//alert("HI---")
	//document.form1.cboLocation_TO.disabled=false
		DLLOrder.disabled=false
		txtvendcd.disabled=false
		txtcustcd.disabled=true
	}
	}*/
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
                <td align="left"  colspan="2">
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
                            <asp:DropDownList ID="cboRO_Lo" runat="server"  Mode="Conditional"
                                RenderMode="Inline" Width="102px">
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
                    <asp:Label ID="Label1" CssClass="blackfnt" Text="Series Containing :" runat="server"
                        Width="102px"></asp:Label>
                </td>
                <td colspan="5" align="left"><asp:TextBox ID="txtcustcd" runat="server" ></asp:TextBox></td>
               
                </tr>
                <tr style="background-color: white">
                <td  align="left">
                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select  Date" runat="server"
                        Width="102px"></asp:Label>
                </td>
                <td >
                 <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        Width="210px">
                                        <asp:ListItem  Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem  Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                       <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                       </asp:RadioButtonList>
                </td>
               <td valign="top" colspan="5"><asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A></td>
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
                <td  colspan="7">
                <asp:RadioButtonList  ID="rpttyp" RepeatDirection="horizontal"   CssClass="blackfnt"  runat="server">
                <asp:ListItem  Selected="True" Text="Missing List " Value="M"></asp:ListItem>
                <asp:ListItem    Text="UnUsed List" Value="U"></asp:ListItem>
                 
                 
                </asp:RadioButtonList>
                 </td>
            </tr>
            <tr bgcolor="white"> <td  colspan="7"></td></tr>
            <tr align="center" bgcolor="white">
                <td  colspan="7">
                <asp:Button  ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();s"  runat="server" Text="Show" Width="75px" />
                 </td>
            </tr>
        </table>
    </div>
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content><%--OnClick="btnShow_Click"--%>
