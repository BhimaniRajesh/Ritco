<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="View_acctGroups_step_2.aspx.cs" Inherits="GUI_admin_Accounts_masters_Acctgroup_View_acctGroups_step_2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<asp:UpdatePanel ID="up2" runat="server">
    <ContentTemplate>
        <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                            <tr>
                                <td align="right"><img src="../../../images/loading.gif" alt="" /></td>
                                <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                            </tr>
                        </table>
                        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                            width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                            runat="server">
                            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                left: 50%;" ID="Panel2" runat="server">
                            </asp:Panel>
                        </asp:Panel>
                    </ProgressTemplate>
            </asp:UpdateProgress>
        <br />
        <div align="left" style="width: 10in;">
                    <table border="0" class="boxbg" cellpadding="1" cellspacing="0" width="100%">
                        <tr bgcolor="white">
                            <td>
                                <table id="Table1" runat="server" border="0" cellpadding="0" cellspacing="0" class="boxbg" align="left" width="100%">
                                    <tr id="Tr1" runat="server" bgcolor="white">
                                        <td align="center">
                                            <b><font color="red"><asp:Label ID="lblmsg" runat="server"></asp:Label></font></b>
                                        </td>
                                    </tr>
                                    <tr id="Tr3" runat="server" bgcolor="white">
                                        <td align="left">
                                            <div align="left">
                                                <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                                    Width="100%" 
                                                    FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                                                    EmptyDataText="No Records Found...">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sr.No." HeaderStyle-Font-Bold="true" >
                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" Width="5%"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblsrno" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Group Code">
                                                            <HeaderStyle HorizontalAlign="left" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="20%"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblgroupcode" Text='<%# DataBinder.Eval(Container.DataItem,"GroupCode") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        
                                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Group Description">
                                                            <HeaderStyle HorizontalAlign="left"  BackColor="#d4e0e7" CssClass="blackfnt" />
                                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="50%"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblgroupdesc"  Text='<%# DataBinder.Eval(Container.DataItem,"Groupdesc") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Parent Group">
                                                            <HeaderStyle HorizontalAlign="left"  BackColor="#d4e0e7" CssClass="blackfnt" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="left" BackColor="white" Width="10%"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblparentcode" Text='<%# DataBinder.Eval(Container.DataItem,"ParentCode") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Company Group Code">
                                                            <HeaderStyle HorizontalAlign="left" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="20%"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcompanygroupcode" Text='<%# DataBinder.Eval(Container.DataItem,"Company_Groupcode") %>'
                                                                    runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                     </tr>
                                </table>
                            </td>
                         </tr>
                   </table>         
            </div>     
    </ContentTemplate>
</asp:UpdatePanel>  
</asp:Content>

