<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Tripsheet_Entry.aspx.cs" Inherits="GUI_Fleet_PeopleContract_PeopleTripsheet"
    EnableEventValidation="false" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register Assembly="eWorld.UI" Namespace="eWorld.UI" TagPrefix="ew" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="AJAX_Validator/PeopleContract.js"></script>

    <br />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  &gt; ADD NEW LOG SHEET</asp:Label>
            </td>
        </tr>
    </table>
    <hr />
    <br />
     <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
    <asp:Panel ID="Panel2" GroupingText="Log Sheet Header" Width="850px" runat="server"
        Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
        <ew:CollapsablePanel ID="CollapsablePanel1" runat="server" Width="800px" CollapseImageUrl="~/GUI/images/collapse_blue.jpg"
            ExpandImageUrl="~/GUI/images/expand_blue.jpg">
            <br />
            <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
                <tr style="background-color: White" runat="server" id="row_Error">
                    <td colspan="6" class="blackfnt" style="text-align: left;">
                        <asp:Label ID="lbl_Trip_Error" class="blackfnt" ForeColor="red" runat="server" Text="" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Trip Sheet Id</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt" color="red">System generated </font>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="blackfnt">Trip Sheet Date</font>
                    </td>
                    <td align="left">
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="tb_TS_Date" CssClass="input" BorderStyle="Groove" Width="75px" runat="server"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/GUI/images/calendar.jpg"
                                        CausesValidation="False" />
                                </td>
                                <td>
                                    <MKB:TimeSelector ID="tm_TS" runat="server" DisplaySeconds="false" CssClass="input">
                                    </MKB:TimeSelector>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="MM/dd/yyyy"
                                        TargetControlID="tb_TS_Date" PopupButtonID="ImgBntCalc" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Manual Tripsheet No.</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="tb_Manual_TS" CssClass="input" BorderStyle="Groove" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Manual_TS" runat="server" ControlToValidate="tb_Manual_TS"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <br />
        </ew:CollapsablePanel>
    </asp:Panel>
    <asp:Panel ID="Panel1" GroupingText="Customer Contract" Width="850px" runat="server"
        Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
        <ew:CollapsablePanel ID="CollapsablePanel2" runat="server" Width="800px" CollapseImageUrl="~/GUI/images/collapse_blue.jpg"
            ExpandImageUrl="~/GUI/images/expand_blue.jpg">
            <br />
            <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
                <tr style="background-color: White" runat="server" id="row_Cust">
                    <td colspan="6" class="blackfnt" style="text-align: left; width: 600px;">
                        <asp:Label ID="lbl_Cust_Err" class="redfnt" ForeColor="red" runat="server" Text="" />
                        <asp:Label ID="lblErr" runat="server" CssClass="redfnt" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Enter Customer</font>
                    </td>
                    <td colspan="5" align="left">
                        <asp:TextBox ID="txtCustCode" runat="server" Width="100px" CssClass="input" BorderStyle="Groove"
                            MaxLength="50" ></asp:TextBox>
                        <asp:TextBox ID="txtCustName" runat="server" Width="300px" BorderStyle="Groove" ></asp:TextBox>&nbsp;
                        <asp:Label ID="lblPopup" runat="server" BorderStyle="Groove" Height="10px"
                            Text='<a href="javascript:nwOpen(1)">...</a>' Width="14px" ToolTip="Select Customer"></asp:Label>
                        <asp:RequiredFieldValidator ID="rfv_txtCustCode" runat="server" ControlToValidate="txtCustCode"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteExShipper"
                            ID="AutoCompleteExShipper" TargetControlID="txtCustCode" ServicePath="../../../services/FleetAutoComplet.asmx"
                            ServiceMethod="GetCustomerCode" CompletionInterval="1000" MinimumPrefixLength="1"
                            EnableCaching="true" CompletionSetCount="20" DelimiterCharacters=";," ShowOnlyCurrentWordInCompletionListItem="true"
                            OnClientItemSelected="selected_Customer" CompletionListCssClass="autocomplete_completionListElement"
                            CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Service By</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Service_By" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Service_By" runat="server" ControlToValidate="ddl_Service_By"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Contract Type</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Contract_Type" runat="server"  />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Contract_Type" runat="server" ControlToValidate="ddl_Contract_Type"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Category</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Category" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Category" runat="server" ControlToValidate="ddl_Category"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Pickup/Drop</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Pickup_Drop" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Pickup_Drop" runat="server" ControlToValidate="ddl_Pickup_Drop"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Route</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Route" Width="250px" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Route" runat="server" ControlToValidate="ddl_Route"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td class="blackfnt" style="text-align: left;">
                        <font class="bluefnt">Duration</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddl_Duration" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Duration" runat="server" ControlToValidate="ddl_Duration"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <br />
        </ew:CollapsablePanel>
    </asp:Panel>
    <asp:Panel ID="Panel3" GroupingText="Vehicle Details" Width="850px" runat="server"
        Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
        <ew:CollapsablePanel ID="CollapsablePanel3" runat="server" Width="800px" CollapseImageUrl="~/GUI/images/collapse_blue.jpg"
            ExpandImageUrl="~/GUI/images/expand_blue.jpg">
            <br />
            <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
                <tr style="background-color: White" runat="server" id="Tr2">
                    <td colspan="6" class="blackfnt" style="text-align: left;">
                        <asp:Label ID="lbl_Err_Veh1" class="redfnt" runat="server" Text="" />
                        <asp:Label ID="lbl_Err_Veh" class="redfnt" runat="server" Text="" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Vehicle Mode</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_Vehicle_Mode" Width="125px" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfv_ddl_Vehicle_Mode" runat="server" ControlToValidate="ddl_Vehicle_Mode"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <font class="bluefnt">Select Vehicle</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_Vehicle_No" runat="server" Width="125" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Vehicle_No" runat="server" ControlToValidate="ddl_Vehicle_No"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <font class="bluefnt">Select Driver</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_Driver" runat="server" Width="125" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Driver" runat="server" ControlToValidate="ddl_Driver"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Vehicle Category</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_Vehicle_Category" runat="server" Width="100" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Vehicle_Category" runat="server" ControlToValidate="ddl_Vehicle_Category"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <font class="bluefnt">Vendor/Vehicle Type</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Vendor_Name" Text="" Width="175px" BorderStyle="None" 
                            runat="server"></asp:TextBox>
                        <font class="blackfnt">/</font>
                        <asp:TextBox ID="tb_Vehicle_Type" Text="" Width="175px" BorderStyle="None" 
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <font class="bluefnt">One/Two Way</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_Way" runat="server" Width="100" />
                        <asp:RequiredFieldValidator ID="rfv_ddl_Way" runat="server" ControlToValidate="ddl_Way"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Driver Licence Number</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Licno" BorderStyle="None" runat="server" />
                    </td>
                    <td>
                        <font class="bluefnt">Licence Validity Date</font>
                    </td>
                    <td>
                        <asp:HiddenField ID="hf_Manual_Driver_Code" runat="server" />
                        <asp:TextBox ID="tb_Validity_Date" BorderStyle="None" runat="server" />
                    </td>
                    <td>
                        <font class="bluefnt">Std. KM as per Reckoner</font>
                    </td>
                    <td>
                        <asp:HiddenField ID="hf_Standard_KM_Rec" runat="server" />
                        <asp:TextBox ID="tb_Standard_KM_Rec" Text="" Width="100px" BorderStyle="None" 
                            runat="server"></asp:TextBox>
                    </td
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Out Station</font>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rblst_Out_Station" RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                            <asp:ListItem Text="No" Value="N" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td>
                        <font class="bluefnt">Working Days</font>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rblst_Working_Days" RepeatDirection="Horizontal"
                            runat="server">
                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                            <asp:ListItem Text="No" Value="N" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td>
                        <font class="bluefnt">Currnet KM Reading</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Current_KM_Read" Text="" Width="100px" BorderStyle="None" 
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Start Date</font>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="tb_Start_Date" onblur="CheckStartDate()" CssClass="input" BorderStyle="Groove"
                                        Width="60px" runat="server"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                                        TargetControlID="tb_Start_Date" PopupButtonID="ImageButton1" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tb_Start_Time" onblur="CheckStartTime()"  CssClass="input" BorderStyle="Groove"
                                        Width="40px" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/calendar.jpg"
                                        CausesValidation="False" />
                                    <asp:RequiredFieldValidator ID="rfv_tb_Start_Date" runat="server" ControlToValidate="tb_Start_Date"
                                        ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <font class="bluefnt">End Date</font>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="tb_End_Date" onblur="CheckEndDate()"  CssClass="input" BorderStyle="Groove"
                                        Width="60px" runat="server"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy"
                                        TargetControlID="tb_End_Date" PopupButtonID="ImageButton2" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tb_End_Time" onblur="CheckEndTime()"  CssClass="input" BorderStyle="Groove"
                                        Width="40px" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/GUI/images/calendar.jpg"
                                        CausesValidation="False" />
                                    <asp:RequiredFieldValidator ID="rfv_tb_End_Date" runat="server" ControlToValidate="tb_End_Date"
                                        ErrorMessage="!!!"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <font class="bluefnt">Total Hours</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Total_Hours" BorderStyle="None"
                            Width="75px" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Start KM Read</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Start_KM_Read" Width="75px" onBlur="CheckStartKM()"
                            BorderStyle="Groove" CssClass="InputRight" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_tb_Start_KM_Read" runat="server" ControlToValidate="tb_Start_KM_Read"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                            TargetControlID="tb_Start_KM_Read" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">End KM Read</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_End_KM_Read" Width="75px" onBlur="CheckEndKM()"
                            BorderStyle="Groove" CssClass="InputRight" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_tb_End_KM_Read" runat="server" ControlToValidate="tb_End_KM_Read"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
                            TargetControlID="tb_End_KM_Read" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">Total KM</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Total_KM" BorderStyle="None" Width="75px"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <ajaxToolkit:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="ddl_Vehicle_Mode"
                Category="vehmode" PromptText="Select Vehicle Mode" LoadingText="[Loading vehilce mode...]"
                ServicePath="DropDownWebService.asmx" ServiceMethod="GetDropDownContents" />
            <ajaxToolkit:CascadingDropDown ID="CascadingDropDown2" runat="server" TargetControlID="ddl_Vehicle_No"
                Category="vehicle" PromptText="Select Vehicle" LoadingText="[Loading vehicles...]"
                ServiceMethod="GetDropDownContentsPageMethod" ParentControlID="ddl_Vehicle_Mode" />
            <ajaxToolkit:CascadingDropDown ID="CascadingDropDown3" runat="server" TargetControlID="ddl_Driver"
                Category="driver" PromptText="Select Driver" LoadingText="[Loading drivers...]"
                ServicePath="DropDownWebService.asmx" ServiceMethod="GetDropDownContents" ParentControlID="ddl_Vehicle_No" />
            <br />
        </ew:CollapsablePanel>
    </asp:Panel>
     <asp:Panel ID="Panel6" GroupingText="Financial /contact details based on contract"
            Width="850px" runat="server" Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
            <ew:collapsablepanel id="CollapsablePanel6" runat="server" width="800px" collapseimageurl="~/GUI/images/collapse_blue.jpg"
                expandimageurl="~/GUI/images/expand_blue.jpg">
            <br />
            <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
                <tr style="background-color: White" runat="server" id="Tr3">
                    <td colspan="6" class="blackfnt" style="text-align: left;">
                        <asp:Label ID="lbl_Err_" class="redfnt" runat="server" Text="" />
                        
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Standard Hrs.</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Std_Hrs" CssClass="InputRight" BorderStyle="Groove"
                            Width="75px" runat="server"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server"
                            TargetControlID="tb_Std_Hrs" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">Standard KM. Run</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Std_KM" CssClass="InputRight" BorderStyle="Groove" Width="75px" 
                            runat="server"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server"
                            TargetControlID="tb_Std_KM" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">Logsheet Amount</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Logsheet_Amt" CssClass="InputRight" BorderStyle="Groove" Text="0" 
                            Width="75px" onblur="CalculateAmt()" runat="server"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="rfv_tb_Logsheet_Amt" runat="server" ControlToValidate="tb_Logsheet_Amt"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server"
                            TargetControlID="tb_Logsheet_Amt" FilterType="Numbers" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Toll Charges</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Toll_Charge"  onblur="CalculateAmt()" CssClass="InputRight" BorderStyle="Groove" Text="0" 
                            Width="75px" runat="server"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
                            TargetControlID="tb_Toll_Charge" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">Parking Charges</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Parking_Charges" onblur="CalculateAmt()" CssClass="InputRight" BorderStyle="Groove" Text="0" 
                            Width="75px" runat="server"></asp:TextBox>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server"
                            TargetControlID="tb_Parking_Charges" FilterType="Numbers" />
                    </td>
                    <td>
                        <font class="bluefnt">Total Amount</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Total_Amt" onblur="CalculateAmt()" CssClass="InputRight" BorderStyle="Groove"
                            Width="75px" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
        </ew:collapsablepanel>
        </asp:Panel>
    <br />
    <asp:Panel ID="Panel4" GroupingText="Employees Details" Width="850px" runat="server"
        Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
        <ew:CollapsablePanel ID="CollapsablePanel4" runat="server" Width="800px" CollapseImageUrl="~/GUI/images/collapse_blue.jpg"
            ExpandImageUrl="~/GUI/images/expand_blue.jpg">
            <br />
            <asp:UpdatePanel runat="server" ID="updone">
                <ContentTemplate>
                    <table cellspacing="1" cellpadding="4" width="100%" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td align="left" width="20%">
                                <asp:Label CssClass="blackfnt" ID="Label15" runat="server">Enter no. of rows </asp:Label>
                            </td>
                            <td width="80%">
                                <asp:TextBox ID="tb_Row_No" MaxLength="2" runat="server" Width="20"
                                    BorderStyle="Groove" onkeydown="return numeric(event)" Text="0" AutoPostBack="true"
                                    OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td colspan="2" width="100%">
                                <asp:GridView ID="gv_Employee_Det" runat="server" HeaderStyle-CssClass="bgbluegrey"
                                    OnRowDeleting="gv_Employee_Details_RowDeleting" CellPadding="4" CellSpacing="0"
                                    AutoGenerateColumns="False" SelectedIndex="1" Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl.No.">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="5%" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee Code">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="15%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Emp_Code" Text='<%# DataBinder.Eval(Container.DataItem,"Emp_Code") %>'
                                                    MaxLength="50" CssClass="input" runat="server" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee Name">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="20%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Emp_Name" Text='<%# DataBinder.Eval(Container.DataItem,"Emp_Name") %>'
                                                    MaxLength="100" CssClass="input" runat="server" Width="150px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Department">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="15%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Department" Text='<%# DataBinder.Eval(Container.DataItem,"Department") %>'
                                                    MaxLength="50" CssClass="input" runat="server" Width="100px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="From Area">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="12%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_From_Area" Text='<%# DataBinder.Eval(Container.DataItem,"From_Area") %>'
                                                    MaxLength="50" CssClass="input" runat="server" Width="50px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Area">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="12%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_To_Area" Text='<%# DataBinder.Eval(Container.DataItem,"To_Area") %>'
                                                    MaxLength="50" CssClass="input" runat="server" Width="50px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="5%" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtn_Delete_Row" runat="server" Font-Underline="true" CausesValidation="false"
                                                    CommandName="Delete" CommandArgument='<%#Container.DataItemIndex%>'>Delete</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="bgbluegrey" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
        </ew:CollapsablePanel>
    </asp:Panel>
    <asp:Panel ID="Panel5" GroupingText="Remarks & Service Level Parameters" Width="850px"
        runat="server" Font-Names="Verdana" Font-Size="8pt" HorizontalAlign="Center">
        <ew:CollapsablePanel ID="CollapsablePanel5" runat="server" Width="800px" CollapseImageUrl="~/GUI/images/collapse_blue.jpg"
            ExpandImageUrl="~/GUI/images/expand_blue.jpg">
            <br />
            <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
                <tr style="background-color: White" runat="server" id="Tr1">
                    <td colspan="2" class="blackfnt" style="text-align: left; width: 600px;">
                        <asp:Label ID="Label1" class="redfnt" ForeColor="red" runat="server" Text="" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Remarks</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Remarks" Width="450px" MaxLength="4000" Height="40px"
                            TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td>
                        <font class="bluefnt">Service Level Parameters</font>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_Service_level" Width="450px" MaxLength="4000" Height="40px"
                            TextMode="MultiLine" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
        </ew:CollapsablePanel>
    </asp:Panel>
    <br />
   
            <table cellspacing="1" width="800px" class="boxbg" border="0">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Button ID="btn_Submit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                             OnClientClick="ValidateData()" CssClass="blackfnt" OnClick="btn_Submit_Click" />
                             
                             <%----%>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgr:ProgressBar ID="pgrone" runat="server" />
</asp:Content>
