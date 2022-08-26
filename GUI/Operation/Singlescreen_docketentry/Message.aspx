<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Message.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_Message" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<link href="../../../images/style.css" rel="stylesheet" type="text/css" />


    <div align="center">
        <br /><br /><br /><br /> <br /><br /><br /><br />
        <table cellpadding="3" cellspacing="1" class="boxbg" width="60%">
            <tr   bgcolor="white">
                <td class="redfnt" align="center" >
                    <asp:Label runat="server" ID="lblmessage" Font-Bold="true"></asp:Label>
                </td>
            </tr>
             <tr   bgcolor="white">
                <td class="redfnt" align="center" >
                    <a href="javascript:window.history.go(-1)" Title="back" >Back</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
