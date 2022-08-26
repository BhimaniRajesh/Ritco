<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportList.aspx.cs" Inherits="GUI_admin_AutoEmail_ReportList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopup(SNO)
    {
          window.open("./Autoemail_step2.aspx?SRNO=" + SNO ,"es","menubar=no,toolbar=no,location=no,resizable=no,scrollbars=no,width=600,height=500,status=no,left=60,top=125");
    }
    
    </script>

    <table cellspacing="1" style="width: 8.0in">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Auto E-mail  Select Report Step -2</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
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
    &nbsp;&nbsp;&nbsp; <a href="AutoEmail_Step2.aspx?id=0"><font class="bluefnt"><u>Add ----->
    </u></font></a>
    <br />
    <br />
    <table cellspacing="1" style="width: 8.0in">
        <tr>
            <td align="left" width="15%">
                <table border="0" style="width: 8.0in">
                    <tr>
                        <td style="text-align: center" class="blackfnt">
                            <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" CssClass="boxbg" Style="width: 5.0in" AutoGenerateColumns="false"
                                OnRowCommand="GVRowDEL" DataKeyNames="srno" EmptyDataText="No Records Found...">
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
                                    <asp:TemplateField HeaderText="Report Name" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReportName")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <%--   <asp:BoundField DataField="ReportName" HeaderText="Report Name">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Report Type" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Type")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Type" HeaderText="Type">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>--%>
                                    <asp:BoundField DataField="Freq" HeaderText="Freq.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:HyperLinkField DataNavigateUrlFields="srno" DataNavigateUrlFormatString="AutoEmail_Step2.aspx?id={0}"
                                        DataTextField="srno" DataTextFormatString="- Edit -">
                                        <ItemStyle CssClass="bluelink" BackColor="white" ForeColor="Blue" />
                                        
                                    </asp:HyperLinkField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" Text="X"
                                                OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" Width="10%"
                                            Wrap="False" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="View Status">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" />
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "srno") %>')">
                                                <font class="Blackfnt">View/Edit</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
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
</asp:Content>
