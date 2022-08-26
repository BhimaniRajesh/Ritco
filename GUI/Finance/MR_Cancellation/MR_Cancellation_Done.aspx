<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MR_Cancellation_Done.aspx.cs" Inherits="GUI_finance_advice_AdvRecv_Done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
    function nwOpenViewWindow(url) {
        //window.location=url;
        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
    function nwOpenPrintWindow(url) {
        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
    }
</script>
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br/><br/>
    <div>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="3">
                <asp:GridView ID="dgGeneral" runat="server" AllowPaging="False" AllowSorting="False"
                AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey" Width="100%"
                EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="bgwhite" BorderWidth="0" 
                RowStyle-CssClass="bgwhite" CssClass="boxbg" CellSpacing="1">
                    <Columns>
                        <asp:TemplateField HeaderText="Document Name" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:Label ID="lbldocnmae" runat="server" Text="Document No."></asp:Label> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Document No" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:Label ID="lblbillmrno" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BillMrNO")%>'></asp:Label> 
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Cancel More MR" CssClass="blackfnt" PostBackUrl="~/GUI/Finance/MR_Cancellation/MR_Cancellation_step_1.aspx"/>
            </td>
        </tr>
    </table>
  </div>
</asp:Content>

