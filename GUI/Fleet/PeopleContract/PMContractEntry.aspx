<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PMContractEntry.aspx.cs" Inherits="GUI_Fleet_PMContract" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgr" %>
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

    <script language="javascript" type="text/javascript" src="AJAX_Validator/PeopleContract.js"></script>

    <pgr:ProgressBar ID="pgrone" runat="server" />
    <br />
    <br />
    <br />
    <div style="text-align: left; width: 10.0in">
        <%--<NumericTextBox:NBT ID="NumericTB" runat="server" />   --%>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr style="background-color: White" runat="server" id="tr1">
                        <td class="blackfnt" style="text-align: left;">
                            <asp:Panel ID="pnlHourBased" Width="100%" runat="server">
                                <table cellspacing="1" width="100%" class="boxbg" border="0">
                                    <tr class="bgbluegrey">
                                        <td align="left">
                                            <asp:Label Width="100px" CssClass="blackfnt" ID="Label15" runat="server">Enter no. of rows </asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tb_Row_No" MaxLength="2" runat="server" Width="20px" BorderStyle="Groove"
                                                Text="0" AutoPostBack="true" OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                                            <ajaxToolkit:FilteredTextBoxExtender ID="fltEx_tb_Row_No" runat="server" FilterType="Numbers"
                                                TargetControlID="tb_Row_No">
                                            </ajaxToolkit:FilteredTextBoxExtender>
                                        </td>
                                        <td width="90%" align="right">
                                            <%--<asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>--%>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td colspan="3">
                            <asp:Panel ID="pblTask" Width="100%" runat="server">
                                <asp:Label ID="lbl_Err_Text" CssClass="redfnt" runat="server"></asp:Label>
                                <asp:Label ID="lbl_Err1_Text" CssClass="redfnt" runat="server"></asp:Label>
                                <asp:GridView ID="gv_People_Contract" runat="server" HeaderStyle-CssClass="bgbluegrey"
                                    OnRowDeleting="gv_People_Contract_RowDeleting" CellPadding="1" CellSpacing="1"
                                    AutoGenerateColumns="False" SelectedIndex="1" Width="100%" OnRowDataBound="gv_People_Contract_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vehicle Type">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <%--<asp:Label ID="HiddenField1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ID") %>' />--%>
                                                <asp:HiddenField ID="hf_Contract_Code" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ID") %>' />
                                                <asp:TextBox ID="tb_Vehicle_Type" Text='<%# DataBinder.Eval(Container.DataItem,"Vehicle_Type") %>'
                                                    CssClass="input" Width="200px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Vehicle_Type" runat="server" ControlToValidate="tb_Vehicle_Type"
                                                    ToolTip="Enter Vehicle Type" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Err_Vehicle_Type" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="autoCompleteType" TargetControlID="tb_Vehicle_Type"
                                                    ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetVehType" MinimumPrefixLength="1"
                                                    CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                                    CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                    DelimiterCharacters=";, :">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Category" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Category" runat="server" ControlToValidate="ddl_Category"
                                                    ToolTip="Select Category" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Select Route" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Route" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Route" runat="server" ControlToValidate="ddl_Route"
                                                    ToolTip="Select Route" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Standard KM">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_RUTKM" Text='<%# DataBinder.Eval(Container.DataItem,"RUTKM") %>'
                                                    CssClass="input" Width="100px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_RUTKM" runat="server" ControlToValidate="tb_RUTKM"
                                                    ToolTip="Enter Vehicle Type" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField HeaderText="From Area" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_From_City" Text='<%# DataBinder.Eval(Container.DataItem,"From_Area") %>'
                                                    BorderStyle="Groove" runat="server" CssClass="input" MaxLength="50"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tb_From_City"
                                                    ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Err_FromCity" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="AutoCompleteExtender3" TargetControlID="tb_From_City"
                                                    ServicePath="../../../services/FleetAutoComplet.asmx" ServiceMethod="GetLocationCode"
                                                    MinimumPrefixLength="1" CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20"
                                                    CompletionListCssClass="autocomplete_completionListElement" CompletionListItemCssClass="autocomplete_listItem"
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Area" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_To_City" BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"To_Area") %>'
                                                    runat="server" CssClass="input" MaxLength="50"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_To_City" runat="server" ControlToValidate="tb_To_City"
                                                    ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Err_ToCity" CssClass="redfnt" runat="server"></asp:Label>
                                                <ajaxToolkit:AutoCompleteExtender runat="server" ID="AutoCompleteExtender1" TargetControlID="tb_To_City"
                                                    ServicePath="../../../services/FleetAutoComplet.asmx" ServiceMethod="GetLocationCode"
                                                    MinimumPrefixLength="1" CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20"
                                                    CompletionListCssClass="autocomplete_completionListElement" CompletionListItemCssClass="autocomplete_listItem"
                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" DelimiterCharacters=";, :"
                                                    ShowOnlyCurrentWordInCompletionListItem="true">
                                                </ajaxToolkit:AutoCompleteExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Duration">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Duration" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Duration" runat="server" ControlToValidate="ddl_Duration"
                                                    ToolTip="Select Duration" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pickup/Drop" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_PickupDrop" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_PickupDrop" runat="server" ControlToValidate="ddl_PickupDrop"
                                                    ToolTip="Select" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Minimum Head #" Visible="false">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Minimum_Head" Text='<%# DataBinder.Eval(Container.DataItem,"Minimum_Head") %>'
                                                    CssClass="input" BorderStyle="Groove" runat="server" Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Minimum_Head" runat="server" ControlToValidate="tb_Minimum_Head"
                                                    ToolTip="Enter Minimum Head" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deployment St. Time">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Deployment_StTime" Text='<%# DataBinder.Eval(Container.DataItem,"Deployment_St_Time") %>'
                                                    CssClass="input" BorderStyle="Groove" runat="server" Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Deployment_StTime" runat="server" ControlToValidate="tb_Deployment_StTime"
                                                    ToolTip="Enter Deployment Start Time" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deployment End Time">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Deployment_EndTime" Text='<%# DataBinder.Eval(Container.DataItem,"Deployment_End_Time") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Deployment_EndTime" runat="server" ControlToValidate="tb_Deployment_EndTime"
                                                    ToolTip="Enter Deployment End Time" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Outstation Charge">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Outstanding_Charge" Text='<%# DataBinder.Eval(Container.DataItem,"Outstanding_Charge") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Outstanding_Charge" runat="server" ControlToValidate="tb_Outstanding_Charge"
                                                    ToolTip="Enter Outstanding Charge" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Non Working Charge">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Non_Working_Charge" Text='<%# DataBinder.Eval(Container.DataItem,"Non_Working_Charge") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Non_Working_Charge" runat="server" ControlToValidate="tb_Non_Working_Charge"
                                                    ToolTip="Enter Non Working Charge" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vehicle Category">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddl_Vehicle_Category" runat="server">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Vehicle_Category" runat="server" ControlToValidate="ddl_Vehicle_Category"
                                                    ToolTip="Select Vehicle Category" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Minimum KM">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Fixed_Km" Text='<%# DataBinder.Eval(Container.DataItem,"Fixed_KM") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Fixed_KM" runat="server" ControlToValidate="tb_Fixed_KM"
                                                    ToolTip="Enter Extra KM" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Extra/KM">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Variable_Km" Text='<%# DataBinder.Eval(Container.DataItem,"Variable_KM") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Variable_Km" runat="server" ControlToValidate="tb_Variable_Km"
                                                    ToolTip="Enter Variable KM" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Minimum HR">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Fixed_Hour" Text='<%# DataBinder.Eval(Container.DataItem,"Fixed_Hour") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Fixed_Hour" runat="server" ControlToValidate="tb_Fixed_Hour"
                                                    ToolTip="Enter Minimum Hour" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Extra/HR">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Variable_Hour" Text='<%# DataBinder.Eval(Container.DataItem,"Variable_Hour") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Variable_Hour" runat="server" ControlToValidate="tb_Variable_Hour"
                                                    ToolTip="Enter Variable Hour" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rate">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Cost" Text='<%# DataBinder.Eval(Container.DataItem,"Cost") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    onblur="return round(this)" Width="75px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_Cost" runat="server" ControlToValidate="tb_Cost"
                                                    ToolTip="Enter Cost" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Vehicle">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_No_Veh" Text='<%# DataBinder.Eval(Container.DataItem,"No_of_Vehicle") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_No_Veh" runat="server" ControlToValidate="tb_No_Veh"
                                                    ToolTip="Enter Number of Vehicle" ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Days">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_No_Days" Text='<%# DataBinder.Eval(Container.DataItem,"No_of_Days") %>'
                                                    CssClass="InputRight" BorderStyle="Groove" runat="server" onkeypress="return checkDecimals(this)"
                                                    Width="48px" MaxLength="10">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_tb_No_Days" runat="server" ControlToValidate="tb_No_Days"
                                                    ToolTip="Enter Number of Days" ErrorMessage="!!!"></asp:RequiredFieldValidator>
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
                            <%--  <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                                TargetControlID="pblTask" Collapsed="false" ExpandControlID="pnlHourBased" CollapseControlID="pnlHourBased"
                                TextLabelID="lblTaskL" CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" />--%>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="3" class="blackfnt" style="text-align: center; height: 25px;">
                            <asp:Button ID="btnSubmit" OnClick="btn_Submit_Click" runat="server" Text="Submit" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </div>
</asp:Content>
