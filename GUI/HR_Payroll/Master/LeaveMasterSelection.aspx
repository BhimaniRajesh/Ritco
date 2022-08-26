<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="LeaveMasterSelection.aspx.cs" Inherits="GUI_HR_Payroll_Master_LeaveMasterSelection" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">
    function CheckData_Add(cboLeaveCode)
    {
        if(cboLeaveCode.value == "Select")
            {
                alert("Please Select Leave Code !!!")
                cboLeaveCode.focus();
                return false;
            }
    }
    function CheckData_Edit(cboLeaveCode)
    {
        if(cboLeaveCode.value == "Select")
            {
                alert("Please Select Leave Code !!!")
                cboLeaveCode.focus();
                return false;
            }
    }
    function CheckData_Inactive(cboLeaveCode)
    {
        if(cboLeaveCode.value == "Select")
            {
                alert("Please Select Leave Code !!!")
                cboLeaveCode.focus();
                return false;
            }
    }
    function CheckData_List(cboLeaveCode)
    {
        if(cboLeaveCode.value == "Select")
            {
                alert("Please Select Leave Code !!!")
                cboLeaveCode.focus();
                return false;
            }
    }
</script>
<br />
<div align="center">

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
                            <asp:ListItem Text="Select"></asp:ListItem>
                            </asp:DropDownList>
                </td>
            </tr>
           
            <tr bgcolor="#FFFFFF" align="left">
                <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                    <table style="width: 292px">
                        <tr>
                            <td align="center" colspan="4">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"/>
                                <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
                                <asp:Button ID="btnInactivate" runat="server" Text="Delete" OnClick="btnInactivate_Click"/>
                                <asp:Button ID="btnListing" runat="server" Text="Listing" OnClick="btnListing_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>



</div>
</asp:Content>

    
