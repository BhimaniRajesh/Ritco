<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCResult_ArrivalUpdate.aspx.cs" Inherits="GUI_Operations_THC_ArrivalUpdate_THCResult_ArrivalUpdate" %>

<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function OpenInWindow(strDocketNo) {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=20,top=20"
            var strPopupURL = "../TCS/PrintTCS/View_Print_UnloadingSheet.aspx?THC_No=" + strDocketNo

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>
    <asp:SqlDataSource ID="MySQLDataSource_THCAvailableForUpdate" runat="server" SelectCommand="Usp_List_THC_Arrival_update"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="fromdt" QueryStringField="fromdt" DefaultValue=""
                Type="String" />
            <asp:QueryStringParameter Name="todt" QueryStringField="todt" DefaultValue=" " Type="String" />
            <asp:QueryStringParameter Name="thcnolist" QueryStringField="thcnolist" DefaultValue=" "
                Type="String" />
            <asp:QueryStringParameter Name="dktnolist" QueryStringField="dktnolist" DefaultValue=" "
                Type="String" />
            <asp:QueryStringParameter Name="vehnolist" QueryStringField="vehnolist" DefaultValue=" "
                Type="String" />
            <asp:QueryStringParameter Name="lastloc" QueryStringField="lastloc" DefaultValue=" "
                Type="String" />
            <asp:SessionParameter Name="BRCD" SessionField="brcd" Type="String" DefaultValue="HYDB" />
            <asp:QueryStringParameter Name="TYP" QueryStringField="TYP" DefaultValue="1"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="upTHCCreate" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <br />
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left" width="75%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Text="" Font-Bold="true" runat="server"></asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img alt="Back" src="./../../images/back.gif" style="border: 0;">
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<PRBAR:PRB ID="PB" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:Label ID="lbl_PDCHDR" Font-Bold="true" CssClass="blackfnt" Text="" runat="server"></asp:Label>
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMain" runat="server"
                style="width: 10.5in">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Label ID="lbltblHDR" CssClass="blackfnt" Text="" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="GRDDKT" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="false" AutoGenerateColumns="false"
                            OnRowDataBound="dgTHC_RowDataBound" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            Width="100%" DataSourceID="MySQLDataSource_THCAvailableForUpdate">
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
                                <asp:TemplateField HeaderText="View Unloading Sheet" ItemStyle-BackColor="white">
                                    <ItemTemplate>
                                        <a href="Javascript:OpenInWindow('<%# DataBinder.Eval(Container.DataItem, "thcno")%>')">
                                            <asp:Label CssClass="blackfnt" ID="lblarrupdt" Text="Unloading Sheet" Font-Underline="true" runat="server"> </asp:Label>
                                            </u></a>

                                    </ItemTemplate>
                                    <ItemStyle CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblarrupdt" Text="Arrival" Font-Bold="true" runat="server"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                       <a href="./THC_ArrivalProcess.aspx?THCno=<%# DataBinder.Eval(Container.DataItem, "thcno")%>&TYP=B">
                                            <asp:Label CssClass="blackfnt" ID="lblarrupdt1"
                                                Font-Underline="true" runat="server">
                                            </asp:Label></a>
                                        <asp:Label CssClass="blackfnt" ID="lblarrupdt2"
                                            runat="server">
                                        </asp:Label>

                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" Wrap="false" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblarr" Text="Arrival" Font-Bold="true" runat="server"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <a href="./THC_ArrivalProcess.aspx?THCno=<%# DataBinder.Eval(Container.DataItem, "thcno")%>&TYP=A">
                                            <asp:Label CssClass="blackfnt" ID="lblarrst"
                                                Font-Underline="true" runat="server">
                                            </asp:Label></a>
                                        <asp:Label CssClass="blackfnt" ID="lblarrst1"
                                            runat="server">
                                        </asp:Label>
                                        <asp:HiddenField ID="HdArr" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "Arr_status")%>' />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" Wrap="false" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblstokup" Text="Stock Update" Font-Bold="true"
                                            runat="server"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                       <a href="./THC_ArrivalProcess.aspx?THCno=<%# DataBinder.Eval(Container.DataItem, "thcno")%>&TYP=S">
                                            <asp:Label CssClass="blackfnt" ID="lblstockst" runat="server">
                                            </asp:Label></a>
                                        <asp:Label CssClass="blackfnt" ID="lblstockst1"
                                            runat="server">
                                        </asp:Label>
                                        <%-- <asp:Label CssClass="blackfnt" ID="lblstokupdt" Text='<% #DataBinder.Eval(Container.DataItem, "Stock_Status")%>'
                                                runat="server">
                                            </asp:Label>--%>
                                        <asp:HiddenField ID="HdStock" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "Stock_Status")%>' />

                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblColname" Font-Bold="true" runat="server"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "thcno")%>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" Wrap="false" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lblColname1" Font-Bold="true" runat="server"> </asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label CssClass="blackfnt" ID="lbldockno1" Text='<% #DataBinder.Eval(Container.DataItem, "ManualTHCNo")%>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="true" Wrap="false" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="THCDate" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderText="THC Date" ReadOnly="True" />
                                <asp:BoundField DataField="Route" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderText="Route" ReadOnly="True" />
                                <asp:BoundField DataField="NextLocation" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderText="Next Location" ReadOnly="True" />
                                <asp:BoundField DataField="PreviousBranch" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderText="Previous Location" ReadOnly="True" />
                                <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderText="Status" ReadOnly="True" />
                                <asp:BoundField DataField="Vehicle" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderText="Vehicle" ReadOnly="True" />
                                <asp:BoundField DataField="ATA" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderText="ATA" ReadOnly="True" />
                                <asp:BoundField DataField="ATD" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderText="ATD" ReadOnly="True" />
                                <asp:BoundField DataField="ETA" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderText="ETA" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
