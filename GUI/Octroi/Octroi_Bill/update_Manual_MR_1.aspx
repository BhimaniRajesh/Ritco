<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="update_Manual_MR_1.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<asp:UpdatePanel ID="UP1" runat="Server">
<ContentTemplate>
<table cellspacing="1" style="width: 100%; height: 263px;" border="0">
            
            
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 90%" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Criteria
                                    </asp:Label>
                                </td>
                            </tr>
                            
                                  <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                       <asp:Label ID="Label3"  CssClass="blackfnt" Text="MR Date" runat="server" Width="145px"></asp:Label>    
                                                            </td>
                                                        <td  align="left" style="width: 359px" valign="top">
                                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1" Width="244px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                          </asp:RadioButtonList></td>
                                                        
                                                        <td valign="top" align="left" style="width: 359px">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label><asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox><asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label><asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                                OnServerValidate="daterange"></asp:CustomValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                                                ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                                                ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator></td>
                        </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                             
                                <td colspan="3" align="center"  >
                             
                                    OR</td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" valign="top">
                                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="MR NO."
                                        Width="145px"></asp:Label></td>
                                <td align="left" colspan="2" style="width: 359px" valign="top">
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                 <td colspan="3"  align="center"  >
                             
                                    OR</td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" style="height: 21px" valign="top">
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Docket No."
                                        Width="145px"></asp:Label></td>
                                <td align="left"  colspan="2" style="width: 359px; height: 21px" valign="top">
                                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                                 
                            </tr>
                         <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                         
                         
                                </tr>
                        </table>
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Button" />
</ContentTemplate>
</asp:UpdatePanel>





</asp:Content>
