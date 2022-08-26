<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SupplementaryBillGeneration.aspx.cs" Inherits="GUI_Finance_Billing_GST_BillGeneration_SupplementaryBillGeneration" %>

<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="uc1" TagName="UserMessage" %>
<%@ Register TagPrefix="xac" TagName="WebxComplete" Src="~/GUI/Common_UserControls/AutoComplete/CRM.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="pb1" TagName="ProgressBar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="JS/SupplementaryBillGeneration.js?v=9"></script>
    <script language="javascript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../Images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>";
        var FinYear = "<%=Session["FinYear"]%>";
        var FinYear_to = parseInt(FinYear) + 1;
        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to;
        }
        var FinYear_fromdate = "01/04/" + FinYear;
        var FinYear_todate = "31/03/" + FinYear_to;
        var Sle_finyear = FinYear + "-" + FinYear_to;

        //window.onload = calculate_GST();
    </script>
    <style type="text/css">
        .imgBtnEvents {
            float: left;
        }
    </style>
    <br />
    <table style="width: 100%;">
        <tr>
            <td>
                <uc1:UserMessage runat="server" ID="msgBox" />
                <pb1:ProgressBar runat="server" ID="ucProgress" />
            </td>
        </tr>
        <tr runat="server" id="trMain1">
            <td>
                <asp:Panel ID="pnlFilter" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table id="tblMain" runat="server" class="boxbg" cellpadding="3" cellspacing="1" width="1100px">
                                <tr class="hrow">
                                    <td colspan="5" align="center">
                                        <asp:Label runat="server" ID="lblCustomerDetails" Text="Customer And Invoice Details" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField ID="HdnCustomerCode" runat="server" />
                                        <asp:HiddenField ID="hidMaxDate" runat="server" />
                                        <asp:HiddenField ID="hidInvoiceDateEditable" runat="server" />
                                        <asp:HiddenField ID="hidInvoiceDateBackDaysYN" runat="server" />
                                        <asp:HiddenField ID="hidInvoiceDateBackDays" runat="server" />
                                        <asp:HiddenField ID="hidDueDateEditable" runat="server" />
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td width="50px">
                                        <span style="margin-right: 0px;">Customer</span>
                                    </td>
                                    <td width="200px">
                                        <asp:Label runat="server" ID="lblCustomerName" Text=""></asp:Label>
                                        <asp:HiddenField ID="hidCustomerID" runat="server" />
                                    </td>
                                    <td>
                                        <span style="margin-right: 0px;">Invoice Number</span>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label runat="server" ID="lblInvoiceNumber" Text="System Generated" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td rowspan="2">
                                        <span style="margin-right: 0px;">Billing address</span>
                                    </td>
                                    <td width="200px" rowspan="2">
                                        <asp:Label runat="server" ID="lblBillingAddress" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <span style="margin-right: 0px;">Invoice Date</span>
                                    </td>
                                    <td colspan="2">
                                        <asp:HiddenField runat="server" ID="hdnSysDate" />
                                        <asp:HiddenField runat="server" ID="hdnPastDate" />
                                       <%-- <asp:TextBox ID="txtGenerationDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtGenerationDate,'anchor112','dd/MM/yyyy'); return false;"
                                            name="anchor112" id="anchor112">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>--%>

                                        <asp:TextBox ID="txtGenerationDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt" onblur="javascript: return ValidateDateOnBlur();"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtGenerationDate,'anchor1123','dd/MM/yyyy'); return false;"
                                            name="anchor1123" id="anchor1123">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Due Date</td>
                                    <td colspan="4">
                                        <asp:HiddenField runat="server" ID="hidCreditDays" Value="0" />
                                        <asp:TextBox ID="txtDueDate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                            CssClass="blackfnt" Enabled="false"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDueDate,'anchor1122','dd/MM/yyyy'); return false;"
                                            name="anchor112" id="anchor1122">
                                            <img src="../../../images/calendar.jpg" border="0" />
                                        </a>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td></td>
                                    <td style="text-align: center">
                                        <b>State</b>
                                    </td>
                                    <td style="text-align: center">
                                        <b>City</b>
                                    </td>
                                    <td style="text-align: center">
                                        <b>GSTIN</b>
                                    </td>
                                    <td style="text-align: center">
                                        <b>Location</b>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Generation</td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillGenerationState" CssClass="input" onblur="responseValidateState(this,'Generation');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:DropDownList ID="DDLBillGenerationState" runat="server" AutoPostBack="true" DataTextField="Name" DataValueField="Code"
                                            OnSelectedIndexChanged="DDLBillGenerationState_SelectedIndexChanged" Width="200px"
                                            onchange="javascript: calculate_GST();">
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationState"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationStateType"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillGenerationCity" CssClass="input" onblur="responseValidateCity(this,'Generation');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:Label runat="server" ID="LblBillGenerationCity" Text=""></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationCity"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label runat="server" ID="LblBillGenerationGSTIN" Text=""></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:TextBox runat="server" ID="txtBillGenerationLocation" CssClass="input" BorderStyle="Groove" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnBillGenerationLocation"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Submission</td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillSubmissionState" CssClass="input" onblur="responseValidateState(this,'Submission');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:DropDownList ID="DDLBillSubmissionState" runat="server" AutoPostBack="true" DataTextField="Name" DataValueField="Code"
                                            OnSelectedIndexChanged="DDLBillSubmissionState_SelectedIndexChanged" Width="200px"
                                            onchange="javascript: calculate_GST();">
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionState"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionStateType"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillSubmissionCity" CssClass="input" onblur="responseValidateCity(this,'Submission');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:Label runat="server" ID="LblBillSubmissionCity" Text=""></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionCity"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label runat="server" ID="LblBillSubmissionGSTIN" Text=""></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:TextBox runat="server" ID="txtBillSubmissionLocation" CssClass="input" BorderStyle="Groove" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnBillSubmissionLocation"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>Bill Collection</td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillCollectionState" CssClass="input" onblur="responseValidateState(this,'Collection');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:DropDownList ID="DDLBillCollectionState" runat="server" AutoPostBack="true" DataTextField="Name" DataValueField="Code"
                                            OnSelectedIndexChanged="DDLBillCollectionState_SelectedIndexChanged" Width="200px">
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionState"></asp:HiddenField>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionStateType"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <%--<asp:TextBox runat="server" ID="txtBillCollectionCity" CssClass="input" onblur="responseValidateCity(this,'Collection');" BorderStyle="Groove"></asp:TextBox>--%>
                                        <asp:Label runat="server" ID="LblBillCollectionCity" Text=""></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionCity"></asp:HiddenField>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:Label runat="server" ID="LblBillCollectionGSTIN" Text=""></asp:Label>
                                    </td>
                                    <td style="text-align: center">
                                        <asp:TextBox runat="server" ID="txtBillCollectionLocation" CssClass="input" BorderStyle="Groove" Enabled="False"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnBillCollectionLocation"></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="hrow align-center">
                                        <center><b>GST Details </b></center>
                                    </td>
                                </tr>
                                <%--<tr class="bgwhite">
                                    <td>Customer GSTIN</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCustomerGSTIN" Text=""></asp:Label>
                                    </td>
                                    <td>Transporter GSTIN</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblTransporterGSTIN" Text=""></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr class="bgwhite">
                                    <td>Inter-state</td>
                                    <td colspan="5">
                                        <asp:Label runat="server" ID="lblInterState" Text=""></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnInterState" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Table ID="tblBillDetails" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                        HorizontalAlign="Left" Width="1100px">
                        <asp:TableRow CssClass="hrow">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                <asp:Label runat="server" ID="lblTransactionDetails" Text="Transaction Details" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" runat="server" ID="tdBillDetails">
                            <asp:TableCell ColumnSpan="4">
                                <asp:UpdatePanel runat="server" ID="Updetail">
                                    <ContentTemplate>
                                        <table width="350" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080"
                                            class="boxbg">
                                            <tr style="background-color: White">
                                                <td style="text-align: center" class="blackfnt">&nbsp;Enter No. of Rows
                                                </td>
                                                <td style="text-align: center" class="blackfnt">&nbsp;<asp:TextBox ID="txtRows" runat="server" Style="text-align: right" BorderStyle="Groove"
                                                    onkeypress="javascript:validInt(event);" CssClass="input" Width="100px"></asp:TextBox>
                                                    &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Submit" UseSubmitBehavior="false"
                                                        OnClick="btnAdd_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table bgcolor="white" width="100%" border="0" cellspacing="0" cellpadding="3" align="center"
                                            class="boxbg">
                                            <tr style="background-color: White">
                                                <td style="text-align: center" class="blackfnt">
                                                    <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True" OnRowDataBound="grvcontrols_RowDataBound"
                                                                HeaderStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                                                <FooterStyle CssClass="boxbg" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sr. No.">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Account Code">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:TextBox ID="txtAccCode" runat="server" BorderStyle="Groove" Enabled="true"
                                                                                Width="80px" onblur="responseValidateAccCode(this);  calculate_GST();"></asp:TextBox>
                                                                            <asp:TextBox ID="txtDescription" runat="server" BorderStyle="Groove" Width="140px"
                                                                                Enabled="false"></asp:TextBox>
                                                                            <asp:HiddenField runat="server" ID="hdnDescription" />
                                                                            <br />
                                                                            <%-- <xac:WebxComplete ID="WebxComplete1" runat="server" WebxEntity="Acccode" CodeTarget="txtAccCode"
                                                                                    NameTarget="txtDescription" MinPrefixLength="3" />
                                                                            --%>
                                                                            <ajaxToolkit:AutoCompleteExtender ID="aceAccountCode" runat="server" TargetControlID="txtAccCode"
                                                                                ServicePath="~/services/WebxCommonService.asmx" ServiceMethod="GetAccCodeValueNameDetail" MinimumPrefixLength="3" CompletionSetCount="10"
                                                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                                ContextKey="" FirstRowSelected="True" Enabled="True" OnClientItemSelected="OnAccCode_Selected">
                                                                            </ajaxToolkit:AutoCompleteExtender>

                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                                        <FooterTemplate>
                                                                            <strong>&nbsp; Total</strong>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="SAC">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList runat="server" ID="ddlSACCode" CssClass="input" Width="200px"
                                                                                onchange="javascript : GetGstRate(this); calculate_GST();" />
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate></FooterTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Narration">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtNarration" Style="text-align: left" MaxLength="250" onblur="javascript:calculate_GST();"
                                                                                runat="server" BorderStyle="Groove" Width="100px" ></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate></FooterTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtAmt" Style="text-align: right" onchange="javascript: Nagative_Chk_wDecimal(this,''); calculate_GST();"
                                                                                onblur="javascript:calculate_GST();"
                                                                                runat="server" BorderStyle="Groove" Width="70px" Text="0.00"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate>
                                                                            <asp:TextBox ID="txtTotAmt" Style="text-align: right" runat="server" BorderStyle="Groove"
                                                                                Width="70px" MaxLength="10" Enabled="False" Text="0.00"></asp:TextBox>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="GST Rate">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtGSTRate" Style="text-align: right;" onchange="javascript: Nagative_Chk_wDecimal(this,'R'); calculate_GST();"
                                                                                runat="server" BorderStyle="Groove" Width="70px" Text="0.00" Enabled="False"></asp:TextBox>
                                                                            <asp:HiddenField runat="server" ID="hdnGSTRate" />
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate>
                                                                            <%--<asp:TextBox ID="txtTotGSTRate" Style="text-align: right" runat="server" BorderStyle="Groove"
                                                                    Width="60" MaxLength="10" Enabled="False" Text="0.00"></asp:TextBox>--%>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="GST Amount">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtGSTAmount" Style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this,'')"
                                                                                runat="server" BorderStyle="Groove" Width="70px" Text="0.00" Enabled="False"></asp:TextBox>
                                                                            <asp:HiddenField runat="server" ID="hdnGSTAmount" />
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate>
                                                                            <asp:TextBox ID="txtTotGSTAmount" Style="text-align: right" runat="server" BorderStyle="Groove"
                                                                                Width="70px" MaxLength="10" Enabled="False" Text="0.00"></asp:TextBox>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Total">
                                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtTotal" Style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this,'')"
                                                                                runat="server" BorderStyle="Groove" Width="70px" Text="0.00" Enabled="False"></asp:TextBox>
                                                                            <asp:HiddenField runat="server" ID="hdnItemTotal" />
                                                                        </ItemTemplate>
                                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="center" />
                                                                        <FooterTemplate>
                                                                            <asp:TextBox ID="txtTotTotal" Style="text-align: right" runat="server" BorderStyle="Groove"
                                                                                Width="70px" MaxLength="10" Enabled="False" Text="0.00"></asp:TextBox>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerStyle HorizontalAlign="Left" />
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="hrow">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                <asp:Label runat="server" ID="lblSummaryofTransactions" Text="Summary of Transactions" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                <table class="stbl" width="100%" cellpadding="1" cellspacing="1">
                                    <tr class="hrow">
                                        <td>Count</td>
                                        <td>Subtotal</td>
                                        <td>SGST</td>
                                        <td>UGST</td>
                                        <td>CGST</td>
                                        <td>IGST</td>
                                        <td>GST Total</td>
                                        <td>Total</td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <asp:Label runat="server" ID="lblCount"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnCount"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblSubtotal"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnSubtotal"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblSGST"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnSGST"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblUGST"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnUGST"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblCGST"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnCGST"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblIGST"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnIGST"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblGSTTotal"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnGSTTotal"></asp:HiddenField>
                                        </td>
                                        <td>
                                            <asp:Label runat="server" ID="lblTotal"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnTotal"></asp:HiddenField>
                                        </td>
                                    </tr>
                                </table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="hrow">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                <asp:Label runat="server" ID="Label1" Text="Summary of Ledger Posting" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                 <table id="tblLedgerPosting" class="stbl" style="width: 100%">
                                            <thead>
                                                <tr class="hrow">
                                                    <th>Ledger</th>
                                                    <th>Sub Ledger</th>
                                                    <th>Dr</th>
                                                    <th>Cr</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:Panel>
            </td>
        </tr>
        <tr runat="server" id="trMain2">
            <td>
                <asp:Table ID="Table1" runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1"
                    HorizontalAlign="Left" Width="1100px">
                    <asp:TableHeaderRow CssClass="bgbluegrey">
                        <asp:TableHeaderCell ColumnSpan="4">
                            <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" OnClientClick="javascript : return ValidateOnSubmit();" />
                            <%--OnClientClick="return newPopupWindow();"--%>
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
