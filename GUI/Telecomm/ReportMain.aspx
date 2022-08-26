<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ReportMain.aspx.cs" Inherits="ReportMain" %>


    <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
        <br />
        <a href="javascript:window.history.go(-1)" title="back">
            <img id="Img2" align="right" alt="" border="0" src="../../GUI/images/back.gif" /></a>&nbsp;
        <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Report</asp:HyperLink>
        &gt;
        <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Report Type"></asp:Label><br />
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
                <td align="left"  colspan="3" width="90%">
                    <font class="blackfnt" color="#0000ff">
                     <a href="./rptCommExeRegister.aspx"><font class="blklnkund"> Communication Cost Summary
                        Report</font></a></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-weight: bold; color: #0000ff">
                <td  height="25" width="2%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" colspan="3" height="18" width="90%">
                    <font class="blackfnt" color="#0000ff"><a href="./rptDueDateManagement.aspx"><font class="blklnkund">
                        Communiction Cost Register</font></a></td>
            </tr>
            
            <tr bgcolor="#ffffff" style="font-weight: bold; color: #0000ff">
                <td  height="25" width="2%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" height="18" width="90%">
                    <font class="blackfnt" color="#0000ff"><a href="./rptExpenseSummary.aspx"><font class="blklnkund"> Communiction Assets Register
                    </font></a></td>
            </tr>
        </table>
    
    </asp:Content>
