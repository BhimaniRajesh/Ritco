<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Result_GL.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Trail_bal_Result_GL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<table id="Table1" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg">
 <tr>
 <td>

    <br />
    <br />
    <table border="0" id="tblGl" runat="server" HorizontalAlign="left"  cellpadding="3" cellspacing="1" style="width:5.5in;" Class="boxbg">
    <tr bgcolor="white" class="blackfnt"><td>Date</td><td><asp:Label  runat="server" ID="LBLDATE"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Branch</td><td><asp:Label  runat="server" ID="LBLBRANCH"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Report Type</td><td><asp:Label  runat="server" ID="LBLRPT"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Report Sub Type</td><td><asp:Label  runat="server" ID="LBLSUBRPT"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Ledger</td><td><asp:Label  runat="server" ID="lblLdger"></asp:Label></td></tr></table>
    <br />
    </td>
 </tr>
 <tr bgcolor="white">
                        <td colspan="2" align="left">
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
 <tr>
 <td>
    <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server"  BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false" 
             CssClass="boxbg" 
              AutoGenerateColumns="false"
           
            FooterStyle-CssClass="boxbg" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." >
            <Columns>
            <asp:BoundField DataField="Heading" HeaderText="">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                    
                </asp:BoundField>
                 <asp:TemplateField HeaderText="Customer"     ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCust"    runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "party")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white"  Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblACC"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Accdesc")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                <asp:BoundField DataField="VRNO" HeaderText="Voucher No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="VRDATE" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="particular" HeaderText="Particular">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="debit" HeaderText="Debit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt"  />
                </asp:BoundField>
                <asp:BoundField DataField="credit" HeaderText="Credit">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt" />
                </asp:BoundField>
                
                <asp:BoundField DataField="party" HeaderText="Party">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Narration" HeaderText="Narration">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="CHQNO" HeaderText="Cheque No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="CHQDT" HeaderText="Cheque Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
            </Columns>
            </asp:GridView>
    <br />
    </td>
 </tr>
 
<tr bgcolor="white">
                        <td colspan="2" align="left">
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>


</table>
</asp:Content>
