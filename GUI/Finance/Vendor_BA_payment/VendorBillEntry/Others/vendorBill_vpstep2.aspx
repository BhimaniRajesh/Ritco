<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorBill_vpstep2.aspx.cs" Inherits="VendorPayment_new_vendorBill_vpstep2" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">

function OpenWindow(reppara,strGenerateBillNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "vendorbill_xls_2.aspx?reppara=" + reppara +"&strGenerateBillNo="+strGenerateBillNo    
            //var strPopupURL = "tckdcktpp.aspx?SessEmpCode=" + '<%=Session["empcd"] %>' + "&SessEmpName=" + '<%=Session["cstnm"] %>' + "&strDckNo=" + strDocketNo + "&Destination=" + strDestination 
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
</script>

    <div>
    
    <asp:GridView align="center" ID="THCdata" runat="server" BorderWidth="1px" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="True" AllowPaging="True" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="White" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="False"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" Width="723px">
<Columns >

<asp:TemplateField HeaderText="SRNo.">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
<ItemTemplate>
<asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
</asp:Label>
</ItemTemplate>
</asp:TemplateField>
            
            
            
                <asp:TemplateField HeaderText="Bill Entry No.">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('0','<%#DataBinder.Eval(Container.DataItem, "BillNo") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "BillNo")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
            
            
            



<asp:BoundField DataField="Billdt" HeaderText="Bill Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="brcd" HeaderText="Bill Location" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="vendorName" HeaderText="Vendor Name" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="duedt" HeaderText="Due Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="netamt" HeaderText="Net Amount" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

    <asp:HyperLinkField NavigateUrl="~/query.aspx" Text="Print" />



</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
    
    </div>
</asp:Content>
