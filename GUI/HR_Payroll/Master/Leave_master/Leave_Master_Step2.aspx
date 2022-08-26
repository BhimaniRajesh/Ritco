<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Leave_Master_Step2.aspx.cs" Inherits="GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">

function CheckData()
{


var seleone=document.getElementById("ctl00_MyCPH1_cboLeaveCode");

if(seleone.value=="All")
				  {
				   alert("Please Select One ")
				   seleone.focus();
				   return false;
				  }
}

</script>

 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
               <font class="blackfnt"><b>HR & Payroll :- </b></font><font class="bluefnt"><b>Leave Masters</b> </font>
                <hr align="center" size="1" color="#8ba0e5">
                <div align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0" alt="" /></a></div>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="3" width="66%" bgcolor="#808080" cellspacing="1" align="center"
            class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <p align="center">
                        <font class="blackfnt"><b>Select Leave Type</b></font></p>
                </td>
            </tr>
            <tr align="left" bgcolor="#FFFFFF">
                <td valign="top" width="40%">
                    <div align="left">
                        <font class="blackfnt">Select Code</font> :
                    </div>
                </td>
                <td bgcolor="#FFFFFF">
                            <asp:DropDownList ID="cboLeaveCode" runat="server">
                           <%-- <asp:ListItem Text="Select One" Value="All"></asp:ListItem>--%>
                            </asp:DropDownList>
                </td>
            </tr>
           
            <tr bgcolor="#FFFFFF" align="left">
                <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                    <table style="width: 292px">
                        <tr>
                            <td align="center" colspan="4">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"/>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClientClick="javascript:return CheckData()" OnClick="btnEdit_Click" />
                                <asp:Button ID="btnDelete" runat="server" OnClientClick="javascript:return CheckData()" Text="Delete" OnClick="btnDelete_Click"/>
                                <asp:Button ID="btnInactivate" runat="server" OnClientClick="javascript:return CheckData()" Text="InActive" OnClick="btnInactivate_Click"/>
                                <asp:Button ID="btnListing" runat="server" Text="Listing" OnClick="btnListing_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</asp:Content>
