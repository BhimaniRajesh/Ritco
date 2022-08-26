<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmCriteria.aspx.cs" Inherits="FrmCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language ="javascript" type ="text/javascript">
    
    function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>
   <%-- <script type="text/javascript" language="javascript" src="../../../CAL/datetimepicker.js"></script>
<link href="../../../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
<script language="javascript" type="text/javascript" src="../../../CAL/popcalendar.js"></script>--%>
    
  <%--  <script language ="javascript" type ="text/javascript" src= "CalendarControl.js" >--%>
 <%-- <LINK rel="stylesheet" type="text/css" href="../../../GUI/UNI_MIS/TOPay_Followup/CalendarControl.css" />
   </script>
--%>
        &nbsp;&nbsp;<br />
        <div align="center">
     <table style="width: 1008px">
        <tr>
        <td  align="left" >  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_finance.aspx"><font class="blklnkund"><b>Finance & Accounts</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Vendor Outstanding Report</b></font>
	    </td>
	        <td align="right">
	            <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	        </td>
        </tr>
    </table>
    </div>  
    <br />
    &nbsp;
    <br />
        <div align="center">
        <table style="width: 639px;height: 90px;" title="Select To Pay Arrival Criteria" border="0" cellpadding="0" cellspacing="1" class="boxbg">
      <tr class="bgbluegrey" >
      <td align="center" colspan="4" class="blackfnt" style="height: 23px"> 
       Select Criteria 
     </td>
          <td align="center" class="blackfnt" colspan="1" style="height: 23px">
          </td>
      </tr> 
     
     <%--<tr class="bgbluegrey">
                    <td align="center" colspan="3" style="height: 23px" class="blackfnt">
                        Your Query
                    </td>
                </tr>--%>
     
            <tr bgcolor="white">
                <td align="left" style="width: 199px" class="blackfnt">
                    Select Vendor Type</td>
                <td align="left" colspan="3">
                <asp:UpdatePanel ID="UpdatePanel1"     UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                    <asp:DropDownList ID="CmbRO" runat="server" OnSelectedIndexChanged="CmbRO_SelectedIndexChanged"
                        Width="206px" AutoPostBack="True">
                    </asp:DropDownList></ContentTemplate> </asp:UpdatePanel></td>
            </tr>
            <tr bgcolor="white">
                <td align="left" class="blackfnt" >
                    Select Vendor</td>
                <td align="left" colspan="3">
                <asp:UpdatePanel ID="UpdatePanel2"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                    <asp:DropDownList ID="CmbLoc" runat="server" Width="206px">
                    </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers><asp:AsyncPostBackTrigger ControlID="CmbRO" EventName="SelectedIndexChanged" /></Triggers>
                    </asp:UpdatePanel></td>
            </tr>            
                <tr bgcolor="white">
                <td align="left" valign="Top" class="blackfnt" style="height: 76px">Select Booking Date</td>
                <td align="left" valign="top" colspan="2" style="width: 400px; height: 76px;">
                <asp:UpdatePanel ID="UpdatePanel3"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate>
                    <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true"
                        CssClass="blackfnt" ValidationGroup="VGDtFromTo" OnSelectedIndexChanged="radDate_SelectedIndexChanged" Width="198px">
                        <asp:ListItem Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                        <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                        <asp:ListItem Selected="True" Text=" Today:" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>
                    </ContentTemplate> 
                    </asp:UpdatePanel>
                    &nbsp;
                    <%--<input id="CmdFromDate" type="button" value="" onclick="showCalendarControl(txtDateFrom);" style="width: 32px"  />--%>&nbsp;<%--<input id="CmdToDate" type="button" value="" onclick="showCalendarControl(txtDateTo);" onmouseout="hidecalendarcontrol();" style="width: 32px"  />--%></td>
                    <td align="left" valign="top" colspan="1" style="height: 76px">
                    <asp:UpdatePanel ID="UpdatePanel4"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                    <asp:TextBox ID="txtDateFrom" runat="Server" Width="83px"></asp:TextBox><asp:TextBox ID="txtDateTo" runat="Server" Width="86px"></asp:TextBox>
                    </ContentTemplate>
                    <Triggers><asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" /></Triggers>
                    </asp:UpdatePanel>
          <asp:CustomValidator ID="CustomValidator1" align="left" runat="server" OnServerValidate="abc" ErrorMessage="To date can not be smaller than from date "
              Width="255px"></asp:CustomValidator>
          <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Date Range can not be greater than 1 month "
              OnServerValidate="daterange" Width="269px"></asp:CustomValidator></td>
                </tr>
         </table> 
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo"
                        ErrorMessage="Please Enter Valid To Date" ForeColor="White" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                        Width="168px"></asp:RegularExpressionValidator></div> 
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
          <div align="center">
    <asp:Button
            ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Submit" /><div align="center"></div>
              &nbsp;&nbsp;</div>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="From Date Can Not Remain Blank" Visible="true" ForeColor="white" Height="20px" SetFocusOnError="True"
                                        ></asp:RequiredFieldValidator><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="To Date Can Not Remain Blank" Height="20px" SetFocusOnError="True"
                                        Visible="true" ForeColor="white"></asp:RequiredFieldValidator><br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Invalid From Date Format" Height="20px" SetFocusOnError="True"
                                        ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                        Visible="true" ForeColor="white"></asp:RegularExpressionValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Invalid To Date Format" Height="20px" SetFocusOnError="True" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                        Visible="true" ForeColor="white"></asp:RegularExpressionValidator><br />
         
    </asp:Content>
