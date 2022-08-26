<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"   CodeFile="AgentBill_ViewPrint.aspx.cs" Inherits="GUI_Octroi_Octroi_Bill_AgentBill_ViewPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">



                                      <%--SUMMARY HEADER LINE--%>
<br /><br />
<div align="center">
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey%>">
            <td class="blackfnt">Agent Bill Summary</td>
        </tr>
    </table>

<br /><br />
                                       <%--SUMMARY TABLE--%>
                                     
                                    
     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Bill Entry Number</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblbillno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Bill date </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblbilldate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Octroi Agent </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblagent" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Agent Bill number</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblagentbillno" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Octroi paid by agent Rs.</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbloctroipaid" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Agent Bill date</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblagentbilldate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Agent service charge</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblagentserchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Service Charge(%)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblserchrgper" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Other Charges</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblothchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Clearance charges</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblclearchrg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Form charges</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblformchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Sundry charges</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblsundrychrg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Total Due </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltotdue" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Due date</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblduedate" runat="server"></asp:Label>
            </td>
        </tr>
    </table>   

<br /><br />
                                      <%--AGENT GRID HEADER LINE--%>

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%" align="center">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt">Agent Bill Details</td>
        </tr>
    </table>
    
    <br />
        
                                      <%--AGENT GRID HEADER LINE--%>

            
    
    <asp:GridView align="center" ID="gvagentbill" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" ShowFooter="true"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvagentbill_SelectedIndexChanged"  Width="85%" OnRowDataBound="gvagentbill_RowDataBound">
    <Columns>
    
        <asp:TemplateField HeaderText="Sr.No.">
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>
        
        <asp:BoundField DataField="dockno" HeaderText="Docket Number" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:BoundField DataField="declval" HeaderText="Declared value" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataField="OCTAMT" HeaderText="Octroi Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="recptno" HeaderText="Octroi receipt no." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="recptdt" HeaderText="Receipt date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

</Columns>
    
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
    
</asp:GridView>
            
            <%--LAST LINE SUMMARY OF DATA GRID--%>
<br />            
<asp:Label ID="lblremark" runat="server" Visible="false"></asp:Label>                   
   <%--  <table bgcolor="#808080" border="0" cellpadding="0" cellspacing="0" class="boxbg" align="center" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="right" style="width:20%">Remark : </td>
            <td class="blackfnt" align="left">
                
            </td>
        </tr>
      </table>--%>
<asp:HiddenField ID="grrwocnt" runat="server" />

</div>


</asp:Content>
