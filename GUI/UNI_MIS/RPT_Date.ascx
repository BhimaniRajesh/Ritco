<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RPT_Date.ascx.cs" Inherits="GUI_UNI_MIS_RPT_Date" %>
<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<div>
    <div id="tabs" style="text-align: left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color: DarkGray">
        <table cellspacing="1" cellpadding="3" border="0" class="boxbg" style="width: 100%">
            <tr style="background-color: white" runat="server">
              
                    <td>
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            Width="210px">
                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                        </asp:RadioButtonList>
                    </td>
                    <td valign="top" colspan="5">
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$DT$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="anchor1">
                            <img src="../images/calendar.jpg" runat="server" id="imgfrm" border="0" />
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$DT$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a1">
                            <img src="../images/calendar.jpg"  runat="server" id="imgto" border="0" />
                        </a>
                    </td>
            </tr>
        </table>
    </div>
</div>
