<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="start.aspx.cs" Inherits="Finance_Billing_Billsubmission_start"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

    <title>Untitled Page</title>
     <link href="../../../images/style.css" rel="stylesheet" type="text/css" />--%>
       <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
        function CheckDocketSelection(billno,party_code,txtDateFrom,txtDateTo,Manualbillno)
        {
        
                     if (billno.value=="" && Manualbillno=="")
					    {
							
							if (party_code.value=="")
							{
							    alert("Plz enter Customer Code");
							    party_code.focus();
							    return false;
							}
							
							
					   
					          if (txtDateFrom.value=="")
					          {
					                    alert("Plz enter From Date");
							            txtDateFrom.focus();
							            return false;
					          }
					          if (txtDateTo.value=="")
					          {
					                    alert("Plz enter To Date");
							            txtDateTo.focus();
							            return false;
					          }
					  }
		return true;
        }
        </script>
        <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
<%--</head>
<body>
    <form id="form1" runat="server">--%>
   
    <div>
  <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Submission 
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../../images/back.gif" border=0></a></td>
        </tr>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr> 
          <td > <center><font class="blackfnt"><b>Select Bills for Submission </b></font> </center></td></tr>
   <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr>
    <td>
    
   
    <br />
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:85%; height: 383px;"  align="center">
         <tr class="bgbluegrey" style="height: 25px">
             <td align="center" colspan="2">
             </td>
         </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;">
                 <span style="font-size: 8pt; font-family: Verdana">Bill Number</span></td>
             <td style="width: 339px; height: 25px;">
                <asp:TextBox ID="Billno" runat="server" MaxLength="20"   onchange="javascript:this.value=this.value.toUpperCase()" Columns="20"></asp:TextBox>&nbsp;
                 </td>
           </tr>
            <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;" colspan="2">
                 <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span></td>
             
           </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;">
                 <span style="font-size: 8pt; font-family: Verdana">Manual Bill Number</span></td>
             <td style="width: 339px; height: 25px;">
                <asp:TextBox ID="txtmanualbillno" runat="server"  onchange="javascript:this.value=this.value.toUpperCase()"  MaxLength="20" Columns="20"></asp:TextBox>&nbsp;
                 </td>
           </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;" colspan="2">
                 <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span></td>
             
           </tr>
       <tr  class="bgbluegrey" style="height:25px">
            <td colspan="2" align="center"><font class="blackfnt"><b> Select Billing Party </b></font></td>
            
       </tr>
       
         <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px">
                 <span style="font-size: 8pt; font-family: Verdana">Bill Type</span></td>
             <td style="width: 339px">
                <asp:DropDownList ID="Cbopaybas" runat="server">
                <asp:ListItem Value="All" Selected="true"> All</asp:ListItem>
                <asp:ListItem Value="2">TBB Bill</asp:ListItem>
                <asp:ListItem Value="6">Octroi Bill</asp:ListItem>
                 <asp:ListItem Value="7">Misc. Bill</asp:ListItem>
                </asp:DropDownList>
             </td>
         </tr>
       <tr bgcolor="white" style="height:25px">
            <td style="width: 210px"  align="center">
               <font class="blackfnt">
                   Enter billing party code 
                  </font>
            </td>
            <td style="width: 339px">
                <asp:TextBox ID="Party_code" runat="server" CausesValidation="True" Width="60" Columns="50"></asp:TextBox>
                <input id="btnPopUp" type="button" value="..." name="custpup12"  runat="server" />
                <br /><font class="blackfnt">(Type Strting Characte of Party)</font><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Party_code"
                    ErrorMessage="PLz Enter Party Ocde"></asp:RequiredFieldValidator>
                <%--<atlas:AutoCompleteExtender ID="Extender1" runat="server">
                    <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCustomerList"
                        ServicePath="../../../services/WebService.asmx" TargetControlID="Party_code" />
                </atlas:AutoCompleteExtender>--%>
                
                
                <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True"
                MinimumPrefixLength="1" ServiceMethod="GetCustomerList" CompletionListItemCssClass="autocomplete_listItem"
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../../../services/WebService.asmx"
                TargetControlID="Party_code">
                </ajaxToolkit:AutoCompleteExtender>

                
           </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td  class="bgbluegrey" colspan="2" align="center">
                <p align="center">
                    <font class="blackfnt">Select Bill Generation Date Range</font>
                </p>
            </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 210px; height: 25px;"  align="center">
                <font class="blackfnt"> Select Docket Date</font>
            </td>
            <td style="width: 600; height: 25px;">
                <table height="100%" width="100%">
                    <tr>
                        <td align="left">
                            <asp:UpdatePanel id="UpdatePanel9" runat="server">
                                <contenttemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="false" Value="0" Text="Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text="Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="True" Value="2" Text="Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text="Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </contenttemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel id="UpdatePanel10" runat="server">
                                <contenttemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="55"></asp:TextBox>
                                     <a HREF="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor112','dd/MM/yyyy'); return false;"  NAME="anchor112" ID="anchor112" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="55"></asp:TextBox>
                                    <a HREF="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor113','dd/MM/yyyy'); return false;"  NAME="anchor113" ID="a1" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" ></asp:RequiredFieldValidator>
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" ></asp:RequiredFieldValidator>
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </contenttemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                               <%-- <asp:AsyncPostBackTrigger __designer:dtid="281505041481784" ControlID="radDate" EventName="SelectedIndexChanged"  />--%>
                                </Triggers>
                            </asp:UpdatePanel>
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
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV></asp:Content>
     
    <%--</form>
</body>
</html>
--%>
