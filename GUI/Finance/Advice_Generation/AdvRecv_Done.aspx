<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdvRecv_Done.aspx.cs" Inherits="GUI_finance_advice_AdvRecv_Done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
    function nwOpenViewWindow(url) {
        //window.location=url;
        window.open(url,'myWindow','height=400,width=700,resizable=yes,scrollbars=yes,left=25,top=100');
    }
    function nwOpenPrintWindow(url) {
        window.open(url,'myWindow','height=400,width=700,resizable=yes,scrollbars=yes,left=25,top=100');
    }
</script>
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Advice Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br/><br/>
    <div>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully Accepted :" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <%--<tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Code" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblviewprint" runat="server" Text="View | Print" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <a href="javascript:nwOpenViewWindow('AdvViewPrint.aspx?adviceno=<%= Request.QueryString["AdviceNo"].ToString() %>&printyn=N');"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:nwOpenPrintWindow('AdvViewPrint.aspx?adviceno=<%= Request.QueryString["AdviceNo"].ToString() %>&printyn=Y');"><font class="blackfnt">Print</font></a>
            </td>
        </tr>--%>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="3">
                <asp:GridView ID="dgGeneral" runat="server" AllowPaging="False" AllowSorting="False"
                AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey" Width="100%"
                EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="bgwhite" BorderWidth="0" 
                RowStyle-CssClass="bgwhite" CssClass="boxbg" CellSpacing="1">
                    <Columns>
                        <asp:TemplateField HeaderText="Document Name" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:Label ID="lbldocnmae" runat="server" Text="Debit Advice"></asp:Label> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Advice No" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:Label ID="lbladvno" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AdviceNo")%>'></asp:Label> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="View | Print" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <a href="javascript:nwOpenViewWindow('AdvViewPrint.aspx?adviceno=<%# DataBinder.Eval(Container.DataItem,"AdviceNo") %>&printyn=N');"><font class="blackfnt">View</font></a>
                                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                                <a href="javascript:nwOpenPrintWindow('AdvViewPrint.aspx?adviceno=<%# DataBinder.Eval(Container.DataItem,"AdviceNo") %>&printyn=Y');"><font class="blackfnt">Print</font></a>
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
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Prepare More Advice" CssClass="blackfnt" PostBackUrl="~/GUI/finance/Advice_Generation/advice.aspx"/>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px"><asp:LinkButton ID="lnkStep2" runat="server" Text="Acknowledge Advices" CssClass="blackfnt" PostBackUrl="~/GUI/finance/advice_generation/Adviceacknowledged_step1.aspx" /></td>
        </tr>
    </table>
  </div>
</asp:Content>

