<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PDCSearch.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_RunSheet_PDCSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<br />
    
    <div align="left">
        
        
        <table border="0" cellpadding="3"  style="width:9.5in" bgcolor="#808080" cellspacing="1" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td  align="center" colspan="3"> <font class="blackfnt"><b>Vendor 
                                  Selection </b></font> </td>
                              </tr>
                           
                              <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor Type&nbsp;&nbsp;
                                <td colspan="2" align="left">
                                
                                <asp:UpdatePanel ID="updatepanel2" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendortype" runat="server" Width="152px" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                                     <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  </asp:UpdatePanel>
                                 
                                </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor &nbsp;&nbsp;</td>
                                <td colspan="2" align="left">
                                <asp:UpdatePanel ID="updatepanel5" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendor" runat="server">
                                     
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  <Triggers>
               <asp:AsyncPostBackTrigger ControlID="cboVendorType" EventName="SelectedIndexChanged" />
         </Triggers>
                                  </asp:UpdatePanel>
                                </td>
                              </tr>
                              
                              <tr class="bgbluegrey"> 
                                <td  align="center" colspan="3"> <font class="blackfnt"><b>Date 
                                  Selection </b></font></td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                
                                <td valign="top" align="left"><font class="blackfnt"> Document 
                                  date range </font></td>
                                  <td align="left">
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
                        </td>
                                
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                    <td valign="top">
                                    <font class="blackfnt">Select PDC Type</font></td>
                                    <td  valign="top" align="left" colspan="2">
                                     <asp:DropDownList ID="CBOPdcty" runat="server" cssclass="blackfnt">
                                                                                                        <asp:ListItem Selected="True" Text="Select" Value="" ></asp:ListItem>
                                                                                                        
                                                                                                        
                                                                                                        <asp:ListItem Text="PRS" Value="P"></asp:ListItem>
                                                                                                        <asp:ListItem Text="DRS" Value="D"></asp:ListItem>
                                                                                                       <%-- <asp:ListItem  Text="Train" Value="3"></asp:ListItem>
                                                                                                        <asp:ListItem  Text="Express" Value="4"></asp:ListItem>--%>
                                                                                                    </asp:DropDownList>
                                    </td>
                                    </tr>
                            <tr bgcolor="#FFFFFF"> 
                                    <td valign="top">
                                    <font class="blackfnt">Select Route Type</font></td>
                                    <td  valign="top" align="left" colspan="2">
                                     <asp:DropDownList ID="ddlRouteMode" runat="server" cssclass="blackfnt">
                                                                                                        <asp:ListItem Selected="True" Text="Select" Value="" ></asp:ListItem>
                                                                                                        
                                                                                                        
                                                                                                        <asp:ListItem Text="ALL(W/o-Road)" Value="All"></asp:ListItem>
                                                                                                        <asp:ListItem Text="Road" Value="2"></asp:ListItem>
                                                                                                       <%-- <asp:ListItem  Text="Train" Value="3"></asp:ListItem>
                                                                                                        <asp:ListItem  Text="Express" Value="4"></asp:ListItem>--%>
                                                                                                    </asp:DropDownList>
                                    </td>
                                    </tr>
                            </table>
                            <center>
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click"/>
                            </center>
        
        
    </div>
    


</asp:Content>
