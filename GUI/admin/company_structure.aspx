<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="company_structure.aspx.cs" Inherits="GUI_admin_company_structure" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Company Structure</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="40%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Company Structure Masters</b> </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">Locations</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./LocationMaster/AddLoc.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./LocationMaster/LocationEdSelect.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">Cities</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./CityMaster_New/Citymaster_Step1.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./CityMaster_New/Citymaster_Step2.aspx" />
            </td>
        </tr>
       <!--  <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Employee</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton
                    ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Underline="true" Font-Bold="false"
                    Text="DownLoad XLS" PostBackUrl="./EmployeeMaster/EMP_DOWNLOAD.aspx" />
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./EmployeeMaster/Employee_Add.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./EmployeeMaster/EmployeeEdSelect.aspx" />
            </td>
        </tr> -->
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">States & Documents</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./StateMaster/StateMaster.aspx?Flag=Add" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./StateMaster/StateMasterCriteria.aspx?Flag=Edit" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">PinCode Master</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/PinCodeMaster/FrmPincodeCriteria.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/admin/PinCodeMaster/PinCodeListing.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">Receiver Master</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/ReceiverMaster/ReceiverMaster.aspx?Flag=Add" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton13" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/admin/ReceiverMaster/ReceiverMasterCriteria.aspx?Flag=Edit" />
            </td>
			
        </tr>
		<tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="70%">
                <font class="blackfnt">HCL Master</font>  
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton14" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/HCLMaster/HCLMasterAdd.aspx" /> 
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton15" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/HCLMaster/HCLMasterEdit.aspx" /> 
                   <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton17"  CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/HCLMaster/HCLMasterView.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Business Type Wise Mode of Service Master</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton16" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="ReSet" PostBackUrl="~/GUI/admin/BussinesTypeWiseModeMaster/BusinessTypeWiseMode.aspx" />
                <font class="blackfnt"></font>
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="center" style="vertical-align: middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" class="blackfnt">
                Company - Employee Mapping
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton21" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/Multi_Company_Master/EmployeeMapping.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton22" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/admin/Multi_Company_Master/EmployeeMapping.aspx" />
            </td>
        </tr>
    </table>
</asp:Content>
