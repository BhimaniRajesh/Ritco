<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateGatePassDone.aspx.cs" Inherits="GUI_Operations_GatePass_UpdateGatePassDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script language="javascript" type="text/javascript">

    </script>

    <br />
    <div align="left" style="width: 10in;">
        <asp:Table ID="tblmain" runat="server" CellSpacing="1" CssClass="boxbg" Width="90%">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="2">
             Following Documents has been Updated Successfully
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                    <asp:GridView HorizontalAlign="center" ID="grvdoc" runat="server" BorderWidth="0"
                        CellSpacing="1" ShowHeader="false" AutoGenerateColumns="false" RowStyle-CssClass="bgwhite" ShowFooter="false"
                         CssClass="boxbg" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblgatepassno" Text='<%# DataBinder.Eval(Container.DataItem,"gatepassno") %>' runat="server" CssClass="blackfnt">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="2">
            Your Next Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="Center">
            <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="center" class="bullet">
                                <img alt="clear.gif" src="../../images/clear.gif" width="4" height="4" /></td>
                        </tr>
                    </table>
                </asp:TableCell>
                <asp:TableCell Font-Underline="true">
                <a href="GatePassCriteria.aspx">Click
                        here to Update More GatePass</a>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
</asp:Content>
