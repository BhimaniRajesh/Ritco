<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Delivered_undelivered_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"></font><font class="blckfnt">Report &gt; Operation</font><strong><font
                        class="bluefnt"> &gt; </strong><strong>Delivered UnDelivered Report</strong>
                </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td  valign="top">
                <table border="0" id="tblGl" runat="server" cellpadding="3" width="565" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td align="center" style="width: 205; height: 25px;" class="bgbluegrey" colspan="2">
                            <label class="blackfnt">
                                <b>You Selected</b></label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Date :</label></td>
                        <td style="height: 10px">
                            &nbsp;
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Location :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                   <%-- <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Document Type :
                            </label>
                        </td>
                        <td style="height: 6px">
                            &nbsp;
                            <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>--%>
                    <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Customer:
                            </label>
                        </td>
                        <td style="width: 205; height: 25px;">
                            &nbsp;
                            <asp:Label ID="lblCust" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Paybas:
                            </label>
                        </td>
                        <td style="width: 205; height: 25px;">
                            &nbsp;
                            <asp:Label ID="lblpaybas" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Mode:
                            </label>
                        </td>
                        <td style="width: 205; height: 25px;">
                            &nbsp;
                            <asp:Label ID="lblMode" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Type:
                            </label>
                        </td>
                        <td style="width: 205; height: 25px;">
                            &nbsp;
                            <asp:Label ID="lblTypem" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                     <tr style="background-color: #ffffff">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Status:
                            </label>
                        </td>
                        <td style="width: 205; height: 25px;">
                            &nbsp;
                            <asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
         <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
        <tr>
            <td><br />
                <asp:GridView Visible="false" align="Left" ID="dgDocket" runat="server" BorderWidth="0"
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
                                <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:BoundField  DataField="EDD" HeaderText="EDD">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField   DataField="ArrDt" HeaderText="Arrv. DT">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="curr_loc" HeaderText="Current Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="orgncd" HeaderText="Origin ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="reassign_destcd" HeaderText="Destination ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="cnor" HeaderText="Cnor">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="cnee" HeaderText="Cnee">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="pkgsno" HeaderText="No. of Packages">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="actuwt" HeaderText="Act Wt.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField  DataField="chrgwt" HeaderText="Chrg Wt.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField  DataField="Freight" HeaderText="Freight Amount">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField  DataField="invamt" HeaderText="Value of Shipment">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="PAYBASis" HeaderText="Pay Mode">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            
                        </asp:BoundField>
                         <asp:BoundField  DataField="tranportmode" HeaderText="Trans. Mode">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="Special_sevice" HeaderText="Special Sevice">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="STYP" HeaderText="Bkg. Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField  DataField="Status" HeaderText="Status">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            
                        </asp:BoundField>
                         <asp:BoundField  DataField="Status_date" HeaderText="Status Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                         <asp:BoundField  DataField="Actual_Status" HeaderText="Act Status">
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
            </td>
        </tr>
         <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
    </table>
</asp:Content>
