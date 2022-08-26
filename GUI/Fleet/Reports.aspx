<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Reports.aspx.cs" Inherits="GUI_Fleet_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<SCRIPT LANGUAGE=javascript>
<!--
// PRINT FUNCTION
function ViewPrint()
  	{
  		window.open("PrintMe.aspx","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
	
	}
//-->
</SCRIPT>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Reports</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Fleet Reports</b> </font>
            </td>
        </tr>


        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width=8%>
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <%--<font class="blackfnt">Vehicle Regsiter</font>--%>
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Vehicle Regsiter" PostBackUrl="~/GUI/Fleet/Reports/Query_Vehicle.aspx" />
            </td>

            <td align="center" nowrap>
            <a href="Javascript:ViewPrint()">Print*</a>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Journey/Trip Register </font>
            </td>

            <td align="center">
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Request Follow-up </font>
            </td>

            <td align="center" nowrap>

            </td>
        </tr>
        
        
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Driver Status </font>
            </td>

            <td align="center" nowrap>

            </td>
        </tr>
        
           
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Route Analysis </font>
            </td>

            <td align="center" nowrap>

            </td>
        </tr>


        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Performance Report </font>
            </td>

            <td align="center" nowrap>

            </td>
        </tr>
        

                 

    </table>
</asp:Content>
