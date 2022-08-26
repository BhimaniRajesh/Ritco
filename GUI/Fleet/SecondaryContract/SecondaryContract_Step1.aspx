<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SecondaryContract_Step1.aspx.cs" Inherits="GUI_Fleet_SecondaryContract_Step1"
    Title="" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="AJAX_Validator/SecondaryContract.js"></script>

    <script language="javascript" type="text/javascript">

//        window.onload = 
//        function AA() {
//            var tr_HourlyBased = document.getElementById("ctl00_MyCPH1_tr_HourlyBased");
//            var tr_HourlyBased_det = document.getElementById("ctl00_MyCPH1_tr_HourlyBased_det");

//            tr_HourlyBased.style["display"] = "none";
//            tr_HourlyBased_det.style["display"] = "none";

//            return false;
//        }
    
    </script>

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
    <%--<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>--%>
    <br />
    <br />
    <br />
    <div style="text-align: left; width: 10.0in">
        <table cellspacing="1" class="boxbg" width="600">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Secondary Contract</strong>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="600">
                    <tr style="background-color: White">
                        <td colspan="2" class="blackfnt" style="text-align: left; width: 600px;">
                            <asp:Label ID="lbl_Error" class="blackfnt" ForeColor="red" runat="server" Text="" />
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td width="300px" class="blackfnt" style="text-align: left;">
                            &nbsp;Select Customer
                        </td>
                        <td width="300px" class="blackfnt" width="551" style="text-align: left;">
                            <asp:TextBox ID="tb_Customer_Code" BorderStyle="Groove" runat="server" Width="100px"
                                CssClass="input" MaxLength="50"></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender runat="server" ID="AutoCompleteExtender1" TargetControlID="tb_Customer_Code"
                                ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetCustomerCode"
                                MinimumPrefixLength="1" CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20"
                                CompletionListCssClass="autocomplete_completionListElement" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" DelimiterCharacters=";, :">
                            </ajaxToolkit:AutoCompleteExtender>
                            <asp:TextBox ID="tb_Customer_Name" BorderStyle="Groove" runat="server" Width="150px"
                                CssClass="input" MaxLength="150"></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender runat="server" ID="autoCompleteType" TargetControlID="tb_Customer_Name"
                                ServicePath="~/services/FleetAutoComplet.asmx" ServiceMethod="GetCustomerName"
                                MinimumPrefixLength="1" CompletionInterval="1000" EnableCaching="true" CompletionSetCount="20"
                                CompletionListCssClass="autocomplete_completionListElement" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" DelimiterCharacters=";, :">
                            </ajaxToolkit:AutoCompleteExtender>
                            <asp:Label ID="lblPopup" runat="server" BorderStyle="Groove" TabIndex="18" Height="10px"
                                Text='<a href="javascript:popupCustomer(1)">...</a>' Width="14px"></asp:Label>
                            <asp:RequiredFieldValidator ID="ReqCustCode" runat="server" Display="Dynamic" Text="!!!"
                                ControlToValidate="tb_Customer_Name" ValidationGroup="main"></asp:RequiredFieldValidator>
                        </td>
                        
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Contract Date Range:
                        </td>
                        <td class="blackfnt" width="551" style="text-align: left">
                            From :
                            <asp:TextBox ID="tb_From_Date" BorderStyle="Groove" CssClass="input" runat="server"
                                Width="75px" MaxLength="1" Style="text-align: justify" ValidationGroup="MKE" />
                            <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/GUI/images/calendar.jpg"
                                CausesValidation="False" />
                            <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tb_From_Date"
                                Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                CultureName="en-GB" ErrorTooltipEnabled="True" />
                            <ajaxToolkit:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                ControlToValidate="tb_From_Date" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="Input a date" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" />
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                                TargetControlID="tb_From_Date" PopupButtonID="ImgBntCalc" />
                            To :
                            <asp:TextBox ID="tb_To_Date" BorderStyle="Groove" CssClass="input" runat="server"
                                Width="75px" MaxLength="1" Style="text-align: justify" ValidationGroup="MKE" />
                            <asp:ImageButton ID="ImgBntToCalc" runat="server" ImageUrl="~/GUI/images/calendar.jpg"
                                CausesValidation="False" />
                            <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="tb_To_Date"
                                Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                OnInvalidCssClass="MaskedEditError" MaskType="Date" CultureName="en-GB" DisplayMoney="Left"
                                AcceptNegative="Left" ErrorTooltipEnabled="True" />
                            <ajaxToolkit:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                ControlToValidate="tb_To_Date" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="Input a date" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" />
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server"
                                TargetControlID="tb_To_Date" PopupButtonID="ImgBntToCalc" />
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" class="blackfnt" style="text-align: left;">
                            <asp:Label ID="Label1" class="blackfnt" runat="server" Text="Service Definition" />
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Contract based On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:RadioButtonList ID="rblst_Contract_Based" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="FTL Type Wise" Value="FTL"></asp:ListItem>
                                <asp:ListItem Text="Vehicle Number Wise" Value="Vehicle"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            AC Status:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:CheckBoxList ID="chklst_AC" RepeatDirection="Horizontal" runat="server">
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Rate based On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:RadioButtonList onClick="javascript:CheckHourlyBased()" ID="rblst_Rate_Based"
                                runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Hourly Based" Value="Hourly"></asp:ListItem>
                                <asp:ListItem Text="Fixed" Value="Fixed"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="bgbluegrey" runat="server" id="tr_HourlyBased">
                        <td colspan="2" class="blackfnt" style="text-align: left;">
                            <asp:Panel ID="pnlHourBased" runat="server" Width="100%">
                                <table cellspacing="1" width="100%" class="boxbg" border="0">
                                    <tr class="bgbluegrey">
                                        <td width="60%">
                                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server">Rate Based On:</asp:Label>
                                        </td>
                                        <td align="left" width="20%">
                                            <asp:Label CssClass="blackfnt" ID="Label15" runat="server">Enter no. of rows </asp:Label>
                                        </td>
                                        <td width="5%">
                                            <asp:TextBox ID="tb_Row_No" MaxLength="2" runat="server" Width="20" BorderStyle="Groove"
                                                onkeydown="return numeric(event)" Text="0" AutoPostBack="true" OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                                        </td>
                                        <td width="10%">
                                            <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr style="background-color: White" runat="server" id="tr_HourlyBased_det">
                        <td colspan="2" class="blackfnt" style="text-align: left;">
                            <asp:Panel ID="pblTask" runat="server">
                                <asp:GridView ID="gv_Hourly_Based" runat="server" HeaderStyle-CssClass="bgbluegrey"
                                    OnRowDeleting="gv_Hourly_Based_RowDeleting" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False"
                                    SelectedIndex="1" Width="100%" OnRowDataBound="gv_Hourly_Based_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sl. No.">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="10%" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Hourly Based">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="40%" />
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hf_Id"  runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Id") %>'  />
                                                <asp:TextBox ID="tb_Hours" Text='<%# DataBinder.Eval(Container.DataItem,"HourlyBasedSlot") %>'
                                                    Style="text-align: right" MaxLength="3" CssClass="input" onkeydown="return numeric(event)"
                                                    runat="server" Width="50px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Extra Rs. Per Hours">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="40%" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="tb_Extra_Charge" Text='<%# DataBinder.Eval(Container.DataItem,"Extra_Charge_Per_Hour") %>'
                                                    Style="text-align: right" MaxLength="3" CssClass="input" onkeydown="return numeric(event)"
                                                    runat="server" Width="50px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="10%" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtn_Delete_Row" runat="server" Font-Underline="true" CausesValidation="false"
                                                    CommandName="Delete" CommandArgument='<%#Container.DataItemIndex%>'>Delete</asp:LinkButton>
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
                        <td class="blackfnt" style="text-align: left;">
                            &nbsp;Rate Type Allowed On:
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:RadioButtonList ID="rblst_RateType" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Per Km" Value="KM"></asp:ListItem>
                                <asp:ListItem Text="Per Kg" Value="KG"></asp:ListItem>
                                <asp:ListItem Text="Per Pkg" Value="PKG"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td class="blackfnt" style="text-align: left;">
                            <asp:CheckBox ID="chk_Variable_Cost" Text="Fixed and Variable Cost/Rate Based On:"
                                runat="server" />
                        </td>
                        <td class="blackfnt" style="text-align: left;">
                            <asp:RadioButtonList ID="rb_Variable_Matrix" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Non-matrix" Value="NonMatrix"></asp:ListItem>
                                <asp:ListItem Text="Matrix" Value="Matrix"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td colspan="2" class="blackfnt" style="text-align: left;">
                            <asp:CheckBox ID="chk_Standard_Charge" Text="Standard Charge Applicable" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td colspan="2" class="blackfnt" style="text-align: right;">
                            <asp:Button ID="btnSubmit" OnClick="btn_Submit_Click" runat="server" Text="Next Step" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
