<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="sfm_funnel_report_Sale_wise.aspx.cs" Inherits="REPORT_sfm_funnel_report_Sale_wise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-SalesPerson Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
    
    <div align="center">
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                                                    colspan="2" width="71%">
                                                    <tr class="bgbluegrey">
                                                        <td align="center" colspan="3">
                                                            <font class="blackfnt"><strong>Select Report Criteria </strong></font>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select RO</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman" colspan="2">
                                                            &nbsp;<asp:UpdatePanel ID="updatepanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboSelectRo" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline"
                                                                        Width="152px" OnSelectedIndexChanged="cboSelectRo_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                    <!--<input name=cboRO type=hidden value="">-->
                                                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select Location</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <div id="LocationCombo">
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboSelectLocation" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                             RenderMode="Inline"
                                                                            Width="152px" OnSelectedIndexChanged="cboSelectLocation_SelectedIndexChanged">
                                                                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectRo" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                                &nbsp;</div>
                                                        </td>
                                                    </tr>
                                                    
                                                                                                       
                                                    
                                                    
                                                    
                                                    
                                                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left" >
                                                            <font class="blackfnt">Select Date </font>
                                                        </td>
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel3"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
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
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
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
                        </td>
                                                    </tr>
                                                    
                                                    
                                                     <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select Employee</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <div id="Div1">
                                                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                             RenderMode="Inline"
                                                                            Width="152px">
                                                                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectLocation" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                                &nbsp;</div>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                                                    
                                                    <tr class="bgbluegrey" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                                        <td align="Center" colspan="3">
                                                            <font class="blackfnt"><strong>OR</strong> </font>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <font class="blackfnt">Enter Employee Code</font></td>
                                                        <td valign="top" align ="left" colspan="2">
                                                            <asp:TextBox ID="txtEmployeeCode" runat="server"></asp:TextBox>&nbsp;
                                                            <asp:Button ID="btnPopUp" runat="server" Width="32px" /></td>
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
    
</asp:Content>
