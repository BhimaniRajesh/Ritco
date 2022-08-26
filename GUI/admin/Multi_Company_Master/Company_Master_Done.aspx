<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Company_Master_Done.aspx.cs" Inherits="GUI_admin_Multi_Company_Master_Company_Master_Done"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br /><br />
<div align="left" style="width: 10.0in;">
    <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="95%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="left" colspan="2">
                <b><asp:Label ID="Lblmsg" runat="server"></asp:Label></b>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Code</b>
            </td>
            <td class="blackfnt" align="center">
                <font class="bluefnt"><asp:Label ID="lblCompanyCode" Font-Bold="true" runat="server"></asp:Label></font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Next Step</b>
            </td>
            <td class="blackfnt" align="center">
                <% if (CodeType == "Company")
                   { %>
                <% if (flag == "1")
                   { %>
                        <a href="Company_Master.aspx?Company_Code=new">Click here to Add More Company Code</a>
                <% }
                   else
                   { %>
                        <a href="Company_Master_Edit.aspx">Click here to Update More Company Code</a>
                <% }
               }%>
               
               <% if (CodeType == "Employee")
                   { %>
                <% if (flag == "1")
                   { %>
                        <a href="EmployeeMapping.aspx">Click here to Add More Employee For Mapping</a>
                <% }
                   else
                   { %>
                        <a href="EmployeeMapping.aspx">Click here to Update More Employee For Mapping</a>
                <% }
               }%>
               
               <% if (CodeType == "Location")
                   { %>
                <% if (flag == "1")
                   { %>
                        <a href="LocationMapping.aspx">Click here to Add More Location For Mapping</a>
                <% }
                   else
                   { %>
                        <a href="LocationMapping.aspx">Click here to Update More Location For Mapping</a>
                <% }
               }%>
               
            </td>
        </tr>
    </table>
</div> 
</asp:Content>

