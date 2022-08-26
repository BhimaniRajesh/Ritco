<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Manual_MR_2.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

function check(roww,btnAdd)
{

}
        function ViewPrint(arg1,arg2) 
        { 
        window.open("mr_summ_popup.aspx?mrsno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Octroi MR </b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 60%"
        align="left">
        <tr class="bgbluegrey">
            <td colspan="4" align="center" style="height: 21px">
                <asp:Label ID="lblQry" CssClass="bluefnt" Font-Bold="True" runat="server">Following Document has Successfully Generated/Updated</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td>
                <font class="blackfnt">Document Name</font></td>
            <td colspan="2">
                <font class="blackfnt">
                    <p align="left">
                        <font class="blackfnt">Document No.</font></p>
                </font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td>
                <font class="blackfnt">Payment Voucher </font>
            </td>
            <td>
                <asp:GridView ID="gv_1" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                    CssClass="boxbg" BorderWidth="0" CellPadding="5" CellSpacing="1" EmptyDataText="No Records Found..."
                    HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                    PageSize="30" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="mrn" HeaderText="MR. No">
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="View" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <label class="blackfnt">
                                  <a href="Javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "mrn")%>',0)">View </a>
                                </label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="View" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                            <ItemTemplate>
                                <label class="blackfnt">
                                  <%--  <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"mr_summ_popup.aspx?mrsno="+DataBinder.Eval(Container.DataItem, "mrn")+"&printyn=1"%>'
                                        Text='Print' ID="Hyperlink3" />--%>
                                        <a href="Javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "mrn")%>',1)">Print </a>
                                </label>
                            </ItemTemplate>
                        </asp:TemplateField>
                         
                    </Columns>
                    <PagerStyle HorizontalAlign="Left" />
                    <HeaderStyle CssClass="dgHeaderStyle" />
                </asp:GridView>
                <%-- <asp:Label ID="Label1" runat="server" CssClass="blackfnt"> </asp:Label></td>
            <td>
                <asp:LinkButton ID="ln1" Text="View" CssClass="bluefnt" Font-Bold="true" Font-Underline="true"
                    OnClick="view" runat="server"></asp:LinkButton>
                |
                <asp:LinkButton ID="ln2" Text=" Print" CssClass="bluefnt" Font-Bold="true" Font-Underline="true"
                    OnClick="print" runat="server"></asp:LinkButton>--%>
            </td>
        </tr>
        <%--  <tr bgcolor="white">
            <td colspan="4">
               
            </td>
        </tr>--%>
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
    <a href="../octroi_menu2.aspx"><font class="blklnkund">Return To Main Menu</font></a>
</asp:Content>
