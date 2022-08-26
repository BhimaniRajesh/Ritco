<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="rptExpenseSummary.aspx.cs" Inherits="rptExpenseSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
function Option()
{
    if(document.getElementById("ctl00_MyCPH1_rbSummType").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbSummVendor").checked = false;
        document.getElementById("ctl00_MyCPH1_rbRegister").checked = false; 
    }
}
function Option1()
{
    if(document.getElementById("ctl00_MyCPH1_rbSummVendor").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbSummType").checked = false;
        document.getElementById("ctl00_MyCPH1_rbRegister").checked = false;
    }
}
function Option2()
{
    if(document.getElementById("ctl00_MyCPH1_rbRegister").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbSummType").checked = false;
        document.getElementById("ctl00_MyCPH1_rbSummVendor").checked = false;
    }   
}
</script>

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="Img2" align="right" alt="" border="0" src="../../GUI/images/back.gif" /></a>&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Report</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/ReportMain.aspx">Report Type</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communiction Assets Register "></asp:Label><br />

    <br />
    <table id="TABLE1" align="center" cellpadding="0" cellspacing="1" class="boxbg" style="width: 80%">
        <tr>
            <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Your
                    Query</span></strong></font></td>
        </tr>
    </table>
    <br /><center>
    <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table id="Table2" align="center" cellpadding="1" cellspacing="1" class="boxbg" style="font-size: 12pt;
                width: 80%; font-family: Times New Roman" width="85%">
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 126px">
                        <font class="blackfnt">&nbsp;Region</font></td>
                    <td align="left" class="blackfnt" style="width: 172px">
                        <font color="red">&nbsp;<asp:DropDownList ID="cboRegion" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRegion_SelectedIndexChanged">
                        </asp:DropDownList></font></td>
                    <td align="left" class="field1">
                        <font class="blackfnt">&nbsp;Vendor Type</font>
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Service Provider - Communication</td>
                </tr>
                <tr align="left" bgcolor="white">
                    <td class="field1" style="width: 126px; height: 22px">
                        <font class="blackfnt">&nbsp;Location</font></td>
                    <td align="left" class="blackfnt" style="width: 172px; height: 22px">
                        &nbsp;<asp:DropDownList ID="ddlLoc" runat="server">
                        </asp:DropDownList></td>
                    <td align="left" class="field1">
                        <font class="blackfnt">&nbsp;Vendor</font>
                    </td>
                    <td align="left">
                        &nbsp;<asp:DropDownList ID="ddlVendor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td align="left" class="field1">
                        <font class="blackfnt">&nbsp;User</font></td>
                    <td align="left">
                        &nbsp;<asp:TextBox ID="txtPerson" runat="server" AutoPostBack="true" OnTextChanged="txtPerson_TextChanged"
                            Width="53px"></asp:TextBox><asp:Label ID="lblPersonName" runat="server" CssClass="blackfnt"></asp:Label><asp:CustomValidator
                            ID="cvPerson" runat="server" ControlToValidate="txtPerson" CssClass="blackfnt"
                            OnServerValidate="Person"></asp:CustomValidator></td>
                    <td align="left" class="field1">
                        <font class="blackfnt">&nbsp;Communication Device Type</font></td>
                    <td align="left">
                        &nbsp;<asp:DropDownList ID="ddlCommType" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td align="left" class="field1">
                        <font class="blackfnt">&nbsp;Report Output</font></td>
                    <td align="left" colspan="3">
                        &nbsp;<asp:RadioButton ID="rbSummType" runat="server" CssClass="blackfnt" onclick="return Option()"
                            Text="Summary Type" />&nbsp;
                        <asp:RadioButton ID="rbSummVendor" runat="server" CssClass="blackfnt" onclick="return Option1()"
                            Text="Summary Vendor" />&nbsp;
                        <asp:RadioButton ID="rbRegister" runat="server" CssClass="blackfnt" onclick="return Option2()"
                            Text="Register" /></td>
                </tr>
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td align="center" class="field1" colspan="4">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" OnClick="btnSubmit_Click" Text="Show" /></td>
                </tr>
            </table>           
        </ContentTemplate>
    </asp:UpdatePanel>
    </center>    
</asp:Content>
