<%@ Page Language="C#" AutoEventWireup="true" CodeFile="compwisereg_step1.aspx.cs" Inherits="SFM_compwisereg_step1" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Company Wise Registration</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <menu:header id="Header1" runat="server" ></menu:header>
    <div align="center">
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 62%">
                              
                                                    <tr bgcolor="#ffffff">
                                                        <td style="width: 101px">
                                                            <font class="blackfnt">Company Name</font></td>
                                                        <td style="font-weight: bold; width: 173px;" colspan="4">
                                                            <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                                                            &nbsp;
                                                            <asp:Button ID="btnPopUp" runat="server" Text="..." /></td>
                                                            
                                                    </tr>
                                                
                                                    <tr bgcolor="#ffffff" width="30">
                                                        <td valign="top" align="left" style="width: 101px">
                                                            <font class="blackfnt">Select Date </font>
                                                        </td>
                                                        <td  style="font-size: 12pt; font-family: Times New Roman; width: 200px;" valign="top">
                                                          
                                                          <asp:UpdatePanel ID="UpdatePanel3"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td valign="top" align="left">
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
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
                                                            
        
                                                            <!--END-->
                                                        </td>
                                                    </tr>
                                                   
                                                </table>
                                                <br />
                                                <table  border="0" cellpadding="3" cellspacing="1" width="71%">
                                                    <tr >
                                                        <td align ="center" colspan="3">
                                                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" Width="96px" OnClick="btnShowReport_Click" /></td>
                                                    </tr>
                                                    </table>
    </div>
    </form>
</body>
</html>
