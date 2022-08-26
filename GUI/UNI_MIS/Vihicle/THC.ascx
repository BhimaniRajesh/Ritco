<%@ Control Language="C#" AutoEventWireup="true" CodeFile="THC.ascx.cs" Inherits="GUI_Vihicle_THC" %>
<%--<atlas:UpdatePanel ID="UpdatePanel5" runat="server" Mode="Conditional" RenderMode="Inline">
    <ContentTemplate>
        <asp:Panel ID="mypanal" runat="server" Width="100%">
  --%>          <table border="0" cellspacing="1" style="width: 100%; height: 263px">
                <tr class="bgbluegrey">
                    <td align="center" colspan="3" style="height: 21px">
                        <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Select Criteria For THC
                                    </asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Route Mode"></asp:Label>
                        <atlas:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlrmode" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlrmode_SelectedIndexChanged">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem Value="R">Train</asp:ListItem>
                                    <asp:ListItem Value="S">Road</asp:ListItem>
                                    <asp:ListItem Value="A">Air</asp:ListItem>
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Text="Route"></asp:Label>
                        <atlas:UpdatePanel ID="UpdatePanel16" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlroute" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlroute_SelectedIndexChanged">
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="Vendor Type"></asp:Label>
                        <atlas:UpdatePanel ID="UpdatePanel15" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlventype" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlventype_SelectedIndexChanged">
                                    <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                </asp:DropDownList>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Text="Vendor"></asp:Label>
                        &nbsp;
                        <atlas:UpdatePanel ID="UpdatePanel17" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlven" runat="server" OnSelectedIndexChanged="ddlven_SelectedIndexChanged">
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" width="200">
                        <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Document Details
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox41" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox41_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel10" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="THC Document No" Value="thcno"></asp:ListItem>
                                    <asp:ListItem Text="Date" Value="thcdt"></asp:ListItem>
                                    <asp:ListItem Text="Location" Value="thcbr"></asp:ListItem>
                                    <asp:ListItem Text="Vehichle No." Value="vehno"></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Vendor Type" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Vendor Name" Value="vendor_name"></asp:ListItem>
                                    <asp:ListItem Text="Route" Value="routename"></asp:ListItem>
                                </asp:CheckBoxList>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="CheckBox41" EventName="CheckedChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" width="200">
                        <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Financial Details- Advance </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel7" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox42" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox42_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel11" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList2" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="Amount" Value="advamt"></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Other Amount" Value=""></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Advance Paid " Value="advamt"></asp:ListItem>
                                    <asp:ListItem Text="Toal Amount" Value="TOTALAMTPAID "></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Advance Paid by" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Advance Paid At" Value="advpaidat"></asp:ListItem>
                                    <asp:ListItem Text="Advance Voucher No. " Value="advvoucherNo"></asp:ListItem>
                                    <asp:ListItem Text="Advance Payment Date." Value="advpaiddt"></asp:ListItem>
                                </asp:CheckBoxList>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="CheckBox42" EventName="CheckedChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" style="height: 47px" width="200">
                        <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Financial Details- Balance
                                    </asp:Label>
                    </td>
                    <td style="height: 47px">
                        <atlas:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox1_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel12" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList3" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="Claims" Value="dclaim"></asp:ListItem>
                                    <asp:ListItem Text="Deductions" Value="oth_ded"></asp:ListItem>
                                    <asp:ListItem Text="Incentive" Value="incentive"></asp:ListItem>
                                    <asp:ListItem Text="Penalty" Value="penalty"></asp:ListItem>
                                    <asp:ListItem Text="Balance Paid" Value="bal_colamt"></asp:ListItem>
                                    <asp:ListItem Text="Balance Paid By" Value="balpaidby"></asp:ListItem>
                                    <asp:ListItem Text="Balanace Paid At" Value="balamtbrcd"></asp:ListItem>
                                    <asp:ListItem Text="Balance Payment Voucher Number" Value="balvoucherNo"></asp:ListItem>
                                    <asp:ListItem Text="Balance Payment Date." Value="balvoucherdt"></asp:ListItem>
                                </asp:CheckBoxList>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="CheckBox1" EventName="CheckedChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" width="200">
                        <asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     Financial Details- Bill Entry 
                                      
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel8" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox2_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel13" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList4" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Enabled="false" Text="Bill Entry Date" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Bill Entry Number" Value="vendorBENo"></asp:ListItem>
                                    <asp:ListItem Text="Vendor Bill Number" Value="vendorbillNo"></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Vendor Bill Amount" Value="bal_colamt"></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Payment Voucher Number" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Payment Date" Value="PaymentDt"></asp:ListItem>
                                </asp:CheckBoxList>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="CheckBox2" EventName="CheckedChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" width="200">
                        <asp:Label ID="Label15" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Docket Details
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel9" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox3" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox3_CheckedChanged" Text="Select All" Width="95px" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel14" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList5" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="Number of Cnotes Moved" Value="Total_docket"></asp:ListItem>
                                    <asp:ListItem Text="Total Actual Weight" Value="ld_actuwt"></asp:ListItem>
                                    <asp:ListItem Text="Total Freight" Value="Total_freight"></asp:ListItem>
                                    <asp:ListItem Text="Dep. Date" Value="dept_dt"></asp:ListItem>
                                    <asp:ListItem Text="Dep. Time" Value="dept_tm"></asp:ListItem>
                                    <asp:ListItem Text="Arrv. date" Value="arrv_dt"></asp:ListItem>
                                    <asp:ListItem Text="Arrv. Time" Value="arrv_tm"></asp:ListItem>
                                    <asp:ListItem Text="Start KM" Value="OPENKM"></asp:ListItem>
                                    <asp:ListItem Text="Close KM" Value="CLOSEKM"></asp:ListItem>
                                    <asp:ListItem Text="Travel Distance" Value="Dist"></asp:ListItem>
                                </asp:CheckBoxList>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="CheckBox3" EventName="CheckedChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="center" colspan="3" style="height: 22px">
                        <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click1" Text="Show" Width="75px" />
                    </td>
                </tr>
            </table>
<%-- </asp:Panel>
    </ContentTemplate>
   <Triggers>
        <atlas:ControlEventTrigger ControlID="ddlDoctype" EventName="SelectedIndexChanged" />
    </Triggers>
</atlas:UpdatePanel>
--%>