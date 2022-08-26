<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Payment_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../JS/Octroi.js"></script>
    <div align="left" style="width: 9.5in;">
        <br />
        <table width="1000" border="0" cellspacing="0" cellpadding="0" align="left">
            <tr>
                <td>
                    <table border="0" cellpadding="3" width="850" cellspacing="1" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>
                                    <asp:Label Font-Bold="true" ID="Trn_Title1" runat="server" CssClass="blackfnt" Text="Selected Criteria"></asp:Label>
                                </b></font>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td  ">
                                <label class="blackfnt">
                                    Date Selected :</label>
                            </td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Date" runat="server" CssClass="blackfnt"  Text="-" ></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Vendor Name & Code:</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Vendor" Text="-" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td  >
                                <label class="blackfnt">
                                    Billno Entry No. :</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_Billno" runat="server" CssClass="blackfnt" Text="-" ></asp:Label>
                            </td>
                        </tr>
                         <tr style="background-color: #FFFFFF">
                            <td  >
                                <label class="blackfnt">
                                   Vendor Billno No. :</label></td>
                            <td  >
                                &nbsp;<asp:Label ID="Lbl_VBillno" runat="server" CssClass="blackfnt" Text="-" ></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left">
                <br />
                    <asp:GridView ID="GV_BillList" runat="server" align="left" BorderWidth="0"  CellSpacing="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                          FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                        Width="85%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" />
                                <HeaderTemplate>
                                    <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_BillList','ChkAll','Chk_Docno','N')" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                    <asp:CheckBox ID="Chk_Docno" runat="server"  />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblBillno" Text='<%# DataBinder.Eval(Container.DataItem, "Billno") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLBilldt" Text='<%# DataBinder.Eval(Container.DataItem, "Billdt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Vendor Bill No" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblVBillno" Text='<%# DataBinder.Eval(Container.DataItem, "VBillno") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Vendor Code & Name" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblVendor" Text='<%# DataBinder.Eval(Container.DataItem, "vendorcd") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Paid Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "Paidamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pending  Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPendamt" Text='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total  Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblTotal" Text='<%# DataBinder.Eval(Container.DataItem, "Totalamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="Lbltotal" Font-Bold="true" runat="server" Text="Total Amount" CssClass="blackfnt"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td><br />
                    <table align="left" cellspacing="1"  width="85%" class="boxbg" border="0" id="ON_Submit"
                        runat="server">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" BorderStyle="Groove"   CssClass="blackfnt" OnClientClick="javascript:return OnSubmit()"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
