<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmDocketDetail.aspx.cs"
    Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    function OpenPopupWindow(strDocketNo,strDcksf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            //var strPopupURL = "../Tracking/2.aspx?strDckNo=" + strDocketNo    
            var strPopupURL = "../Tracking_New/TAB_Tracking/Docket/Docket_track.aspx?strDckNo=" + strDocketNo + "&strDcksf=" + strDcksf    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

</head>
<body>
    <br />
    <form id="form1" runat="server">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top" align="left">
                    <img border="0" src="../images/webxpress_logo.gif"></td>
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
        <br />
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a href="FrmMain.aspx"><font class="blklnkund"><b>My WebXPress</b></font></a> <b>&gt;
                    </b><a href="FrmCriteria.aspx"><font class="blklnkund"><b>Track Dockets</b></font></a>
                    <b>&gt; </b><a href="FrmCriteria.aspx"><font class="blklnkund"><b>Query Result</b></font></a>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <div align="left">
            <table border="0" cellspacing="1" cellpadding="5" colspan="2" bgcolor="#ffffff" class="boxbg">
                <tr bgcolor="#ffffff" class="bgbluegrey">
                    <td align="center" style="height: 25px" colspan="3">
                        <font class="blackfnt"><b>You Selected</b></font></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="height: 25px; width: 23%;">
                        <font class="blackfnt"><b>Date Range</b></font></td>
                    <td align="left" style="height: 25px">
                        <font class="blackfnt">
                            <asp:Label ID="lbldaterange" runat="server">
                            </asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 23%">
                        <font class="blackfnt"><b>Region</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblRO" runat="server">
                            </asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 23%; height: 29px;">
                        <font class="blackfnt"><b>Location</b></font>
                    </td>
                    <td align="left" style="height: 29px">
                        <font class="blackfnt">
                            <asp:Label ID="lblLocation" runat="server">
                            </asp:Label>
                        </font>
                    </td>
                </tr>
            </table>
            <asp:TextBox ID="TxtDateRange" runat="server" Width="170px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 405px; position: absolute; top: 122px"></asp:TextBox>
            <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 405px; position: absolute; top: 157px"></asp:TextBox>
            <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
                Style="z-index: 102; left: 405px; position: absolute; top: 193px"></asp:TextBox>
            <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
            <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
            <asp:GridView ID="GrdLoadUnload" OnRowDataBound="GrdLoadUnload_RowDataBound" OnPageIndexChanging="PageIndexChanged_Click"
                PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false"
                HeaderStyle-CssClass="bgbluegrey" runat="server" SelectedIndex="1" EmptyDataText="No Records Found !!!!"
                EmptyDataRowStyle-CssClass="blackfnt" BorderWidth="0" CellSpacing="1" CellPadding="5"
                Width="942px">
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO.">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="True" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Docket No">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "DOCKNO")+"','"+ Convert.ToString(DataBinder.Eval( Container.DataItem,"docksf"))%>')">
                                <font cssclass="Blackfnt">
                                    <%# Convert.ToString(DataBinder.Eval( Container.DataItem,"dockno")) + Convert.ToString(DataBinder.Eval( Container.DataItem,"docksf"))%>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bkg. Location">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lblorgncd" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"orgncd") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bkg. Date">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lblbkgdt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dly. Location">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lbldlyloc" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"REASSIGN_DESTCD") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dly. Date">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lbldlydt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dely_dt") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Consignor">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lblconsignor" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"csgnnm") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Consignee">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lblconsignee" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"csgenm") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delivered">
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lbldelivered" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkt_dly") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" BackColor="White" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
                <EmptyDataRowStyle CssClass="blackfnt" />
            </asp:GridView>
        </div>
        <div align="center" style="width: 10in">
            <br />
            <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="61px" /></div>
    </form>
</body>
</html>
