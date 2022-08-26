<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmCriteriaOld.aspx.cs" Inherits="FrmCriteria" %>

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
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    <asp:UpdatePanel ID="up1" runat="server">
      <ContentTemplate>
    
        <table style="width: 916px;height: 173px; z-index: 100; left: 16px; position: relative; top: -283px;" title="Select To Pay Arrival Criteria" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Select To Pay Arrival Criteria</label></p>
     </td></tr> <tr>
                <td style="width: 199px; height: 6px;" >
                    Select Date</td>
                <td colspan="2" style="height: 6px; width: 520px;">
                    <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true"
                        CssClass="blackfnt" ValidationGroup="VGDtFromTo" OnSelectedIndexChanged="radDate_SelectedIndexChanged">
                        <asp:ListItem Selected="false" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                        <asp:ListItem Selected="false" Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                        <asp:ListItem Selected="true" Text=" Today:" Value="2"></asp:ListItem>
                    </asp:RadioButtonList><asp:Label ID="lblFrom" runat="server" CssClass="blackfnt"
                        Text=" From: " style="z-index: 100; left: 453px; position: absolute; top: 56px"></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo"                        
                            Width="80" style="z-index: 101; left: 494px; position: absolute; top: 53px"></asp:TextBox>
                        <%--<input id="CmdFromDate" type="button" value="" onclick="showCalendarControl(txtDateFrom);" style="width: 32px"  />--%>
                            <asp:Label ID="lblTo" runat="server" CssClass="blackfnt"
                                Text=" To: " style="z-index: 102; left: 584px; position: absolute; top: 56px"></asp:Label>
                                <asp:TextBox ID="txtDateTo" runat="Server" Width="80" style="z-index: 103; left: 608px; position: absolute; top: 54px"></asp:TextBox>
                    <%--<input id="CmdToDate" type="button" value="" onclick="showCalendarControl(txtDateTo);" onmouseout="hidecalendarcontrol();" style="width: 32px"  />--%>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo"
                        ErrorMessage="Please Enter Valid To Date" ForeColor="White" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                        Width="168px" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                        ErrorMessage="From Date Can Not Be Blank" ForeColor="White"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                        ErrorMessage="To Date Can Not Be Blank" ForeColor="White" style="z-index: 106; left: 22px; position: absolute; top: 37px" Height="1px"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom"
                        ErrorMessage="Please Enter Valid From Date" ForeColor="White" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                        Width="181px" style="z-index: 105; left: 381px; position: absolute; top: 125px" Enabled="False"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 199px">
                </td>
                <td colspan="2" style="width: 520px">
                </td>
            </tr>
            <tr>
                <td style="width: 199px">
                    Select RO</td>
                <td colspan="2" style="width: 520px">
                    <asp:DropDownList ID="CmbRO" runat="server" OnSelectedIndexChanged="CmbRO_SelectedIndexChanged"
                        Width="206px" AutoPostBack="True">
                    </asp:DropDownList>
                    Select RO
                    <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="CmbRO_SelectedIndexChanged"
                        Width="206px" AutoPostBack="True">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 199px">
                    Select Location</td>
                <td colspan="2" style="width: 520px">
                    <asp:DropDownList ID="CmbLoc" runat="server" Width="153px">
                    </asp:DropDownList>
                    Select Location
                    <asp:DropDownList ID="DropDownList2" runat="server" Width="153px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 199px">
                    </td>
                <td colspan="2" style="width: 520px">
                    </td>
            </tr>
            <tr>
                <td style="width: 199px">
                    </td>
                <td colspan="2" style="width: 520px">
                    </td>
            </tr>
            <tr>
                <td style="width: 199px">
                    Enter Customer Code</td>
                <td colspan="2" style="width: 520px">
                    <asp:TextBox ID="TextBox1" runat="server" Width="110px"></asp:TextBox>
                    <asp:Button ID="BtnCustCode" runat="server" OnClientClick = 'BranchPopup("FrmCCodePopUp.aspx")' Width="39px"/></td>
            </tr>
        </table>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
          <asp:CustomValidator ID="CustomValidator1" runat="server" OnServerValidate="abc" ErrorMessage="To date can not be smaller than from date "
              Width="255px" style="z-index: 103; left: 31px; position: absolute; top: 392px"></asp:CustomValidator><br />
          <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Date Range can not be greater than 1 month "
              OnServerValidate="daterange" Width="355px" style="z-index: 101; left: 31px; position: absolute; top: 411px"></asp:CustomValidator><br />
          <asp:Button
            ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Submit" ForeColor="Black" style="z-index: 102; left: 346px; position: absolute; top: 414px" />
         </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Content>
