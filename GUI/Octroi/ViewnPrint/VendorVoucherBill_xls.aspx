<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorVoucherBill_xls.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorBill_xls" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<div align="center">

<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Vendor Bill Summary</td>
        </tr>    
    </table>
<br /><br />


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
       <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Bill Entry Number :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblbillno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Bill Entry Date : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblbilldate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Vendor Name : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvendorname" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Vendor Bill Number :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvendorbillno" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Vendor Bill Date :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvendorbilldate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Due Date :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblduedate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Contract Amount (+)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblcontractamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Advanced Paid (-)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbladvancepaid" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Other Amount (+)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblotheramount" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Deductions (-)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbldeduction" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Service Tax Charged (+)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblsertaxchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Service Tax Deduction (-)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblservtaxded" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Cess (+)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblcess" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">TDS Deduction (-)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltdsded" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">&nbsp;</td>
            <td class="blackfnt" align="left">&nbsp;</td>
            <td class="blackfnt" align="left">Net Payable</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblnetpay" runat="server"></asp:Label>
            </td>
        </tr>    
    </table>    
    <br /><br />
        


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Vendor Bill Details</td>
        </tr>    
    </table>
    <br /><br />
    
    
    
     <asp:GridView align="center" ID="gvvendorbillsummary" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                ShowFooter="true" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" HeaderStyle-BorderWidth="1"
                OnRowDataBound="gvvendorbillsummary_RowDataBound" HeaderStyle-Wrap="true"
                OnSelectedIndexChanged="gvvendorbillsummary_SelectedIndexChanged" Width="85%">
    <Columns >
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="billno" HeaderText="Document Number" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
        </asp:BoundField>

        <asp:BoundField  DataField="pcamt" HeaderText="Contract Amount (+)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
        </asp:BoundField>


        <asp:BoundField DataField="othamt" HeaderText="Other Amount (+)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
         <asp:BoundField DataField="svctax" HeaderText="Service Tax (+)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
         </asp:BoundField>

        <asp:BoundField DataField="cess" HeaderText="Cess (+)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
        </asp:BoundField>

        <asp:BoundField DataField="advpaid" HeaderText="Advance Paid (-)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="othded" HeaderText="Deductions (-)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="svctaxded" HeaderText="Service Tax Dedn (-)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="tds_rate" HeaderText="TDS Rate" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
         <asp:BoundField DataField="tdsded" HeaderText="TDS Dedcn. (-)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        <asp:BoundField DataField="netpay" HeaderText="Net Payable" >
            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
</Columns>
    
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey"/>
    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
    
</asp:GridView>
<asp:HiddenField ID="grrwocnt" runat="server" />

</div>

</asp:Content>
