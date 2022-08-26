<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Cancel_Manifest.aspx.cs" Inherits="GUI_admin_Exceptions_Operations_Cancel_Manifest" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white" width="75%">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Cancel Manifest</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
            
        </tr>
    </table>
    <br />

    <script src="../../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

 
    <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
        <tr style="background-color: white">
            <td align="center" width="100%">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False" DataKeyNames="MF"
                            DataSourceID="SqlDataSource1" CellSpacing="1"
                            CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="true" PagerStyle-CssClass="pager" PageSize="20" PagerSettings-Mode="NumericFirstLast">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkCancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel this Manifest?');"
                                            CommandName="Delete">Cancel Manifest</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="MF" HeaderText="Manifest #" InsertVisible="false"
                                    ReadOnly="True" SortExpression="BookCode" />
                                <asp:BoundField DataField="MF_Date" HeaderText="Manifest Date" ReadOnly="True"
                                    SortExpression="MF_Date" />
                                <asp:BoundField DataField="MF_Branch" HeaderText="Manifest Branch" ReadOnly="True" SortExpression="DOC_SR_To" />
                                <asp:BoundField DataField="No_Of_Docket_Attached" HeaderText="Dockets Attached Count" ReadOnly="True" SortExpression="Alloted_On" />
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
        DeleteCommand="Exec usp_Manifest_Do_Cancel @Original_MF, @empcd" DeleteCommandType="Text"
        OldValuesParameterFormatString="Original_{0}" ProviderName="System.Data.SqlClient">
        <DeleteParameters>
            <asp:Parameter Name="Original_MF" Type="string" />
            <asp:SessionParameter Name="empcd" Type="string" />
        </DeleteParameters>
    </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    
    <%--SelectCommand="SELECT * FROM [vw_DCR_Series_ForReDeAllocate]"--%>
</asp:Content>
