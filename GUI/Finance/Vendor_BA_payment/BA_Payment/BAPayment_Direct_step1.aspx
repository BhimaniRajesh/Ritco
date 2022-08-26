<%@ Page Language="C#"  enableViewStateMac="False" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BAPayment_Direct_step1.aspx.cs" Inherits="VendorPayment_new_BA_Payment_BAPayment_BillEntry_step1" %>

<%@ OutputCache Location="None" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="JavaScript" src="../../../Images/CalendarPopup.js"></script> 
<script type="text/javascript"language="javascript" src="../../../images/commonJs.js"></script>
<script type="text/javascript" language="JavaScript" >
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
</script>
<script type="text/javascript" language="JavaScript" >
function fsubmit()
{
     var cboVendor=document.getElementById("ctl00_MyCPH1_cboVendor");
      var cboDocType=document.getElementById("ctl00_MyCPH1_cboDocType");
      var ddlRouteMode=document.getElementById("ctl00_MyCPH1_ddlRouteMode");
      var txtfrom=document.getElementById("ctl00$MyCPH1$txtDateFrom");
    var txtto=document.getElementById("ctl00$MyCPH1$txtDateTo");


   //alert("hi..")
    if(!isValidDate(txtfrom.value,"From"))
    return false;
    
    if(!isValidDate(txtto.value,"To"))
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
   
<br />
<table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Payment</strong></font>

<font class=bluefnt><strong> &gt; </strong>
		  <strong>BA Payment - Direct </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"/></td>
        </tr>

   
        
        <tr> 
          <td align=right><img src="../../../images/back.gif" /></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
                       <div align="center">
    <table  border="0"  cellpadding="5"   style="width: 8.0in;" bgcolor="#808080" cellspacing="1" class="boxbg">
                   <tr class="bgbluegrey"> 
                         <td  align="center" colspan="5"> <font class="blackfnt"><b>Select Sales Criteria</b></font>
                         </td>
                   </tr>
                   <tr bgcolor="#FFFFFF"> 
                                <td valign="top"><font class="blackfnt">Select Date 
                                  </font></td>
                                <td  valign="top" align="left">
                                <asp:UpdatePanel ID="UpdatePanel3"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                       <%-- <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel> 
                                    
                                 </td>
                                      <td valign="top" align="left" colspan="2">
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10" ></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="../../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox> <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="../../../images/calendar.jpg" border="0"></img>
			</A>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td> 
                                   </tr> 
                                   
                                   <tr>
                                   <td  bgcolor="#FFFFFF"><font class="blackfnt">Select Vendor </font></td>
                                   <td  bgcolor="#FFFFFF" colspan="3" align="left">
                                    <asp:DropDownList ID="cboVendor" runat="server" >
        
       </asp:DropDownList>
                                   </td>
                                   </tr>
                                   
                                   
                                   <tr>
                                   <td  bgcolor="#FFFFFF"><font class="blackfnt">Select Type</font></td>
                                   <td  bgcolor="#FFFFFF" colspan="3" align="left">
                                    <asp:UpdatePanel ID="UpdatePanel1"  runat="server">
                                <ContentTemplate> <asp:DropDownList ID="cboDocType"  CssClass="blackfnt" runat="server" AutoPostBack="true"  >
         <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
         <asp:ListItem Text="For Booking" Value="bkg"></asp:ListItem>
         <asp:ListItem Text="For Delivery" Value="dly"></asp:ListItem>
       </asp:DropDownList></ContentTemplate></asp:UpdatePanel>
                                   </td>
                                   </tr>
                                   <tr bgcolor="#FFFFFF"> 
                                    <td valign="top">
                                    <font class="blackfnt">Select Mode Type</font></td>
                                    <td  valign="top" align="left" colspan="3">
                                     <asp:DropDownList ID="ddlRouteMode" runat="server" cssclass="blackfnt">
                                                                                                        <asp:ListItem Selected="True" Text="Select" Value="" ></asp:ListItem>
                                                                                                        
                                                                                                        
                                                                                                        <asp:ListItem Text="ALL(W/o-Road)" Value="All"></asp:ListItem>
                                                                                                        <asp:ListItem Text="Road" Value="2"></asp:ListItem>
                                                                                                       <%-- <asp:ListItem  Text="Train" Value="3"></asp:ListItem>
                                                                                                        <asp:ListItem  Text="Express" Value="4"></asp:ListItem>--%>
                                                                                                    </asp:DropDownList>
                                    </td>
                                    </tr>
        <tr>
            <td bgcolor="#ffffff" align="center" colspan="4">
            <asp:Button ID="btnShow" runat="server" Text="Submit" Width="75px" OnClientClick= "javascript:return fsubmit()"  OnClick="btnShow_Click"  />
            </td>
        </tr>
                                   
                                    
                                  </table>
                                   </div>
                              </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>
                           
    
   
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
    </asp:Content>
