<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Track_POD.aspx.cs" Inherits="GUI_Tracking_Track_POD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
       <link href="../images/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript">
    function ViewPrint(arg1,arg2)
{
window.open("../Operations/PFM/pfm_print.aspx?strPFMNo=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
}

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </center>
                        <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2"
                         HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false" PagerStyle-HorizontalAlign="Center"
                            CssClass="boxbg" FooterStyle-CssClass="boxbg" Width="9.0in" PagerSettings-Mode="NumericFirstLast"
                            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found..." >
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <ItemTemplate>
                                        <asp:Label  CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                              <%--  <asp:TemplateField HeaderText="PFM No" ItemStyle-HorizontalAlign="Center"  HeaderStyle-HorizontalAlign="center" HeaderStyle-CssClass="blackfnt" 
                                    ItemStyle-BackColor="white">
                                    <ItemTemplate  >
                                        <label  class="blackfnt">
                                            <asp:HyperLink  runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='#'
                                                Text='<%# DataBinder.Eval( Container.DataItem,"fm_no") %>' ID="Hyperlink1">
                                            </asp:HyperLink>
                                        </label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                 <asp:TemplateField HeaderText="PFM No." >
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="120" />
                                <ItemStyle CssClass="bluefnt" BackColor="white" />
                                <ItemTemplate>
                                <a href="JavaScript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "fm_no") %>',0)">
                                <font  CssClass="bluefnt"><u>
<%#DataBinder.Eval(Container.DataItem, "fm_no")%></u></font>
</a>

                                    <%--<label class="bluefnt">
                                        <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"~/GUI/Tracking/FrmMenifestView.aspx?tcno=" +DataBinder.Eval(Container.DataItem, "tcno")%>'
                                            Text='<%#DataBinder.Eval(Container.DataItem, "tcno")%>' ID="Hyperlink3" />
                                    </label>--%>
                                </ItemTemplate>
                                <ItemStyle CssClass="bluefnt"  HorizontalAlign="Center" />
                            </asp:TemplateField>
                               <%-- <asp:HyperLinkField Text="PFM" HeaderText="PFMNO" />
                                <asp:BoundField DataField="fm_no" HeaderText="PFM No">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="fmdt" HeaderText="PFM Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="fromloc" HeaderText="From">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="toLoc" HeaderText="TO">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                
                                 </Columns>
                            <RowStyle BackColor="white" />
                            <PagerStyle HorizontalAlign="Center" BackColor="white" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
    </div>
    </form>
</body>
</html>
