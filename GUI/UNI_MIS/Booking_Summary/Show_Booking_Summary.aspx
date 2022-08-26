<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Booking_Summary.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 11.5in;" align="left" border="0">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Booking Summary Report
                        </b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <table border="0" cellpadding="3" style="width: 5.5in;" align="left" cellspacing="1"
        class="boxbg">
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :
                </label>
            </td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205">
                <label class="blackfnt">
                    Location :</label></td>
            <td style="width: 343">
                &nbsp;
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205; height: 6px;">
                <label class="blackfnt">
                    Ro :</label></td>
            <td style="width: 343; height: 6px;">
                &nbsp;
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <table border="0" style="width: 9.5in;" align="left">
        <tr style="background-color: #FFFFFF" align="left">
            <td align="left">
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5"
                    HeaderStyle-CssClass="bgbluegrey" CellSpacing="1" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    OnRowDataBound="CustomersGridView_RowDataBound" OnPageIndexChanging="pgChange" FooterStyle-BackColor="white"
                    AllowSorting="False" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:BoundField DataField="Sno" ItemStyle-Wrap="true" ItemStyle-BackColor="White">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="20" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="loc" ItemStyle-Wrap="true" ItemStyle-BackColor="White">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="report_loc" ItemStyle-Wrap="true" ItemStyle-BackColor="White">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                            DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=1" ItemStyle-BackColor="white"
                            ControlStyle-BackColor="white" DataTextField="totdkt" />
                        <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                            DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=2" ItemStyle-BackColor="white"
                            DataTextField="Quickdkt" />
                        <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                            DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=3" ItemStyle-BackColor="white"
                            DataTextField="Operdkt" />
                        <asp:HyperLinkField DataNavigateUrlFields="loccode" ControlStyle-Font-Underline="true"
                            DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=4" ItemStyle-BackColor="white"
                            DataTextField="Findkt" />
                        <asp:BoundField DataField="per1" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="per2" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TotalChgWt" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <table border="0" style="width: 9.5in;" align="left">
        <tr align="left">
            <td style="background-color: #ffffff">
                <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                </asp:LinkButton>
            </td>
            <td style="background-color: #ffffff">
                <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                </asp:LinkButton>
            </td>
        </tr>
        <tr align="center" style="background-color: #ffffff">
            <asp:Button class="btncolor" runat="server" ID="Button1" OnClick="Button1_Click" /></tr>
        <tr>
            <td colspan="2" style="background-color: #ffffff" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
