<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="sfm_funnel_report_loc_wise3.aspx.cs" Inherits="REPORT_sfm_funnel_report_loc_wise3"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "pros_reg_detail.aspx?prospectcode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
    </script>

    <table style="width: 100%">
        <tr>
            <td align="left" colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-Location Wise Report" CssClass="blackfnt"
                    Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img border="0" src="../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="left">
        <table border="0" cellpadding="3" colspan="2" width="55%" bgcolor="#ffffff" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#ffffff">
                <td align="left" width="45%">
                    <font class="blackfnt"><b>Location</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lbllocation" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="30%">
                    <font class="blackfnt"><b>Prospect Type</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblProspectType" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="30%">
                    <font class="blackfnt"><b>Prospects</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblProspect" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="30%">
                    <font class="blackfnt"><b>Value</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblValue" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="42%">
                    <font class="blackfnt"><b>Date Selection</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblDate" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GridFunnle_Location_2" runat="server" align="center" BorderWidth="1"
            CellPadding="2" HeaderStyle-CssClass="bgbluegrey" CssClass="boxbg" BackColor="white"
            FooterStyle-CssClass="boxbg" AllowPaging="false" PageSize="100" OnPageIndexChanging="pgChange"
            AllowSorting="False" AutoGenerateColumns="false" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                    <ItemStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Prospect" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" Font-Bold="true" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "prospectcode") %>')">
                            <%#DataBinder.Eval(Container.DataItem, "Prospect")%>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Call Made" HeaderStyle-Font-Bold="true">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="120" />
                    <ItemStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <label class="blackfnt">
                            <%--<asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"sfm_funnel_report_loc_wise4.aspx?pro=" +DataBinder.Eval(Container.DataItem, "prospect")+"&loccode="DataBinder.Eval(Container.DataItem, "location")+""%>' Text= '<%#DataBinder.Eval(Container.DataItem, "callmade")%>' ID="Hyperlink3"/>--%>
                            <%--<asp:LinkButton ID="lnk1" runat="server" PostBackUrl='<%#"sfm_funnel_report_loc_wise4.aspx?pro=" +DataBinder.Eval(Container.DataItem, "prospectCode")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode")+"&calltype=" +DataBinder.Eval(Container.DataItem, "AcctCategory") + "&fromdt=" +fromdt + "&todt=" +todt +"&value="+DataBinder.Eval(Container.DataItem, "valpmonth")+"&callmade="+DataBinder.Eval(Container.DataItem, "callmade")+"&entryby="+DataBinder.Eval(Container.DataItem, "entryby")%>' Text='<%#DataBinder.Eval(Container.DataItem, "callmade")%>'></asp:LinkButton>--%>
                            <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"sfm_funnel_report_loc_wise4.aspx?pro=" +DataBinder.Eval(Container.DataItem, "prospectCode")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode")+"&calltype=" +calltype + "&fromdt=" +fromdt + "&todt=" +todt +"&callmade="+DataBinder.Eval(Container.DataItem, "callmade")+"&entryby="+DataBinder.Eval(Container.DataItem, "entryby")%>'
                                Text='<%#DataBinder.Eval(Container.DataItem, "callmade")%>' ID="Hyperlink3" />
                        </label>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:BoundField DataField="valpmonth" HeaderText="Order Value" HeaderStyle-CssClass="blackfnt"
                    ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                    HeaderStyle-Font-Bold="true" />--%>
                <asp:BoundField DataField="entryby" HeaderText="Sales Person" HeaderStyle-CssClass="blackfnt"
                    ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                    HeaderStyle-Font-Bold="true" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
