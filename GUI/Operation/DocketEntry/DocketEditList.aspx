<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DocketEditList.aspx.cs" Inherits="GUI_admin_DocketPrint_DocketList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice);
 }
 function openEdit(choice)
 { 
 
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice,'',winOpts);
 return false;
 }
 
    </script>

    <br />
    <u><font class="blackfnt"><b>Docket Entry</b> >> <font class="bluefnt"><b>Edit List</b></font></font></u>
    <br />
    <br />
    <asp:Panel runat="server" Width="10in">
        <asp:Table runat="server" Width="6in" CellSpacing="1" CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" Font-Bold="true">Rules</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell Width="15px" HorizontalAlign="Center">
                 <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="bullet"><img alt=" src="../../images/clear.gif" width="4" height="4"/></td>
                    </tr>
                 </table>
                </asp:TableCell>
                <asp:TableCell>Docket Not Billed</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell Width="15px" HorizontalAlign="Center">
                 <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="bullet"><img alt=" src="../../images/clear.gif" width="4" height="4"/></td>
                    </tr>
                 </table>
                </asp:TableCell>
                <asp:TableCell>MR Not Generated</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell Width="15px" HorizontalAlign="Center">
                 <table border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="bullet"><img alt=" src="../../images/clear.gif" width="4" height="4"/></td>
                    </tr>
                 </table>
                </asp:TableCell>
                <asp:TableCell>Docket Booking Date must be within Current Financial Year</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <%--      SELECTION CRITERIA--%>
        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1"
            width="70%">
            <tr id="trdockno" runat="server">
                <td align="right" style="width: 50%; display: block;" bgcolor="#ffffff">
                    <font class="blackfnt">
                        <%=dkt_call %>
                        Number : </font>
                </td>
                <td bgcolor="#ffffff" style="width: 50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" CssClass="blackfnt" ID="lbldockno"></asp:Label></font></td>
            </tr>
            <tr id="trdockdt" runat="server">
                <td align="right" style="width: 50%; display: block;" bgcolor="#ffffff">
                    <font class="blackfnt">
                        <%=dkt_call %>
                        Booking Date : </font>
                </td>
                <td bgcolor="#ffffff" style="width: 50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldates"></asp:Label></font></td>
            </tr>
        </table>
        <br />
        <br />
        <%--GRID VIEW OF DATA--%>
        <asp:GridView align="center" ID="grvdocket" runat="server" CellSpacing="1" BorderWidth="0"
            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="10"
            CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" EmptyDataText="No Records Found..."
            Width="90%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="<%=dkt_call %> No.">
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"dockno") %>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="dockdt" HeaderText="Booking Date">
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Origin-Del Location">
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"locroute") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From-To Location" >
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"cityroute") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="paybas" HeaderText="Pay Basis">
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="party" HeaderText="Billing Party">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdockedit" runat="server" OnClick="lnkdockedit_Click">Edit</asp:LinkButton>
                        <asp:HiddenField ID="hdndockno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"dockno") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="boxbg" Style="width: 90%;
            display: none;">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Sr No.</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt"><%=dkt_call %> No.</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Booking Date</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Origin-Del Location</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">From-To Location</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Pay Basis</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Billing Party</asp:TableCell>
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">Edit</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Style="height: 24px;" BackColor="white">
                <asp:TableCell ColumnSpan="8" HorizontalAlign="Center" Font-Bold="true" CssClass="redfnt">No Records Found......</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
