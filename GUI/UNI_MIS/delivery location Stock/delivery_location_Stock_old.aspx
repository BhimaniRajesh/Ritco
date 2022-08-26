<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="delivery_location_Stock_old.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

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
                            <tr class="bgbluegrey">
                                <td align="center" colspan="3" style="height: 21px">
                                    <table  cellpadding="1" cellspacing="1" style="height: 80px">
                                        <tr style="background-color: white">
                                            <td align="left" colspan="3" style="width: 5025px">
                                                <asp:Label ID="lbl" runat="server" CssClass="blackfnt" Text="Select RO" Width="102px"></asp:Label></td>
                                            <td align="left" style="width: 1365px">
                                                &nbsp;<asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                                                &nbsp;<asp:DropDownList ID="ddlro" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged" AutoPostBack="True">
                                                                </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                            </td>
                                            <td align="left" style="width: 651px">
                                                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Select RO" Width="102px"></asp:Label></td>
                                            <td align="left" style="width: 2299px">
                                                <asp:UpdatePanel ID="UpdatePanel20" runat="server"    UpdateMode="Conditional" RenderMode="inline">
                                                    <ContentTemplate>
                                                        <asp:Panel ID="pnlventype" runat="server">
                                                            &nbsp;
                                                            <asp:DropDownList ID="ddlro2" runat="server" OnSelectedIndexChanged="ddlro2_SelectedIndexChanged" AutoPostBack="True">
                                                            </asp:DropDownList></asp:Panel>
                                                    </ContentTemplate>
                                                    <%--<Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                                                    </Triggers>--%>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td align="left" colspan="3" style="width: 325px">
                                                <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Select Location"
                                                    Width="113px"></asp:Label></td>
                                            <td align="left" style="width: 1365px">
                                                &nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                &nbsp;<asp:DropDownList ID="ddlloc" runat="server" AutoPostBack="True">
                                                                </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                            </td>
                                            <td align="left" style="width: 651px">
                                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Select Location"
                                                    Width="113px"></asp:Label></td>
                                            <td align="left" style="width: 299px">
                                                <asp:UpdatePanel ID="UpdatePanel22" runat="server">
                                                    <ContentTemplate>
                                                        <asp:Panel ID="pnlstaff" runat="server">
                                                            &nbsp;
                                                            <asp:DropDownList ID="ddlloc2" runat="server" AutoPostBack="True">
                                                            </asp:DropDownList></asp:Panel>
                                                    </ContentTemplate>
                                                   <%-- <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                                                    </Triggers>--%>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                       <asp:Label ID="Label3"  CssClass="blackfnt" Text="Select Login Date" runat="server" Width="145px"></asp:Label>    
                                                            </td>
                                                        <td  align="left" style="width: 359px" valign="top">
                                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1" Width="244px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
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
                            <tr style="background-color: white">
                         <td align="left" style="height: 25px; width: 100px;">
                             &nbsp;<asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="Stock As On"
                                 Width="113px"></asp:Label></td>
                                
                                
                                    <td align="left" style="height: 24px; width:25px;">
                                   
                                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal">
                                        <asp:ListItem>Today</asp:ListItem>
                                        <asp:ListItem>Specific</asp:ListItem>
                                    </asp:RadioButtonList>
                                               </td>
                                    <td align="left" colspan="2" valign="top"  style="height: 25px; width:800px;">
                                    &nbsp;&nbsp; 
                          
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                                     
                            </tr>
                    
                            <tr style="background-color: white">
                                <td align="left" style="height: 24px;">
                                    &nbsp;<asp:Label ID="Label6"  CssClass="blackfnt" Text="Select Report Type" runat="server" Width="140px"></asp:Label></td>
                                
                                <td align="left" colspan="2" valign="top" style="height: 24px;">
                                    &nbsp;<asp:RadioButtonList ID="rdreptype" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="S">Summary</asp:ListItem>
                                        <asp:ListItem Value="X">Detail Download</asp:ListItem>
                                        <asp:ListItem Value="D">Detail Page Wise</asp:ListItem>
                                    </asp:RadioButtonList></td>
                               
                             
 
                                
                                
                            </tr>
                            
                                  
                        </table> <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Button" />
                        </td>
                        </tr>
                        </table>
                       
</ContentTemplate>
</asp:UpdatePanel>





</asp:Content>
