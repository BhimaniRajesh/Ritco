<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ViewCustomerContractStep1.aspx.cs" Inherits="ViewCustomerContractStep1" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <div>
        
        <input type="hidden" id="HidRandomNo" runat="server" />
        <input type="hidden" id="HidCustCode" runat="server" />
        <input type="hidden" id="HidCustCodeName" runat="server" />
        
        <table cellpadding="1" cellspacing="1" border="0" width="70%">
            
            <tr>
			    <td colspan="2">
				    <label class="blackfnt">
				        <b>
				            Customer Contract Master - View Existing Contract
				        </b>
				        <hr align="center" size="1" color="#8ba0e5">
				    </label>
			    </td>
		    </tr>
        </table>
         
        <br style="font-size:2px;" />
            
        <%--Step 1 Details--%>
        <table cellpadding="1" cellspacing="1" class="boxbg" width="70%" border="0">
            <%--Row for header--%>
            <tr id="Tr1" class="bgbluegrey" runat="server">
                <td colspan="4" align="center" style="height: 25px;" nowrap>
                    <label class="blackfnt">
                        <strong>
                            &nbsp;Step 1: View contract details
                        </strong>
                    </label>
                </td>
            </tr>
        </table>
        
        <br style="font-size: 3px;" />
        
        <table cellpadding="1" cellspacing="1" class="boxbg" width="70%" border="0">
            <%--Row for header--%>
            <%--<tr class="bgbluegrey" runat="server">
                <td colspan="4" align="center" style="height: 25px;" nowrap>
                    <label class="blackfnt">
                        <strong>
                            &nbsp;Step 1: View contract details
                        </strong>
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White;">
                <td colspan="4">
                    <br style="font-size: 2px;" />
                </td>
            </tr>--%>
            
            <tr style="background-color: White;" runat="server">
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;Selected Customer:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" align="left" valign="top">
                    &nbsp;
                    <label class="blackfnt" id="lblSelectedCustomer" runat="server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt">
                        Contract ID:
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" style="color: Red;" runat="server" id="lblContractID">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Contract Date:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblContractDate" runat="server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Valid Until:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblContractUntilDate" runat="server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Effective From Date:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblContractEffFromDate" runat="server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Contract Signing Location:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblContSignLocation" runat="server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt">
                        &nbsp;Customer Representative:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCustRep" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;Company Employee Name:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCoEmpName" runat="Server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt">
                        &nbsp;Designation:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCustEmpDesi" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;Designation:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCoEmpDesi" runat="Server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt">
                        &nbsp;Customer Witness:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCustWitness" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;Company Witness:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCoWitness" runat="Server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt">
                        &nbsp;Billing Address:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblBillingAddress" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;City-Pin Code:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblCityPC" runat="Server">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Party Category:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left">
                    &nbsp;
                    <label class="blackfnt" id="lblPartyCategory" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt" style="color: Red;">
                        &nbsp;*
                    </label>
                    <label class="blackfnt">
                        Contract Category:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top">
                    &nbsp;
                    <label class="blackfnt" id="lblContractCategory" runat="Server">
                    </label>
                </td>
            </tr>
              
            <tr style="background-color: White" runat="server">
                <td style="width:20%;" valign="top" align="left" nowrap>
                    <label class="blackfnt">
                        &nbsp;Service Tax Applicable:&nbsp;
                    </label>
                </td>
                
                <td style="width:25%;" valign="top" align="left" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblSTApp" runat="Server">
                    </label>
                </td>
                
                <td style="width:20%;" align="left" valign="top" nowrap>
                    <label class="blackfnt">
                        &nbsp;Accounts Representative:&nbsp;
                    </label>
                </td>
                
                <td align="left" valign="top" nowrap>
                    &nbsp;
                    <label class="blackfnt" id="lblAcctRep" runat="Server">
                    </label>
                </td>
            </tr>  
             
        </table>
        
        <br />
        
        <%--Step 2 Details--%>
        <table cellpadding="1" cellspacing="1" class="boxbg" width="70%" border="0">
            <%--Row for header--%>
            <tr id="Tr2" class="bgbluegrey" runat="server">
                <td colspan="4" align="center" style="height: 25px;" nowrap>
                    <label class="blackfnt">
                        <strong>
                            &nbsp;Step 2: Summary of Charges
                        </strong>
                    </label>
                </td>
            </tr>
        </table>
        
        <br style="font-size: 3px;" />
        
        <table border="0" cellpadding="2" width="70%" cellspacing="1" class="boxbg">
            <%--<tr style="background-color: White">
                <td colspan="6" align="left">
                    <label class="blackfnt">
                        <b>
                            &nbsp;Step 2: Summary of Charges
                        </b>
                    </label>
                </td>
            </tr>--%>
            
            <tr> 
                <td style="background-color: White">
                    <label class="blackfnt">
                        &nbsp;Mode of Transport:
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label class="blackfnt" id="lblMTAir" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label class="blackfnt" id="lblMTRoad" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White" >
                    &nbsp;
                    <label class="blackfnt" id="lblMTTrain" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White" colspan="2">
                    &nbsp;
                    <label class="blackfnt" id="lblMTExpress" runat="server">
                    </label>
                </td>
            </tr>
            
            <tr> 
                <td style="background-color: White">
                    <label class="blackfnt">
                        &nbsp;Type of Load:
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label class="blackfnt" id="lblTLFTL" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White" colspan="4">
                    &nbsp;
                    <label class="blackfnt" id="lblTLSundry" runat="server">
                    </label>
                </td>
            </tr>
            
            <tr> 
                <td style="background-color: White">
                    <label class="blackfnt">
                        &nbsp;Pickup-Delivery:
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label class="blackfnt" id="lblPDGD" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label class="blackfnt" id="lblPDGG" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White" >
                    &nbsp;
                    <label class="blackfnt" id="lblPDDD" runat="server">
                    </label>
                </td>
                
                <td style="background-color: White" colspan="2">
                    &nbsp;
                    <label class="blackfnt" id="lblPDDG" runat="server">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Applicabl_yn_dp_chrg="Y"--%>                                   
            <%--For Door Pickup Charge--%>
            <tr id="trDoorPickupCharge" runat="server" visible="false"  style="background-color: White">
                <td>
                    <label class="blackfnt">
                        &nbsp;Door Pickup Charges:
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Minimum in Rs.:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblDoorPickupCharge" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Rate/Kg.:
                    </label>
                </td>
                
                <td colspan="2">    
                    &nbsp;
                    <label id="lblDoorPickupChargePerKg" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Applicabl_yn_dp_chrg="N"--%>
            <%--manage hidden variables - see CustomerContractStep1a.asp file--%>
            
            <%--Table row for Applicabl_yn_dd_chrg="Y"--%>
            <%--For Door Delivery Charge--%>
            <tr id="trDoorDeliveryCharge" runat="server" visible="false" style="background-color: White"> 
                <td>
                    <label class="blackfnt">
                        &nbsp;Door Delivery Charges:
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Minimum in Rs.:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblDoorDeliveryCharge" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Rate/Kg.:
                    </label>
                </td>
                
                <td colspan="2">
                    &nbsp;
                    <label id="lblDoorDeliveryChargePerKg" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Applicabl_yn_dd_chrg="N"--%>
            <%--manage hidden variables - see CustomerContractStep1a.asp file--%>
            
            <%--Table row for Applicabl_yn_fov="Y"--%>
            <%--For FOV Charge--%>
            <tr style="background-color: White" id="trFOVCharge" runat="server" visible="false"> 
                <td>
                    <label class="blackfnt">
                        &nbsp;FOV Type:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblFOVType" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;FOV Rate:
                    </label>
                </td>
                
                <td colspan="4">
                    &nbsp;
                    <label id="lblFOVCharge" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Applicabl_yn_fov="N"--%>
            <%--Manage hidden columns--%>
            
            <%--Table row for Insurance Percentage--%>
            <tr style="background-color: White"> 
                <td>
                    &nbsp;
                </td>
                
                <td>
                    &nbsp;
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Insurance Percentage:
                    </label>
                </td>
                
                <td colspan="4">
                    &nbsp;
                    <label id="lblInsPer" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Type of Service--%>
            <tr>
                <td style="background-color: White">
                    <label class="blackfnt">
                        &nbsp;Type of Service:
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label id="lblTSCODDOD" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label id="lblTSODA" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td style="background-color: White">
                    &nbsp;
                    <label id="lblTSVolumetric" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td style="background-color: White" colspan="2" valign="top">
                    &nbsp;
                    <label id="lblTSDACC" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for COD-DOD (Type of Service) checkbox checked--%>
            <tr id="trTSCODChecked" runat="server" visible="false" style="background-color: White">
                <td colspan="6">
                    <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="3">
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;COD/DOD Charges:
                                </label>
                            </td>
                            
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Minimum in Rs.:
                                </label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <label id="lblCODCharge" runat="server" class="blackfnt">
                    </label>
                            </td>
							
                            <td>
                                <label class="blackfnt">
                                    &nbsp;% of Amount:
                                </label>
                            </td>
                            
                            <td>						                                                                
                                &nbsp;
                                <label id="lblCODChargePer" runat="server" class="blackfnt">
                                </label>
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>       
            
            <%--Table row for Volumetric (Type of Service) checkbox checked--%>
            <tr id="trTSVolumetricChecked" runat="server" visible="false">
                <td colspan="6" style="background-color: White">
                    <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="3">
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Volumetric Measure:
                                </label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <label id="lblVolMeasure" runat="server" class="blackfnt">
                                </label>
                            </td>
                            
                            <td colspan="2">
                                <label class="blackfnt">
                                    &nbsp;Volumetric conversion 1 CFT=Kg.:
                                </label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <label id="lblCFTToKg" runat="server" class="blackfnt">
                                </label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <%--Table row for DACC (Type of Service) checkbox checked--%>
            <tr id="trTSDACCChecked" runat="server" style="background-color: White" visible="false">
                <td colspan="6">
                    <table width="100%" border="1" class="boxbg" cellspacing="0" cellpadding="3" bgcolor="#999999">
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;DACC Charges:
                                </label>
                            </td>
                            
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Minimum in Rs.:
                                </label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <label id="lblDACCChargeRs" runat="server" class="blackfnt">
                                </label>
                            </td>
                            
                            <td>
                                <label class="blackfnt">
                                    &nbsp;% of Freight:
                                </label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <label id="lblDACCChargePer" runat="server" class="blackfnt">
                                </label>
                            </td>           
                        </tr>
                    </table>
                </td>
            </tr>
            
            <%--Table row for Demurrage after days--%>
            <tr style="background-color: White"> 
                <td>
                    <label class="blackfnt">
                        &nbsp;Demurrage after days:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblDemAfterDays" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            
            <%--Table row for Applicabl_yn_dem="Y"--%>
            <tr id="trDemurrageCharges" style="background-color: White" runat="Server" visible="false">
                <td>
                    <label class="blackfnt">
                        &nbsp;Demurrage Charges:
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Minimum in Rs.:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblDemChargeRs" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Per Kg.:
                    </label>
                </td>
                
                <td colspan="2">
                    &nbsp;
                    <label id="lblDemChargePerKg" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Bill Generation Location--%>
            <tr style="background-color: White">
                <td>
                    <label class="blackfnt">
                        &nbsp;Bill Generation at Location:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblBillGen" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td colspan="3">
                    <label class="blackfnt">
                        &nbsp;Billing Instance:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblBillingInstance" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Bill Submission Location--%>
            <tr style="background-color: White">
                <td>
                    <label class="blackfnt">
                        &nbsp;Bill Submission at Location:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblBillSubLocation" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td colspan="3">
                    <label class="blackfnt">
                        &nbsp;Total credit limit Rs.:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblCreditLimit" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for Bill Collection Location--%>
            <tr style="background-color: White">
                <td>
                    <label class="blackfnt">
                        &nbsp;Bill Collection at Location:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblBillCollLocation" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td colspan="3">
                    <label class="blackfnt">
                        &nbsp;Credit days from generation:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblCreditDays" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--Table row for SKU Wise Y/N--%>
            <tr style="background-color: White">
                <td>
                    <label class="blackfnt">
                        &nbsp;SKU Wise Y/N:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSKU" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            
            <%--Table row for Service Tax Payment--%>
            <tr id="trServiceTax" style="background-color: White" runat="server" visible="false">
                <td>
                    <label class="blackfnt">
                        &nbsp;Service Tax Paid by:
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSTPaidBy" runat="server" class="blackfnt">
                    </label>
                    <%--<label style="margin-left: 5px;">
                    </label>
                    <asp:DropDownList ID="ddlSTPaidBy" runat="server" CssClass="blackfnt">
                        <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                        <asp:ListItem Selected="False" Text="Transporter" Value="T"></asp:ListItem>
                        <asp:ListItem Selected="False" Text="Party" Value="P"></asp:ListItem>
                    </asp:DropDownList>--%>
                </td>
                
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
        </table>
        
        <br />
        
        <%--<table border="0" cellpadding="2" width="90%" cellspacing="1" align="center" class="boxbg">--%>
            <%--Dynamically populate charges table in code behind--%>
            <%--<%=strContractCharges %>--%>
            <%--<%=strContractChargesHidden %>--%>
        <%--</table>--%>
        
        <table border="0" cellpadding="2" width="70%" cellspacing="1" class="boxbg">
            <tr style="background-color: White">
                <td style="width: 25%">
                    &nbsp;
                    <label id="lblSCHG01" runat="server" class="blackfnt"></label>
                </td>
                
                <td style="width: 25%">
                    &nbsp;
                    <label id="lblSCHG01Value" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td style="width: 25%">
                    &nbsp;
                    <label id="lblSCHG02" runat="server" class="blackfnt"></label>
                </td>
                
                <td style="width: 25%">
                    &nbsp;
                    <label id="lblSCHG02Value" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG03" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG03Value" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG04" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG04Value" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG05" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG05Value" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG06" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG06Value" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
              
            <%--<tr style="background-color: White">
                <td>
                    <label id="lblSCHG07" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG07" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
                
                <td>
                    <label id="lblSCHG08" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG08" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
            </tr>--%>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG09" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG09Value" runat="server" class="blackfnt">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG10" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG10Value" runat="server" class="blackfnt">
                    </label>
                </td>
            </tr>
            
            <%--<tr style="background-color: White">
                <td>
                    <label id="lblSCHG11" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG11" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
                
                <td>
                    <label id="lblSCHG12" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG12" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
            </tr> 
            
            <tr style="background-color: White">
                <td>
                    <label id="lblSCHG13" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG13" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
                
                <td>
                    <label id="lblSCHG14" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    <input id="txtSCHG14" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
                        onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
                </td>
            </tr>--%>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG15" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG15Value" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG16" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG16Value" runat="server" class="blackfnt"></label>
                </td>
            </tr> 
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG17" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG17Value" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG18" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG18Value" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG19" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG19Value" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG20" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG20Value" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG21" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG21Value" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG22" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG22Value" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label id="lblSCHG23" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblSCHG23Value" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                </td>
                
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        
        <%--<table border="0" cellpadding="0" width="70%" cellspacing="0" class="boxbg">
            <tr style="background-color: White">
                <td style="width: 25%">
                    <label id="lblUCHG01" runat="server" class="blackfnt"  visible="false"></label>
                </td>
                
                <td style="width: 25%">
                    <label id="lblUCHG01Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td style="width: 25%">
                    <label id="lblUCHG02" runat="server" class="blackfnt"  visible="false"></label>
                </td>
                
                <td style="width: 25%">
                    <label id="lblUCHG02Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    <label id="lblUCHG03" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG03Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG04" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG04Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    <label id="lblUCHG05" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG05Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG06" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG06Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    <label id="lblUCHG07" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG07Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG08" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG08Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    <label id="lblUCHG09" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG09Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG10" runat="server" class="blackfnt" visible="false"></label>
                </td>
                
                <td>
                    <label id="lblUCHG10Value" runat="server" class="blackfnt" visible="false"></label>
                </td>
            </tr>
        </table>--%>
        
        <p>
            <label class="blackfnt">
                <b>
                    &nbsp;Minimum Freight
                </b>
            </label>
        </p>
        
        <table border="0" cellpadding="2" width="40%" bgcolor="#808080" cellspacing="1" class="boxbg">
            <tr style="background-color: White"> 
                <td>
                    <label class="blackfnt">
                        &nbsp;Mode of Transport
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Rate
                    </label>
                </td>
                
                <td>
                    <label class="blackfnt">
                        &nbsp;Basis
                    </label>
                </td>    
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label class="blackfnt" id="lblAirForFreight" runat="server" style="margin-left: 5px;">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblAirRateForFreight" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblAirBasisForFreight" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label class="blackfnt" id="lblRoadForFreight" runat="server" style="margin-left: 5px;">            
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblRoadRateForFreight" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblRoadBasisForFreight" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label class="blackfnt" id="lblTrainForFreight" runat="server" style="margin-left: 5px;">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblTrainRateForFreight" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblTrainBasisForFreight" runat="server" class="blackfnt"></label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td>
                    &nbsp;
                    <label class="blackfnt" id="lblExpressForFreight" runat="server" style="margin-left: 5px;">
                    </label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblExpressRateForFreight" runat="server" class="blackfnt"></label>
                </td>
                
                <td>
                    &nbsp;
                    <label id="lblExpressBasisForFreight" runat="server" class="blackfnt"></label>
                </td>
            </tr>
        </table>
    </div>
            
</asp:Content>
