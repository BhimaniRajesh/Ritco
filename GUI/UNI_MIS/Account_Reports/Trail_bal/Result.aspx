<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Trail_bal_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<%--<asp:GridView Visible="false" align="center" ID="dgDocket" runat="server"  BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false" 
             CssClass="boxbg" 
              AutoGenerateColumns="false"
           
            FooterStyle-CssClass="boxbg" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." >
            <Columns>
            <asp:BoundField DataField="CAT" HeaderText="Opening Debit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="groupdesc_m" HeaderText="Opening Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="groupdesc" HeaderText="Opening Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="acccdesc" HeaderText="Opening Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="opn_DR" HeaderText="Opening Debit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="opn_CR" HeaderText="Opening Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="TR_TRANS_DR" HeaderText="Current Debit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="TR_TRANS_CR" HeaderText="Current Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
            </Columns>
            </asp:GridView>--%>
            
            <table id="Table1" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg">
 <tr>
 <td>

    <br />
    <br />
    <table border="0" HorizontalAlign="left"  CellPadding="3" CellSpacing="1" style="width:5.5in;" Class="boxbg">
    <tr bgcolor="white" class="blackfnt"><td>Date</td><td><asp:Label  runat="server" ID="LBLDATE"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Branch</td><td><asp:Label  runat="server" ID="LBLBRANCH"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Report Type</td><td><asp:Label  runat="server" ID="LBLRPT"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Report Sub Type</td><td><asp:Label  runat="server" ID="LBLSUBRPT"></asp:Label></td></tr></table>
    <br />
    <asp:Table id="TBL_TB" border="0" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
    <br />
    </td>
 </tr>
 
<tr>
 <td><br />
   
       <%-- <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="left">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>--%>
         </td>
 </tr>
 
 </table>
</asp:Content>
