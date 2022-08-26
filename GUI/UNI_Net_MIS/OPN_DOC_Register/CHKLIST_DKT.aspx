<table id="tbl_CHKdkt" style="width: 8.5in; display: block;" class="boxbg" runat="server"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="Labeldoc" runat="server" cssclass="blackfnt" text="<b>Docket Details</b>"
                width="111px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All " cssclass="blackfnt" id="CHKDKT1" onclick="CHKDKT1(this.value);"
                runat="server" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:checkboxlist id="CheckBoxList1" runat="server" cssclass="blackfnt" repeatdirection="Horizontal"
                repeatcolumns="4" textalign="right" width="750px" cellpadding="2" cellspacing="2">
                                <asp:ListItem Selected=True Value="d.dockno" Text="Docket No"></asp:ListItem>
                                <asp:ListItem Value="dockdt" Selected=True Text="Docket Date"></asp:ListItem>
                                <asp:ListItem Value="orgncd" Text="Origin"></asp:ListItem>
                                <asp:ListItem Value="destcd" Text="Destination"></asp:ListItem>
                                <asp:ListItem Value="Curr_loc" Text="Current Location"></asp:ListItem>
                                <asp:ListItem Value="nextloc" Text="Next Location"></asp:ListItem>
                                 <asp:ListItem Value="from_loc" Text="From"></asp:ListItem>
                                <asp:ListItem Value="to_loc" Text="To"></asp:ListItem>
                                 <asp:ListItem Value="Paybas_st" Text="Payment Basis"></asp:ListItem>
                                <asp:ListItem Value="trn_mod_st" Text="Transport Mode"></asp:ListItem>
                                <asp:ListItem Value="Service_class_st" Text="Booking Type"></asp:ListItem>
                                <asp:ListItem Value="loadtype" Text="Load Type"></asp:ListItem>
                                 <asp:ListItem Value="businesstype" Text="Bussiness Type"></asp:ListItem>
                                <asp:ListItem Value="PROD_str" Text="Product Type"></asp:ListItem>
                                  <asp:ListItem Value="Cnor " Text="Consignor "></asp:ListItem>
                                 <asp:ListItem Value="Cnee " Text="Consignee "></asp:ListItem>
                             <asp:ListItem Value="BACode " Text="BA Code "></asp:ListItem>
                                 <asp:ListItem Value="PkgsNo " Text="Pkgs. No. "></asp:ListItem>
                                  <asp:ListItem Value="Actuwt " Text="Actual Wt. "></asp:ListItem>
                                 <asp:ListItem Value="ChrgWt " Text="Chrg Wt."></asp:ListItem>
                                  <asp:ListItem Value="Yield" Text="Yield"></asp:ListItem>
                                 <asp:ListItem Value="FRT_Rate" Text="FRT Rate"></asp:ListItem>  
                                  <asp:ListItem Value="subtotal"  Text=" Basic FRT "></asp:ListItem>  
                                   <asp:ListItem Value="svctax " Text="S.tax"></asp:ListItem>  
                                    <asp:ListItem Value="Cess" Text="Cess"></asp:ListItem>  
                                    <asp:ListItem Value="hedu_cess" Text="H.Cess"></asp:ListItem>
                                    <asp:ListItem Value="dkttot" Text="Docket Total"></asp:ListItem>
                                     <asp:ListItem Value="Delivered" Text="Delievered"></asp:ListItem>
									 <asp:ListItem Value="cdeldt" Text="EDD"></asp:ListItem>
                                      <asp:ListItem Value="Dely_Date" Text="dely. Date"></asp:ListItem>
                                      <asp:ListItem Value="MR" Text="MR Generated"></asp:ListItem>
									    <asp:ListItem Value="Cancelled" Text="Cancelled"></asp:ListItem>
									    <asp:ListItem Value="spl_svc_req" Text="Special Instruction"></asp:ListItem>
									    <asp:ListItem Value="VEHNO" Text="VEHNO"></asp:ListItem>
									     <asp:ListItem Value="LastEditBy" Text="Last Edit By"></asp:ListItem>
										 <asp:ListItem Value="LastEditDate" Text="Edit Date & Time"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="Label17" runat="server" cssclass="blackfnt" text="<b>Amount & Charges Details</b>"
                width="186px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="CHKDKT2" runat="server" onclick="CHKDKT2(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="ChkAmtChrgDtl" runat="server" cssclass="blackfnt" repeatdirection="Horizontal"
                repeatcolumns="4" textalign="Right" width="750px" cellpadding="2" cellspacing="2">
                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" colspan="4" valign="top">
            <asp:label id="Label16" runat="server" cssclass="blackfnt" text="<b>Invoice & PFM Details</b>"
                width="153px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right" valign="bottom">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="CHKDKT3" runat="server" onclick="CHKDKT3(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" valign="top">
            <asp:checkboxlist id="CheckBoxList3" runat="server" cssclass="blackfnt" repeatdirection="Horizontal"
                repeatcolumns="4" textalign="right" width="750px" cellpadding="2" cellspacing="2">
                                <asp:ListItem   Value="invno" Text="Invoice No"></asp:ListItem>
                                <asp:ListItem Value="invdt" Text="Invoice Date"></asp:ListItem>
                                <asp:ListItem Value="invamt" Text="Invoice Amt"></asp:ListItem>
                                
                                  <asp:ListItem  Value="PFMno" Text="PFM No."></asp:ListItem>
                                   <asp:ListItem Enabled="false" visible="fasle" Value="pfmdt" Text="PFM Date"></asp:ListItem>
                                   <%-- <asp:ListItem Value="PFMRECDT" Text="PFM Rec. Date"></asp:ListItem>--%>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="Labemrbill" runat="server" cssclass="blackfnt" text="<b>MR & Bill Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="CHKDKT4" runat="server" onclick="CHKDKT4(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="CheckBoxList4" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                                <asp:ListItem Value="MRSNo" Text="MR No"></asp:ListItem>
                                <asp:ListItem Value="mrsdt" Text="MR Date"></asp:ListItem>
                                <asp:ListItem Value="BillNo" Text="Bill No"></asp:ListItem>
                                 <asp:ListItem Value="manualbillno" Text="Manual Bill No"></asp:ListItem>
                                <asp:ListItem Value="bgndt" Text="Bill Date"></asp:ListItem>
                                <asp:ListItem Value="party_code" Text="Bill Party"></asp:ListItem>
                                <asp:ListItem Value="fincmplbr" Text="Bill Gen. At"></asp:ListItem>
                                 <asp:ListItem Value="billsubbrcd" Text="Bill Sub. At"></asp:ListItem>
                                  <asp:ListItem Value="billcolbrcd" Text="Bill Coll. At"></asp:ListItem>
                                  <asp:ListItem Value="BillAmt" Text="Bill Amount"></asp:ListItem>
</asp:checkboxlist>
        </td>
    </tr>
</table>
<table id="tbl_thcchk" runat="server" align="left" border="0" cellpadding="1" cellspacing="1"
    class="boxbg" style="width: 8.5in; display: none;">
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblthc1" runat="server" cssclass="blackfnt" text="<b>Document Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox id="THCHK1" runat="server" cssclass="blackfnt" onclick="THCHK1(this.value);"
                text="Select All" width="100%"></asp:checkbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="THCCHKLIST1" runat="server" cellpadding="2" cellspacing="2"
                cssclass="blackfnt" repeatcolumns="4" repeatdirection="Horizontal" textalign="Right"
                width="750px">
                                <asp:ListItem Value="thcno" Text="Document No."></asp:ListItem>
                                <asp:ListItem Value="manualthcno" Text="Manual Document No."></asp:ListItem>
                                <asp:ListItem Value="tripsheetno" Text="TripSheet No."></asp:ListItem>
                                <asp:ListItem Value="thc_dt" Text="Date"></asp:ListItem>
                                <asp:ListItem Value="thcbr" Text="Location"></asp:ListItem>
                              
                                <asp:ListItem Value="vehno" Text="Vehichle No."></asp:ListItem>
                                <%--<asp:ListItem Value="thcno" Text="Vehichle Type"></asp:ListItem>--%>
                                <asp:ListItem Value="vendtype" Text="Vendor Type"></asp:ListItem>
                                <asp:ListItem Value="vendor_name" Text="Vendor Name"></asp:ListItem>
                                <asp:ListItem Value="routename" Text="Route"></asp:ListItem>
                                <asp:ListItem Value="cancelled" Text="Cancelled"></asp:ListItem>
								 <asp:ListItem Value="PANNO" Text="PANNO"></asp:ListItem>
                                 <asp:ListItem Value="airbillno" Text="Air BillNo"></asp:ListItem>
								  <asp:ListItem Value="LastEditBy" Text="Last Edit By"></asp:ListItem>
							    <asp:ListItem Value="LastEditDate" Text="Edit Date & Time"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblthc2" runat="server" cssclass="blackfnt" text="<b>Financial Details- Advance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox id="THCHK2" runat="server" cssclass="blackfnt" onclick="THCHK2(this.value);"
                text="Select All" width="100%"></asp:checkbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="THCCHKLIST2" runat="server" cellpadding="2" cellspacing="2"
                cssclass="blackfnt" repeatcolumns="4" repeatdirection="Horizontal" textalign="Right"
                width="750px"><asp:ListItem Value="pcamt" Text="Contract Amount"></asp:ListItem>
                               <asp:ListItem Value="advamt " Text="Adv Amount"></asp:ListItem>
                                <asp:ListItem Value="advamt_lastpaid" Text="Advance Paid"></asp:ListItem>
                               <%-- <asp:ListItem Value="adv_colamt" Text="Advance Paid"></asp:ListItem>--%>
                              
                                <asp:ListItem Value="TOTALAMTPAID" Text="Toal Amount"></asp:ListItem>
                                <asp:ListItem Value="advpaidby" Text="Advance Paid by"></asp:ListItem>
                                <asp:ListItem Value="advpaidat" Text="Advance Paid At"></asp:ListItem>
                                <asp:ListItem Value="advvoucherNo" Text="Advance Voucher No."></asp:ListItem>
                                <asp:ListItem Value="advvoucherDt" Text="Advance Payment Date."></asp:ListItem>
                                
                                <asp:ListItem Value="(pcamt-advamt) as due" Text="Due Amount"></asp:ListItem>
                                <asp:ListItem Value="othamt" Text="Other Amount"></asp:ListItem>
                                <asp:ListItem Value="totcontamt" Enabled="false" Text="Tot Contract Amount"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblthc3" runat="server" cssclass="blackfnt" text="<b>Financial Details- Balance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox id="THCHK3" runat="server" cssclass="blackfnt" onclick="THCHK3(this.value);"
                text="Select All" width="100%"></asp:checkbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="THCCHKLIST3" runat="server" cellpadding="2" cellspacing="2"
                cssclass="blackfnt" repeatcolumns="4" repeatdirection="Horizontal" textalign="Right"
                width="750px">
                         
                                 <asp:ListItem Value="dclaim" Text="Claims"></asp:ListItem>
                                <asp:ListItem Value="oth_ded" Text="Deductions"></asp:ListItem>
                                <asp:ListItem Value="incentive" Text="Incentive"></asp:ListItem>
                                <asp:ListItem Value="penalty" Text="Penalty"></asp:ListItem>
                                <asp:ListItem Value="tds_chrg" Text="TDS"></asp:ListItem>
				                <asp:ListItem Value="load_chrg" Text="Loading Charge"></asp:ListItem>
                                <asp:ListItem Value="netbalamt" Text="Balance Amt"></asp:ListItem>
                                <asp:ListItem Value="balpaidby" Text="Balance Paid By"></asp:ListItem>
                                <asp:ListItem Value="balamtbrcd" Text="Balanace Paid At"></asp:ListItem>
                                <asp:ListItem Value="balvoucherNo" Text="Balance Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="balvoucherdt" Text="Balance Payment Date."></asp:ListItem>
                               <asp:ListItem Value="unload_chrg" Text="Handling Charge"></asp:ListItem>
                               <asp:ListItem Value="deten_chrg" Text="Detention"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblthc4" runat="server" cssclass="blackfnt" text="<b>Financial Details- Bill Entry </b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox id="THCHK4" runat="server" cssclass="blackfnt" onclick="THCHK4(this.value);"
                text="Select All" width="100%"></asp:checkbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="THCCHKLIST4" runat="server" cellpadding="2" cellspacing="2"
                cssclass="blackfnt" repeatcolumns="4" repeatdirection="Horizontal" textalign="Right"
                width="750px">
                              <asp:ListItem Value="billdt" Text="Bill Entry Date"></asp:ListItem>
                                <asp:ListItem Value="vendorBENo" Text="Bill Entry Number"></asp:ListItem>
                                <asp:ListItem Value="vendorbillNo" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="billamt" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="voucherno" Text="Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="PaymentDt" Text="Payment Date  "></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblthc5" runat="server" cssclass="blackfnt" text="<b>Docket Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox id="THCHK5" runat="server" cssclass="blackfnt" onclick="THCHK5(this.value);"
                text="Select All" width="100%"></asp:checkbox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="THCCHKLIST5" runat="server" cellpadding="2" cellspacing="2"
                cssclass="blackfnt" repeatcolumns="4" repeatdirection="Horizontal" textalign="Right"
                width="750px">
                               <asp:ListItem Value="Total_docket" Text="Number of Cnotes Moved"></asp:ListItem>
                                <asp:ListItem Value="MyActualWt" Text="Total Actual Weight"></asp:ListItem>
                                <asp:ListItem Value="ld_actuwt" Text="Charged Weight"></asp:ListItem>
                                <asp:ListItem Value="Total_freight_dkt" Text="Total Freight"></asp:ListItem>
                                <asp:ListItem Value="dept_dt" Text="Dep. Date"></asp:ListItem>
                                <asp:ListItem Value="dept_tm" Text="Dep. Time"></asp:ListItem>
                                <asp:ListItem Value="arrv_dt" Text="Arrv. date  "></asp:ListItem>
                                 <asp:ListItem Value="arrv_tm" Text="Arrv. Time"></asp:ListItem>
                                <asp:ListItem Value="OPENKM" Text="Start KM"></asp:ListItem>
                                <asp:ListItem Value="CLOSEKM" Text="Close KM"></asp:ListItem>
                                <asp:ListItem Value="Dist" Text="Travel Distance"></asp:ListItem>
                                <asp:ListItem Value="capacity" Text="Capacity"></asp:ListItem>
                                <asp:ListItem Value="PKGSNO" Text="Package"></asp:ListItem>
                                
                                </asp:checkboxlist>
        </td>
    </tr>
</table>
<table id="tbl_PRSchk" style="width: 8.5in; display: none;" class="boxbg" runat="server"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblPRS1" runat="server" cssclass="blackfnt" text="<b>Document Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="PRSHK1" runat="server" onclick="PRSHK1(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="PRSCHKLIST1" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                                <asp:ListItem Value="pdcno" Text="Document No."></asp:ListItem>
                                <asp:ListItem Value="pdc_dt" Text="Date"></asp:ListItem>
                                <asp:ListItem Value="pdcbr" Text="Location"></asp:ListItem>
                              
                                <asp:ListItem Value="vehno" Text="Vehichle No."></asp:ListItem>
	<asp:ListItem Value="PANNO" Text="PANNO"></asp:ListItem>
                               <%-- <asp:ListItem Value="thcno" Text="Vehichle Type"></asp:ListItem>--%>
                                <asp:ListItem Value="vendtype" Text="Vendor Type"></asp:ListItem>
                                <asp:ListItem Value="vendorname" Text="Vendor Name"></asp:ListItem>
                              <%--  <asp:ListItem Value="thcno" Text="Route"></asp:ListItem>--%>
                                </asp:checkboxlist>
						
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblPRS2" runat="server" cssclass="blackfnt" text="<b>Financial Details- Advance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="PRSHK2" runat="server" onclick="PRSHK2(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="PRSCHKLIST2" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                                <asp:ListItem Value="advamt" Text="Adv Amount"></asp:ListItem>
                                <asp:ListItem Value="othamt" Text="Other Amount"></asp:ListItem>
                                <asp:ListItem Value="adv_colamt" Text="Advance Paid"></asp:ListItem>
                              
                                <asp:ListItem Value="PDC_AMT" Text="Toal Amount"></asp:ListItem>
                                <asp:ListItem Value="advamt_paidby" Text="Advance Paid by"></asp:ListItem>
                                <asp:ListItem Value="adv_entrydt" Text="Advance Paid At"></asp:ListItem>
                                <asp:ListItem Value="adv_voucherNo" Text="Advance Voucher No."></asp:ListItem>
                                <asp:ListItem Value="adv_VoucherDt" Text="Advance Payment Date."></asp:ListItem>
                                <asp:ListItem Value="pdc_amt"  Text="Contract Amount"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblPRS3" runat="server" cssclass="blackfnt" text="<b>Financial Details- Balance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="PRSHK3" runat="server" onclick="PRSHK3(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="PRSCHKLIST3" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                             
                                 <asp:ListItem Value="dclaim" Text="Claims"></asp:ListItem>
                                <asp:ListItem Value="PDC_TOTDED" Text="Deductions"></asp:ListItem>
                                <asp:ListItem Value="0 as Incentive" Text="Incentive"></asp:ListItem>
                                <asp:ListItem Value="0 as Penalty" Text="Penalty"></asp:ListItem>
                                <asp:ListItem Value="bal_colamt" Text="Balance Paid"></asp:ListItem>
                                <asp:ListItem Value="bal_paidby" Text="Balance Paid By"></asp:ListItem>
                                <asp:ListItem Value="balamtbrcd" Text="Balanace Paid At"></asp:ListItem>
                                <asp:ListItem Value="bal_voucherNo" Text="Balance Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="bal_VoucherDt" Text="Balance Payment Date."></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblPRS4" runat="server" cssclass="blackfnt" text="<b>Financial Details- Bill Entry </b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="PRSHK4" runat="server" onclick="PRSHK4(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="PRSCHKLIST4" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                                  <asp:ListItem Value="vendorBEdt" Text="Bill Entry Date"></asp:ListItem>
                                <asp:ListItem Value="vendorBENo" Text="Bill Entry Number"></asp:ListItem>
                                <asp:ListItem Value="vendorbillNo" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="billamt" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="voucherno" Text="Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="PaymentDt" Text="Payment Date  "></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblPRS5" runat="server" cssclass="blackfnt" text="<b>Docket Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="PRSHK5" runat="server" onclick="PRSHK5(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="PRSCHKLIST5" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                                 <asp:ListItem Value="dktot" Text="Number of Cnotes Moved"></asp:ListItem>
                                <asp:ListItem Value="chrgwt" Text="Total Actual Weight"></asp:ListItem>
                                <asp:ListItem Value="frt" Text="Total Freight"></asp:ListItem>
                                <asp:ListItem Value="DKT_D" Text="Total Cnotes Sent for Delivery"></asp:ListItem>
                                <asp:ListItem Value="chrgwt_D" Text="Total Cnotes Sent Actual Weight"></asp:ListItem>
                                <asp:ListItem Value="FRT_D" Text="Total  Cnotes Sent Freight "></asp:ListItem>
                                 
                                <asp:ListItem Value="OPENKM" Text="Start KM"></asp:ListItem>
                                <asp:ListItem Value="CLOSEKM    " Text="Close KM"></asp:ListItem>
                                <asp:ListItem Value="Dist" Text="Travel Distance"></asp:ListItem>
                                <asp:ListItem Value="PDC_AMT" Text="Hire Charges"></asp:ListItem>
                                
                                </asp:checkboxlist>
        </td>
    </tr>
</table>
<table id="tbl_DRSchk" style="width: 8.5in; display: none;" class="boxbg" runat="server"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS1" runat="server" cssclass="blackfnt" text="<b>Document Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK1" runat="server" onclick="DRSHK1(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST1" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                               <asp:ListItem Value="pdcno" Text="Document No."></asp:ListItem>
                                <asp:ListItem Value="pdc_dt" Text="Date"></asp:ListItem>
                                <asp:ListItem Value="pdcbr" Text="Location"></asp:ListItem>
                              	<asp:ListItem Value="PANNO" Text="PANNO"></asp:ListItem>
                                <asp:ListItem Value="vehno" Text="Vehichle No."></asp:ListItem>
                               <%-- <asp:ListItem Value="thcno" Text="Vehichle Type"></asp:ListItem>--%>
                                <asp:ListItem Value="vendtype" Text="Vendor Type"></asp:ListItem>
                                <asp:ListItem Value="vendorname" Text="Vendor Name"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS2" runat="server" cssclass="blackfnt" text="<b>Financial Details- Advance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK2" runat="server" onclick="DRSHK2(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST2" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                             
                                <asp:ListItem Value="advamt" Text="Adv Amount"></asp:ListItem>
                                <asp:ListItem Value="othamt" Text="Other Amount"></asp:ListItem>
                                <asp:ListItem Value="adv_colamt" Text="Advance Paid"></asp:ListItem>
                              
                                <asp:ListItem Value="PDC_AMT" Text="Toal Amount"></asp:ListItem>
                                <asp:ListItem Value="advamt_paidby" Text="Advance Paid by"></asp:ListItem>
                                <asp:ListItem Value="adv_entrydt" Text="Advance Paid At"></asp:ListItem>
                                <asp:ListItem Value="adv_voucherNo" Text="Advance Voucher No."></asp:ListItem>
                                <asp:ListItem Value="adv_VoucherDt" Text="Advance Payment Date."></asp:ListItem>
                                <asp:ListItem Value="contract_amt" enabled="false"  Text="Contract Amount"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS3" runat="server" cssclass="blackfnt" text="<b>Financial Details- Balance</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK3" runat="server" onclick="DRSHK3(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST3" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                        
                                  <asp:ListItem Value="dclaim" Text="Claims"></asp:ListItem>
                                <asp:ListItem Value="PDC_TOTDED" Text="Deductions"></asp:ListItem>
                                <asp:ListItem Value="0 as Incentive" Text="Incentive"></asp:ListItem>
                                <asp:ListItem Value="0 as Penalty" Text="Penalty"></asp:ListItem>
                                <asp:ListItem Value="bal_colamt" Text="Balance Paid"></asp:ListItem>
                                <asp:ListItem Value="bal_paidby" Text="Balance Paid By"></asp:ListItem>
                                <asp:ListItem Value="balamtbrcd" Text="Balanace Paid At"></asp:ListItem>
                                <asp:ListItem Value="bal_voucherNo" Text="Balance Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="bal_VoucherDt" Text="Balance Payment Date."></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS4" runat="server" cssclass="blackfnt" text="<b>Financial Details- Bill Entry </b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK4" runat="server" onclick="DRSHK4(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST4" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                               <asp:ListItem Value="vendorBEdt" Text="Bill Entry Date"></asp:ListItem>
                                <asp:ListItem Value="vendorBENo" Text="Bill Entry Number"></asp:ListItem>
                                <asp:ListItem Value="vendorbillNo" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="billamt" Text="Vendor Bill Number"></asp:ListItem>
                                <asp:ListItem Value="voucherno" Text="Payment Voucher Number"></asp:ListItem>
                                <asp:ListItem Value="PaymentDt" Text="Payment Date  "></asp:ListItem>
									
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS5" runat="server" cssclass="blackfnt" text="<b>Docket Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK5" runat="server" onclick="DRSHK5(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST5" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                              <asp:ListItem Value="dktot" Text="Number of Cnotes Moved"></asp:ListItem>
                                <asp:ListItem Value="chrgwt" Text="Total Actual Weight"></asp:ListItem>
                                <asp:ListItem Value="frt" Text="Total Freight"></asp:ListItem>
                                
                                </asp:checkboxlist>
        </td>
    </tr>
    <tr class="bgbluegrey">
        <td align="left" valign="top">
            <asp:label id="lblDRS6" runat="server" cssclass="blackfnt" text="<b>Delivery Details</b>"
                width="178px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All" cssclass="blackfnt" id="DRSHK6" runat="server" onclick="DRSHK6(this.value);"
                width="100%" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left">
            <asp:checkboxlist id="DRSCHKLIST6" repeatcolumns="4" textalign="Right" runat="server"
                cssclass="blackfnt" repeatdirection="Horizontal" width="750px" cellpadding="2"
                cellspacing="2">
                            
                                <asp:ListItem Value="DKT_D" Text="Total Cnotes Sent for Delivery"></asp:ListItem>
                                <asp:ListItem Value="chrgwt_D" Text="Total Cnotes Sent Actual Weight"></asp:ListItem>
                                <asp:ListItem Value="FRT_D" Text="Total  Cnotes Sent Freight "></asp:ListItem>
                                 
                                <asp:ListItem Value="DKT_Y" Text="Cnotes Delivered "></asp:ListItem>
                                <asp:ListItem Value="chrgwt_Y" Text="Cnotes Delivered Weight"></asp:ListItem>
                                <asp:ListItem Value="FRT_Y" Text=" Cnotes Delivered  Freight"></asp:ListItem>
                                
                                 <asp:ListItem Value="DKT_N" Text="Cnotes Not Delivered "></asp:ListItem>
                                <asp:ListItem Value="chrgwt_N" Text="Cnotes Not  Weight"></asp:ListItem>
                                <asp:ListItem Value="FRT_N" Text="Cnotes Not  Freight"></asp:ListItem>
                                
                                <%-- <asp:ListItem Value="thcno" Text="Cnotes Part Delivered "></asp:ListItem>
                                <asp:ListItem Value="thcno" Text="Cnotes Part Weight"></asp:ListItem>
                                <asp:ListItem Value="thcno" Text="Cnotes Part Freight"></asp:ListItem>
                                --%>
                                
                                 <asp:ListItem Value="OPENKM" Text="Start KM"></asp:ListItem>
                                <asp:ListItem Value="CLOSEKM" Text="Close KM"></asp:ListItem>
                                <asp:ListItem Value="Dist" Text="Travel Distance"></asp:ListItem>
                                </asp:checkboxlist>
        </td>
    </tr>
</table>