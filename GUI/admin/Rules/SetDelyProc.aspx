<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true"
    CodeFile="SetDelyProc.aspx.cs" Inherits="GUI_admin_SetDelyProc" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_BizType" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_GeneralMaster" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BUT" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_ServiceType" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_GeneralMaster" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="SVCTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_DelyProc" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_GeneralMaster" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="DLYPRC" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="upStockUpdate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Set Delivery Process:</asp:Label>
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
            <table border="0" cellspacing="1" cellpadding="3" width="500px" class="boxbg" id="tblSUCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Dely Proc againts Biz Type & Service Type"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Biz. Type:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboBizType" runat="server" CssClass="input" DataSourceID="MySQLDataSource_BizType"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFVBiz" runat="server" SetFocusOnError="true" ErrorMessage="*" ControlToValidate="cboBizType"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Service Type:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboServiceType" runat="server" CssClass="input" DataSourceID="MySQLDataSource_ServiceType"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFVServ" runat="server" SetFocusOnError="true" ErrorMessage="*" ControlToValidate="cboServiceType"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Delivery Process:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboDlyProc" runat="server" CssClass="input" DataSourceID="MySQLDataSource_DelyProc"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RFVDlyProc" runat="server" SetFocusOnError="true" ErrorMessage="*" ControlToValidate="cboDlyProc"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <tr bgcolor="white">
                    <td align="left" colspan="2">
                        <asp:Button ID="btnSetDelyProc" Text="<<  Set Delivery Process Rule  >>" runat="server" OnClick="SetDelyProc" />
                    </td>
                </tr>                
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
