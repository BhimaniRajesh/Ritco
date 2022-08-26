<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManualOctroiMr_viewPrint.aspx.cs"  MasterPageFile="~/GUI/MasterPage.master"  Inherits="GUI_Octroi_Octroi_Bill_ManualOctroiMr_viewPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<p>&nbsp;</p>

        <%--IN CHEQUE GRIDVIEW FIELDS HAS BEEN SET--%>
        
        

                                            <%--SUMMARY HEADER LINE--%>
<div align="center">
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4">Octroi MR Summary</td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">MR No.</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblmrno" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">Date </td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblmrdate" runat="server"></asp:Label>
            </td>
        </tr>
         
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">MR Type </td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblmrtype" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">MR Branch</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblmrbranch" runat="server"></asp:Label>
            </td>
        </tr>
 
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Party</td>
            <td align="left" class="blackfnt" colspan="3">
                <asp:Label ID="lblparty" runat="server"></asp:Label>
            </td>
        </tr>
 
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Booking Branch</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblbookbranch" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">Delivery Branch</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lbldelbranch" runat="server"></asp:Label>
            </td>
        </tr>

    </table>

<br /><br />
                                    <%--GRID VIEW--%>


<asp:GridView align="center" ID="gvagentpayvoucher" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvagentpayvoucher_SelectedIndexChanged"  Width="85%">
    <Columns >
        
        <asp:BoundField DataField="DOCKNO" HeaderText="Docket No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:BoundField DataFormatString="{0:d2}" DataField="OCTAMT" HeaderText="Octroi Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataField="OCT_PERCENTAGE" HeaderText="Octroi (%)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        <asp:BoundField DataField="clearance_chrg" HeaderText="Clearance Charges" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="PROCESSING_PER" HeaderText="Processing(%)" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="PROCESS_CHRG" HeaderText="Processing Chrg." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="COL_OTH" HeaderText="Other Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
<%--Confusion about mr amount--%>
        <asp:BoundField DataField="MRSAMT" HeaderText="MR Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        <asp:BoundField DataField="RECPTNO" HeaderText="Reciept No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        <asp:BoundField DataField="RECPTDT" HeaderText="Reciept Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
 
</Columns>
    
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
    
</asp:GridView>



<br /><br />
                                    <%--COLLECTION DETAILS--%>
     
     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4">Collection Details</td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">MR Amount.</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblmramt" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">TDS Rate(%)</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lbltdsrate" runat="server"></asp:Label>
            </td>
        </tr>
         
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Service Tax(+) </td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblsertax" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">TDS amount (-)</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lbltdsamt" runat="server"></asp:Label>
            </td>
        </tr>
 
        <tr bgcolor="#ffffff">
           <td align="left" class="blackfnt"></td>
            <td align="left" class="blackfnt">
                <asp:Label ID="Label5" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">TDS Type</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lbltdstype" runat="server"></asp:Label>
            </td>
        </tr>
 
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Total </td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lbltotal" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">Other Deduction (-)</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblothded" runat="server"></asp:Label>
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Payment Mode</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblpaymode" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">Other Amount (+)</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblothamt" runat="server"></asp:Label>
            </td>
        </tr>
        
         <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Net Amount</td>
            <td align="left" colspan="3" class="blackfnt">
                <asp:Label ID="lblnetamt" runat="server"></asp:Label>
            </td>
        </tr>
         <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Collection Amount :</td>
            <td align="left" colspan="3" class="blackfnt">
                <asp:Label ID="lblcolamt" runat="server"></asp:Label>
            </td>
        </tr>
         <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Remark</td>
            <td align="left" colspan="3" class="blackfnt">
                <asp:Label ID="lblremark" runat="server"></asp:Label>
            </td>
        </tr>


    </table>
     
     <br /><br />
                             
  
 

</div>
</asp:Content>
