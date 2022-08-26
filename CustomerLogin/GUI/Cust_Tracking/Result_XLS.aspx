<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="Result_XLS.aspx.cs" Inherits="GUI_Cust_Tracking_Result_XLS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>

</head>
<body>
    <form id="form1" runat="server">
    <div align="left">
    
        <table id = "sd" style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0" runat = "server" >
            
            <tr>
                <td valign="top">
                    <%--<center>--%>
                    <table border="1" id="tblGl" runat="server" cellpadding="4" width="565" cellspacing="1"
                        align="left" class="boxbg">
                        <tr  style="background-color: #ffffff; height:20px;">
                            <td align="center" class="bgbluegrey" colspan="2">
                                <label class="blackfnt">
                                    <b>You Selected</b></label></td>
                        </tr>
                        <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :</label></td>
                            <td style="height: 10px">
                                &nbsp;
                                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF;height:20px;">
                            <td style="width: 205; height: 15px;">
                                <label class="blackfnt">
                                    RO :</label></td>
                            <td style="width: 343;height:20px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF;height:20px;">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Location :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Document Type :
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                        <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Customer:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblCust" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                        <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Paybas:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblpaybas" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                         <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Mode:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblMode" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                         <tr style="background-color: #ffffff;height:20px;">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Type:
                                </label>
                            </td>
                            <td style="height: 6px">
                                &nbsp;
                                <asp:Label ID="lblTypem" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                        <tr style="background-color: #ffffff;height:20px;">
                            <td colspan="2" style="height: 6px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
            <tr>
                <td>
                    <br />
                    <asp:GridView Visible="false" align="Left" ID="dgDocket" runat="server" BorderWidth="1"
                        CellPadding="4" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "doc_no")%>'
                                        runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="dktst" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "Docket_Status")%>' />
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="doc_no" HeaderText="Docket No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "doc_dt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="Dockdt" HeaderText="Docket Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Deldt" HeaderText=" EDD - ADD ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                           <asp:BoundField DataField="Origin_dest" HeaderText="Origin - Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                           
                             <asp:BoundField DataField="Curr_Next" HeaderText="Curr. Loc. - Next Loc.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                           
                            <asp:BoundField DataField="Type" HeaderText="Paybas | Mode | Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnor" HeaderText="Consignor">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnee" HeaderText="Consignee">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                           
                        </Columns>
                       
                       
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                            Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    <br />
                    <br />
                </td>
            </tr>
           
        </table>
        
    </div>
    </form>
</body>
</html>
