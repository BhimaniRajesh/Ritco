<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SecondaryContract_Step2.aspx.cs" Inherits="GUI_Fleet_SecondaryContract_SecondaryContract_Step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 15px;
        }
        .style2
        {
            width: 150px;
        }
        .style3
        {
            width: 20px;
        }
    </style>

    <script language="javascript" type="text/javascript" src="AJAX_Validator/SecondaryContract.js"></script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <br />
    <br />
    <br />
    <div style="text-align: left; width: 10.0in">
        <%--<NumericTextBox:NBT ID="NumericTB" runat="server" />   --%>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="450px">
                    <tr style="background-color: White">
                        <td colspan="2" class="blackfnt" style="text-align: left; width: 450px;">
                            <asp:Label ID="lbl_Error" class="blackfnt" ForeColor="red" runat="server" Text="" />
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <strong>Secondary Contract</strong>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left; width: 40%;">
                            &nbsp;Contract based On:
                        </td>
                        <td class="blackfnt" style="text-align: left; width: 60%;">
                            <asp:Label ID="lbl_Contract_Based_On" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            AC Status:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_AC_status" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Rate based On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_Rate_Based_On" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Rate Type allowed on:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_Rate_Type_Allowed_On" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Fixed cost rate based On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_Fiexed_Cost_Based_On" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Variable Cost Rate Based On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_Variable_Cost_Based_On" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White" runat="server" id="tr_HourlyBased">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Standard Charge Applcable:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Label ID="lbl_Standard_Charge_Applcable" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr style="background-color: White" runat="server" id="tr1">
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Panel ID="pnlHourBased" Width="850px" runat="server">
                                <table cellspacing="1" width="100%" class="boxbg" border="0">
                                    <tr class="bgbluegrey">
                                        <td align="left" width="20%">
                                            <asp:Label CssClass="blackfnt" ID="Label15" runat="server">Enter no. of rows </asp:Label>
                                        </td>
                                        <td width="65%">
                                            <asp:TextBox ID="tb_Row_No" MaxLength="2" runat="server" Width="20" BorderStyle="Groove"
                                                onkeydown="return numeric(event)" Text="0" AutoPostBack="true" OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                                            <ajaxToolkit:FilteredTextBoxExtender ID="fltEx_tb_Row_No" runat="server" FilterType="Numbers"
                                                TargetControlID="tb_Row_No">
                                            </ajaxToolkit:FilteredTextBoxExtender>
                                        </td>
                                        <td width="15%">
                                            <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td colspan="3">
                            <asp:Panel ID="pblTask" Width="850px" runat="server">
                                <asp:Label ID="lbl_Hdr_Text" Visible="false" runat="server"></asp:Label>
                                <asp:GridView ID="gv_Secondary_Contract" runat="server" HeaderStyle-CssClass="bgbluegrey"
                                    OnRowDeleting="gv_Secondary_Contract_RowDeleting" CellPadding="1" CellSpacing="1"
                                    AutoGenerateColumns="False" SelectedIndex="1" Width="100%" OnRowDataBound="gv_Secondary_Contract_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hf_Contract_Det_Code" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Contract_Det_Code") %>' />
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Location">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Location" Text='<%# DataBinder.Eval(Container.DataItem,"LocCode") %>'
                                                    CssClass="input" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Location" runat="server" ControlToValidate="tb_Location"
                                                    ToolTip="Enter Location" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Location_Err" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="autoComLoc" TargetControlID="tb_Location"
                                                    ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetLocationName" MinimumPrefixLength="1"
                                                    CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vehicle Number" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Vehicle_No" Text='<%# DataBinder.Eval(Container.DataItem,"Vehicle_No") %>'
                                                    CssClass="input" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Vehicle_No" runat="server" ControlToValidate="tb_Vehicle_No"
                                                    ToolTip="Enter Vehicle Numer" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Vehicle_No_Err" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="autoComplete1" TargetControlID="tb_Vehicle_No"
                                                    ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetVehNo" MinimumPrefixLength="1"
                                                    CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="FTL Type" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Vehicle_Type" Text='<%# DataBinder.Eval(Container.DataItem,"Vehicle_Type_Code") %>'
                                                    CssClass="input" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Vehicle_Type" runat="server" ControlToValidate="tb_Vehicle_Type"
                                                    ToolTip="Enter Vehicle Type" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Vehicle_Type_Err" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="autoCompleteType" TargetControlID="tb_Vehicle_Type"
                                                    ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetFTLType" MinimumPrefixLength="1"
                                                    CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Category" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Category" runat="server" ControlToValidate="ddl_Category"
                                                    ToolTip="Select Category" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Houly<br> Based Slot" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Hourly_Based_Slot" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Hourly_Based_Slot" runat="server" ControlToValidate="ddl_Hourly_Based_Slot"
                                                    ToolTip="Select Hourly Based Slot" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="From KM" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_From_Km" Text='<%# DataBinder.Eval(Container.DataItem,"From_KM") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_From_Km" runat="server" ControlToValidate="tb_From_Km"
                                                    ToolTip="Enter From KM" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="TO KM" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_To_Km" Text='<%# DataBinder.Eval(Container.DataItem,"To_KM") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_To_Km" runat="server" ControlToValidate="tb_To_Km"
                                                    ToolTip="Enter To KM" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fixed Cost">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Fixed_Cost" Text='<%# DataBinder.Eval(Container.DataItem,"Fixed_Cost") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    onblur="return round(this)" Width="75px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Fixed_Cost" runat="server" ControlToValidate="tb_Fixed_Cost"
                                                    ToolTip="Enter Fixed Cost" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Variable Cost">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Variable_Cost" Text='<%# DataBinder.Eval(Container.DataItem,"Variable_Cost") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    onblur="return round(this)" Width="75px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Variable_Cost" runat="server" ControlToValidate="tb_Variable_Cost"
                                                    ToolTip="Enter Variable Cost" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fixed Cost on KM" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Fixed_Cost_Km" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Fixed_Cost_Km" runat="server" ControlToValidate="ddl_Fixed_Cost_Km"
                                                    ToolTip="Enter Cost Based on KM" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <%--Fixed_Cost_KM--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtn_Delete_Row" runat="server" Width="20px" Font-Underline="true"
                                                    CausesValidation="false" CommandName="Delete" CommandArgument='<%#Container.DataItemIndex%>'>Delete</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="bgbluegrey" />
                                </asp:GridView>
                            </asp:Panel>
                            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                                TargetControlID="pblTask" Collapsed="false" ExpandControlID="pnlHourBased" CollapseControlID="pnlHourBased"
                                TextLabelID="lblTaskL" CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" />
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td colspan="3" class="blackfnt" style="text-align: right; height: 25px;">
                            <asp:Button ID="btnSubmit" OnClick="btn_Submit_Click" runat="server" Text="Submit" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </div>
</asp:Content>
