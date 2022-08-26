<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LeaveMasterList.aspx.cs" Inherits="GUI_HR_Payroll_Master_LeaveMasterList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

    </script>

    <br />
    <div align="center">
        <asp:GridView ID="GridLeaveType" Style="width: 9.0in" ShowFooter="True" EmptyDataText="No Records Found....."
            PagerStyle-Mode="NumericPages" AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey" DataKeyNames="LEAVE_NAME"
            BackColor="White" runat="server" CellSpacing="1" SelectedIndex="1" OnRowCommand="GridLeaveType_RowCommand" >
           
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:HyperLink NavigateUrl='<% #"LeaveMasterAdd.aspx?Code=" + 0 +",A" %>' ID="linkAdd" runat="server" Text="Add" BorderStyle="Groove" ></asp:HyperLink>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LEAVE_NAME" HeaderText="Leave Code" ItemStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="false" />
                <%--<asp:TemplateField HeaderText="Code">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                         <asp:Label ID="lblCode" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LEAVE_NAME") %>'>
                         </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Description">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                         <asp:Label ID="lblDesc" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LEAVE_DESC") %>'>
                         </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Affects Salary">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                         <asp:Label ID="lblAffectSalary" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AFFECT_SALARY") %>'>
                         </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Carry Over">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblCarryOver" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CARRY_OVER") %>'>
                         </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Carry Over Limit">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblCarryOverLimit" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CARRY_OVER_LIMIT") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                     </asp:TemplateField>
                    <%-- <asp:HyperLinkField DataNavigateUrlFields="Level_No" DataNavigateUrlFormatString="../../../GUI/admin/HierarchyMaster/HierarchyMaster.aspx?editLevelNo={0}"
                                    DataTextField="Level_No" DataTextFormatString="--Edit--" HeaderStyle-CssClass="bgbluegrey">
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>--%>
                    <asp:TemplateField HeaderText="">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:HyperLink NavigateUrl='<% #"LeaveMasterAdd.aspx?Code=" + DataBinder.Eval(Container.DataItem, "LEAVE_NAME")+ ",E" %>' ID="linkEdit" runat="server" Text="Edit" BorderStyle="Groove" ></asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                     </asp:TemplateField>
                     
                     
                                <asp:TemplateField>
                                <ItemTemplate>
                                <asp:LinkButton ID="DeleteButton" runat="server"  CausesValidation="False" BorderStyle="Groove"
                                Text="Delete" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                </asp:LinkButton>
                                </ItemTemplate>
                                </asp:TemplateField>
                     
                     
               
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
