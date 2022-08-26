<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLMasterDone.aspx.cs" Inherits="GUI_admin_HCLMaster_HCLMasterDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>HCL Master </u></b></font>
                    <td>
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
            </tr>
        </table>
    <table border="0" width="60%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>HCL MASTER</b></font>
                </td>
            </tr>
        </table>

    <table border="1" width="60%">
            <!--Row 1-->
            <tr bgcolor="#ffffff">
                <td align="left" colspan="2">
                    <%--<font class="blackfnt">HCL Master Successfully Added</font>--%>
                    <asp:Label runat="server" ID="lblDisplay"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" colspan="3" style="display:inline">
                   <a href="HCLMasterAdd.aspx">Add More HCL Master</a>
                </td>
             </tr>
    </table>
</asp:Content>

