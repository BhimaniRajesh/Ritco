<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_CustomerMaster_ListAll" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div style="width: 10in">
        <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table border="0" align="left" align="center" cellpadding="0" cellspacing="0" style="width: 100%;
                        height: 228px">
                        <tr>
                            <td style="height: 1px">
                                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a href="">
                                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href=""><font
                                        class="blklnkund"><strong>Business Partners</strong></font></a> <font class="bluefnt">
                                            <strong>&gt; Employee Master</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue">
                                <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                        </tr>
                        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>
                        <tr>
                            <td align="right" style="height: 3px">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a></td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 392px">
                                <br />
                                <table border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <font class="blackfnt"><b>Employee List : &nbsp;</b></font></td>
                                        <td width="100">
                                            <font class="blackfnt">All</font></td>
											<td width="100">
                                             <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">Download</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <table border="0" cellpadding="0" cellspacing="1" align="center" style="width: 783px">
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AllowSorting="true"
                                                        AutoGenerateColumns="false" BorderColor="#8ba0e5" BorderWidth="1" CellPadding="5"
                                                        CellSpacing="1" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle"
                                                        OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                                                        PageSize="30" Width="100%" CssClass="blackfnt">
                                                        <Columns>
                                                            <asp:BoundField DataField="Sr. No" HeaderText="Sr. No">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="EMPID" HeaderText="Employee Code">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                                  <asp:BoundField DataField="UserID" HeaderText="User Id">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="NAME" HeaderText="Employee Name">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BRANCHCODE" HeaderText="Location">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VirtulaLocation" HeaderText="Virtula Location">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Edit" HeaderStyle-Font-Bold="true">
                                                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemStyle CssClass="blackfnt" />
                                                                <ItemTemplate >
                                                                    <label class="blackfnt">
                                                                        <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"Employee_Edit.aspx?para1=2&eno="+DataBinder.Eval(Container.DataItem, "EMPID")+"&enm="+DataBinder.Eval(Container.DataItem, "NAME")%>'
                                                                             Text='Edit' ID="Hyperlink3" />
                                                                    </label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Left" />
                                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        </div>
</asp:Content>
