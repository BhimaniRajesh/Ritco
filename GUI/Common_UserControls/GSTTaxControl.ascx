<%--
    Version 1.0.0.7 State based on location. 
    Version 1.0.0.6 Rule Based customer registration allow.
    Version 1.0.0.5 Added New logic if company is registerd with GST Then do overwrite Make RCM Yes to No else keep Yes as Yes.
    Version 1.0.0.4 Added New logic for RCM Applicalble if NOT Register Then Make RCM To NO and calculate GST For same. 
                    ALSO Removed Provisinal text and made single GST Number. 
    Version 1.0.0.3 Added new validation in Submit and added logic of overwrite RCM in case of no registration. 
    Version 1.0.0.2 Resolved all bugs
    Version 1.0.0.1 Implemention of control logic.
--%>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GSTTaxControl.ascx.cs" Inherits="GUI_Common_UserControls_GSTTaxControl" %>
<script type="text/javascript" src="<%= ResolveUrl("~/GUI/Common_UserControls/Js/jsGSTTaxCalculation.js?v1007") %>"></script>
<style type="text/css">
    .ui-autocomplete, ui-autocomplete-input {z-index:1000}
</style>
<asp:UpdatePanel runat="server" ID="updateGstPan">
    <ContentTemplate>
        <table class="boxbg" cellspacing="1" style="width: 100%;">
            <tr>
                <th class="hrow" colspan="4">
                    <asp:HiddenField runat="server" ID="hdnGSTBillingParyCode" />
                    <asp:HiddenField runat="server" ID="hdnCustomerId"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnRulesTBBAllowWithoutRegistration" Value="Y" />

                    <asp:HiddenField runat="server" ID="hdnPaybasisCode"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnProduct"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnStateCode"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnSACCAtegory"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnSACCode"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnServicetypeCode"></asp:HiddenField>

                    <asp:HiddenField ID="hdnPayBaseId" runat="server" />
                    <asp:HiddenField ID="hdnCityId" runat="server" />
                    <asp:HiddenField ID="hdnBookingBranch" runat="server" />
                    <asp:HiddenField runat="server" ID="hdnGSTRate"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnNonRegisterRate"></asp:HiddenField>

                    <asp:HiddenField runat="server" ID="hdnRCMApplicable"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnRCMApplicableActualValue"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnGSTAmount"></asp:HiddenField>
                    <asp:HiddenField runat="server" ID="hdnGstCreateStateUT" />

                    <asp:HiddenField runat="server" ID="hdnGstCreateGSTINNumber" />
                    <asp:HiddenField runat="server" ID="hdnGSTRegistered" />

                    <asp:HiddenField runat="server" ID="hdnIsGStDocumentScan" />
                    <asp:HiddenField runat="server" ID="hdnGSTRemark" />
                    <asp:HiddenField runat="server" ID="hdnDocketMode" />
                    <asp:HiddenField runat="server" ID="hdnDocketNumber" />
                    <asp:HiddenField runat="server" ID="hdnEnableGSTRCMLogic" />
                    <asp:HiddenField runat="server" ID="hdnCompanyCode" />
                    <asp:HiddenField runat="server" ID="hdnGSTPartyRegister" />
                    <asp:HiddenField runat="server" ID="hdnGSTRegister" />
                    <asp:HiddenField runat="server" ID="hdnGSTRegDeclaration" />
                    <asp:HiddenField runat="server" ID="hdnDeductAmount" />
                    <asp:HiddenField runat="server" ID="hdnDestinationBranch" />
                    <asp:HiddenField runat="server" ID="hdnDestinatonCityId" />
                    <asp:HiddenField runat="server" ID="hdnBilledAtBranch" />
                    <asp:HiddenField runat="server" ID="hdnBilledAtBranchActual" />                    
                    <asp:HiddenField runat="server" ID="hdnPartyAs" />
                    <asp:HiddenField runat="server" ID="hdnTempCsgnCode" />
                    <asp:HiddenField runat="server" ID="hdnTempCsgeCode" />                    
                    <asp:HiddenField runat="server" ID="hdnCustID" />
                    <asp:HiddenField runat="server" ID="hdnPlaceOfSupply" />

                    <asp:HiddenField runat="server" ID="hdnActualGstCreateStateUT" />
                    <asp:HiddenField runat="server" ID="hdnActualPlaceOfSupply" />
                    <asp:HiddenField runat="server" ID="hdnActualSACCode" />
                    <b>Customer GST Detail</b>                    
                </th>
            </tr>
            <tr class="nrow">
                <td style="width: 150px;">GST Exempted
                </td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlGSTExempted" onchange="onGSTExemptedChange()">
                        <asp:ListItem Value="Y">Yes</asp:ListItem>
                        <asp:ListItem Value="N" Selected="True">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="nrow ExemptionCategory" style="display: none;">
                <td>Exemption Category
                </td>
                <td colspan="3">
                    <asp:DropDownList runat="server" ID="ddlExemptionCategory" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Selected="True">--SELECT--</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="nrow">
                <td>Product</td>
                <td>
                    <asp:Label runat="server" ID="lblProduct"></asp:Label>
                </td>
                <td>Service Code</td>
                <td>
                    <asp:Label runat="server" ID="lblSACCategory" Style="display: none"></asp:Label>
                    <asp:Label runat="server" ID="lblServiceType"></asp:Label>
                </td>
            </tr>
            <tr class="nrow">
                <td>Pay Basis</td>
                <td>
                    <asp:Label runat="server" ID="lblPaybasis"></asp:Label>
                </td>
                <td>GST Payment party</td>
                <td>
                    <asp:Label runat="server" ID="lblBillingParyCode"></asp:Label>
                    :
                    <asp:Label runat="server" ID="lblBillingParty"></asp:Label>
                    <a href="javascript:void(0)" runat="server" id="registerCustomer" onclick="showDetails()" style="color: blue;">(Register Customer/GST Detail)</a>
                </td>
            </tr>
            <tr class="nrow">
                <td>State of Supply</td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlGstCreateBillingStateUT" onchange="javascript:LoadDetails()"
                        CssClass="ltxt" AppendDataBoundItems="true">
                    </asp:DropDownList>
                    <asp:Label runat="server" ID="lblStateName" Style="display: none"></asp:Label>
                </td>
                <td>Place of supply</td>
                <td>
                    <select id="ddlPlaceOFSupplyCity" onchange="javascript:OnChangePlaceOFSupplyCity()">
                    </select>
                </td>
            </tr>
            <tr class="nrow">
                <td>GSTIN</td>
                <td>
                    <asp:Label runat="server" ID="lblGSTInNumber"></asp:Label>
                    <a href="javascript:void(0)" runat="server" id="lnkGstDetails" onclick="showDetails()" style="color: blue;">(Register Customer/GST Detail)</a>
                </td>
                <td>Address
                </td>
                <td>
                    <asp:Label runat="server" ID="lblGstAddress"></asp:Label>
                </td>
            </tr>
            <tr class="nrow">
                <td>Billed At</td>
                <td colspan="3">
                    <select id="ddlLocation" onchange="javascript:ChangeLocationCall(this)" >
                    </select>
                </td>
            </tr>
        </table>
        <table class="boxbg" cellspacing="1" style="width: 40%;">
            <tr>
                <th class="hrow" colspan="4">
                    <b>GST Calculation</b>
                </th>
            </tr>
            <tr class="nrow">
                <td>Docket Sub-total</td>
                <td>
                    <asp:TextBox runat="server" CssClass="rtxt" ID="txtDocketSubTotal">0</asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>GST Rate</td>
                <td>
                    <asp:TextBox runat="server" CssClass="rtxt" ID="txtGstRate">0</asp:TextBox>%
                </td>
            </tr>
            <tr class="nrow">
                <td>GST Amount</td>
                <td>
                    <asp:TextBox runat="server" CssClass="rtxt" ID="txtGSTAmount">0</asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>RCM Applicable</td>
                <td>
                    <asp:Label runat="server" ID="lblRCMApplicable"></asp:Label>
                </td>
            </tr>
            <tr class="nrow">
                <td>GST Charged</td>
                <td>
                    <asp:TextBox runat="server" CssClass="rtxt" ID="txtGSTCharged">0</asp:TextBox>
                </td>
            </tr>
            <tr class="nrow">
                <td>Docket Total</td>
                <td>
                    <asp:TextBox runat="server" CssClass="rtxt" ID="txtDocketTotal">0</asp:TextBox>
                </td>
            </tr>
        </table>
        <div id="lightGstDetails" style="display: none" title="Customer Registration/ GST Registration">
            <table class="boxbg" cellspacing="1" style="width: 100%;">
                <tr class="nrow customerSelection">
                    <td>Enter GST/Party Details</td>
                    <td colspan="3">
                        <asp:TextBox CssClass="ltxt" runat="server" ID="txtCustomerSearch" onblur="return OnBlurCustomerSelection(this)" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr class="nrow">
                    <th class="hrow" colspan="5">
                        <b>Customer Detail</b>
                    </th>
                </tr>
                <tr class="nrow">
                    <td>Group Code</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlGroupCode" CssClass="ltxt" AppendDataBoundItems="true">
                            <asp:ListItem Value="">--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>Customer Name</td>
                    <td colspan="2">
                        <asp:TextBox runat="server" ID="txtCustomerName" MaxLength="50" onkeypress="return ValidAlphaNumeric(event,alphanumeric);" CssClass="ltxt"></asp:TextBox>
                    </td>
                </tr>
                <tr class="nrow">
                    <td>GST Registered</td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlGSTRegistered"
                            onchange="onGstRegistrationChange()"
                            CssClass="ltxt" AppendDataBoundItems="true">
                            <asp:ListItem Value="Y">Yes</asp:ListItem>
                            <asp:ListItem Value="N" Selected="True">No</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <label class="colDeclaration colDeclarationTitle">Declaration</label></td>
                    <td colspan="2">
                        <asp:HiddenField runat="server" ID="hdnCustomerDeclaratoinFiles" />
                        <asp:Label ID="lblCustomerDeclaratoinFilesText" CssClass="colDeclaration" runat="server"></asp:Label>
                        <asp:Button runat="server" CssClass="colDeclaration" ID="btnUploadDocuments"
                            Text="Upload Document" OnClientClick="javascript: getThing('UploadDocumnet'); return false;" />
                    </td>
                </tr>
            </table>
            <table class="boxbg gstMasterDetails" id="tableGstDetails" cellspacing="1" style="width: 100%;">
                <thead>
                    <tr class="nrow ">
                        <th class="hrow">GSTN</th>
                        <th class="hrow">State</th>
                        <th class="hrow">City</th>
                        <th class="hrow">Address</th>
                        <th class="hrow">Pin code</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr class="nrow gstMasterDetailsDataCapture">
                        <td>
                            <asp:TextBox runat="server" ID="txtGstCreateGSTINNumber" onkeypress="return ValidAlphaNumeric(event,alphanumeric);" MaxLength="16" CssClass="ltxt"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblGstCreateBillingStateUT"></asp:Label>
                        </td>
                        <td>
                            <select id="ddlCityRegistration">
                            </select>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtGstCreateBillingAddress" MaxLength="250" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtGstPinCode" MaxLength="6"></asp:TextBox>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div id="lightGstDetailsFade" class="black_overlay"></div>
    </ContentTemplate>
</asp:UpdatePanel>
