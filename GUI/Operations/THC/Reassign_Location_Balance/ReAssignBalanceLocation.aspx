<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="ReAssignBalanceLocation.aspx.cs" Inherits="GUI_Operations_THC_Reassign_Location_Balance_ReAssignBalanceLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function popuplist(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl;
            confirmWin = window.open(url, "", winOpts);
            return false;
        }
    </script>

    <div align="center">
        <form id="form1">
        <div align="left">
            <asp:UpdatePanel ID="UP1" runat="server"  UpdateMode="Conditional">
                <ContentTemplate>
                    <p align="left">
                        <font class="blackfnt"><b>You Selected</b></font></p>
                    <table border="0" cellpadding="3" cols="1" style="width: 9.5in" bgcolor="#808080"
                        cellspacing="1" align="left" class="boxbg">
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">THC Date</font></div>
                            </td>
                            <td width="343" align="left">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font></div>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td width="205" align="left">
                                <div align="left">
                                    <font class="blackfnt">THC No</font>
                                </div>
                            </td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblDocNo" runat="server" Text="Label"></asp:Label></font></div>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <p align="left">
                        <font class="blackfnt"><b>THC List For Re-Assign Balance Payment Location</b></font></p>
                    <br />
                    <asp:GridView ID="GridTHCList" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                        AllowSorting="true" AllowPaging="false" PageSize="100" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                        EmptyDataText="No Records Found..." OnRowDataBound="GridTHCList_RowDataBound"
                        Style="width: 9.5in">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    THC No</HeaderTemplate>
                                <HeaderStyle CssClass="blckfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <center>
                                        <a href="javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"THCNo") %>','0')">
                                            <%# DataBinder.Eval(Container.DataItem, "THCNo")%>
                                        </a>
                                        <asp:HiddenField ID="hdnTHCNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"THCNo") %>' />
                                        <asp:HiddenField ID="hdnFromModule" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"FromModule") %>' />
                                        <asp:HiddenField ID="hdnIsBTHProposal" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"IsBTHProposal") %>' />
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="THCDT" HeaderText="THC Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vendor" HeaderText="Vendor Name ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Branch" HeaderText="Branch">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Balamtbrcd" HeaderText="Balance Location">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                <HeaderTemplate>
                                    New Balance Location
                                    <br />
                                    <asp:TextBox runat="server" ID="txtbacode" BorderStyle="Groove" MaxLength="15" Width="60px"></asp:TextBox>
                                    <asp:Button ID="btnnewbacode" Text="..." CssClass="blackfnt" runat="server" />
                                </HeaderTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtbacode" BorderStyle="Groove" MaxLength="50" Width="60px" runat="server"></asp:TextBox>
                                    <asp:Button ID="btnbacode" Text="..." CssClass="blackfnt" runat="server" />
                                    <asp:HiddenField ID="hdnfld" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    </div>
                    <br />
                    <asp:HiddenField ID="txtdocketlist" runat="server" />
                    <asp:HiddenField ID="txtdocketlist_count" runat="server" />
                    <div align="left">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" Text="Click Here To Submit" OnClick="btnSubmit_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </form>
    </div>
</asp:Content>
