<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HierarchyList.aspx.cs" Inherits="GUI_admin_HierarchyMaster_HierarchyList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <div>
    
    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Hierarchy Master" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
        <%--<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../../images/back.gif" /></a>
                    </td>
                </tr>
            </table>--%>
            <br />	
	  
	  <table cellspacing="1" style="width: 70%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 21px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="addnew" runat="server" CssClass="bluefnt" Font-Bold="true"
                                PostBackUrl="../../../GUI/admin/HierarchyMaster/HierarchyMaster.aspx" Text="Add New Hierarchy Level"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <br />
	  <div align="center">
	  <asp:GridView ID="HierarchyList" runat="server" AllowPaging="True" AllowSorting="True" 
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="blackfnt" DataKeyNames="Level_No" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="bgbluegrey" PagerSettings-Mode="Numeric" 
                            PagerStyle-HorizontalAlign="left" PageSize="50" OnPageIndexChanging="pgChange" Width="50%">
                            
                            <Columns>
                                
                                <asp:BoundField DataField="Level_No" HeaderText="Level No"  HeaderStyle-CssClass="bgbluegrey"/>
                                <asp:BoundField DataField="Level_Type" HeaderText="Level Type" HeaderStyle-CssClass="bgbluegrey">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:HyperLinkField DataNavigateUrlFields="Level_No" DataNavigateUrlFormatString="../../../GUI/admin/HierarchyMaster/HierarchyMaster.aspx?editLevelNo={0}"
                                    DataTextField="Level_No" DataTextFormatString="--Edit--" HeaderStyle-CssClass="bgbluegrey">
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                                
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        </div>
    </div>
    </asp:Content>
