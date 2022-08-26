<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ContractEditList.aspx.cs" Inherits="GUI_admin_CustomerContract" %>

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
    <%--<u><font class="blackfnt"><b>Docket Entry</b> >> <font class="bluefnt"><b>Edit List</b></font></font></u>--%>
    <br />
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
        <asp:Table ID="Table1" runat="server" HorizontalAlign="Center"  Width="100%" CssClass="blackfnt" >
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left" Width="180px">
				       &nbsp;Customer Code & Name
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>      
        <br /><br />
            <asp:Panel ID="divone" HorizontalAlign="Left" runat="server" Width="90%">
                <asp:LinkButton ID="lnkaddnew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Add New Contract" OnClick="lnkaddnew_Click"></asp:LinkButton>
            </asp:Panel>
       
        <%--GRID VIEW OF DATA--%>
        <asp:GridView align="center" ID="grvcontractlist" runat="server" CellSpacing="1" BorderWidth="0"
            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="10"
            PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
            SelectedRowStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerStyle-Font-Underline="true" PagerStyle-Font-Size="Larger"
            PagerSettings-LastPageText="[Last]" OnRowDataBound="grvcontractlist_RowDataBound" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
             Width="90%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ContractID" SortExpression="tot1">
                    <HeaderStyle Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"contractid") %>
                        <asp:HiddenField ID="hdncontractid" Value='<%# DataBinder.Eval( Container.DataItem,"contractid") %>' runat="server" />
                        <asp:HiddenField ID="hdnstatus" Value='<%# DataBinder.Eval( Container.DataItem,"activeflag") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Start Date">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                     <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "startdate")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="End Date">
                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"enddate") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contract Type">
                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval( Container.DataItem,"contracttype") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkview" CssClass="blackfnt" runat="server" OnClick="lnkdockview_Click">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblstatus" CssClass="blackfnt" Text=' <%# DataBinder.Eval( Container.DataItem,"status") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkedit" CssClass="blackfnt" runat="server" OnClick="lnkcontractedit_Click">Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdeactivate" CssClass="blackfnt" runat="server" OnClick="lnkcontractdeactivate_Click">DeActivate</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdelete" CssClass="redfnt" runat="server">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="blackfnt" BackColor="#8ba0e5"
            Style="width: 90%; display: none;">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell Font-Bold="true" CssClass="blackfnt">No Contract Found</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="white">
                <asp:TableCell ColumnSpan="8" HorizontalAlign="Center" Font-Bold="true" CssClass="redfnt">No Records Found......</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdncustcode" runat="server" />
    </asp:Panel>
</asp:Content>
