<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RouteMasterXls.aspx.cs" Inherits="GUI_Fleet_TripRouteMaster_RouteMasterXls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Repeater runat="server" ID="Repeater1" OnItemDataBound="Repeater1_ItemDataBound">
            <HeaderTemplate>
            </HeaderTemplate>
            <ItemTemplate>
                <table width="100%" class="boxbg">
                    <tr class="bgwhite">
                        <td width="15%">
                            <b>Route Code</b>
                        </td>
                        <td width="30%">
                            <asp:Label ID="lblRutcd" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RUTCD")%>'></asp:Label>
                        </td>
                        <td width="15%">
                            <b>Route Descripation</b>
                        </td>
                        <td colspan="3" width="40%">
                            <%# DataBinder.Eval(Container.DataItem, "RUTDESC")%>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <b>Route Mode</b>
                        </td>
                        <td>
                            <%# DataBinder.Eval(Container.DataItem, "ROUTEMODE")%>
                        </td>
                        <td>
                            <b>Dist.(KM)</b>
                        </td>
                        <td>
                            <%# DataBinder.Eval(Container.DataItem, "SCHDEP_HR")%>
                        </td>
                        <td>
                            <b>Transit Time</b>
                        </td>
                        <td>
                            <%# DataBinder.Eval(Container.DataItem, "TransHrs")%>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <b>Controlling Location</b>
                        </td>
                        <td>
                            <%# DataBinder.Eval(Container.DataItem, "ControlLoc")%>
                        </td>
                        <td>
                            <b>Departure Time</b>
                        </td>
                        <td colspan="3">
                            <%# DataBinder.Eval(Container.DataItem, "SCHDEP_HR")%>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <b>Round Trip</b>
                        </td>
                        <td>
                            <%# DataBinder.Eval(Container.DataItem, "ROUND_TRIP")%>
                        </td>
                        <td>
                            <b>Active Flag</b>
                        </td>
                        <td colspan="3">
                            <%# DataBinder.Eval(Container.DataItem, "ACTIVEFLAG")%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:GridView ID="gvRutDetails" runat="server" OnRowCreated="gvTripRoute_RowCreated"
                                AutoGenerateColumns="False" CssClass="boxbg" EnableModelValidation="True"
                                Width="100%" ShowFooter="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <center>
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </center>
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Location Name" SortExpression="RUTNO">
                                        <FooterTemplate>
                                            Total :
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("LOCNAME") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dist (In Km)" SortExpression="DIST_KM">
                                        <FooterTemplate>
                                            <asp:Label ID="lbl_Tot_Dist" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("DIST_KM") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hours" SortExpression="TRTIME_HR">
                                        <FooterTemplate>
                                            <asp:Label ID="lbl_Tot_TrHours" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("TRTIME_HR") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Min" SortExpression="TRTIME_MIN">
                                        <FooterTemplate>
                                            <asp:Label ID="lbl_Tot_TrMin" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("TRTIME_MIN") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hours" SortExpression="STTIME_HR">
                                        <FooterTemplate>
                                            <asp:Label ID="lbl_Tot_StHours" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("STTIME_HR") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mins" SortExpression="STTIME_MIN">
                                        <FooterTemplate>
                                            <asp:Label ID="lbl_Tot_StMin" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("STTIME_MIN") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Obward/Return" SortExpression="ONW_RET">
                                        <ItemTemplate>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("ONW_RET") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="bgwhite" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <SeparatorTemplate>
                <hr>
            </SeparatorTemplate>
        </asp:Repeater>
    </div>
    </form>
</body>
</html>
