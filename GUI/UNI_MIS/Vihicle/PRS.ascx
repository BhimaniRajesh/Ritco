<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PRS.ascx.cs" Inherits="GUI_Vihicle_PRS" %>
<%--<atlas:UpdatePanel ID="UpdatePanel18" runat="server" Mode="Conditional" RenderMode="Inline">
    <ContentTemplate>
        <asp:Panel ID="mypanel2" runat="server" Width="100%">
  --%>          <table border="0" cellspacing="1" style="width: 100%; height: 263px">
                <tr class="bgbluegrey">
                    <td align="center" colspan="3" style="height: 21px">
                        <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Select Criteria For PRS
                                    </asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text="Deliverd By"></asp:Label>&nbsp;
                        <atlas:UpdatePanel ID="UpdatePanel19" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddldelby" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddldelby_SelectedIndexChanged">
                                    <asp:ListItem>Select</asp:ListItem>
                                    <asp:ListItem Value="R">BA</asp:ListItem>
                                    <asp:ListItem Value="S">Own</asp:ListItem>
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                    <td align="left">
                        &nbsp;&nbsp;
                        <asp:Label ID="Label18" runat="server" CssClass="blackfnt" Text="Vendor Type" Visible="False"></asp:Label><atlas:UpdatePanel
                            ID="UpdatePanel20" runat="server" Visible="False">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlventypePRS" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlventypePRS_SelectedIndexChanged">
                                    <asp:ListItem>Select</asp:ListItem>
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="Label19" runat="server" CssClass="blackfnt" Text="BA / Vendor"></asp:Label>&nbsp;
                        <atlas:UpdatePanel ID="UpdatePanel21" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlvenPRS" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlvenPRS_SelectedIndexChanged">
                                    <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                </asp:DropDownList>
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                    <td align="left">
                        &nbsp; &nbsp; &nbsp;
                        <asp:Label ID="Label20" runat="server" CssClass="blackfnt" Text="Staff" Visible="False"></asp:Label><atlas:UpdatePanel
                            ID="UpdatePanel22" runat="server" Visible="False">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlstaff" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlstaff_SelectedIndexChanged">
                                    <asp:ListItem>Select</asp:ListItem>
                                </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                            </ContentTemplate>
                            <Triggers>
                                <atlas:ControlEventTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left" width="200">
                        <asp:Label ID="Label21" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Document Details
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel23" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox4" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox41_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel24" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList6" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="THC Document No" Value="thcno"></asp:ListItem>
                                    <asp:ListItem Text="Date" Value="thcdt"></asp:ListItem>
                                    <asp:ListItem Text="Location" Value="thcbr"></asp:ListItem>
                                    <asp:ListItem Text="Vehichle No." Value="vehno"></asp:ListItem>
                                    <asp:ListItem Enabled="false" Text="Vendor Type" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Vendor Name" Value="vendor_name"></asp:ListItem>
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
                        <asp:Label ID="Label22" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Financial Details- Advance </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel25" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox5" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox42_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel26" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList7" runat="server" CellPadding="2" CellSpacing="2"
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
                                    <asp:ListItem Text="Hire Charges." Value=" "></asp:ListItem>
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
                        <asp:Label ID="Label23" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Financial Details- Balance
                                    </asp:Label>
                    </td>
                    <td style="height: 47px">
                        <atlas:UpdatePanel ID="UpdatePanel27" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox6" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox1_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel28" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList8" runat="server" CellPadding="2" CellSpacing="2"
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
                        <asp:Label ID="Label24" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     Financial Details- Bill Entry 
                                      
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel29" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox7" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox2_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel30" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList9" runat="server" CellPadding="2" CellSpacing="2"
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
                        <asp:Label ID="Label25" runat="server" CssClass="blackfnt" Font-Bold="true">
                                     
                                      Docket Details
                                    </asp:Label>
                    </td>
                    <td>
                        <atlas:UpdatePanel ID="UpdatePanel31" runat="server">
                            <ContentTemplate>
                                <asp:CheckBox ID="CheckBox8" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                    OnCheckedChanged="CheckBox3_CheckedChanged" Text="Select All" />
                            </ContentTemplate>
                        </atlas:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" colspan="3" style="height: 21px">
                        <atlas:UpdatePanel ID="UpdatePanel32" runat="server" Mode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList10" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="4" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="700px">
                                    <asp:ListItem Text="Number of Cnotes Moved" Value="Total_docket"></asp:ListItem>
                                    <asp:ListItem Text="Total Actual Weight" Value="ld_actuwt"></asp:ListItem>
                                    <asp:ListItem Text="Total Freight" Value="Total_freight"></asp:ListItem>
                                    <asp:ListItem Text="Total Cnotes Sent for Delivery" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Total Actual Weight" Value=" "></asp:ListItem>
                                    <asp:ListItem Text="Total Freight" Value=" "></asp:ListItem>
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
                        <asp:Button ID="BtnPRS" runat="server" OnClick="BtnPRS_Click1" Text="Show" Width="75px" />
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