<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Device_Type_Edit.aspx.cs" Inherits="Operation_Device_Type_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Master</asp:HyperLink>
    &nbsp;&gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Operation/Master_Page.aspx">Communication Master Type</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communication Device Type Master Edit"></asp:Label><br />
    <center>
            <a href="javascript:window.history.go(-1)" title="back">
                <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a></center>
    <center>
        &nbsp;</center>
    <center>
        &nbsp;</center>
        <center>
            <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 80%" class="boxbg">
                <tr>
                    <td align="center" class="bgbluegrey" style="height: 27px">
                        <font class="blackfnt"><strong>Communication Device Type Master - Edit Existing</strong></font></td>
                </tr>
            </table>
        </center>
        <center>
            &nbsp;</center>
        <center>
        <asp:GridView ID="gvDevice_Master" runat="server" BorderWidth="1px" HeaderStyle-CssClass="dgHeaderStyle" AutoGenerateColumns="False" CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="40%">
            <Columns>
                <asp:HyperLinkField DataTextFormatString="- Edit -" DataNavigateUrlFormatString="~/GUI/Telecomm/Operation/Device_Type_Add.aspx?id={0}" DataNavigateUrlFields="CDT_Code" DataTextField="CDT_Code">
                <ItemStyle CssClass="bluelink" ForeColor="Blue" Font-Underline="True" HorizontalAlign="Center" />                    
                    <ControlStyle Font-Underline="True" />
                </asp:HyperLinkField>
                <asp:BoundField HeaderText="Device Code" DataField="CDT_Code" />
                <asp:BoundField HeaderText="Device Type" DataField="CDT_Desc" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>                
            </Columns>
            <HeaderStyle CssClass="dgHeaderStyle" />
        </asp:GridView>
        </center>
    </asp:Content>
