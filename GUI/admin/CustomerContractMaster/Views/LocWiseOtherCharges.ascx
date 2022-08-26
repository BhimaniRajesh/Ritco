<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LocWiseOtherCharges.ascx.cs"
    Inherits="Views_LocWiseOtherCharges" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/CCMFilter.ascx" TagName="CCMFilter" TagPrefix="UC" %>


<div>
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <cust:CustInfo runat="server" ID="cstheader" Visible="false"/>
    <br />
    <table width="600">
        <tr class="bgwhite">
            <td width="100" class="blackfnt">
                Charge Name :
            </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchargename" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>&nbsp;
            </td>
        </tr>
        <tr class="bgwhite">
            <td width="100" class="blackfnt">
                Charge Type :
            </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblChgTyp" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>&nbsp;
            </td>
        </tr>
    </table>
    <table>
        <tr class="dgHeaderStyle">
            <td>Advanced Search</td>
        </tr>
        <tr class="bgwhite">
            <td class="blackfnt">
                 <UC:CCMFilter runat="server" ID="ucFilter" />
            </td>
        </tr>
        <tr class="bgbluegrey" align="center">
            <td class="blackfnt">
                <asp:Button ID="btnShow" runat="server" Text="Search" OnClick="btnShow_Click" />                
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="updtPnl" runat="server">
        <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <%--CssClass="boxbg"
                            HeaderStyle-CssClass="dgHeaderStyle" 
                            AlternatingRowStyle-BackColor="#f7f7f7"
                            PagerStyle-HorizontalAlign="left" PagerStyle-BackColor="white" HeaderStyle-Font-Bold="true"--%>
                            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0" Width="10in" 
                                AllowPaging="true"  CellSpacing="0" CellPadding="2" AllowSorting="true" AutoGenerateColumns="false"
                                PageSize="25" PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="TopAndBottom"
                                PagerSettings-FirstPageText="[First]"  PagerSettings-LastPageText="[Last]" 
                                CssClass="mGrid"  
                                PagerStyle-CssClass="pgr"  
                                AlternatingRowStyle-CssClass="alt"                                
                                EmptyDataText="No Records Found..." EmptyDataRowStyle-BackColor="white"  
                                OnRowDataBound="grvcharges_RowDataBound"   OnPageIndexChanging="grvcharges_PageIndexChanging"                                
                                >
                                <Columns>
                                    <asp:TemplateField HeaderText="SrNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblSrno" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblFrom" Text='<%# DataBinder.Eval( Container.DataItem,"fromLocName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="To" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblTo" Text='<%# DataBinder.Eval( Container.DataItem,"toLocName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tran. Mode" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblTransMode" Text='<%# DataBinder.Eval( Container.DataItem,"trans_type_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mimimum Charge(in RS)" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblMinChg" Text='<%# DataBinder.Eval( Container.DataItem,"minrate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Rate" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblChgRate" Text='<%# DataBinder.Eval( Container.DataItem,"rate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Maximum Charge(in Rs)" HeaderStyle-HorizontalAlign="Center"
                                        ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblMaxChg" Text='<%# DataBinder.Eval( Container.DataItem,"maxrate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblRateType" Text='<%# DataBinder.Eval( Container.DataItem,"RateTypeDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="dgRowStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<script type="text/ecmascript">   
    window.onload = onLoad();
</script>