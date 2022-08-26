<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="PAYMENT_1.aspx.cs"  Inherits="GUI_Finance_Fix_Asset_aaaaa" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  <script language="JavaScript" type="text/javascript">
  
   function nwOpen()
        {
            window.open("popupLoc.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        </script>
        
        
  <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Fix Asset Management</b></font></a>
                <b>&gt; </b><font class="bluefnt"><b>Payment </b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />

<div align="left" style="width: 9.5in;">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                            </asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td valign="top" align="left">
                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Enter the PO Date" runat="server"
                                Width="145px"></asp:Label>
                        </td>
                        <td align="left"  valign="top">
                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                Width="244px">
                                <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td valign="top" align="left" >
                            <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                name="anchor1" id="a1">
                                <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg"
                                    border="0">
                            </a>
                            <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                            <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;"
                                name="anchor11" id="anchor11">
                                <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg"
                                    border="0"></a>
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
                        </td>
                    </tr>
                    
                    
                
                     
                    <tr style="background-color: white">
                        <td align="left" style="width:2in">
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter Vendor" runat="server"
                                Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtven" runat="server" Width="100px"></asp:TextBox><asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen()">...</a>'
                        Width="14px"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label7" CssClass="blackfnt" Text="Enter Purchase Order " runat="server" Width="213px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtpono" runat="server" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <br />
                <div style="width: 9.5in" align="center">
                    <asp:Button ID="Button3" runat="server" Text="Show" Width="150" OnClick="Button3_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
