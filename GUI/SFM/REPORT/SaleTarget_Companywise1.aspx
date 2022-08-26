<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SaleTarget_Companywise1.aspx.cs" Inherits="REPORT_SaleTarget_Companywise1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

//function check(cboIndustry)
//{
//    if(cboIndustry.value=="Select")
//    {
//    alert("Please Select Industry")
//    cboIndustry.focus()
//    return false
//    }
//}
</script>
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sale Target Company Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
                                                            <font class="blackfnt"><strong>Search Criteria</strong></font></td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" >
                                                        <td align="left" style="width: 102px">
                                                            <div align="left">
                                                                <font class="blackfnt">Select RO</font> :
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <asp:UpdatePanel ID="updatepanel3" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboSelectRo" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline"
                                                                        Width="152px" OnSelectedIndexChanged="cboSelectRo_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr bgcolor="#ffffff">
                                                        <td align="left" style="width: 102px">
                                                            <div align="left">
                                                                <font class="blackfnt">Select Location</font>
                                                            </div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            <div>
                                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboSelectLocation" runat="server" AutoPostBack="true">
                                                                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectRo" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                                </div>
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
                                                                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
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
                                        <%--<asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="Customer" Text="Customer"></asp:ListItem>
                                        <asp:ListItem  Value="Hot" Text="Hot"></asp:ListItem>
                                        <asp:ListItem  Value="Warm" Text="Warm"></asp:ListItem>
                                        <asp:ListItem  Value="Cold" Text="Cold"></asp:ListItem>--%>
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
                            
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="font-weight: bold; width: 208px;">
                                    <font class="blackfnt">Financial Year</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboyear" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
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
                        </table>
                        <br />
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click"  />
                        &nbsp;&nbsp; &nbsp;&nbsp;<br />
                        &nbsp;&nbsp;
                        <br />
    
    
    
    </div>
    </asp:Content>
