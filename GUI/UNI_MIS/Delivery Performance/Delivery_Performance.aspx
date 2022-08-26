<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Delivery_Performance.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<%-- <script language="javascript" type="text/javascript" src="docket_javascript.js"></script>--%>
<script language="javascript" type="text/javascript" >
var cal = new CalendarPopup("testdiv1");
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
</script>

<div align="left" style="width:9.5in;">
<table style="width: 1100px">
    <tr>
    <td  align="left">  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_Operation.aspx"><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Delivery Performance Report</b></font>
	</td>
	<td align="right">
	    <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	</td>
    </tr>
    </table>
<asp:UpdatePanel ID="UP1" runat="Server">
<ContentTemplate>
<br /><br />
<table cellspacing="1" style="width: 9in" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="True" runat="server" Width="200px">
                                        Select Criteria
                                    </asp:Label>
                                </td>
                            </tr>
                         </table>  
                         <br /> 
        
                    <table cellspacing="1" class="boxbg" cellpadding="3" style="width: 9in;" border="0">
                         <tr style="background-color: white">
                         <td align="left">
                            
                                    <asp:Label ID="lbl"  CssClass="blackfnt" Text="Select RO" runat="server" Width="102px"></asp:Label>    
                                </td>
                                
                                <td align="left" colspan="2" valign="top" >
                                
                                    <asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                                                &nbsp;<asp:DropDownList ID="ddlro" Width="250" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged" AutoPostBack="True">
                                                                </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                      </td>
                                     
                            </tr>
                    
                            <tr style="background-color: white">
                                <td align="left" >
                                    <asp:Label ID="Label4"  CssClass="blackfnt" Text="Select Location" runat="server" Width="113px"></asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" valign="top">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                &nbsp;<asp:DropDownList ID="ddlloc" Width="250" runat="server" AutoPostBack="True">
                                                                </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                </td>
                                
                                
                            </tr>
                            
                                  <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                       <asp:Label ID="Label3"  CssClass="blackfnt" Text="Select Date" runat="server" Width="145px"></asp:Label>    
                                                            </td>
                                                        <td  align="left" valign="top">
                                                         <%--<asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    --%>
                                    
                                                  
                                                                                                                
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%">
                                                            <tr style="background-color: white">
                                                            <td align="left" valign="top" class="blackfnt">
                                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                                            <ContentTemplate>
                                                            <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo"
                                                            Width="210px">
                                                            <asp:ListItem Selected="True" Text=" Date Range " Value="0"></asp:ListItem>
                                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                            </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            </td>
                                                            <td align="left" valign="top" class="blackfnt">
                                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                                            <ContentTemplate>
                                                            <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="a1" ><img src="./../../images/calendar.jpg" alt="calendar.jpg" border="0">

                                                            </a> (dd/mm/yyyy)

                                                            <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                                            <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;" name="anchor11" id="anchor11" ><img src="./../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)


<br />
<asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                                OnServerValidate="daterange"></asp:CustomValidator>
                                                              <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    
                                    
</ContentTemplate>

</asp:UpdatePanel>
</td>
</tr> 
</table>
 
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                                           </td>
                        </tr>
                      <tr align="left" bgcolor="#ffffff">
 <td align="center" valign="top" colspan="3" class="blackfnt">
                       <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Show" /></td>
                       </tr>
                        </table>
                        
</ContentTemplate>
</asp:UpdatePanel>

</div>
<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>

</asp:Content>
