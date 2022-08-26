<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Device_Master_Edit.aspx.cs" Inherits="Operation_Device_Master_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Master</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/Telecomm/Operation/Master_Page.aspx">Communication Device Master Type</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communicatin Device Master Edit"></asp:Label><br />
    <center>
        <a href="javascript:window.history.go(-1)" title="back">
            <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a></center>
    <center>
        &nbsp;</center>
    <center>
        &nbsp;</center>
        <center>
            <table id="TABLE1" align="center" border="0" cellpadding="0" cellspacing="1" style="width: 80%" class="boxbg">
                <tr>
                    <td align="center" class="bgbluegrey" style="height: 27px">
                        <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Communication
                            Device Master - Edit Existing</span></strong></font></td>
                </tr>
            </table>
        </center>
        <center>
            &nbsp;</center>
        <center>
        <asp:GridView ID="gvDevice_Master" runat="server" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle" AutoGenerateColumns="False" CssClass="blackfnt" BorderColor="#8BA0E5">
            <Columns>
                <asp:HyperLinkField DataTextFormatString="Edit" DataNavigateUrlFormatString="~/GUI/Telecomm/Operation/Device_Master_Add.aspx?id={0}" DataNavigateUrlFields="CDM_Code" DataTextField="CDM_Code">
                <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                    <ControlStyle Font-Underline="True" />
                </asp:HyperLinkField>
                <asp:BoundField HeaderText="Device Code" DataField="CDM_Code"  >
                    <ItemStyle HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField HeaderText="Device Type" DataField="CDM_Type" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Number" DataField="CDM_Number" />
                <asp:BoundField HeaderText="Vendor" DataField="CDM_Vendor" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Assigned to Person" DataField="Name" />
                <asp:BoundField HeaderText="Assigned to Location" DataField="CDM_Location" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CDM_Cust_Ref" HeaderText="Customer Ref No." >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CDM_Bill_Code" HeaderText="Billing Code" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="CDM_Credit_Amt" HeaderText="Credit Amount" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="CDM_Active" HeaderText="Active" />
                <asp:BoundField DataField="StartDt" HeaderText="Service Start Date" />
                <asp:BoundField DataField="EndDt" HeaderText="Service End Date" />
            </Columns>
            <HeaderStyle CssClass="dgHeaderStyle" />
        </asp:GridView>
        </center>
   </asp:Content>
