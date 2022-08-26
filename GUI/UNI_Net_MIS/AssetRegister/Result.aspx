<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_AssetRegister_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"></font><font class="blckfnt">Report &gt; Finance</font><strong><font
                        class="bluefnt"> &gt; </strong><strong>FA Register</strong>
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
            <td valign="top">
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
                                Installation Date</label></td>
                        <td style="height: 10px">
                            &nbsp;
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <%--<tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                RO</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>--%>
                    <%--<tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Location</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 25px;">
                            <label class="blackfnt">
                                Days</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblDays" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:GridView Visible="true" align="Left" ID="dgFA" runat="server" BorderWidth="0"
                    CellPadding="4" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgFA_RowDataBound"
                    EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" HeaderStyle-Font-Bold="true">
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
                        <asp:TemplateField HeaderText="Allocate No" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "allotcd")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Asset Name" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblAssetName" Text='<% #DataBinder.Eval(Container.DataItem, "asset_name")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Installation Date" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblInstallationDate" Text='<% #DataBinder.Eval(Container.DataItem, "install_date")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Classifcation" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblClassifcation" Text='<% #DataBinder.Eval(Container.DataItem, "group_name")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDescription" Text='<% #DataBinder.Eval(Container.DataItem, "description_detail")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Depreciate Rate (%)" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDepreciateRate" Text='<% #DataBinder.Eval(Container.DataItem, "deprate")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Depreciate Method" HeaderStyle-Wrap="false" Visible="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDepreciateMethod" Text='<% #DataBinder.Eval(Container.DataItem, "depmethod")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Current Location" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblCurrentLocation" Text='<% #DataBinder.Eval(Container.DataItem, "loccode")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assign Location" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblAssignLocation" Text='<% #DataBinder.Eval(Container.DataItem, "next_loccode")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assign To Emp" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblAssignToEmp" Text='<% #DataBinder.Eval(Container.DataItem, "assgnempcd")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gross Value" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblGrossValue" Text='<% #DataBinder.Eval(Container.DataItem, "gross_val")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Depreciation Amount" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDepreciationAmount" Text='<% #DataBinder.Eval(Container.DataItem, "gross_val")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net Value" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblNetValue" Text='<% #DataBinder.Eval(Container.DataItem, "gross_val")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
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
            <td valign="top">
                <br />
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
