<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PODPFM_track.aspx.cs" Inherits="GUI_View_Track_Operation_Docket_PODPFM_track" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>POD/PFM Track</title>
    <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
        <script language="javascript" type="text/javascript">
    function topWindowPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
                           var client="<%=Session["Client"]%>"
           // var strPopupURL1 = "../../../../GUI/Operations/FM/FMDocuments/"+client+"/" + strDocketNo1 
            var strPopupURL1 = "../../../../GUI/Operations/FM/ViewFMScannedDocument.aspx?DocName=" + strDocketNo1     
                       winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
            
        }
        </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 8.0in; " border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td nowrap align="center">
                        <font class="blackboldfnt">
                            <%=call_dkt%>
                            POD/PFM Track</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
                    <%-- <a href="javascript:topWindowPOD('<%=DocumentName%>')" title="View POD"><u>--%>
                     <asp:Label ID="lbldockst" runat="server" Width="142px" Font-Bold="true" CssClass="bluefnt"></asp:Label>
                    <%--<asp:Label runat="server" Text="No POD Uploaded" Font-Bold="true" CssClass="bluefnt" ID="lbldockst"></asp:Label>
                    </u></a>--%>
                    </td>
                </tr>
                 <tr bgcolor="white">
                    <td  style="height:20;" align="center">
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
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
                                <asp:BoundField DataField="FM_no" HeaderText="PFM No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Manual_fm_no" HeaderText="Manual PFM No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FM_Date" HeaderText="PFM Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FM_Entrydt" HeaderText="PFM Entry Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FWDTO" HeaderText="FWD To">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FromLoc" HeaderText="From Loc.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ToLoc" HeaderText="To Loc.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ACk" HeaderText="Acknowledged">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ACKDT" HeaderText="Acknowledged Date">
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
        </div>
    </form>
</body>
</html>
