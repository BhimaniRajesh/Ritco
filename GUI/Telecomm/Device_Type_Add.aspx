<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Device_Type_Add.aspx.cs" Inherits="Operation_Device_Type" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
<script language="javascript" type="text/javascript">
    function Check()
    {
        if(document.getElementById("ctl00_MyCPH1_txtDeviceType").value == "")
        {
            alert("Please Enter Communication Device Type Description ")
            document.getElementById("ctl00_MyCPH1_txtDeviceType").focus();
            return false;
        } 
    }
</script> 

    <br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Master</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Operation/Master_Page.aspx">Communication Device Master Type</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communication Device Type Master Add / Edit"></asp:Label><br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />

        <br />
    
    <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 80%" class="boxbg">
            <tr >
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Communication Device Type Master -
                    <asp:Label ID="lblAddEdit" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label></strong></font></td>
            </tr>
        </table>
        <br />
        
        <table align="center" bgcolor="#000000" border="0" cellpadding="4" cellspacing="1" class="boxbg" style="width: 80%;">
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Communication Device Type Code</font>
                </td>
                <td align="left"  colspan="3" width="90%" ><font class="blackfnt" color="red">&nbsp;<asp:Label ID="lblTypeCode" runat="server" Text="< System Generated >"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Communication Device Type Description</font>
                </td>
                <td align="left"  colspan="3" width="90%">
                <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>
                    &nbsp;<asp:TextBox ID="txtDeviceType" runat="server" OnTextChanged="txtDeviceType_TextChanged" AutoPostBack="true" TabIndex="1" MaxLength="100"></asp:TextBox>
            <asp:Label ID="lblDesc" runat="server" CssClass="blackfnt" ForeColor="Red"></asp:Label>
            <asp:CustomValidator ID="cvDeviceType" runat="server" ControlToValidate="txtDeviceType"
                OnServerValidate="DeviceType"></asp:CustomValidator>
                        </ContentTemplate>
    </asp:UpdatePanel>
                        </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" colspan="5" width="90%" style="height: 27px">
                <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClick="cmdSubmit_Click" OnClientClick="return Check()" />
                </td>
            </tr>
            
        </table>
        
   </asp:Content>
