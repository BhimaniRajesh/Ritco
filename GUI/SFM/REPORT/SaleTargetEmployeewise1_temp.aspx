<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SaleTargetEmployeewise1_temp.aspx.cs" Inherits="REPORT_SaleTargetEmployeewise1." %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Visit Register-Company Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
    <div align="center">
    
    
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <tr class="bgbluegrey">
                                                        <td align="center" colspan="3">
                                                            <font class="blackfnt"><strong>Enter Sale Taget</strong></font></td>
                                                    </tr>
                                                    
                                                    
                                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select RO</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman" colspan="2">
                                                            &nbsp;<asp:UpdatePanel ID="updatepanel3" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboSelectRo" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline"
                                                                        Width="152px" OnSelectedIndexChanged="cboSelectRo_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td align="left">
                                                            <div align="left">
                                                                <font class="blackfnt">Select Location</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <div id="LocationCombo">
                                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
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
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectLocation" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                                &nbsp;</div>
                                                        </td>
                                                    </tr>
                            
                            <tr bgcolor="#ffffff">
                                <td align ="left" style="font-weight: bold; width: 208px;" >
                                    <font class="blackfnt">Prospect Status</font>
                                </td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboAccCategory" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        <asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="Customer" Text="Customer"></asp:ListItem>
                                        <asp:ListItem  Value="Hot" Text="Hot"></asp:ListItem>
                                        <asp:ListItem  Value="Warm" Text="Warm"></asp:ListItem>
                                        <asp:ListItem  Value="Cold" Text="Cold"></asp:ListItem>
                                    </asp:DropDownList></font></td>
                            </tr>
                            
                           <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td align="left" style="width: 208px">
                                                            <div align="left">
                                                                <font class="blackfnt">Comapny</font></div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboCompany" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                             RenderMode="Inline"
                                                                            Width="152px">
                                                                            <asp:ListItem Text="All" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboIndustry" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                            
                            
                            
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="font-weight: bold; width: 208px;">
                                    <font class="blackfnt">Period</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboPeriod" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        <asp:ListItem  Value="Monthly" Text="Monthly"></asp:ListItem>
                                        <asp:ListItem  Value="Quarterly" Text="Quarterly"></asp:ListItem>
                                        <asp:ListItem  Value="Yearly" Text="Yearly"></asp:ListItem>
                                        
                                    </asp:DropDownList></font></td>
                            </tr>
                        </table>
                        <br />
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click"  />
                        &nbsp;&nbsp; &nbsp;&nbsp;<br />
                        &nbsp;&nbsp;
                        <br />
    
    
    
    </div>
    </asp:Content>
