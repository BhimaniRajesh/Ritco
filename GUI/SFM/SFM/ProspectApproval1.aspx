<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectApproval1.aspx.cs" Inherits="SFM_ProspectApproval1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

function datecheck(txtDateFrom,txtDateTo)
{
    if(txtDateFrom.value == "" || txtDateTo.value == "")
    {
    alert("Please Enter Date")
    return false
    }
}

</script>

<div align="center">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Approval" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
                                                            <font class="blackfnt"><strong>Prospect Status and Submission </strong></font>
                                                        </td>
                                                    </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left" >
                                                            <font class="blackfnt">Submission Date</font></td>
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel3"       UpdateMode="Conditional" RenderMode="Inline" runat="server">
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
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"      UpdateMode="Conditional" runat="server">
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
                            
                            
                            <tr bgcolor="#ffffff">
                                <td style="height: 28px; width: 257px;" align ="left" >
                                    <font class="blackfnt">Employee Id </font>
                                    
                                </td>
                                <td style="font-size: 12pt; font-family: Times New Roman; height: 28px;" align="left" colspan="2">
                                    <asp:TextBox ID="txtEmpId" runat="server" Style="left: 0px; position: relative;
                                        top: 0px" Width="60px"></asp:TextBox>
                                        <input id="btnCust" type="button" name="" runat="server"/>
                                       <%-- <asp:Button ID="btnPopUp" runat="server" Width="25px" />&nbsp;--%>
                                        <%--<atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server">
                                        <atlas:AutoCompleteProperties Enabled="True"
                                            TargetControlID="txtEmpId"
                                            ServiceMethod="GetBlogEMPForAutoComplete"
                                            ServicePath="~/Service/AutoCompleteSFM.asmx" MinimumPrefixLength="1"  />
                                        </atlas:AutoCompleteExtender> --%>
                                        
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align ="left" style="width: 257px" >
                                    <font class="blackfnt">Industry </font>
                                </td>
                                
                                <td bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman" align= "left" colspan="2">
                                    <asp:UpdatePanel ID="updatepanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboIndustry" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                        RenderMode="Inline"
                                                                        OnSelectedIndexChanged="cboIndustry_SelectedIndexChanged">
                                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel>
                                    </td>
                            </tr>
                            
                            <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td align="left" style="width: 208px">
                                                            <div align="left">
                                                                <font class="blackfnt">Company</font></div>
                                                        </td>
                                                        <td align="left" bgcolor="#ffffff" colspan="2">
                                                            
                                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboCustomerId" runat="server" OnSelectedIndexChanged="cboCustomerId_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboIndustry" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                            
                           <%-- <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" style="width: 257px" >
                                    <font class="blackfnt">City</font></td>
                                <td style="font-weight: bold; font-size: 12pt; font-family: Times New Roman" align="left" colspan="2">
                                    
                                    <asp:TextBox ID="txtCity" runat="server" Style="left: 0px; position: relative;
                                        top: 0px"></asp:TextBox></td>
                            </tr>--%>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="height: 26px; width: 257px;">
                                    <font class="blackfnt">Account Category</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt">
                                     <asp:UpdatePanel ID="updatepanel5" runat="server">
                                                                <ContentTemplate>
                                    <asp:DropDownList ID="cboAccCategory" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                       <%-- <asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="H" Text="Hot"></asp:ListItem>
                                        <asp:ListItem  Value="W" Text="Warm"></asp:ListItem>
                                        <asp:ListItem  Value="C" Text="Cold"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </font></td>
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" bgcolor="#ffffff" valign="top" style="height: 26px; width: 257px;">
                                    <font class="blackfnt">Submission Status</font></td>
                                <td align="left" bgcolor="#ffffff" style="font-weight: bold; height: 26px;" valign="top" width="222" colspan="2">
                                    <font class="blackfnt">
                                     <asp:UpdatePanel ID="updatepanel6" runat="server">
                                                                <ContentTemplate>
                                    <asp:DropDownList ID="cboApproval" runat="server"
                                        Style="left: 0px; position: relative; top: 0px" Width="104px">
                                       <%-- <asp:ListItem  Value="" Text="All"></asp:ListItem>
                                        <asp:ListItem  Value="S" Text="Submitted"></asp:ListItem>
                                        <asp:ListItem  Value="R" Text="Rejected"></asp:ListItem>--%>
                                        
                                    </asp:DropDownList>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </font></td>
                            </tr>
                        </table>
                        <br />
                        <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="Button3_Click" />
                        &nbsp;&nbsp; &nbsp;&nbsp;<br />
                        &nbsp;&nbsp;
                        <br />
            
            
            </div>


</asp:Content>
