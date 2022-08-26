<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result_Page.aspx.cs" Inherits="Octroi_Agent_Voucher_Result_Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <center>
        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="You Selected"></asp:Label>&nbsp;</center>
    <center>
        &nbsp;</center>
    
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    &nbsp;Agent Bill Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    &nbsp;<asp:Label ID="lblBillType" runat="server" CssClass="blackfnt"></asp:Label></label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblAgeType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    
    <center>
        &nbsp;</center>
    <center>
    <br />
        <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Prepare voucher from following Bill Entries"></asp:Label>&nbsp;</center>
    <center>
        &nbsp;</center>
    <center>
        &nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
    
    <asp:GridView ID="gvAgentVoucher" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
        CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
        HeaderStyle-CssClass="dgHeaderStyle" OnPageIndexChanging="pgChange"
        PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
        PageSize="50">
        <Columns>
            <asp:TemplateField>
            <HeaderTemplate>
                <asp:CheckBox  runat="server" ID="HeaderLevelCheckBox" AutoPostBack="true" OnCheckedChanged="HeaderChecked" />
            </HeaderTemplate>
            <ItemTemplate>
                <asp:CheckBox runat="server" ID="RowLevelCheckBox" />
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bill entry number">
            <ItemTemplate>            
            <asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"ocbillno") %>' runat="server" ID="lblBillEntry"></asp:Label>
             </ItemTemplate>
            </asp:TemplateField>            
            <asp:BoundField HeaderText="Agent Bill Number" DataField="ocagbillno">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Entry date" DataField="entrydt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>            
            <asp:BoundField DataField="Name" HeaderText="Agent Name" />
            <asp:BoundField HeaderText="Octroi amount" DataField="octotaldue">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Due date" DataField="ocduedt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
        <PagerStyle HorizontalAlign="Left" />
        <HeaderStyle CssClass="dgHeaderStyle" />
    </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        &nbsp;&nbsp;</center>
    <center>
        &nbsp;</center>
    <center>
        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" Text="Submit" OnClick="btnSubmit_Click" />
    </center>
</asp:Content>
