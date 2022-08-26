<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorBill_vpstep1.aspx.cs" Inherits="VendorPayment_new_vendorBill_vpstep1" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <atlas:ScriptManager ID="ScriptManager1" runat="server"></atlas:ScriptManager>
    <div align="center">
    
    
    <table border="0"  cellpadding="3"  colspan="1"  width="85%"  bgcolor="#808080" cellspacing="1" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td  align="center" colspan="3"> <font class="blackfnt"><b>Select Document Date </b></font> </td>
                              </tr>
                             
                              <tr bgcolor="#FFFFFF"> 
                                
                                <td valign="top" align="left"><font class="blackfnt"> Document 
                                  date range </font></td>
                                  <td align="left">
                                  <atlas:UpdatePanel ID="UpdatePanel3" Mode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </atlas:UpdatePanel>
                                  
                                  
                                  </td>
                                   <td valign="top" align="left">
                            <atlas:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" Mode="Conditional" runat="server">
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
                                    <atlas:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </atlas:UpdatePanel>
                        </td>
                                
                              </tr>
        <tr bgcolor="#ffffff">
            <td align="left" colspan="3" valign="top">
               <font class="blackfnt"><strong>Select Bill Entry For</strong></font></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Document Type</font></td>
                                <td colspan="2" align="left">
                                
                                <atlas:UpdatePanel ID="updatepanel1" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cboDocumentType" runat="server" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                                    <%-- <asp:ListItem Text="Select" Value=""></asp:ListItem>--%>
                                     <asp:ListItem Text="THC" Value=""></asp:ListItem>
                                     <asp:ListItem Text="PDC" Value=""></asp:ListItem>
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  </atlas:UpdatePanel>
                                 
                                </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor Type
                                <td colspan="2" align="left">
                                
                                <atlas:UpdatePanel ID="updatepanel2" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendortype" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                                     <%--<asp:ListItem Text="--All--" Value=""></asp:ListItem>--%>
                                   </asp:DropDownList>
                                  </ContentTemplate>
                                  </atlas:UpdatePanel>
                                 
                                </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor &nbsp;&nbsp;</td>
                                <td colspan="2" align="left">
                                <atlas:UpdatePanel ID="updatepanel5" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendor" runat="server">
                                     
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  <Triggers>
               <atlas:ControlEventTrigger ControlID="cboVendorType" EventName="SelectedIndexChanged" />
         </Triggers>
                                  </atlas:UpdatePanel>
                                </td>
                              </tr>
        <tr bgcolor="#ffffff">
            <td align="left" colspan="3">
                <font class="blackfnt"><strong>OR</strong></font></td>
        </tr>
                              
                              
                              <tr bgcolor="#FFFFFF"> 
                                <td valign="top" align="left"><font class="blackfnt">Enter Bill Entry No.</font></td>
                                <td valign="top" colspan="2" align="left"><asp:TextBox ID="txtdocno" runat="server" Width="164px"></asp:TextBox>
                                  </td>
                              </tr>
                            </table>
                            <br />
                            <center>
                                <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" />
                            </center>
    
    
    </div>
    </asp:Content>
