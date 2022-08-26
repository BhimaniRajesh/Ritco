<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmvoucher_view_printResult.aspx.cs" Inherits="GUI_Finance_voucher_Print_frmvoucher_view_printResult" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="voucher_result" runat="server">
    <br /><br /><br />
    <table border="1">
        <tr>
            <td width="131">&nbsp;</td>
            <td><asp:DataGrid ID="myGrid" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundColumn DataField="tran_date" HeaderText="Transaction Date"></asp:BoundColumn>
                    <asp:BoundColumn DataField="Voucherno" HeaderText="Voucher No"></asp:BoundColumn>
                    <asp:BoundColumn DataField="brcd" HeaderText="Location"></asp:BoundColumn>
                    <asp:TemplateColumn HeaderText="View | Print">
                        <ItemTemplate>
                            <a href=""
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            
            </asp:DataGrid></td>
        </tr>
    </table>
    
    
</asp:Content>
