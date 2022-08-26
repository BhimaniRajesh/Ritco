<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorContract_view.aspx.cs" Inherits="GUI_Admin_Vendor_contract_VendorContract_view" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br /><br />
<table align="left" border="0" cellpadding="3" cellspacing="1"  style="width 9.0in" class="boxbg">
		<tr class="bgbluegrey">
			<td  align="center"><font class="blackfnt"><b>Vendor Contract Master</b></font></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF">
			<table  border="0" align="center" cellspacing="1" cellpadding="6" width="100%" class="boxbg">
								<tr class="bgbluegrey">
									<td colspan=4><font class="blackfnt"><strong><U>Step : 1</U></strong></font></td>
								</tr>
								<tr bgcolor="#ffffff">
											<td width="25%" ><font class="blackfnt">Vendor Name</font></td>
											
											<td width="25%"><font class="blackfnt" ><asp:Label cssclass="blackfnt" ID="lblVendor_Name" runat="server" >
                                                                            </asp:Label></font></td>
											<td width="25%"><font class="blackfnt">Vendor Type</font></td>
											
											<td width="25%"><font class="blackfnt" ><asp:Label cssclass="blackfnt" ID="lblVendorType" runat="server" >
                                                                            </asp:Label></font></td>
								</tr>
								<tr bgcolor="#ffffff">
										<td width="20%" ><font class="blackfnt">Contract Code</font></td>
										
										<td>
										<font class="blackfnt" color="red">
											
											<asp:Label cssclass="blackfnt" ID="lblContractCode" runat="server" >
                                                                            </asp:Label>
											
										</font></td>
										<td width="20%"><font class="blackfnt">Contract Date</font></td>
										
										<td ><font class="blackfnt" color="red"><asp:Label cssclass="blackfnt" ID="lblContractDate" runat="server" >
                                                                            </asp:Label></font></td>
								</tr>

				<tr bgcolor="#ffffff">
						<td width="20%" ><font class="blackfnt">Contract Signing Location</font></td>
						
						<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblContractsigninglocation" runat="server" >
                                                                            </asp:Label>
						</font></td>
						
						<td width="15%" ><font class="blackfnt">Valid Until</font></td>
						
						<td ><font class="blackfnt" color="red"><asp:Label cssclass="blackfnt" ID="lblValidUntil" runat="server" >
                                                                            </asp:Label></font></td>
				</tr>
			
								<tr bgcolor="#ffffff">
								<td width="20%"><font class="blackfnt">Vendor Representative</font></td>
								<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblVendorRepresentative" runat="server" >
                                                                            </asp:Label></font></td>
								
								<td width="20%" ><font class="blackfnt">Effective From Date</font></td>
								
								<td ><font class="blackfnt" color="red"><asp:Label cssclass="blackfnt" ID="lblEffectiveFromDate" runat="server" >
                                                                            </asp:Label></font></td>
				</tr>

				<tr bgcolor="#ffffff">
									<td width="20%"><font class="blackfnt">Designation</font></td>
									<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblDesignation" runat="server" >
                                                                            </asp:Label>	</font></td>
									
									<td width="20%" ><font class="blackfnt">Company Employee Name</font></td>
									
									<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblCompanyEmployeeName" runat="server" >
                                                                            </asp:Label></font></td>
				</tr>
				<tr bgcolor="#ffffff">
									<td width="20%"><font class="blackfnt">Vendor Witness</font></td>
									<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblVendorWitness" runat="server" >
                                                                            </asp:Label></font></td>
									
									<td width="20%" ><font class="blackfnt">Designation	</font></td>
									
									<td><font class="blackfnt">	<asp:Label cssclass="blackfnt" ID="lblDesignation_vendor" runat="server" >
                                                                            </asp:Label></font></td>
			</tr>
			<tr bgcolor="#ffffff">
									<td width="20%"><font class="blackfnt">Vendor Address</font></td>
									<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblVendorAddress" runat="server" >
                                                                            </asp:Label></font></td>
									
									<td width="20%" ><font class="blackfnt">Company Witness	</font></td>
									
									<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblCompanyWitness" runat="server" >
                                                                            </asp:Label></font></td>
		</tr>
		<tr bgcolor="#ffffff">
										<td width="20%"><font class="blackfnt">City- Pin</font></td>
										<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblCityPin" runat="server" >
                                                                            </asp:Label></font></td>
										
										<td width="20%" ><font class="blackfnt">Vendor Category</font></td>
										
										<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblVendorCategory" runat="server" >
                                                                            </asp:Label>
										</font>
										</td>
		</tr>
		<tr bgcolor="#ffffff">
								<td width="20%"><font class="blackfnt">TDS Applicable</font></td>
								
								<td ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblTDSApplicable" runat="server" >
                                                                            </asp:Label></font></td>
								
								<td width="20%" ><font class="blackfnt">Contract Category</font></td>
								
								<td><font class="blackfnt">
								<asp:Label cssclass="blackfnt" ID="lblContractCategory" runat="server" >
                                                                            </asp:Label>
								</font>
								
								</td>
			</tr>
			<tr bgcolor="#ffffff">
								<td width="20%"><font class="blackfnt">TDS Rate</font></td>
								<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblTDSRate" runat="server" >
                                                                            </asp:Label></font></td>
								
								<td width="20%" ><font class="blackfnt">Security Deposit Cheque(s)</font></td>
								
								<td>
								<font class="blackfnt">
								<asp:Label cssclass="blackfnt" ID="lblSecurityDepositCheque" runat="server" >
                                                                            </asp:Label>
								</font>	</td>
			</tr>
			<tr bgcolor="#ffffff">
						<td width="20%"><font class="blackfnt">Payment Interval</font></td>
						<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblPaymentInterval" runat="server" >
                                                                            </asp:Label>
						</font>
						
						<td width="20%" ><font class="blackfnt">Security Deposit Date</font></td>
						
						<td ><font class="blackfnt" color="red"><asp:Label cssclass="blackfnt" ID="lblSecurityDepositDate" runat="server" >
                                                                            </asp:Label></font></td>
				</tr>


				<tr bgcolor="#ffffff">
							<td width="20%"><font class="blackfnt">Payment Basis</font></td>
							<td width="20%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblPaymentBasis" runat="server" >
                                                                            </asp:Label>
																				</font>
																				
							</td>
							<td width="20%" ><font class="blackfnt">Security Deposit Amount</font></td>
							
							<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblSecurityDepositAmount" runat="server" >
                                                                            </asp:Label>
							</font></td>
		</tr>
		<tr bgcolor="#ffffff">
								<td width="20%" ><font class="blackfnt">Payment Location</font></td>
								
								<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblPaymentLocation" runat="server" >
                                                                            </asp:Label>
							</font></td>
								<td><font class="blackfnt">Monthly Phone Charges</font></td>
								<td><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblMonthlyPhoneCharges" runat="server" >
                                                                            </asp:Label></font></td>
		</tr>
		<tr bgcolor="#ffffff">
								<td width="20%" ><font class="blackfnt">Service</font></td>
								
								<td colspan=2><font class="blackfnt">
								<font class="blackfnt">Road - <asp:Label cssclass="blackfnt" ID="lblRoad" runat="server" >
                                                                            </asp:Label></font> <font class="blackfnt"></font>
								</font></td>
								<td><font class="blackfnt">Air - <asp:Label cssclass="blackfnt" ID="lblAir" runat="server" >
                                                                            </asp:Label></font><font class="blackfnt"></font></td>
		</tr>
		<tr bgcolor="#ffffff">
									<td width="20%" ><font class="blackfnt">&nbsp;</font></td>
									<td colspan=2><font class="blackfnt">Express - <asp:Label cssclass="blackfnt" ID="lblExpress" runat="server" >
                                                                            </asp:Label></font><font class="blackfnt"></font></td>
									<td><font class="blackfnt">Rail - <asp:Label cssclass="blackfnt" ID="lblRail" runat="server" >
                                                                            </asp:Label></font></td>
		</tr>

</table>
			
<br />
<table  border="0" align="center" cellspacing="1" cellpadding="6" width="100%" class="boxbg">
<tr >
<td colspan="5" class="bgbluegrey"><font class="blackfnt"><strong><U>Step : 2</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Summary of Charges</b> </strong></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Late Penalty</font></td>
<td width="25%" ><font class="blackfnt">Per hour</font></td>
<td width="25%"><font class="blackfnt" ><asp:Label cssclass="blackfnt" ID="lblLatePenalty" runat="server" >
                                                                            </asp:Label></font></td>
<td width="25%"><font class="blackfnt">% of Contract</font></td>
<td width="25%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblLateContract" runat="server" >
                                                                            </asp:Label></font></td></tr>
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Incentive</font></td>
<td width="25%" ><font class="blackfnt">Per hour</font></td>
<td width="25%"><font class="blackfnt" ><asp:Label cssclass="blackfnt" ID="lblIncentive" runat="server" >
                                                                            </asp:Label></font></td>
<td width="25%"><font class="blackfnt">% of Contract</font></td>
<td width="25%"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblIncentiveContract" runat="server" >
                                                                            </asp:Label></font></td></tr>  
</table>
<br />
<table  border="0" id="tblMatrix10"  visible="false" align="center" cellspacing="1" runat="server" cellpadding="6" width="100%" class="boxbg">
<tr >
<td colspan="2" class="bgbluegrey"><font class="blackfnt">Fixed Charges</font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Fixed Charges Rs. </font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblfchrg" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
</table>



<asp:Table id="tblMatrix1" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        
        <table  border="0" id="tblMatrix2a_9" align="center" visible="false" cellspacing="1" runat="server" cellpadding="6" width="100%" class="boxbg">
<tr >
<td colspan="2" class="bgbluegrey"><font class="blackfnt">Fixed Charges</font></td>
</tr>
<tr bgcolor="#ffffff" id="RWAT" runat="server">
<td width="25%"  ><font class="blackfnt">Applicable Transaction</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblAPPT" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Fixed charges - Minimum</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblminchrg" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Fixed charges - Maximum</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblmaxchrg" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Charge basis</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblchargebasis" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff" id="row12"  runat="server" >
<td width="25%"  ><font class="blackfnt">Slab basis</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblslabbasis" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
</table>

<br />
<table  border="0" id="tblRailSlab" align="center" visible="false" cellspacing="1" runat="server" cellpadding="6" width="100%" class="boxbg">
<tr >
<td colspan="12" class="bgbluegrey"><font class="blackfnt">Define Slab of KG.</font></td>
</tr>
<tr bgcolor="#ffffff" id="Tr1" runat="server">
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 1</strong></font></td>
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 2</strong></font></td>
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 3</strong></font></td>
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 4</strong></font></td>
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 5</strong></font></td>
<td colspan="2" style="text-align: center"><font class="blackfnt"><strong>Slab 6</strong></font></td>
                                                                  
</tr>
<tr bgcolor="#ffffff">
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>From</strong></font></td>
<td style="text-align: center"><font class="blackfnt"><strong>To</strong></font></td>
</tr>
<tr bgcolor="#ffffff">
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF1" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST1" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF2" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST2" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF3" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST3" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF4" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST4" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF5" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST5" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblSF6" runat="server" Text=""></asp:Label></font></td>
<td style="text-align: center"><font class="blackfnt"><asp:Label ID="lblST6" runat="server" Text=""></asp:Label></font></td>

</tr>

</table>
<br />

<asp:Table id="tblSC" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
</asp:Table>

        <asp:Table id="tblMatrix2b" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        <asp:Table id="tblMatrix6b" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        <asp:Table id="tblMatrix7a" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
         <asp:Table id="tblMatrix7c" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        
        <asp:Table id="tblMatrix7b" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        
        
        
        <asp:Table id="tblMatrix7d" Visible="false" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
                <asp:GridView CssClass="boxbg"  HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" CellSpacing="1" ID="grvSlab" runat="server" AutoGenerateColumns="False" Visible="False" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="rutnm" HeaderText="Route/Tonnage">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="MinVal" HeaderText="Min.">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="MaxVal" HeaderText="Max">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                         <asp:BoundField DataField="slab1" HeaderText="Slab 1 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="slab2" HeaderText="Slab 2 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="slab3" HeaderText="Slab 3 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="slab4" HeaderText="Slab 4 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="slab5" HeaderText="Slab 5 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="slab6" HeaderText="Slab 6 Rate">
                            <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" BackColor="White" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold ="True" BackColor="White"  />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <br />
<br />
<table  border="0" id="tblMatrix6"  visible="false" align="center" cellspacing="1" runat="server" cellpadding="6" width="100%" class="boxbg">
<tr >
<td colspan="2" class="bgbluegrey"><font class="blackfnt">ODA Charges</font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Calculation Basis</font></td>
<td width="25%" ><font class="blackfnt"> Per Cnote</font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Fixed charges Rs. - Minimum</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblminchrg_oda" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Fixed charges Rs. - Maximum </font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblmaxchrg_oda" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%"  ><font class="blackfnt">Variable as % of ODA</font></td>
<td width="25%" ><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblvariable_oda" runat="server" >
                                                                            </asp:Label></font></td>
</tr>
</table>
</td>
			</tr>
			
</table>
</asp:Content>

