<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="rptCommExeRegister.aspx.cs" Inherits="rptCommExeRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
function Option()
{
    if(document.getElementById("ctl00_MyCPH1_rbLoc").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbVendorWise").checked = false;
        document.getElementById("ctl00_MyCPH1_rbDeviceWise").checked = false; 
    }
}
function Option1()
{
    if(document.getElementById("ctl00_MyCPH1_rbVendorWise").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbLoc").checked = false;
        document.getElementById("ctl00_MyCPH1_rbDeviceWise").checked = false;
    }
}
function Option2()
{
    if(document.getElementById("ctl00_MyCPH1_rbDeviceWise").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_rbLoc").checked = false;
        document.getElementById("ctl00_MyCPH1_rbVendorWise").checked = false;
    }   
}
function Select()
{
    if(document.getElementById("ctl00_MyCPH1_lbMonth").value == "")
    {
        alert("Please Select Any One Month")
        document.getElementById("ctl00_MyCPH1_lbMonth").focus();
        return false;
    }
}
function Check()
{
    if(document.getElementById("ctl00_MyCPH1_ddlYear").value == "- Select One -")
    {
        alert("Please Select One Year");
        document.getElementById("ctl00_MyCPH1_ddlYear").focus();
        return false;
    }

//    if(document.getElementById("ctl00_MyCPH1_txtPerson").value == "")
//    {
//        alert("Please Enter Valid User ID");
//        document.getElementById("ctl00_MyCPH1_txtPerson").focus();
//        return false;
//    }
    if(document.getElementById("ctl00_MyCPH1_lbMonths").value == "")
    {
        alert("Please Select atlist one Month");
        document.getElementById("ctl00_MyCPH1_lbMonth").focus();
        return false;
    }
}
</script>

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="Img2" align="right" alt="" border="0" src="../../GUI/images/back.gif" /></a><br />
        <br />
        <table id="TABLE1" align="center" cellpadding="0" cellspacing="1" class="boxbg" style="width: 80%">
            <tr>
                <td align="center" class="bgbluegrey" style="height: 27px">
                    <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Your
                        Query</span></strong></font></td>
            </tr>
        </table>
        <br />
        <center>
                <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional" RenderMode="Inline">               
            <ContentTemplate>
        <table id="Table2" align="center" cellpadding="1" cellspacing="1" class="boxbg" style="font-size: 12pt;
            width: 80%; font-family: Times New Roman" width="85%">
            <tr bgcolor="white">
                <td class="field1" style="width: 126px" align="left">
                    <font class="blackfnt">&nbsp;Year</font></td>
                <td align="left" class="blackfnt" style="width: 172px">
                    <font color="red">&nbsp;<asp:DropDownList ID="ddlYear" runat="server">
                        <asp:ListItem>- Select One -</asp:ListItem>
                        <asp:ListItem>2001</asp:ListItem>
                        <asp:ListItem>2002</asp:ListItem>
                        <asp:ListItem>2003</asp:ListItem>
                        <asp:ListItem>2004</asp:ListItem>
                        <asp:ListItem>2005</asp:ListItem>
                        <asp:ListItem>2006</asp:ListItem>
                        <asp:ListItem>2007</asp:ListItem>
                        <asp:ListItem>2008</asp:ListItem>
                        <asp:ListItem>2009</asp:ListItem>
                        <asp:ListItem>2010</asp:ListItem>
                    </asp:DropDownList></font></td>
                <td class="field1"  align="left">
                    <font class="blackfnt">&nbsp;Vendor Type</font>
                </td>
                <td align="left" class="blackfnt">
                    &nbsp;Service Provider - Communication</td>
            </tr>
            <tr bgcolor="white" align="left" >
                <td class="field1" style="width: 126px; height: 22px;">
                    <font class="blackfnt">&nbsp;Region</font></td>
                <td align="left" class="blackfnt" style="width: 172px; height: 22px">
                    &nbsp;<asp:DropDownList ID="cboRegion" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRegion_SelectedIndexChanged">
                    </asp:DropDownList></td>
                <td class="field1" align="left">
                    <font class="blackfnt">&nbsp;Vendor</font>
                </td>
                <td align="left">
                    &nbsp;<asp:DropDownList ID="ddlVendor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged">
                    </asp:DropDownList>
                    </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td class="field1" align="left" style="height: 40px">
                    <font class="blackfnt">&nbsp;Location</font></td>
                <td align="left" style="height: 40px">
                    &nbsp;<asp:DropDownList ID="ddlLoc" runat="server">
                    </asp:DropDownList></td>
                <td class="field1" align="left" style="height: 40px">
                    <font class="blackfnt">&nbsp;Communication Device Type</font></td>
                <td align="left" style="height: 40px">
                    &nbsp;<asp:DropDownList ID="ddlCommType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCommType_SelectedIndexChanged">
                    </asp:DropDownList>
                    </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td class="field1" align="left" >
                    <font class="blackfnt">&nbsp;User</font>
                </td>
                <td align="left">
                    &nbsp;<asp:TextBox ID="txtPerson" runat="server" Width="53px" AutoPostBack="true" OnTextChanged="txtPerson_TextChanged" ></asp:TextBox>
                    <asp:Label ID="lblPersonName" runat="server" CssClass="blackfnt"></asp:Label><asp:CustomValidator ID="cvPerson"
                            runat="server" ControlToValidate="txtPerson" CssClass="blackfnt" OnServerValidate="Person"></asp:CustomValidator></td>
                <td class="field1" align="left">
                    <font class="blackfnt">&nbsp;Number</font></td>
                <td align="left">
                    &nbsp;<asp:DropDownList ID="ddlNumber" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td align="left" class="blackfnt">
                    &nbsp;Select Monts</td>
                <td align="left">
                    &nbsp;<asp:ListBox ID="lbMonth" runat="server" Height="98px" Width="107px">
                        <asp:ListItem Value="January">January</asp:ListItem>
                        <asp:ListItem Value="February">February</asp:ListItem>
                        <asp:ListItem Value="March">March</asp:ListItem>
                        <asp:ListItem Value="April">April</asp:ListItem>
                        <asp:ListItem Value="May">May</asp:ListItem>
                        <asp:ListItem Value="June">June</asp:ListItem>
                        <asp:ListItem Value="July">July</asp:ListItem>
                        <asp:ListItem Value="August">August</asp:ListItem>
                        <asp:ListItem Value="September">September</asp:ListItem>
                        <asp:ListItem Value="October">October</asp:ListItem>
                        <asp:ListItem Value="November">November</asp:ListItem>
                        <asp:ListItem Value="December">December</asp:ListItem>
                    </asp:ListBox></td>
                <td align="center" class="field1">
                    <asp:Button ID="btnMove" runat="server" OnClientClick="return Select()" OnClick="btnMove_Click" Text="Move >>" /><br />
                    <asp:Button ID="btnMoveAll" runat="server" OnClick="btnMoveAll_Click" Text="Move All >>>" /><br />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="<< Back" /><br />
                    <asp:Button ID="btnBackAll" runat="server" OnClick="btnBackAll_Click" Text="<<< Back All" /></td>
                <td align="left">
                    &nbsp;<asp:ListBox ID="lbMonths" runat="server" Height="95px" Width="105px"></asp:ListBox></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td class="field1" align="left">
                    <font class="blackfnt">&nbsp;Report Output</font></td>
                <td align="left" colspan="3">
                    &nbsp;<asp:RadioButton ID="rbLoc" runat="server" CssClass="blackfnt" Text="Location Wise" onClick="return Option()" />&nbsp;
                    <asp:RadioButton ID="rbVendorWise" runat="server" CssClass="blackfnt" Text="Vendor Wise" onClick="return Option1()" />&nbsp;
                    <asp:RadioButton ID="rbDeviceWise" runat="server" CssClass="blackfnt" Text="Device Type Wise" onClick="return Option2()" /></td>
            </tr>           
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td align="center" class="field1" colspan="4">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" Text="Show" OnClick="btnSubmit_Click" OnClientClick="return Check()" /></td>
            </tr>
        </table>                
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    </center>
    </asp:Content>
