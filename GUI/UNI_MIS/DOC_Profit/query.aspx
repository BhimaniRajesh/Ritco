<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_DOC_Profit_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	window.onload=function()
	{
	document.getElementById("ctl00_MyCPH1_sub_rpttyp_3").disabled=true	
	document.getElementById("ctl00_MyCPH1_sub_rpttyp_4").disabled=true	
	}
	
	function Chk1(obj)
	{
	  // alert(obj.value)
	    var txtdocno=document.getElementById("ctl00_MyCPH1_txtdocno");
	     if (document.getElementById("ctl00_MyCPH1_sub_rpttyp_0").checked==true )
	    {
	        txtdocno.disabled=false		
        }
	    else
	    {
	        txtdocno.disabled=true
	    }
	    
	
	}
	
	function Chk(obj)
	{

        var DLLMode=document.getElementById("ctl00_MyCPH1_DLLMode");
        var DLLTYPE=document.getElementById("ctl00_MyCPH1_DLLpaybas");
        var DLLDly=document.getElementById("ctl00_MyCPH1_DLLDly");
        
	    if (document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true )
	    {
		     DLLDly.disabled=false		
		     DLLMode.disabled=false	
		     DLLTYPE.disabled=true
	    }
	    else 
	    {   DLLDly.disabled=true
		    DLLMode.disabled=true
		    DLLTYPE.disabled=false	
		    	
	    }
	    
	    
	     /*if (document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true )
	    {
		    DLLDly.disabled=true
		    DLLMode.disabled=true
	    }
	    else 
	    {    DLLDly.disabled=false		
		     DLLMode.disabled=false		
	    }
	    */
	     if(document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true || document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true)
		   {
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_1").disabled=false	
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_2").disabled=false	
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_3").disabled=true	
		   }
	     if(document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true)
		   {
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_1").disabled=true	
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_2").disabled=true	
		    document.getElementById("ctl00_MyCPH1_sub_rpttyp_3").disabled=false	
		   }
	    
	    if (document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true ||document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true )
	    {
		    DLLDly.disabled=true
		   DLLMode.disabled=true
		   if(document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true)
		   {document.getElementById("ctl00_MyCPH1_sub_rpttyp_3").disabled=false	
		   document.getElementById("ctl00_MyCPH1_sub_rpttyp_4").disabled=false	
		   }
		  
	    }
	    else 
	    {
		    DLLDly.disabled=false		
		   DLLMode.disabled=false	
		  
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

    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong><font class="blklnkund">
                        <strong>Operation </strong></font><strong>&gt; </strong><font class="bluefnt"><strong>
                            &gt; </strong><strong>Document Profitability</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td align="right">
            <a href="javascript:window.history.go(-1)" title="back">

                <img src="./../../images/back.gif" border="0"> </a></td>
        </tr>
        <tr>
            <td height="300" valign="top">
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
                            <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                                <td align="left" colspan="2">
                                    <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Vendor Type" runat="server"
                                        Width="100%"></asp:Label>
                                </td>
                                <td align="left" colspan="5" valign="top">
                                    <asp:DropDownList Enabled="false" ID="DLLpaybas" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="Tr2" visible="true" runat="server" style="background-color: white">
                                <td align="left" colspan="2">
                                    <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Mode" runat="server" Width="100%"></asp:Label>
                                </td>
                                <td align="left" colspan="5" valign="top">
                                    <asp:DropDownList ID="DLLMode" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="Tr3" visible="true" runat="server" style="background-color: white">
                                <td align="left" colspan="2">
                                    <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Status" runat="server" Width="100%"></asp:Label>
                                </td>
                                <td align="left" colspan="5" valign="top">
                                    <asp:DropDownList ID="DLLDly" runat="server">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Y" Text="Delivered"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="Not - Delivered"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        Width="210px">
                                        <asp:ListItem Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
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
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td colspan="7">
                                <font class="blackboldfnt">OR </font>
                            </td>
                        </tr>
                        <tr id="Tr111" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label111" CssClass="blackfnt" Text="Enter Documnet No." runat="server"
                                    Width="100%"></asp:Label>
                            </td>
                            <td align="left" colspan="5" valign="top">
                                <asp:TextBox Text="" ID="txtdocno" runat="server" Width="250"></asp:TextBox>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td colspan="7">
                                <asp:RadioButtonList ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server" onClick="javascript:Chk(this);">
                                    <asp:ListItem Selected="True" Text="" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Vehicle Wise " Value="3"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td colspan="7">
                                <asp:RadioButtonList ID="sub_rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                                    onClick="javascript:Chk1(this);" runat="server">
                                    <asp:ListItem Selected="True" Text="Register" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Branch Wise" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Customer/Vendor Wise" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Vendor Type Wise" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Vehicle Type Wise" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
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
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
