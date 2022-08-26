<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="GUI_Operations_LoadingSheet_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<asp:TextBox ID="CustomerSearch" runat="server"></asp:TextBox>&nbsp;
        <asp:button ID="SearchButton" runat="server" Text="Search" />
            Implementing the UpdateProgress, we can now provide the user feedback.<br />
    NOTE: because this is likely a quick operation, click the button to simulate a 3
    second delay to show what it would look like.&nbsp;<br />
        <br />
         <asp:UpdateProgress ID="ProgressIndicator" runat="server">
        <ProgressTemplate>
            <div id="progressArea">
                Loading the data, please wait... <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
            </div>
        </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:Button ID="SortChange" runat="server" OnClick="ChangeSort" Text="Change Sort" />
        <br />
        <asp:UpdatePanel ID="UpdateGrid" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="NWindDb" PageSize="5">
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="SortChange" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="NWindDb" runat="server" ConnectionString="Data Source=.;Initial Catalog=webxpressfornet;UID=sa;pwd=sa" 
            SelectCommand="SELECT codeid, codedesc from webx_master_general">
        </asp:SqlDataSource>
</asp:Content>

