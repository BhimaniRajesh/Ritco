<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChqDepositVoucher_step2.aspx.cs" Inherits="GUI_Finance_Cheque_Deposit_ChqDepositVoucher_step2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("Div1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
		function checktotamt(id)
		{
		    //debugger;
		    var chequedetail="";
		    var HdnTotalAmt = document.getElementById("ctl00_MyCPH1_HdnTotalAmt");
		    var txtTotalAmt = document.getElementById("ctl00_MyCPH1_txtTotalAmt");
		    var chqdtl,amt;
		    if(id.checked == true)
		    {
		        chequedetail = id.value;
		        chqdtl = chequedetail.split("|");
		        amt = chqdtl[3];
		        if(HdnTotalAmt.value != "")
		            HdnTotalAmt.value = parseFloat(Number(HdnTotalAmt.value) + Number(amt)).toFixed(2);
		        else
		            HdnTotalAmt.value = parseFloat(Number(amt)).toFixed(2);
		    }
		    else
		    {
		        chequedetail = id.value;
		        chqdtl = chequedetail.split("|");
		        amt = chqdtl[3];
		        if(HdnTotalAmt.value != "")
		            HdnTotalAmt.value = parseFloat(Number(HdnTotalAmt.value) - Number(amt)).toFixed(2);
		    } 
		    txtTotalAmt.value = HdnTotalAmt.value;
		}
        function CheckFinacialYear(date,voucher)
	    {
	        //debugger;
	        var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
            var dt =date.value
            var dt_dd=dt.substring(0,2)
            var dt_mm=dt.substring(3,5)
            var dt_yy=dt.substring(6,10)
            var sdt =server_dt
            var sdt_dd=sdt.substring(0,2)
            var sdt_mm=sdt.substring(3,5)
            var sdt_yy=sdt.substring(6,10)

            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                    
            var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
		    var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
		    var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
		    FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
    		
		    var FinYear_todate_dd=FinYear_todate.substring(0,2)
		    var FinYear_todate_mm=FinYear_todate.substring(3,5)
		    var FinYear_todate_yy=FinYear_todate.substring(6,10)
		    FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
    			
		    if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
		    {
			    alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO  Voucher Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
			    date.focus();
			    return false;
		    }
    		
		    if (dt>server_dt)
		     {
                alert( voucher + " Date should not be greater than today's date !!!")
                date.focus();
                return false;
		     }
		     return true;
	    }
		function CheckData()
		{
		    var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
		    var ddrBankaccode = document.getElementById("ctl00_MyCPH1_ddrBankaccode");
		    var txtNarration = document.getElementById("ctl00_MyCPH1_txtNarration");
		    var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)
		    
		    if(txtVoucherDate.value == "")
            {
                alert("Please Enter Voucher Date");
                txtVoucherDate.focus();
                return false;
            }
            var dateflag = CheckFinacialYear(txtVoucherDate,"Voucher");
            if(!dateflag)
                return false;
            if(ddrBankaccode.value == "")
            {
                alert("Please Select Bank");
                ddrBankaccode.focus();
                return false;
            }
            if(txtNarration.value == "")
            {
                alert("Please Enter Narration");
                txtNarration.focus();
                return false;
            }
            var tbl=document.getElementById("ctl00_MyCPH1_dgGeneral");
            var Totalcount=tbl.rows.length;
            var chkchqno,Hdnchqdt;
            var non=0;
            for(i = 2; i <= Totalcount ; i++)
            {
                if(i<10)
                {
                   Hdnchqdt = document.getElementById("ctl00_MyCPH1_dgGeneral_ctl0" + i + "_Hdnchqdt");
                   chkchqno = document.getElementById("ctl00_MyCPH1_dgGeneral_ctl0" + i + "_chkchqno");
                }
                else
                {
                   Hdnchqdt = document.getElementById("ctl00_MyCPH1_dgGeneral_ctl" + i + "_Hdnchqdt");
                   chkchqno = document.getElementById("ctl00_MyCPH1_dgGeneral_ctl" + i + "_chkchqno");
                }
               
                if(chkchqno.checked == true)
                {
                        non = 1;
                        var chq_dt = Hdnchqdt.value
                        var voucher_dt = txtVoucherDate.value
                        
                        var vdt_dd=voucher_dt.substring(0,2)
                        var vdt_mm=voucher_dt.substring(3,5)
                        var vdt_yy=voucher_dt.substring(6,10)
                        
                        var cdt =chq_dt
                        var cdt_dd=cdt.substring(0,2)
                        var cdt_mm=cdt.substring(3,5)
                        var cdt_yy=cdt.substring(6,10)

                        voucher_dt=new Date(months[parseFloat(vdt_mm)] + " " + parseFloat(vdt_dd) + ", " + parseFloat(vdt_yy))
                        chq_dt=new Date(months[parseFloat(cdt_mm)] + " " + parseFloat(cdt_dd) + ", " + parseFloat(cdt_yy))
                        	
		                if (voucher_dt < chq_dt)
		                {
			                alert("Voucher Date Should Not Be Less than Cheque Date!!!")
			                txtVoucherDate.value = "";
			                txtVoucherDate.focus();
			                return false;
		                }
                }
            }
            if(non == 0)
            {
                alert("Plz Select Atleast One Cheque Number!!!");
                return false;
            }
            if(click_count > 0)
            {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else
            {
                click_count=click_count+1
                document.getElementById("ctl00_MyCPH1_click_count").value=click_count
            } 
            return true;   
		}
    </script>
    <div style="width: 10.0in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" border="0" /></a>
    </div>
    <div style="text-align: center; width: 10.0in">
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Cheque Deposit Voucher</strong>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel2"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
            <ContentTemplate>
        <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr style="background-color: White"> 
                <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                    &nbsp;Voucher No</td>
                <td class="blackfnt"  nowrap style="text-align: left"> <span style="color: #ff0000">&nbsp;&lt;System Generated&gt;</span></td>
                <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Voucher Date</td>
                <td width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                    <asp:TextBox ID="txtVoucherDate" runat="server" 
                        Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                        id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                </td>
            </tr>
            <tr style="background-color: White"> 
                <td style="text-align: left; width: 151px;"   nowrap class="blackfnt"> &nbsp;Total Amount</td>
                <td class="blackfnt" style="text-align: left"> &nbsp; 
                    <asp:TextBox ID="txtTotalAmt" runat="server" Text="0.00" BorderStyle="Groove" CssClass="input" Width="100px" Enabled="false"></asp:TextBox> 
                    <asp:HiddenField ID="HdnTotalAmt" runat="server" />
                </td>
                <td style="text-align: left"   nowrap class="blackfnt"> &nbsp;Deposited In Bank</td>
                <td style="text-align: left" nowrap   class="blackfnt"> &nbsp; 
                        <asp:DropDownList ID="ddrBankaccode" runat="server" Width="200px"> </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: White"> 
                <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Narration</td>
                <td colspan="3" class="blackfnt" style="text-align: left"> &nbsp; 
                    <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="input" TextMode="MultiLine" Width="250px"></asp:TextBox>
                </td>
            </tr>
        </table>
        </br>
        <table border="0" cellpadding="1" cellspacing="1" width="800">
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="dgGeneral" runat="server" AllowPaging="False" AllowSorting="False"
                                AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey" RowStyle-CssClass="bgwhite" 
                                EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="bgwhite" BorderWidth="0" CssClass="boxbg" CellSpacing="1" Width="800" >
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ControlStyle-Width="50px" >
                                        <ItemTemplate>
                                            <input type="checkbox" onclick="javascript:checktotamt(this)" id="chkchqno" runat="server"  value='<%# DataBinder.Eval(Container.DataItem,"chqnodt")%>' />   
                                            <asp:HiddenField ID="Hdnchqdt" Value='<%# DataBinder.Eval(Container.DataItem,"chqdate")%>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="chqno" HeaderText="Cheque No"/>
                                    <asp:BoundField DataField="chqdt" HeaderText="Cheque Date"  />
                                    <asp:BoundField DataField="chqamt" HeaderText="Cheque Amount"  />
                                    <asp:BoundField DataField="entrydt" HeaderText="Entry Date"  />
                                    <asp:BoundField DataField="party" HeaderText="Party"  />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" /></td>
                    <asp:HiddenField ID="click_count" runat="server" Value="0" />   
            </tr>
        </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>   
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

