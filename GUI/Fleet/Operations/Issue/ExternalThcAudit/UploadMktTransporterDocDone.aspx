<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="UploadMktTransporterDocDone.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_UploadMktTransporterDocDone" %>

<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        function disableenter() {

        }

    </script>

    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">

            <tr>
                <td>
                    <label class="blackfnt">
                        <b>View Scan Documents				            
                        </b>
                        <hr align="center" size="1" color="#8ba0e5">
                    </label>
                </td>
            </tr>

            <tr>
                <td>
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 39%" valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td valign="top">
                                                        <br />

                                                        <center>
                                                            <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="75%">
                                                                <tr class="bgbluegrey">
                                                                    <td align="left" colspan="5" style="height: 20px;">
                                                                        <label class="blackfnt">
                                                                            <b>Following Documents Are Scanned
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td colspan="5" align="left">
                                                                        <asp:GridView ID="gvSuccess" runat="server" AutoGenerateColumns="false"
                                                                            HeaderStyle-CssClass="dgHeaderStyle" RowStyle-CssClass="dgRowStyle" Width="100%">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Sr. No." DataField="SrNo" />
                                                                                <asp:TemplateField>
                                                                                    <HeaderTemplate>
                                                                                        <label>
                                                                                            External Thc No                                                                            
                                                                                        </label>
                                                                                    </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <label>
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ExternalThcNo")%>
                                                                                        </label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="View Document">
                                                                                    <ItemTemplate>
                                                                                        <asp:HyperLink ID="hylView" runat="server" Text="View" Font-Underline="true" Target="_blank" CssClass="bluefnt" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL")%>'></asp:HyperLink>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                            <RowStyle HorizontalAlign="center" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td colspan="5" align="left">&nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr class="bgbluegrey" id="trFail" runat="server">
                                                                    <td align="left" colspan="5" style="height: 20px;">
                                                                        <label class="blackfnt">
                                                                            <b>Following Documents Fail To Scan
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td colspan="5" align="left">
                                                                        <asp:GridView ID="gvFail" runat="server" AutoGenerateColumns="false" HeaderStyle-CssClass="dgHeaderStyle" RowStyle-CssClass="dgRowStyle" Width="100%">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Sr. No." DataField="SrNo" />
                                                                                <asp:TemplateField>
                                                                                    <HeaderTemplate>
                                                                                        <label>
                                                                                            External Thc No                                                                        
                                                                                        </label>
                                                                                    </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <label>
                                                                                            <%# DataBinder.Eval(Container.DataItem, "ExternalThcNo")%>
                                                                                        </label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField HeaderText="Reason" DataField="Reason" ItemStyle-HorizontalAlign="left" />
                                                                            </Columns>
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                            <RowStyle HorizontalAlign="center" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td colspan="5" align="left">&nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr class="bgbluegrey">
                                                                    <td colspan="5" align="left">
                                                                        <label class="blackfnt">
                                                                            <b>Your Next Step:
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td colspan="5" align="left">
                                                                        <label class="blackfnt">
                                                                            <a href="UploadMktTransporterDoc.aspx">
                                                                                <u>Scan More Documents
                                                                                </u>
                                                                            </a>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </center>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>&nbsp;
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
