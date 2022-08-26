<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_OUTSTD_BILL_MR_result" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <p align="center">
        <label class="blackfnt">
            <b>You Selected </b>
        </label>
    </p>
    <%--<center>--%>
    <table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205; height: 15px;">
                <label class="blackfnt">
                    RO :</label></td>
            <td style="width: 343; height: 15px;">
                &nbsp;
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
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
                        Customer Code :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
         <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Report Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
    </table>
    <br />
    <asp:Table id="TBL_MonthlySales" border="0" HorizontalAlign="center" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
   <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 
        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
        <Columns>
           <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
          <asp:BoundField  DataField="loccode" HeaderText="Customer Code">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="locname" HeaderText="Customer Name">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="fromASon" HeaderText="Outstanding as on From Date">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
           
             <asp:BoundField  DataField="billgenamt" HeaderText="Billing During the Period">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Recvamt" HeaderText="Amt Received During the Period">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="ToASon" HeaderText="Outstanding as on To Date">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="On_AC_balance" HeaderText="On Acc. Balance ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
           
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
    </asp:GridView>
    <br />
    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
