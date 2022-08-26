<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Copy of SalesTarget1.aspx.cs" Inherits="SFM_SalesTarget1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sale Target Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <tr class="bgbluegrey">
                                                        <td align="center" colspan="3">
                                                            <font class="blackfnt"><strong>Enter Sale Taget</strong></font></td>
                                                    </tr>
                            
                            
                            <%--<tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align ="left" style="width: 257px" >
                                    <font class="blackfnt">Industry </font>
                                </td>
                                
                                <td bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman" align= "left" colspan="2">
                                    <asp:DropDownList ID="cboIndustry" runat="server" Style="left: 0px; position: relative; top: 0px;">
                                    </asp:DropDownList>&nbsp;</td>
                            </tr>--%>
                            
                            
                                                  <tr bgcolor="#ffffff">
                                                        <td align="left" style="font-weight: bold; width: 208px;">
                                                            <div align="left">
                                                                <font class="blackfnt">Sales Person</font>
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                        <asp:TextBox ID="txtEmployeeCode" runat="server" AutoPostBack="true" Width="60px"></asp:TextBox>&nbsp;
                                                            <asp:Button ID="btnPopUp" runat="server" Width="25px" /> 
                                                                    <%--<asp:DropDownList ID="cboSalesPerson" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline">
                                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>--%>
                                                        </td>
                                                    </tr>
                                                    
                                                    
                            
                            
                            
                            <tr bgcolor="#ffffff">
                                                        <td align="left" style="font-weight: bold; width: 208px;">
                                                            <div align="left">
                                                                <font class="blackfnt">Industry</font>
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                           
                                                            <asp:UpdatePanel ID="updatepanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboIndustry" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline"
                                                                        Width="152px" OnSelectedIndexChanged="cboIndustry_SelectedIndexChanged">
                                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                            
                            
                            
                            
                            <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td align="left" style="width: 208px">
                                                            <div align="left">
                                                                <font class="blackfnt">Customer/Prospect</font>                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboCustomerId" runat="server" AutoPostBack="true" Mode="Conditional"
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
                            
                            
                            <tr bgcolor="#ffffff">
                                <td align ="left" style="font-weight: bold; width: 208px;" >
                                    <font class="blackfnt">Prospect Status</font>
                                </td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboAccCategory" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        <asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="Hot" Text="Hot"></asp:ListItem>
                                        <asp:ListItem  Value="Warm" Text="Warm"></asp:ListItem>
                                        <asp:ListItem  Value="Cold" Text="Cold"></asp:ListItem>
                                    </asp:DropDownList></font></td>
                            </tr>
                            
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align ="left" style="font-weight: bold; width: 208px;" >
                                    <font class="blackfnt">For the Year</font>
                                </td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboYear" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        
                                        <asp:ListItem  Value="01/01/2001-31/12/2001" Text="2001-2002"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2002-31/12/2002" Text="2002-2003"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2003-31/12/2003" Text="2003-2004"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2004-31/12/2004" Text="2004-2005"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2005-31/12/2005" Text="2005-2006"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2006-31/12/2006" Text="2006-2007"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2007-31/12/2007" Text="2007-2008"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2008-31/12/2008" Text="2008-2009"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2009-31/12/2009" Text="2009-2010"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2010-31/12/2010" Text="2010-2011"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2011-31/12/2011" Text="2011-2012"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2012-31/12/2012" Text="2012-2013"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2013-31/12/2013" Text="2013-2014"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2014-31/12/2014" Text="2014-2015"></asp:ListItem>
                                        <asp:ListItem  Value="01/01/2015-31/12/2015" Text="2015-2016"></asp:ListItem>
                                        
                                    </asp:DropDownList></font></td>
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
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" />
                        &nbsp;&nbsp; &nbsp;&nbsp;<br />
                        &nbsp;&nbsp;
                        <br />
            
            
            </div>

</asp:Content>
