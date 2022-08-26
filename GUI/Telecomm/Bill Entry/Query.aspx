<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Query.aspx.cs" Inherits="Bill_Entry_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
    function Check()
    {
        if(document.getElementById("ctl00_MyCPH1_cboVendor").value == "--Select--")
        {
            alert("Please Select Vendor Any One ")
            document.getElementById("ctl00_MyCPH1_cboVendor").focus();
            return false;
        } 
    }
</script> 

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
    <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>&nbsp;
    <asp:HyperLink ID="hlEntryBill" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Expense Bill</asp:HyperLink>
    &gt;
    <asp:Label ID="lbVendor" runat="server" CssClass="blackfnt" Text="Vendor Selection"></asp:Label><br />
    &nbsp;<br />
        <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="1" style="width: 80%" class="boxbg">
            <tr>
                <td align="center" class="bgbluegrey" style="height: 27px">
                    <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Vendor
                        Selection</span></strong></font></td>
            </tr>
        </table>
        <br />
    
    
        <table align="center" bgcolor="#000000" border="0" cellpadding="4" cellspacing="1"
            class="boxbg" style="width: 80%">
            <tr bgcolor="#ffffff">
                <td style="width: 31%; height: 25px">
                    <font class="blackfnt">Select Vendor Type</font></td>
                <td align="left" colspan="3" width="90%">
                    <font class="blackfnt" >Service Provider- Communication</font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td style="width: 31%; height: 25px" class="blackfnt">
                    Region</td>
                <td align="left" colspan="3" width="90%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <asp:DropDownList ID="cboRegion" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRegion_SelectedIndexChanged">
                    </asp:DropDownList>
                </ContentTemplate>
                </asp:UpdatePanel>
                    </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td style="width: 31%; height: 25px" class="blackfnt">
                    Location</td>
                <td align="left" colspan="3" width="90%"><asp:UpdatePanel ID="Updatepanel" runat="server">
                    <ContentTemplate>
                    <asp:DropDownList ID="ddlLoc" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLoc_SelectedIndexChanged">
                    </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 31%; height: 25px">
                    <font class="blackfnt">Select Vendor</font></td>
                <td align="left" colspan="3" width="90%">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
                    <asp:DropDownList ID="cboVendor" runat="server">
                    </asp:DropDownList>                    
            <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/admin/Vendor/VendorMaster.aspx">Add New Vendor</asp:HyperLink>
        </ContentTemplate>
    </asp:UpdatePanel>
                    </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" colspan="5" style="height: 27px" width="90%">
                    <asp:Button ID="cmdSubmit" runat="server" OnClick="cmdSubmit_Click" OnClientClick="return Check()"
                        Text="Submit" />
                </td>
            </tr>
        </table>
    &nbsp;
    
</asp:Content>
