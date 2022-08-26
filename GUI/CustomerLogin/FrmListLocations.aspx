<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmListLocations.aspx.cs"
    Inherits="GUI_admin_VehicleMaster_ListAll" Title="Untitled Page" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<asp:ScriptManager EnablePartialRendering="true" runat="server" ID="sm1">
</asp:ScriptManager>
<br />
<body>
    <form id="form1" runat="server">
    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" align="left">
                                <%--<img border="0" src="../images/webxpress_logo.gif">--%><asp:Image Height="50" ID="imgLogo" runat="server" /></td>
                            <td valign="top" align="left">
                                <img border="0" src="../images/blank_top.gif" width="0" height="19"></td>
                        </tr>
                    </table>
        <%--<table width="778" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" align="left">
                                <img border="0" src="../images/webxpress_logo.gif"></td>
                            <td valign="top" align="left">
                                <img border="0" src="../images/blank_top.gif" width="0" height="19"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    &nbsp;</td>
                <td align="right" class="blacklink">
                </td>
            </tr>
            <tr>
                <td width="343" height="65" valign="top" background="../images/topband1.jpg">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <img src="../images/clear.gif" width="10" height="7"></td>
                        </tr>
                        <tr>
                            <td height="14" background="../images/band_strip.gif">
                                <font class="bandstrip"><em>&nbsp;&nbsp;<strong>Module</strong></em></font></td>
                        </tr>
                        <tr>
                            <td height="14">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td height="14">
                                &nbsp;&nbsp;<font class="whitefnt"></font></td>
                        </tr>
                    </table>
                </td>
                <td width="192">
                    <img src="../images/topband2.jpg"></td>
                <td width="243" background="../images/topband3.jpg" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                        <tr>
                            <td height="20">
                                <font class="whitefnt"><strong></strong></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>--%>
        <div align="left" style="width: 10in">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;
                            height: 228px">
                            <tr>
                                <td align="left" style="height: 33px">
                                    <a href="FrmMain.aspx"><font class="blklnkund"><b>My <%=Client %></b></font></a> <b>&gt;
                                    </b><a><font class="blklnkund"><b>View Location List</b></font></a>
                                </td>
                                <td align="right" style="height: 33px">
                                    <a href="javascript:window.history.go(-1)" title="back">
                                        <img src="../images/back.gif" border="0" alt="" /></a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 392px">
                                    <table border="0" cellspacing="1" cellpadding="5" class="boxbg">
                                        <tr class="bgbluegrey">
                                            <td colspan="2" align="center">
                                                <font class="blackfnt"><b>Location Listing</b></font></td>
                                        </tr>
                                        <tr bgcolor="#FFFFFF">
                                            <td style="width: 116px">
                                                <font class="blackfnt"><b>Customer Code: &nbsp;</b></font></td>
                                            <td width="100">
                                                <font class="blackfnt">
                                                    <asp:Label ID="lblcustname" runat="server"></asp:Label></font></td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="1" align="center" style="width: 783px">
                                        <tr>
                                            <td>
                                                <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="true" AutoGenerateColumns="false"
                                                            BorderColor="#8ba0e5" BorderWidth="0" CellPadding="5" CellSpacing="1" EmptyDataText="No Records Found..."
                                                            HeaderStyle-CssClass="dgHeaderStyle" OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric"
                                                            PagerStyle-HorizontalAlign="left" Width="999px" CssClass="boxbg">
                                                            <Columns>
                                                                <asp:BoundField DataField="Sr. No" HeaderText="Sr. No">
                                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="loccode" HeaderText="Location Code">
                                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="locname" HeaderText="Location Name">
                                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="locaddr" HeaderText="Location Address">
                                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="contactinfo" HeaderText="Contact Information">
                                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="locemail" HeaderText="Contact Email">
                                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" Wrap="False" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <PagerStyle HorizontalAlign="Left" />
                                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <div align="center" style="width:999px">
                                    <asp:Button ID="cmdexcel" runat="server" Text="Excel" OnClick="cmdexcel_Click" />
                                    </div>
                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <br />
        <br />
    </form>
</body>
</html>
