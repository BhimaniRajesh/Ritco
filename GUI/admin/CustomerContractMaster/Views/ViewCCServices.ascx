<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewCCServices.ascx.cs"
    Inherits="Views_ViewCCServices" %>
<asp:Panel ID="pnlMain" runat="server">
        <asp:Panel ID="Panel1" runat="server">
            <asp:Table ID="tblMain" runat="server" Width="10in" HorizontalAlign="left">             
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <asp:Table ID="tblMain2" runat="server" Width="10in" HorizontalAlign="left">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Panel ID="Panel2" runat="server" Style="width: 10in;" HorizontalAlign="left">
                                        <asp:Table runat="server" CellSpacing="1" ID="tblheader" CssClass="boxbg" Style="width: 100%;">
                                            <asp:TableRow ID="step1" CssClass="bgbluegrey" BorderWidth="1px">
                                                <asp:TableCell HorizontalAlign="left" ColumnSpan="4">
                                <b>Step 1 : Contract Details</b>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trrcplcustname" runat="server" BackColor="#ffffff" CssClass="blackfnt"
                                                BorderWidth="1px">
                                                <asp:TableCell>
                                Customer Code
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustcode" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Customer Name
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustname" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trrcplcontractid" BorderWidth="1px" runat="server" BackColor="#ffffff"
                                                CssClass="blackfnt">
                                                <asp:TableCell>
                                Contract ID
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblrcplcontractid" runat="server" CssClass="redfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trcustcodename" BorderWidth="1px" runat="server" BackColor="#ffffff"
                                                CssClass="blackfnt">
                                                <asp:TableCell>
                                Customer Code & Name
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustcodename" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Contract ID
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcontractid" runat="server" CssClass="redfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trDate" BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Contract Date
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <asp:Label ID="lblcontractdate" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Valid Until
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <asp:Label ID="lblvaliduntil" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Effective From Date</asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <asp:Label ID="lbleffectivedate" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Contract Signing Location
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcontractsignloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Customer Representative
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustrepresent" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Company Employee Name
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcompempname" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Designation
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustempdesig" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Designation
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcompempdesig" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Customer Witness</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcustwitness" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Company Witness
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcompwitness" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Billing Address</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblbilladdress" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                City-Pincode
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcitypincode" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Party Category</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblpartycat" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Contract Category
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcontractcat" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                                <asp:TableCell>
                                Service Tax Applicable</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblstaxapplicable" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                Accounts Representative
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblaccrepresent" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" ID="trcommitedbusiness" runat="server">
                                                <asp:TableCell>
                                Commited Business
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcommitedbusiness" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell ColumnSpan="2">
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" ID="treditinfo" runat="server">
                                                <asp:TableCell CssClass="blackfnt">
                                Last Edit By
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lbllasteditby" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>Last Edit Date
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lbllasteditdate" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BorderWidth="1px" BackColor="#ffffff" ID="trcontractmode" runat="server">
                                                <asp:TableCell>
                                        Contract Mode
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblcontractmode" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                            Remarks
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblremarks" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:Panel>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                    &nbsp;
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left">
                                    <br />
                                    <asp:Table ID="tbldetail" runat="server" CellSpacing="1" CssClass="boxbg" Width="10in">
                                        <asp:TableRow ID="step2" BorderWidth="1px" CssClass="bgbluegrey">
                                            <asp:TableCell HorizontalAlign="left" ColumnSpan="5">
                            <b>Step 2 : Contract Details</b>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell Style="width: 20%;">
                            Mode of Transport
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblTransportMode" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Type of Load
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblLoadType" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Flat MultiPoint PickUp
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFlatMultiPointPU" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                           Location Wise MultiPoint PickUp 
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblLocMultiPointPU" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>                                        
                                        <asp:TableRow BorderWidth="1px" ID="trLoadingCharges" runat="server" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Flat Loading Charges 
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFlatLoadingCharges" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                           Location Wise Loading Charges  
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblLocLoadingCharges" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Flat MultiPoint Delivery
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFlatMultiPointDL" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                           Location Wise MultiPoint Delivery 
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblLocMultiPointDL" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>                                        
                                        <asp:TableRow BorderWidth="1px" ID="trUnLoadingCharges" runat="server" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Flat Unloading Charges 
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFlatUnLoadingCharges" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                           Location Wise Unloading Charges  
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblLocUnLoadingCharges" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>                                        
                                        
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Pick-Up Delivery
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lbldg" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            FOV Type
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblfovtype" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblfovflatrate" runat="server" CssClass="blackfnt"></asp:Label>
                                                <asp:Label ID="lblfovcarrierrate" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblfovownerrate" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Risk Type
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblRiskType" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Type of Minimum Freight
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblTypeMinFreight" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Insurance Percentage
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblinsuranceper" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Type of Service
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblTypeOfService" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trCodDoc" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            COD/DOD Charges
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Minimum in Rs.
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblCodMinRs" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                            % of Amount
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblCodPerAmount" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trVolumetric" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Volumetric Measure
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblVolMeasureType" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Volumetric conversion 1 CFT=Kg.
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label ID="lblCFTToKg" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trDACC" runat="server" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            DACC Charges
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Minimum in Rs.
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblDACCMinRs" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                            % of Freight
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblDACCPerFreight" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeApp" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell Style="height: 20px;" ColumnSpan="5">
                           
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell Style="width: 20%;">
                            Fuel Surcharge Applicable
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblFuelSurcharge" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeTitle" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true">Air</asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true">Road</asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true">Train</asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true">Express</asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeBase" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Fuel Surcharge Based On
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargebasair" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargebasroad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargebastrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargebasexpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeRate" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Rate
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargeRateAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargeRateRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargeRateTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblFuelSurchargeRateExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeMin" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Min Charges in RS
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMinFuelSurchargeAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMinFuelSurchargeRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMinFuelSurchargeTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMinFuelSurchargeExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trFuelSurchargeMax" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Max Charge in RS
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMaxFuelSurchargeAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMaxFuelSurchargeRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMaxFuelSurchargeTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMaxFuelSurchargeExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trOctroiSurcharge" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell Style="height: 20px;" ColumnSpan="5">
                           
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell Style="width: 20%;">
                            Octroi Surcharge Applicable
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblOctroiSurchargeApp" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trOctroiSurChargeBase" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Octroi Sur Charge Based On
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblOctroiBase" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>                            Octroi SurCharge                                               
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblOctroiSurCharge" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trOctroiSurChargeMin" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell>
                            Minimum Octroi Charge in RS
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblMinOctroi" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>                           Maximum Octroi Charge in RS                                               
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                                <asp:Label ID="lblMaxOctroi" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" ID="trOctroiSurchargeEd" runat="server" BackColor="#ffffff"
                                            CssClass="blackfnt">
                                            <asp:TableCell Style="height: 20px;" ColumnSpan="5">
                           
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Demurrage After Days
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lbldemafterdays" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="4">
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Demurrage Charges
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Minimum Charges</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblmindemchrg" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell>
                            Per Kg.</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lbldemperkg" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Bill Generation Location
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblbillgenloc" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                            Billing Instance</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblbillinginstance" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Bill Submission at Location
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblbillsubloc" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                            Total Credit Limit(in Rs)</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lbltotlimitrs" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            Bill Collection at Location</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblbillcolloc" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                            Credit days from Generation
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblcreditdaysfromgen" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell>
                            SKU Y/N
                                            </asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblsku" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="2">
                            Service Tax Paid By</asp:TableCell>
                                            <asp:TableCell>
                                                <asp:Label ID="lblstaxpaidby" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell BorderWidth="1px" HorizontalAlign="Left">
                                    <br />
                                    <asp:Table runat="server" ID="ChargesMst" CellPadding="1" CellSpacing="1" Style="width: 7in;"
                                        CssClass="boxbg">
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                    &nbsp;
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left">
                                    <br />
                                    <asp:Table ID="tblbasewiseminfreight" runat="server" CellSpacing="1" CssClass="boxbg" Width="5in">
                                        <asp:TableRow BorderWidth="1px" CssClass="bgbluegrey">
                                            <asp:TableCell ColumnSpan="3" Font-Bold="true">
                            Minimum Freight Details
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt" HorizontalAlign="center">
                                            <asp:TableCell HorizontalAlign="center">
                            Mode of Transport
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                            Rate
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                            Basis
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell HorizontalAlign="center">
                            Air
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="rate_air" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="basis_air" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell HorizontalAlign="center">
                            Road
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="rate_road" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="basis_road" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell HorizontalAlign="center">
                            Train
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="rate_train" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="basis_train" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow BorderWidth="1px" BackColor="#ffffff" CssClass="blackfnt">
                                            <asp:TableCell HorizontalAlign="center">
                            Express
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="rate_express" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="center">
                                                <b>
                                                    <asp:Label ID="basis_express" runat="server" CssClass="blackfnt"></asp:Label></b>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Left">                                    
                                    <asp:Table ID="tblpercentwiseminfreight" runat="server" Width="60%" CellSpacing="1"
                                        CssClass="boxbg">
                                        <asp:TableRow CssClass="bgbluegrey">
                                            <asp:TableCell></asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    Freght Rate
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    SubTotal
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow CssClass="bgwhite">
                                            <asp:TableCell Width="20%"></asp:TableCell>
                                            <asp:TableCell Width="40%" HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                                <asp:Label ID="lblApplyFreight" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell Width="40%" HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                                <asp:Label ID="lblApplySubtotal" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow CssClass="bgbluegrey">
                                            <asp:TableCell>
                                    &nbsp;Mode of Transport
                                            </asp:TableCell>
                                            <asp:TableCell>
                                    &nbsp;Minimum Freight<br /> (in RS)
                                            </asp:TableCell>
                                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                                            </asp:TableCell>
                                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                                            </asp:TableCell>
                                            <asp:TableCell>
                                    &nbsp;Minimum<br /> (in RS)
                                            </asp:TableCell>
                                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                                            </asp:TableCell>
                                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: White">
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblmodenameair" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateLowerlimAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateUpperlimAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinSubTotalAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalLowerlimAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalUpperlimAir" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: White">
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblmodenameroad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateLowerlimRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateUpperlimRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinSubTotalRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalLowerlimRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalUpperlimRoad" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: White">
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblmodenametrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateLowerlimTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateUpperlimTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinSubTotalTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalLowerlimTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalUpperlimTrain" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: White">
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblmodenameexpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateLowerlimExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinFreightRateUpperlimExpree" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblMinSubTotalExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalLowerlimExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Left">
                                                <asp:Label ID="lblSubTotalUpperlimExpress" runat="server" CssClass="blackfnt"></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                    &nbsp;
                                </asp:TableCell>
                            </asp:TableRow>                   
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>                         
            </asp:Table>
            <asp:HiddenField ID="hdncustcode" runat="server" />
            <asp:HiddenField ID="hdncontractid" runat="server" />
            <asp:HiddenField ID="hdnftls" runat="server" />
        </asp:Panel>  
</asp:Panel>
