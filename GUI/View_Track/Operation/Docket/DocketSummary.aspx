<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocketSummary.aspx.cs" Inherits="GUI_Tracking_ver1_Docket_DocketSummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Summary</title>
    <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
<script language="javascript" type="text/jscript">
    function OpenPopupMF(MF)
    {
//        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//        var strPopupURL = "../../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + MF +",0"
//        winNew = window.open(strPopupURL, "_blank", strWinFeature)
          window.open("../../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + MF +",0","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    }
    function OpenPopupTHC(strTHC,view)
        {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                var strURL = "../../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC +".,0"
                winNew = window.open(strURL,"_blank",strWinFeature)
        }
    function OpenPopupDRS(strDRS,view)
        {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                var strURL = "../../../Operations/DRS/DRS_View_Print.aspx?DRSNo=" + strDRS +",0"
                winNew = window.open(strURL,"_blank",strWinFeature)
        }
    function OpenPopupPRS(strPRS,view)
        {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                var strURL = "../../../Operations/PRS/PRS_View_Print.aspx?DRSNo=" + strPRS +",0"
                winNew = window.open(strURL,"_blank",strWinFeature)
        }
    </script>
</head>

<body>

    
    <form id="form1" runat="server">
        <div>
            <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="8" nowrap align="center">
                        <font class="blackboldfnt">
                            <%=call_dkt%>
                            Summary</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="Left">
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td nowrap align="center">
                                    <font class="blackfnt">
                                        <%=call_dkt%>
                                        No.</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">
                                        <%=call_dkt%>
                                        Date</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">Origin</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">Curr. Loc</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">Next Loc.</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">Destination</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">From </font>
                                </td>
                                <td nowrap align="center">
                                    <font class="blackfnt">To</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldockno"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldockst"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblorgncd"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblcurrloc"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblnextloc"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldestcd"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblfrom"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblto"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr>
                                <td class="bgbluegrey" align="center">
                                    <font class="blackboldfnt">
                                        <%=call_dkt%>
                                        Status</font></td>
                                <td bgcolor="white" align="center">
                                    <asp:Label runat="server" Text="" Font-Bold="true" CssClass="bluefnt" ID="lblstatus"></asp:Label></td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center">
                                    <font class="blackboldfnt">Booking Details</font></td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Service Type | Paybas | Mode</font></td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Pkgsno | Charge Wt. | Act. Wt.</font></td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Cnor - Cnee</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblstype"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblwtdet"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblConrcnee"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="blackboldfnt">Delivery Details</font></td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">EDD | ADD</font></td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Arrived On</font></td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Date of Last Attempt | No. of Attempt </font>
                                </td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Reason | Rec. Person</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblEDDADD"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblarr"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblattempt"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblreason"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table id="TBLCODCOD" runat="server" style="width: 8.0in" border="0" cellpadding="3"
                            cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="blackboldfnt">COD/DOD Details</font></td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">COD/DOD No.</font></td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">COD/DOD Amount To Be collected </font>
                                </td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">COD/DOD Amount Collected</font>
                                </td>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Collection Date </font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblCodecodeno"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblCODAmt"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblCODAmt1"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblCoddt"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="Table1" runat="server" style="width: 8.0in" border="0" cellpadding="3"
                            cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center">
                                    <font class="blackboldfnt">Time Tracking</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td backcolor="white">
                                    <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                        AllowPaging="false" CssClass="boxbg" Style="width: 8.0in" AutoGenerateColumns="false"
                                        EmptyDataText="No Records Found...">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                                <ItemTemplate>
                                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                        runat="server">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="blackfnt" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CurLoc" HeaderText="Curr. Loc">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NextLoc" HeaderText="Next Loc">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ArrvDt" HeaderText="Arrv. Dt.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DeptDt" HeaderText="Dept. Dt.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="LS" HeaderText="LS">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <%--<asp:BoundField DataField="MF" HeaderText="MF">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="MF">
                                                <HeaderStyle CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" />
                                                <ItemTemplate>
                                                    <a href="JavaScript:OpenPopupMF('<%#DataBinder.Eval(Container.DataItem, "MF") %>',0)">
                                                        <font class="Blackfnt">
                                                            <%#DataBinder.Eval(Container.DataItem, "MF")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="THC" HeaderText="THC">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="THC">
                                                <HeaderStyle CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" />
                                                <ItemTemplate>
                                                    <a href="JavaScript:OpenPopupTHC('<%#DataBinder.Eval(Container.DataItem, "THC") %>')">
                                                        <font class="Blackfnt">
                                                            <%#DataBinder.Eval(Container.DataItem, "THC")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="THCveh" HeaderText="THC Veh">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <%--<asp:BoundField DataField="PRS" HeaderText="PRS">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="PRS">
                                                <HeaderStyle CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" />
                                                <ItemTemplate>
                                                    <a href="JavaScript:OpenPopupPRS('<%#DataBinder.Eval(Container.DataItem, "PRS") %>')">
                                                        <font class="Blackfnt">
                                                            <%#DataBinder.Eval(Container.DataItem, "PRS")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="DRS" HeaderText="DRS">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="DRS">
                                                <HeaderStyle CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" />
                                                <ItemTemplate>
                                                    <a href="JavaScript:OpenPopupDRS('<%#DataBinder.Eval(Container.DataItem, "DRS") %>')">
                                                        <font class="Blackfnt">
                                                            <%#DataBinder.Eval(Container.DataItem, "DRS")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DRSVeh" HeaderText="DRS Veh">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                        </Columns>
                                        <RowStyle />
                                        <HeaderStyle CssClass="bgbluegrey" />
                                        <FooterStyle CssClass="boxbg" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
