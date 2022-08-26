<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <table  bgcolor="#000000" border="0" cellpadding="4" cellspacing="1"
            class="boxbg" style="font-size: 12pt; font-family: Times New Roman; left: 0px; width: 80%; position: relative; top: 0px; height: 48px;">
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" width="2%" style="height: 25px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet" style="width: 5px">
                                <img  src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" width="90%">
                    <font class="blackfnt" color="#0000ff"><a href="./Operation/Master_Page.aspx"><font class="blklnkund">
                        Communication Master</font></a></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-weight: bold; color: #0000ff">
                <td bgcolor="#ffffff" height="25" width="2%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" height="18" width="90%">
                    <font class="blackfnt" color="#0000ff"><a href="./Bill Entry/Query.aspx"><font class="blklnkund">
                    Communication Expenses Bill</font></a></td>
            </tr>
            
            <tr bgcolor="#ffffff" style="font-weight: bold; color: #0000ff">
                <td bgcolor="#ffffff" width="2%" style="height: 16px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" width="90%" style="height: 16px">
                    <font class="blackfnt" color="#0000ff"><a href="./ReportMain.aspx"><font class="blklnkund">
                    Reports</font></a></td>
            </tr>
        </table>
</asp:Content>
