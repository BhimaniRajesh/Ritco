<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SelectDate.ascx.cs" Inherits="UserControls_SelectDate" %>
<table border="0" cellspacing="1" cellpadding="4" width="100%" align="center" class="boxbg">
 <tr style="background-color: white">
                        <td valign="top" width="20%" >
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Date</asp:Label>
                        </td>
                        <td align="left" valign="top">
                            <atlas:UpdatePanel ID="UpdatePanel1" Mode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange" >
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Last Week (Including Today)"></asp:ListItem>
                                        
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </atlas:UpdatePanel>
                        </td>
                        <td valign="top" align="left" >
                            <atlas:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" Mode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom" CssClass="blackfnt"
                                        ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :(" CssClass="blackfnt"
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <atlas:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </atlas:UpdatePanel>
                        </td>
                    </tr>
                    </table> 