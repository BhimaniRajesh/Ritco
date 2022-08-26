<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Advice_done.aspx.cs" Inherits="GUI_finance_advice_Advice_done" Title="Untitled Page" %>
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
<div>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fund Transfer Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br/><br/>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully Generated :" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Code" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
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
                <%--<asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>--%>
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

