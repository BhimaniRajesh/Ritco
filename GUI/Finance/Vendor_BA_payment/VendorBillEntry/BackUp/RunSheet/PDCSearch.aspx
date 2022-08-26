<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PDCSearch.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_RunSheet_PDCSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
 <script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
<br />

<div align="left">

<table style="width:9.5in" border="0" align="left" cellpadding="3" cellspacing="1" bgcolor="#808080" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="3"><font class="blackfnt"><b>Prepare Payment Voucher 
        </b></font></td>
    </tr>
    
    <%--<tr bgcolor="#ffffff"> 
      <td valign="top">
      <font class="blackfnt">
        <asp:Label ID="lblTHCMode" runat="server" Text="THC Mode"></asp:Label>
        </font>
      </td>
      <td  valign="top" align="left">
       <asp:UpdatePanel ID="updatepanel1" runat="server">
      <ContentTemplate>
       <asp:DropDownList ID="cboMode" runat="server" AutoPostBack="true">
         <asp:ListItem Text="--All--" Value=""></asp:ListItem>
          <asp:ListItem Text="Air" Value="1"></asp:ListItem>
           <asp:ListItem Text="Rail" Value="2"></asp:ListItem>
            <asp:ListItem Text="Train" Value="3"></asp:ListItem>
       </asp:DropDownList>
        </ContentTemplate>
      </asp:UpdatePanel>
        </td>
      
    </tr>--%>
    
    <tr bgcolor="#ffffff"> 
      <td valign="top">
      <font class="blackfnt">
        <asp:Label ID="Label3" runat="server" Text="Select Vendor"></asp:Label>
        </font>
      </td>
      <td  valign="top" align="left">
       <asp:UpdatePanel ID="updatepanel12" runat="server">
      <ContentTemplate>
      <asp:DropDownList ID="cboVendor2" runat="server" AutoPostBack="true">
         <asp:ListItem Text="--All--" Value=""></asp:ListItem>
       </asp:DropDownList>
        </ContentTemplate>
      </asp:UpdatePanel>
        </td>
      
    </tr>
    
    
   
    <tr bgcolor="#ffffff"> 
      
      <td valign="top"><font class="blackfnt"> Document date range </font></td>
      <td colspan="2" valign="top"> 
      <table width="100%" height="100%">
          <tr> <td align="left">
            <asp:UpdatePanel ID="UpdatePanel9"  runat="server" >
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text="Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text="Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text="Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text="Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td valign="top" align="left">
                            <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor112','dd/MM/yyyy'); return false;"  name="anchor112" id="anchor112" ><img src="../../../../images/calendar.jpg" border="0" /> 
                                  </a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor113','dd/MM/yyyy'); return false;"  name="anchor113" id="a1" ><img src="../../../../images/calendar.jpg" border="0" /> 
                                  </a>
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
        </table></td>
    </tr>
    
    
    
    <tr bgcolor="#ffffff"> 
        <td valign="top" colspan="3">
        <font class="blackfnt"><b>
        OR</b>
        </font>
        </td>
    </tr>
    <tr bgcolor="#ffffff"> 
      <td valign="top">
      <font class="blackfnt">
        <asp:Label ID="lblDocument" runat="server" Text="Bill Entry Number"></asp:Label>
        </font>
      </td>
      <td  valign="top" align="left">
      <asp:TextBox ID="txtDocNo" runat="server" Width="164px"></asp:TextBox><font class="blackfnt">(If Multiple - separated by comma)</font>
        </td>
      
    </tr>
    
    
    <tr bgcolor="#ffffff"> 
        <td valign="top" colspan="3">
        <font class="blackfnt"><b>
        OR</b>
        </font>
        </td>
    </tr>
    <tr bgcolor="#ffffff"> 
      <td valign="top">
      <font class="blackfnt">
        <asp:Label ID="Label1" runat="server" Text="Vendor Bill Number"></asp:Label>
        </font>
      </td>
      <td valign="top" align="left">
      <asp:TextBox ID="txtVendorBillNo" runat="server" Width="164px"></asp:TextBox><font class="blackfnt">(If Multiple - separated by comma)</font>
        </td>
      
    </tr>
    
    
    <tr bgcolor="#ffffff"> 
        <td valign="top" colspan="3">
        <font class="blackfnt"><b>
        OR</b>
        </font>
        </td>
    </tr>
    <tr bgcolor="#ffffff"> 
      <td valign="top">
      <font class="blackfnt">
        <asp:Label ID="Label2" runat="server" Text="Search By Vehicle Number"></asp:Label>
        </font>
      </td>
      <td  valign="top" align="left">
      <asp:TextBox ID="txtVehicleNo" runat="server" Width="164px"></asp:TextBox><font class="blackfnt">(If Multiple - separated by comma)</font>
        </td>
      
    </tr>
    
   
  </table>
  <br />
  <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />


<asp:Button ID="btnsubmit1" runat="server" CssClass="blackfnt" Text="Submit" OnClick="btnsubmit1_Click"/>


</div>
   
 <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div></asp:Content>

