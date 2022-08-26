<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ContraVoucher_Edit.aspx.cs" Inherits="GUI_Finance_Voucher_Edit_ContraVoucher_Edit" Title="Untitled Page" %>
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
	
    function ValidateDate(obj)
    {
      if (obj.value!="")
      { 
	    if (isDate(obj.value)==false)
	    {
		    obj.focus();
		    return false;
	    }
        return true;
      }
    }
    var dtCh= "/";
    var minYear="1900";
    var maxYear="2100";
    function DaysArray(n) 
     {
	    for (var i = 1; i <= n; i++) 
	    {
		    this[i] = 31
		    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
		    if (i==2) {this[i] = 29}
       } 
        return this
     }
    function isDate(dtStr){
    var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
	return true
}

function Manualbillblur(id)
{   
    var txtManualBillno=id;
    var Manualbill = txtManualBillno.value;
    if(Manualbill=="")
    {
        return false
    }
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=Manualbill&Code=" + Manualbill + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                    {
                        alert("Manual Voucher Number is Already Exists... Please Enter Other Mumber");
                        txtManualBillno.value="";
                        txtManualBillno.focus();
                        return false;
                    }
                }
         }
    findobj.send(null);
    }
    return false;
}
function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value;					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.00";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.00";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.00";
		obj.focus();
		return false;
	}
	obj.value=roundit(temp) 
	return true;					   
}
function roundit(Num)
	{
		Places=2
		if (Places > 0) 
			{
			if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
			{
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				var Rounder = Math.pow(10, Places);
				return Math.round(Num * Rounder) / Rounder;
			}
			else 
			{
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				else
				{  
					if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
						return Num.toString() +'0';	
					else
						return Num.toString();				   

				}
			}
			}
		else return Math.round(Num);
	}
	function CheckFinacialYear(checkdate,voucher)
	{
	    var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
        var dt =checkdate.value
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
			alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Journal Voucher  Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
			checkdate.focus();
			return false;
		}
		
		if (dt>server_dt)
		 {
            alert( voucher + " Date should not be greater than today's date !!!")
            checkdate.focus();
            return false;
		 }
		 return true;
	}
	function CheckData()
	{   
        //debugger;
        var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
        var txtManualNo = document.getElementById("ctl00_MyCPH1_txtManualNo");
        var txtRefNo = document.getElementById("ctl00_MyCPH1_txtRefNo");
        var txtNarration = document.getElementById("ctl00_MyCPH1_txtNarration");
        var Paymode1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_ddlcashbank")
        var Paymode2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_ddlcashbank")
        var Acccode1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_ddlaccountlist")
        var Acccode2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_ddlaccountlist")
        var Debit1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_txtDebitAmt")
        var Debit2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_txtDebitAmt")
        var Credit1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_txtCreditAmt")
        var Credit2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_txtCreditAmt")
        var Chqno1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_txtChqno")
        var Chqdt1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_txtChqdate")
        var Chqno2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_txtChqno")
        var Chqdt2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_txtChqdate")
        var ddlaccountlist1 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl02_ddlaccountlist")
        var ddlaccountlist2 = document.getElementById("ctl00_MyCPH1_grvcontrols_ctl03_ddlaccountlist")
        var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
        
        if(txtVoucherDate.value == "")
        {
            alert("Please Enter Voucher Date");
            return false;
        }
        var voucherdateflag = CheckFinacialYear(txtVoucherDate,"Voucher")
        if(!voucherdateflag)
            return false; 
        if(txtManualNo.value == "")
        {
            alert("Please Enter Manual No");
            txtManualNo.focus()
            return false;
        }
        if(txtNarration.value == "")
        {
            alert("Please Enter Narration");
            txtNarration.focus()
            return false;
        }
        if(Paymode1.value == "")
        {
            alert("Please Select PayMode");
            Paymode1.focus()
            return false;
        }
        if(Acccode1.value == "")
        {
            alert("Please Select Account");
            Acccode1.focus()
            return false;
        }
        if(Paymode1.value == "Cash" && Paymode2.value == "Cash")
        {
            alert("Paymode Cash to Cash Not Possible.");
            Paymode1.value = "";
            Paymode1.focus();
            return false;
        }
        if(Paymode1.value == "Bank" && Paymode2.value == "Bank")
        {
            if(ddlaccountlist1.value == ddlaccountlist2.value)
            {
                alert("Plz Select The Different Bank");
                ddlaccountlist1.focus();
                return false;
            }
        }
        if(parseFloat(Credit1.value)== 0 && parseFloat(Debit1.value)== 0)
        {    
             alert("Please Enter Either Debit Or Credit Amount");
             Debit1.focus();
             return false;
        }
        if(parseFloat(Credit1.value) > 0 && parseFloat(Debit1.value) > 0)
        {    
             alert("Please Enter Either Debit Or Credit Amount");
             Debit1.value = "0.00";
             Credit1.value = "0.00";
             Debit1.focus();
             return false;
        }
        if(Paymode1.value == "Cash")
        {
            if(Chqno1.value != "" || Chqdt1.value != "")
            {
                alert("Your can't Enter Cheque No Or Cheque Date In Cash Mode");
                Chqno1.value = "";
                Chqdt1.value = "";
                return false;
            }
            
        }
        if(Paymode1.value == "Bank")
        {
            if(parseFloat(Credit1.value) > 0)
            {
                if(Chqno1.value == "")
                {
                    alert("Plz Enter Cheque No");
                    Chqno1.focus();
                    return false;
                 }
                if(!isValidDate(Chqdt1.value,"Contra Voucher"))
                {   
                    Chqdt1.focus();
                    return false;
                 }
                //var dateflag = CheckFinacialYear(Chqdt1,"Cheque")
                //if(!dateflag)
                //    return false; 
            }
            else if(parseFloat(Credit1.value) <= 0)
            {
                if(Chqno1.value != "")
                {
                    alert("Cheque No and Cheque Date Not Allowed");
                    Chqno1.value = "";
                    Chqdt1.value = "";
                    return false;
                 }
                if(Chqdt1.value != "")
                {
                    alert("Cheque No and Cheque Date Not Allowed");
                    Chqno1.value = "";
                    Chqdt1.value = "";
                    return false;
                 }
            }
        }
        if(Paymode2.value == "")
        {
            alert("Please Select PayMode");
            Paymode2.focus()
            return false;
        }
        if(Acccode2.value == "")
        {
            alert("Please Select Account");
            Acccode2.focus()
            return false;
        }
        if(parseFloat(Credit2.value)== 0 && parseFloat(Debit2.value)== 0)
        {    
             alert("Please Enter Either Debit Or Credit Amount");
             Debit2.focus();
             return false;
        }
        if(parseFloat(Debit1.value) > 0 && parseFloat(Debit2.value) > 0)
        {    
             alert("Please Enter Valid Debit Or Credit Amount");
             Debit2.value = "0.00";
             Debit2.focus();
             return false;
        }
        if(parseFloat(Credit1.value) > 0 && parseFloat(Credit2.value) > 0)
        {    
             alert("Please Enter Valid Debit Or Credit Amount");
             Credit2.value = "0.00";
             Credit2.focus();
             return false;
        }
        if(Paymode2.value == "Cash")
        {
            if(Chqno2.value != "" || Chqdt2.value != "")
            {
                alert("Your can't Enter Cheque No Or Cheque Date In Cash Mode");
                Chqno2.value = "";
                Chqdt2.value = "";
                return false;
            }
        }
        if(Paymode2.value == "Bank")
        {
            if(parseFloat(Credit2.value) > 0)
            {
                if(Chqno2.value == "")
                {
                    alert("Plz Enter Cheque No");
                    Chqno2.focus();
                    return false;
                 }
                if(!isValidDate(Chqdt2.value,"Contra Voucher"))
                {
                    //alert("Plz Enter Date In DD/MM/YYYY Format");
                    Chqdt2.focus();
                    return false;
                 }
                var dateflag = CheckFinacialYear(Chqdt2,"Cheque")
                if(!dateflag)
                    return false; 
            }
            else if(parseFloat(Credit2.value) <= 0)
            {
                if(Chqno2.value != "")
                {
                    alert("Cheque No and Cheque Date Not Allowed");
                    Chqno2.value = "";
                    Chqdt2.value = "";
                    return false;
                 }
                if(Chqdt2.value != "")
                {
                    alert("Cheque No and Cheque Date Not Allowed");
                    Chqno2.value = "";
                    Chqdt2.value = "";
                    return false;
                 }
            }
        }
        var totDebit = parseFloat(parseFloat(Debit1.value) + parseFloat(Debit2.value));
        var totCredit = parseFloat(parseFloat(Credit1.value) + parseFloat(Credit2.value));
        if( totDebit != totCredit)
        {    
             alert("Please Enter Valid Debit Or Credit Amount");
             Debit1.focus();
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
                <strong>Contra Voucher</strong>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate> 
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Voucher No</td>
                    <td class="blackfnt"  nowrap style="text-align: left">
                        <strong><span style="color: #ff0000"><asp:Label ID="lblvoucherno" runat="server"></asp:Label></span></strong>
                        <asp:HiddenField ID="HdnBrcd" runat="server" />
                        <asp:HiddenField ID="HdnChqno" runat="server" />
                        <asp:HiddenField ID="HdnChqdt" runat="server" />
                        <asp:HiddenField ID="HdnCashBankAmt" runat="server" />
                    </td>
                    <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Voucher Date</td>
                    <td colspan="2" width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtVoucherDate" Enabled="true" runat="server" onblur="javascript:ValidateDate(this)"
                            Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap  style="text-align: left"> &nbsp;Manual No.</td>
                    <td class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtManualNo" onblur="javascript:return Manualbillblur(this)" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px" MaxLength="50"></asp:TextBox></td>
                    <td class="blackfnt" nowrap  style="text-align: left"> &nbsp;Ref. No.</td>
                    <td colspan="2" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtRefNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px" MaxLength="50"></asp:TextBox></td>    
                </tr>        
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;"   nowrap class="blackfnt"> &nbsp;Prepared At</td>
                  <td class="blackfnt" style="text-align: left"> &nbsp;<strong><asp:Label ID="lblpreparedloc" runat="server"></asp:Label></strong></td>
                  <td style="text-align: left"   nowrap class="blackfnt"> &nbsp;Prepared By</td>
                  <td colspan="2" style="text-align: left"  nowrap  class="blackfnt"> &nbsp;<strong>
                        <asp:Label ID="lblpreparedby" runat="server"></asp:Label></strong>
                        <asp:HiddenField ID="HdnEntryby" runat="server" /> 
                  </td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Narration</td>
                  <td style="text-align: left" colspan="4" class="blackfnt"> &nbsp; <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="Blackfnt" MaxLength="200" onblur="javascript:this.value=this.value.toUpperCase()" TextMode="MultiLine" Width="300px" Height="30px"></asp:TextBox></td>
                </tr>
            </table> 
            <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <table border="0" cellpadding="0" cellspacing="0" width="800">
                <tr bgcolor="#ffffff"> 
                      <td align="left" class="blckfnt"><font class="redfnt"><strong><asp:CheckBox runat="server" ID="chkRefno" Checked="false" /> Check here to Enter Referance No.<br /></strong></font></td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                        <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                    CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." 
                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                    PagerStyle-HorizontalAlign="left" Width="100%"  OnRowDataBound="grvcontrols_RowDataBound">
                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr. No.">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pay Mode">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlcashbank" AutoPostBack="true" runat="server" OnSelectedIndexChanged="fillcashbank">
                                                    <asp:ListItem Value="">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="CASH">Cash</asp:ListItem>
                                                    <asp:ListItem Value="BANK">Bank</asp:ListItem>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Account Code">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlaccountlist" runat="server" Width="215px">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Debit">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                &nbsp;
                                                <asp:TextBox ID="txtDebitAmt" style="text-align :right"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                    BorderStyle="Groove" CssClass="input" Width="100px" Text="0.00" MaxLength="10"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Credit">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                &nbsp;
                                                <asp:TextBox ID="txtCreditAmt"  style="text-align :right"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                    BorderStyle="Groove" CssClass="input" Width="100px" Text="0.00" MaxLength="10"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque/Ref. No">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                &nbsp;
                                                <asp:TextBox ID="txtChqno"  style="text-align :right" MaxLength="50" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque/Ref. Date">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                &nbsp;
                                                <asp:TextBox ID="txtChqdate"  style="text-align :right" onblur="javascript:this.value=this.value.toUpperCase()"  runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt"  OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                            Width="150px" OnClick="btnSubmit_Click" />
                        <asp:HiddenField ID="click_count" runat="server" Value="0" />    
                    </td>
                </tr>
            </table>
            <br />
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"> </div>   
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>    
</asp:Content>

