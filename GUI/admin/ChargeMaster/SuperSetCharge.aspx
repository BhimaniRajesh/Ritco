<%@ Page Language="C#" AutoEventWireup="true" Trace="false" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="SuperSetCharge.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_DText" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cont1" runat="server">

    <script language="javascript" type="text/javascript">
        function alterDisplay(txtid,lblid)
        {
            var txtchargename=document.getElementById(txtid);
            var lblchargename=document.getElementById(lblid);

            if(txtchargename.style.display=='none')
               {
                    txtchargename.style.display="block";
                    lblchargename.style.display="none";
                    txtchargename.focus();
                    txtchargename.select();
               }
            else
            {
                txtchargename.style.display="none";
                lblchargename.style.display="block";
                lblchargename.innerText=txtchargename.value;
            }
           
        }
    </script>

    <br />
    <br />
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Panel Width="10in" runat="server">
                <asp:Table ID="Table1" runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="2">Charges Master</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trlist" runat="server">
                        <asp:TableCell Width="350px">
                            <asp:Label ID="lbllistname" runat="server" CssClass="blackfnt"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList ID="ddllist" runat="server" DataValueField="codeid" DataTextField="codedesc"
                                AutoPostBack="true" CssClass="blackfnt" OnSelectedIndexChanged="ddllist_SelectedIndexChanged">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trgrid" runat="server">
                        <asp:TableCell>
                            <asp:GridView ID="grvcharges" runat="server" BorderWidth="0" CellSpacing="1" CellPadding="2"
                                AllowSorting="true" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                AutoGenerateColumns="false" HeaderStyle-Wrap="false" OnRowDataBound="grvcharges_RowDataBound"
                                EmptyDataText="No Records Found...">
                                <Columns>
                                    <asp:TemplateField HeaderText="Charge Name">
                                        <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblchargename" Text='<%# DataBinder.Eval(Container.DataItem,"chargename") %>'
                                                runat="server" CssClass="blackfnt"></asp:Label>
                                            <asp:Label ID="lblfixed" runat="server" CssClass="redfnt"></asp:Label>
                                            <asp:HiddenField ID="hdnchargecode" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode") %>'
                                                runat="server" />
                                            <asp:TextBox ID="txtchargename" Style="display: none; background-color: Yellow;"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"chargename") %>' Width="520px"
                                                MaxLength="50" runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Operator">
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Width="200px" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddloperator" CssClass="blackfnt" runat="server">
                                                <asp:ListItem Value="+">Add</asp:ListItem>
                                                <asp:ListItem Value="-">Subtract</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vary by Location">
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Width="100px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkvarybyloc" runat="server" />
                                            <asp:HiddenField ID="hdnvarybyloc" Value='<%# DataBinder.Eval(Container.DataItem,"varybyloc") %>'
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="At Booking Time">
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Width="100px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkbooktimeflag" runat="server" />
                                            <asp:HiddenField ID="hdnbooktimeflag" Value='<%# DataBinder.Eval(Container.DataItem,"booktimeflag") %>'
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="At Delivery Time">
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Width="100px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkdeltimeflag" runat="server" />
                                            <asp:HiddenField ID="hdndeltimeflag" Value='<%# DataBinder.Eval(Container.DataItem,"deltimeflag") %>'
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active Flag">
                                        <ItemStyle BackColor="White" HorizontalAlign="Center" Width="100px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkactiveflag" runat="server" />
                                            <asp:HiddenField ID="hdnactiveflag" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag") %>'
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trsubmit" runat="server">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnsubmit_Click" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:HiddenField ID="hdnbasedon" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
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
