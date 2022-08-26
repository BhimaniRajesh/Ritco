<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCrossingVendorContract.aspx.cs"
    Inherits="GUI_admin_CrossingVendorMaster_ViewCrossingVendorContract" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Crossing Contract View</title>
     <link href="../../images/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellspacing="1" class="boxbg" style="width: 8in">
             <tr bgcolor="white">
                    <td width="60%" valign="top">
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                    </tr>
             <tr class="bgwhite" >
                    <td class="blackfnt" colspan="2" align="center">
                       <b>Crossing Vendor Contract</b> 
                    </td>
                </tr>
                <tr class="bgwhite" >
                    <td class="blackfnt" colspan="2">
                        Vendor Code :
                        <asp:Label ID="lblVendorCode" runat="server" ></asp:Label>
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td class="blackfnt" colspan="2">
                        Vendor Name :<asp:Label ID="lblVendorName" runat="server" ></asp:Label>
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td class="blackfnt" colspan="2">
                        Contract ID :<asp:Label ID="lblContractID" runat="server" ></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" align="left" colspan="2">
                        <asp:GridView CssClass="boxbg" runat="server" ID="grvcity" CellSpacing="1" style="width: 8in"
                            AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0" FooterStyle-CssClass="boxbg"
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]" OnRowDataBound="grvcity_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Origin
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbllocation" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Origin") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Dest.City
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDestcity" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DestCity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Rate Type
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRatetype" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"RateType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Rate
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRate" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Rate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Door Dely. Charges
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDoorDeliveryChrg" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"doordeliverycharge") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
