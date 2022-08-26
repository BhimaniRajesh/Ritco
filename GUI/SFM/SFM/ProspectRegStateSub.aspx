<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectRegStateSub.aspx.cs" Inherits="SFM_ProspectRegStateSub" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
function check(txtCompanyName,txtEmpId,hidcompany)
{

var ProspectCode = txtCompanyName.value.split(':')

hidcompany.value = ProspectCode[0]

}
</script>
<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Status and Submission" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
             
                                                        <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                                        <ContentTemplate>
                                
            <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <tr class="bgbluegrey">
                                                        <td align="center" colspan="3">
                                                            <font class="blackfnt"><strong>Prospect Status and Submission </strong></font>
                                                        </td>
                                                    </tr>
                           
                                                    
                                                <%--<tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                    
                                                        <td valign="top" align ="left" style="width: 183px" >
                                                            <font class="blackfnt">Registration Date</font>
                                                        </td>
                                                        
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                                                      
                                                        <asp:RadioButton ID="rb1" runat="server" AutoPostBack="true" Text="Date Range [dd/mm/yyyy]" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb1_CheckedChanged"/>
                                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                                        <asp:TextBox ID="txtDateFrom" runat="Server" Width="80"></asp:TextBox>
                                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                                        <asp:TextBox ID="txtDateTo" runat="Server" Width="80"></asp:TextBox><br />
                                                        <asp:RadioButton ID="rb2" AutoPostBack="true" runat="server" Text="Last Week (Including Today)" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb2_CheckedChanged"/><br />
                                                        <asp:RadioButton ID="rb3" AutoPostBack="true" runat="server" Text="Today:" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb3_CheckedChanged"/><br />
                                                        <asp:RadioButton ID="rb4" AutoPostBack="true" runat="server" Text="Till Date:" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb4_CheckedChanged"/>
                                                       
                                                       
                                                        </td>
                                                </tr>
                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        
                                                        <td valign="top" align ="left" style="width: 183px" >
                                                            <font class="blackfnt">Last Visit Date</font>
                                                        </td>
                                                        
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                                                        
                                                       
                                                        <asp:RadioButton ID="rb5" runat="server" Text="Date Range [dd/mm/yyyy]" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb5_CheckedChanged"/>
                                                        <asp:Label ID="lblFrom1" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                                        <asp:TextBox ID="txtDateFrom1" runat="Server" Width="80" AutoPostBack="true"></asp:TextBox>
                                                        <asp:Label ID="lblTo1" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                                        <asp:TextBox ID="txtDateTo1" runat="Server" Width="80" AutoPostBack="true"></asp:TextBox><br />
                                                        <asp:RadioButton ID="rb6" AutoPostBack="true" runat="server" Text="Last Week (Including Today)" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb6_CheckedChanged"/><br />
                                                        <asp:RadioButton ID="rb7" AutoPostBack="true" runat="server" Text="Today:" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb7_CheckedChanged"/><br />
                                                        <asp:RadioButton ID="rb8" AutoPostBack="true" runat="server" Text="Till Date:" CssClass="blackfnt" GroupName="abc" OnCheckedChanged="rb8_CheckedChanged"/>
                                                           
                                                      
                                                        </td>
                                                 </tr>--%>
                                                    
                            <tr bgcolor="#ffffff">
                                <td align ="left" style="height: 30px; width: 183px;" >
                                    <font class="blackfnt">Company Name</font></td>
                                <td align="left" style="height: 30px" colspan="2">
                                    <asp:TextBox ID="txtCompanyName" runat="server" Style="left: 0px; position: relative;
                                        top: 0px" Width="136px"></asp:TextBox>&nbsp;
                                        <asp:Button ID="btnCompany" runat="server" Width="25px" />
                                        <%--<atlas:AutoCompleteExtender ID="Extender1" runat="server">
                                        <atlas:AutoCompleteProperties Enabled="True"
                                            TargetControlID="txtCompanyName"
                                            ServiceMethod="GetBlogCompanyForAutoComplete"
                                            ServicePath="~/Service/AutoCompleteSFM.asmx" MinimumPrefixLength="1"  />
                                        </atlas:AutoCompleteExtender> --%>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td style="height: 28px; width: 183px;" align ="left" >
                                    <font class="blackfnt">Employee Id </font>
                                    
                                </td>
                                <td style="font-size: 12pt; font-family: Times New Roman; height: 28px;" align="left" colspan="2">
                                    <asp:TextBox ID="txtEmpId" runat="server" Style="left: 0px; position: relative;
                                        top: 0px" Width="60px"></asp:TextBox>
                                        <%--<asp:Button ID="btnPopUp" runat="server" Width="25px" />--%>&nbsp;
                                        <%--<atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server">
                                        <atlas:AutoCompleteProperties Enabled="True"
                                            TargetControlID="txtEmpId"
                                            ServiceMethod="GetBlogEMPForAutoComplete"
                                            ServicePath="~/Service/AutoCompleteSFM.asmx" MinimumPrefixLength="1"  />
                                        </atlas:AutoCompleteExtender> --%>
                                        
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align ="left" style="width: 183px" >
                                    <font class="blackfnt">Industry </font>
                                </td>
                                
                                <td bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman" align= "left" colspan="2">
                                    <asp:DropDownList ID="cboIndustry" runat="server" Style="left: 0px; position: relative; top: 0px;"
                                        Width="160px">
                                    </asp:DropDownList>&nbsp;</td>
                            </tr>
                            <%--<tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" style="width: 183px" >
                                    <font class="blackfnt">City</font></td>
                                <td style="font-weight: bold; font-size: 12pt; font-family: Times New Roman" align="left" colspan="2">
                                    
                                    <asp:TextBox ID="txtCity" runat="server" Style="left: 0px; position: relative;
                                        top: 0px"></asp:TextBox></td>
                            </tr>--%>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="height: 26px; width: 183px;">
                                    <font class="blackfnt">Account Status</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboAccCategory" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        <%--<asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="H" Text="Hot"></asp:ListItem>
                                        <asp:ListItem  Value="W" Text="Warm"></asp:ListItem>
                                        <asp:ListItem  Value="C" Text="Cold"></asp:ListItem>--%>
                                    </asp:DropDownList></font></td>
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="height: 26px; width: 183px;">
                                    <font class="blackfnt">Submission Status</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt"><asp:DropDownList ID="cboApproval" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                        <%--<asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="S" Text="Submitted"></asp:ListItem>
                                        <asp:ListItem  Value="U" Text="UnSubmitted"></asp:ListItem>
                                        <asp:ListItem  Value="R" Text="Rejected"></asp:ListItem>--%>
                                        
                                    </asp:DropDownList></font></td>
                            </tr>
                        </table>
                           </ContentTemplate>
                                                        </asp:UpdatePanel>  
                        <br />
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" />
                        &nbsp;&nbsp; &nbsp;&nbsp;<br />
                        &nbsp;&nbsp;
                        <br />
                        
                        <asp:HiddenField ID="hidcompany" runat="server" />
            
            
            </div>
            </asp:Content>
