<table id="tbl_CHK_BILL" class="boxbg" runat="server" style="width: 8.5in;display:block;"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr class="bgbluegrey">
        <td align="right" valign="top">
            <asp:label id="LabelBill" runat="server" cssclass="blackfnt" text="<b>BILL Details</b>"
                width="111px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All " cssclass="blackfnt" id="CHKDKT2"   onClick="CHKDKT2(this.value);" runat="server" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:checkboxlist id="CheckBoxList2" runat="server" cssclass="blackfnt" repeatdirection="Horizontal"
                repeatcolumns="4" textalign="right" width="750px" cellpadding="2" cellspacing="2">
                                <asp:ListItem Selected="True" Value="Billno" Text="Bill No."></asp:ListItem>
                                 <asp:ListItem  Value="manualbillno" Text="Manual Bill No."></asp:ListItem>
                                  <asp:ListItem  Value="BillGenDT" Text="Bill Date"></asp:ListItem>
                                   <asp:ListItem  Value="bbrcd" Text="Bill Location"></asp:ListItem>
                                  <asp:ListItem  Value="TYp" Text="Bill Type"></asp:ListItem>
                                   <asp:ListItem  Value="PARTY" Text="Bill Party"></asp:ListItem>
                                    <asp:ListItem  Value="BILL_STATuS" Text="Bill Status"></asp:ListItem>
                                    <asp:ListItem  Value="billcolbrcd" Text="Collection At"></asp:ListItem>
                                    <asp:ListItem  Value="BillCollDT" Text="Collection Date"></asp:ListItem>
                                    <asp:ListItem  Value="paymode" Text="Collection BY"></asp:ListItem>
                                    <asp:ListItem  Value="billsubbrcd" Text="Submission At"></asp:ListItem>
<asp:ListItem Value="BillSubmitTo"  Text="Bill Submit To"></asp:ListItem>
                                    <asp:ListItem  Value="BillSUBDT" Text="Submission Date"></asp:ListItem>
                                    <asp:ListItem  Value="BillDueDT" Text="Due Date"></asp:ListItem>
                                    <asp:ListItem  Value="DUE_DYAS" Text="Overdue Days "></asp:ListItem>                                    
                                    <asp:ListItem  Value="STAX_CESS_HCESS" Text="Service Tax + Cess + H.Cess"></asp:ListItem>
                                    <asp:ListItem  Value="dbo.FN_MR_FORBILL(BILLNO,1)" Text="MR No."></asp:ListItem>
                                    <asp:ListItem  Value="dbo.FN_MR_FORBILL(BILLNO,2)" Text="MR Date"></asp:ListItem>
                                    <asp:ListItem  Value="billamt" Text="Amount"></asp:ListItem>
                                    <asp:ListItem  Value="CLAMT" Text="Collection Amount"></asp:ListItem>
                                    <asp:ListItem  Value="PENDAMT" Text="Pending Amount "></asp:ListItem>
                                    <asp:ListItem  Value="FRT_DED" Text="Deduction"></asp:ListItem>
                                    <asp:ListItem  Value="CLM_DED" Text="Claim"></asp:ListItem>
                                    <asp:ListItem  Value="TDS_DED" Text="TDS"></asp:ListItem>
                                    <asp:ListItem  Value="UNE_DED" Text="Unadjusted Amount"></asp:ListItem>
                                    <asp:ListItem  Value="BCANEMPCD" Text="Cancelled By "></asp:ListItem>
                                    <asp:ListItem  Value="Bcan_dt" Text="Cancelled On "></asp:ListItem> 
									<asp:ListItem  Value="remark" Text="Remark "></asp:ListItem>  									
                                   <asp:ListItem  Value="billno"  Text=" View"></asp:ListItem>
                                </asp:checkboxlist>
                                </td>
                                </tr>
    </table>
    
    <table id="tbl_CHK_MR" class="boxbg" runat="server" style="width: 8.5in;display:none;"
    border="0" align="left" cellpadding="1" cellspacing="1">
    <tr class="bgbluegrey">
        <td align="right" valign="top">
            <asp:label id="LabelMR" runat="server" cssclass="blackfnt" text="<b>MR Details</b>"
                width="111px"></asp:label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="right">
            <asp:checkbox text="Select All " cssclass="blackfnt" id="CHKDKT1"   onClick="CHKDKT1(this.value);" runat="server" />
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="400">
            <asp:checkboxlist id="CheckBoxList1" runat="server" cssclass="blackfnt" repeatdirection="Horizontal"
                repeatcolumns="4" textalign="right" width="750px" cellpadding="2" cellspacing="2">
                                <asp:ListItem Selected="True" Value="MRSNO" Text="MR No."></asp:ListItem>
                                <asp:ListItem Value="DOCKNo" Text="<%=dkt_Call%> No."></asp:ListItem>
                                <asp:ListItem Value="TYP" Text="MR Type"></asp:ListItem>
                                <asp:ListItem Value="MR_GEN_DT" Text="MR Date"></asp:ListItem>
                                <asp:ListItem Value="PARTY" Text="MR Party"></asp:ListItem>
                                <asp:ListItem Value="mrsbr" Text="MR Branch"></asp:ListItem>
                                <asp:ListItem Value="MRSTATUS" Text="MR Status"></asp:ListItem>
                                <asp:ListItem Value="DKT_dly" Text="a"></asp:ListItem>
                                <asp:ListItem Value="MRSAMT" Text="MR Amt"></asp:ListItem>
                                <asp:ListItem Value="TDS_DED" Text="TDS"></asp:ListItem>
                                <asp:ListItem Value="FRT_DED" Text="Fraight Rrebate"></asp:ListItem>
                                <asp:ListItem Value="CLM_DED" Text="CLAIM"></asp:ListItem>
                                <asp:ListItem Value="OT_DED" Text="Other Deduction"></asp:ListItem>
                                <asp:ListItem Value="UNE_DED" Text="UnAdjusted Amt"></asp:ListItem>
                                <asp:ListItem Value="netamt" Text="Net MR Close Amt"></asp:ListItem>
                                <asp:ListItem Value="paymode" Text="Payment Mode"></asp:ListItem>                                
                                <asp:ListItem Value="dbo.FN_GET_CHQNO(MRSNO,1)" Text="Cheque No./Date"></asp:ListItem>
                                <asp:ListItem Value="dbo.FN_GET_CHQNO(MRSNO,2)" Text="Cheque Amt"></asp:ListItem>
                                <asp:ListItem Value="closedt" Text="MR Close Date"></asp:ListItem>
                                <asp:ListItem Value="Closedby" Text="MR Close By"></asp:ListItem>
                                <asp:ListItem Value="BCANEMPCD" Text="MR Cancelled By"></asp:ListItem>
                                  <asp:ListItem Value="Bcan_dt" Text="MR Cancelled On"></asp:ListItem>
                                <asp:ListItem Value="remark" Text="REMARK"></asp:ListItem>
        </asp:checkboxlist>
        </td>
        </tr>
       
    </table>
   
