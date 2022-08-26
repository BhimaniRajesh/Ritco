<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JournalVoucher_Ver1.aspx.cs" Inherits="GUI_Finance_Journal_Voucher_JournalVoucher" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    var FinYear="<%=Session["FinYear"]%>"
    //maintain this for back dated entery not allowed in RCPL and RITCO
    var brcd="<%=Session["brcd"]%>";
    var client="<%=Session["Client"]%>";
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
     
function popuplist(mode,ctlid,tbl)
 { 
      //debugger;
      var hdnradbtnval = "";
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
      if(mode != "AccCode")
      {
         hdnradbtnval = document.getElementById("ctl00_MyCPH1_hdnradbtnval").value;
      }
      else
      {
         hdnradbtnval = mode;   
      }
      url="DataPopUp.aspx?mode=" + hdnradbtnval + "&ctlid=" + ctlid + "&tbl=" + tbl ;
      confirmWin=window.open(url,"",winOpts);
      return false;
 }
 function PartyBlur(id)
 {  
    var str="";
    for(var i=0;i<id.length-12;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtPartyCode=document.getElementById(id);
    var txtPartyDescription=document.getElementById(id.substring(0,id.length - 12) + "txtPartyDescription");
    
    var txtAccCode=document.getElementById(id.substring(0,id.length - 12) + "txtAccCode");
    var txtDescription=document.getElementById(id.substring(0,id.length - 12) + "txtDescription");
    
    var hdnradbtnval = document.getElementById("ctl00_MyCPH1_hdnradbtnval").value;
    //var Hdnnorefcode = document.getElementById("ctl00_MyCPH1_Hdnnorefcode").value;
    //var Hdnnorefdesc = document.getElementById("ctl00_MyCPH1_Hdnnorefdesc").value;
    
    var VendorType = "";
    if(hdnradbtnval == "P")
        VendorType = "Customer" ;
    else if(hdnradbtnval == "V")
        VendorType = "Vendor" ;
    else if(hdnradbtnval == "E")
        VendorType = "Employee" ;  
    else if(hdnradbtnval == "D")
        VendorType = "Driver" ;    
    else if(hdnradbtnval == "L")
        VendorType = "Vehicle" ;          
              
    var PartyCode=txtPartyCode.value.toUpperCase();
    
    //if(PartyCode == "")
    //{   
    //    return false;
    //}
    if(PartyCode == "NOREF" || PartyCode == "")
    {
        txtPartyCode.value = "NOREF";
        txtPartyDescription.value = "--";
        //txtAccCode.value = Hdnnorefcode;
        //txtDescription.value = Hdnnorefdesc;
        return false;
    }
    
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var r=tbl.rows.length;
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
    
     var strpg="CheckExist.aspx?mode=" + VendorType + "&Code=" + PartyCode + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert( VendorType + " Code is not Valid... Please Enter Valid " + VendorType + " Code");
                        txtPartyCode.value="";
                        txtPartyDescription.value="";
                        txtPartyCode.focus();
                        return false;
                    }
                    else
                    {
                        txtPartyDescription.value=res[1];
                    }
                    
                }
         }
         
    findobj.send(null);
    }
    
    return false;
 }
 function AccBlur(id)
 {
    var str="";
    for(var i=0;i<id.length-10;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtAccCode=document.getElementById(id);
    var txtDescription=document.getElementById(id.substring(0,id.length - 10) + "txtDescription");
  
    var AccCode=txtAccCode.value.toUpperCase();
    
    if(AccCode=="")
        return false;
 
    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
    var r=tbl.rows.length;
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="CheckExist.aspx?mode=AccCode&Code=" + AccCode + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        { 
            if(findobj.readyState==4 && findobj.status==200)
            {
                var res=findobj.responseText.split("|");
                if(res[0]=="false")
                {
                    alert("Account Code is not Valid... Please Enter Valid Account Code");
                    txtAccCode.value="";
                    txtDescription.value="";
                    txtAccCode.focus();
                    return false;
                 }
                else
                {
                    txtDescription.value=res[1];
                    Get_Debit_Credit_Tot('_txtDebitAmt','_txtTotDebitAmt')
                    Get_Debit_Credit_Tot('_txtCreditAmt','_txtTotCreditAmt')
                    /*  edited on 05/07/2008 by manish kher */
                    var txtNarrationMain = document.getElementById("ctl00_MyCPH1_txtNarration");
                    var txtNarrationGrid = document.getElementById(id.substring(0,id.length - 10) + "txtNarration"); 
                    txtNarrationGrid.value = txtNarrationMain.value;
                    /* for DRS & Other CLIENT ONLY */
                        
                 }  
             }
         }
         
    findobj.send(null);
    }
    return false;
}
function validFloatVal(event,txtid)
{
    //var tb=document.getElementById(txtid);
    var txt=txtid.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
}
function Manualbillblur(id)
{
    //debugger;
    var txtManualBillno=document.getElementById(id);
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
function Get_Debit_Credit_Tot(Ind_amt_id,TotAmt_Id)
	{  
	    //debugger;
	    var i,Amt,TotDebitAmt,T=0;
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        { 
            if(i<10)
            {
               Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + Ind_amt_id).value;
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
            }
            else
            {
                Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + Ind_amt_id).value;
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
            }
            if(Acccode!="")
            {
                T = parseFloat(Number(T) + Number(Amt)).toFixed(2);
            }
        }
         
        var j = rows;
        if(j<10)
        {
            TotDebitAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + j + TotAmt_Id);
        }
        else
        {
            TotDebitAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + j + TotAmt_Id);
        }
        
        TotDebitAmt.value = T;
	}
	
function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value 
	//alert(temp)		
	var HdnRoundOffRule = document.getElementById("ctl00_MyCPH1_hdnroundoff");			
	if (temp=="")	
	{
		alert("Value can not be blank")
		if(HdnRoundOffRule.value == "Y")
            obj.value="0";
        else
            obj.value="0.00";
        obj.focus();
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		if(HdnRoundOffRule.value == "Y")
            obj.value="0";
        else
            obj.value="0.00";
        obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		if(HdnRoundOffRule.value == "Y")
            obj.value="0";
        else
            obj.value="0.00";
        obj.focus();
		return false;
	}
	//obj.value=roundit(temp) 
	if(HdnRoundOffRule.value == "Y")
        obj.value=roundit(Math.round(obj.value));
    else
        obj.value=roundit(roundNumber(obj.value,2));
	
	return true;					   
}
function roundit(Num)
{
    Places=2;
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
function radio_btn_selection(id)
	{   
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        {   
            if(i<10)
            {
               radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_rad_Particular");
            }
            else
            {
               radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_rad_Particular");
            }
            if(radbtn_id == id && i == 2)
            {
                alert("You Can't Select This Ledger For Particular");
                id.checked = false;
                id.disabled=true;
                return false;
            }
            else if(radbtn_id != id)
            {
                radbtn_id.checked = false;
            }
            if(i == 2)
            {
                radbtn_id.disabled = true;
            }
        }
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
			alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO Multiple Journal Voucher  Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
			date.focus();
			return false;
		}
		
		if (dt>server_dt)
		 {
            alert( voucher + " Date should not be greater than today's date !!!")
            date.focus();
            return false;
		 }
		 //This Case is Only For RCPL and RITCO Client
		if (dt<server_dt)
        {
	        /*if(client == 'RCPL')
            {
        	    if(brcd != 'HQTR')
                {     
                    alert( voucher + " Date should not be Less than today's date !!!")
                    date.focus();
                    return false;
                }   
            }
            if(client == 'Ritco')
            {
        	    alert( voucher + " Date should not be Less than today's date !!!")
                date.focus();
                return false;
            }*/
        }
		return true;
}
function CheckData()
{   
        //debugger;
        var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
        var txtManualNo = document.getElementById("ctl00_MyCPH1_txtManualNo");
        var txtPreparedFor = document.getElementById("ctl00_MyCPH1_txtPreparedFor");
        var Othercode = document.getElementById("ctl00_MyCPH1_txtCode");
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
        if(txtPreparedFor.value == "")
        {
            alert("Please Enter Prepared For");
            txtPreparedFor.focus()
            return false;
        }
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var Totalcount=tbl.rows.length;
        var Acccode_flag="N";
        var Radio_selection = "N";
        for(i = 2; i < Totalcount ; i++)
        {
            if(i<10)
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               PartyCode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtPartyCode").value;
               radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_rad_Particular");
            }
            else
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
               PartyCode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtPartyCode").value;
               radbtn_id=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_rad_Particular");
            }
            if(radbtn_id.checked == true && Acccode != "")
            {
                Radio_selection="Y";
            }
            if(Acccode != "" && PartyCode != "")
            {
                Acccode_flag="Y";
            }
            if(Acccode != "" && PartyCode == "")
            {
                Acccode_flag="N";
                break;
            }
        }
        if(Radio_selection != "Y")
        {
             alert("Please Select Ledger For Particular");
             return false;
        }
        if(Acccode_flag != "Y")
        {
             alert("Please Enter Atleast One Account Code Or Party Code");
             return false;
        }
        else
        {
            for(i = 2; i < Totalcount ; i++)
            {
                if(i<10)
                {
                    Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
                    Cr_Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtCreditAmt");
                    Dr_Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtDebitAmt");
                }
                else
                {
                    Cr_Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtCreditAmt");
                    Dr_Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ct1" + i + "_txtDebitAmt");
                    Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
                }
                if(Acccode!="")
                { 
                    if(parseFloat(Cr_Amount.value)== 0 && parseFloat(Dr_Amount.value)== 0)
                    {
                         alert("Please Either Debit Or Credit Amount");
                         Dr_Amount.focus();
                         return false;
                    }
                    if(parseFloat(Cr_Amount.value)> 0 && parseFloat(Dr_Amount.value)>0)
                    {
                         alert("Please Either Debit Or Credit Amount Will BE Geater then Zero");
                         Cr_Amount.focus();
                         return false;
                    }
                }
            }
      
            var j = Totalcount;
        
            if(j<10)
            {   
                TotDebitAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + j + "_txtTotDebitAmt");
                TotCreditAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + j + "_txtTotCreditAmt");
            }
            else
            {
                TotDebitAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + j + "_txtTotDebitAmt");
                TotCreditAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + j + "_txtTotCreditAmt");
            }
        
            if(parseFloat(TotDebitAmt.value)!=parseFloat(TotCreditAmt.value))
            {
                alert("Total Debit Should Be Equals To Total Credit")
                return false;
            }
        
            TotDebitAmt.disabled=false;
            TotCreditAmt.disabled=false;
        }
        for(i = 2; i < Totalcount ; i++)
        {
            //alert(Totalcount)
            if(i<10)
            {
               Description=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtDescription");
               PartyDescription=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtPartyDescription");
            }
            else
            {
               Description=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtDescription");
               PartyDescription=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtPartyDescription");
            }
            
            Description.disabled=false;
            PartyDescription.disabled=false;
        }
	}
</script>

<div style="width: 10.5in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="text-align: center; width: 10.5in">
    <table cellspacing="1" class="boxbg" width="950">
        <tr class="bgbluegrey">
            <td align="center">
                <strong>Multiple Journal Voucher</strong>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate> 
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="950">
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Voucher No</td>
                    <td class="blackfnt"  nowrap style="text-align: left; width: 169px;"> <span style="color: #ff0000">&nbsp;&lt;System 
                        Generated&gt;</span></td>
                    <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Voucher Date</td>
                    <td colspan="3" width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtVoucherDate" runat="server" Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap  style="text-align: left"> &nbsp;Manual No.</td>
                    <td class="blackfnt"  nowrap style="text-align: left; width: 169px;"> &nbsp; 
                        <asp:TextBox ID="txtManualNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox></td>
                    <td class="blackfnt" nowrap  style="text-align: left"> &nbsp;Ref. No.</td>
                    <td colspan="3" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtRefNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox></td>    
                </tr>        
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;"   nowrap class="blackfnt"> &nbsp;Prepared 
                    at location</td>
                  <td class="blackfnt" style="text-align: left; width: 169px;"> &nbsp;<strong><asp:Label ID="lblpreparedfor" runat="server"></asp:Label></strong> </td>
                  <td style="text-align: left"   nowrap class="blackfnt"> &nbsp;Prepared By</td>
                  <td colspan="3" style="text-align: left"  nowrap  class="blackfnt"> &nbsp;<strong><asp:Label ID="lblpreparedby" runat="server"></asp:Label></strong> </td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left" class="blackfnt"> &nbsp;Prepared For</td>
                  <td colspan="5" style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedFor" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox></td>
                </tr>
                <tr style="background-color: White"> 
                  <td class="blackfnt" style="text-align: left; "> &nbsp;Paid 
                    To</td>
                  <td align="left" style="width: 169px"> <asp:RadioButton ID="RAD_Customer"  Checked="true" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Customer" OnCheckedChanged="Show_Party"/>  </td>
                  <td align="left"><asp:RadioButton ID="RAD_Vendor" AutoPostBack="true" GroupName="Pbov_list" runat="server"  Text="Vendor" OnCheckedChanged="Show_Party"/></td>
                  <td align="left" style="width: 158px"><asp:RadioButton ID="RAD_Emp" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Employee" OnCheckedChanged="Show_Party"/></td>
                  <td align="left"><asp:RadioButton ID="RAD_Driver" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Driver" OnCheckedChanged="Show_Party"/></td>
                  <td align="left"><asp:RadioButton ID="RAD_Vehicle" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Vehicle" OnCheckedChanged="Show_Party"/></td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Narration</td>
                  <td style="text-align: left" colspan="5" class="blackfnt"> &nbsp; 
                        <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="Blackfnt"  onblur="javascript:this.value=this.value.toUpperCase()" TextMode="MultiLine" MaxLength="200" Width="300px"></asp:TextBox>
                        <asp:HiddenField ID="hdnradbtnval" runat="server" />
                        <%--<asp:HiddenField ID="Hdnnorefcode" runat="server" />
                        <asp:HiddenField ID="Hdnnorefdesc" runat="server" />--%>
                  </td>
                </tr>
            </table> 
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                        &nbsp;Enter No. of Rows
                    </td>
                    <td style="text-align: left" class="blackfnt">
                        &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" style="text-align:right" onkeypress="javascript:validInt(event);" CssClass="input" Width="100px"></asp:TextBox>
                        <asp:UpdatePanel ID="upAddRow" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Add Rows"  OnClick="btnAdd_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="950">
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                        <font color="red"><strong><asp:Label ID="lblparticular" runat="server" Text="Plz Check Radio Button For Particular Ledger"></asp:Label></strong></font>
                    </td>
                </tr>
            </table>
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
            <table border="0" cellpadding="0" cellspacing="0" width="950">
                <tr style="background-color: White">
                    <td style="text-align: left" class="blackfnt">
                        <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                    CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                    PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True" OnRowDataBound="grvcontrols_RowDataBound">
                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                    <FooterStyle CssClass="boxbg" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Particular">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <input type="radio" id="rad_Particular" runat="server" onclick="radio_btn_selection(this)" />  
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Account Code">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtAccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                    Enabled="true" Width="70px"></asp:TextBox>
                                                <asp:TextBox ID="txtDescription" runat="server" BorderStyle="Groove"
                                                    Width="135px" CssClass="input" Enabled="false"></asp:TextBox>
                                                <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                             </ItemTemplate>
                                             <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                             <FooterTemplate><strong></strong></FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party Code">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtPartyCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                    Enabled="true" Width="70px"></asp:TextBox>
                                                <asp:TextBox ID="txtPartyDescription" runat="server" BorderStyle="Groove"
                                                    Width="180px" CssClass="input" Enabled="false"></asp:TextBox>
                                                <asp:Button ID="btnPartyCode" runat="server" Text="..." />
                                            </ItemTemplate>
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" />
                                            <FooterTemplate>
                                            <strong>Total</strong>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Debit">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtDebitAmt" onkeypress="javascript:validFloatVal(event,this);" onblur="javascript:Get_Debit_Credit_Tot('_txtDebitAmt','_txtTotDebitAmt')"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                    BorderStyle="Groove" CssClass="input" Width="70px" Text="0.00" style="text-align:right" ></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <FooterTemplate>
                                                <asp:TextBox ID="txtTotDebitAmt" runat="server" CssClass="input" BorderStyle="Groove"
                                                    Width="70px" MaxLength="10" Enabled="False"  style="text-align:right"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Credit">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCreditAmt" onkeypress="javascript:validFloatVal(event,this);" onblur="javascript:Get_Debit_Credit_Tot('_txtCreditAmt','_txtTotCreditAmt')"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                    BorderStyle="Groove" CssClass="input" Width="70px" Text="0.00" style="text-align:right" ></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <FooterTemplate>
                                                <asp:TextBox ID="txtTotCreditAmt" runat="server" CssClass="input" BorderStyle="Groove"
                                                    Width="70px" MaxLength="10" Enabled="False" style="text-align:right"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Narration">
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                            <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtNarration"  onblur="javascript:this.value=this.value.toUpperCase()"  runat="server" BorderStyle="Groove" CssClass="input" TextMode="MultiLine" MaxLength="200" Width="150px"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table cellspacing="1" class="boxbg" width="950">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt"  OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" />
                        <asp:HiddenField ID="hdnroundoff" runat="server" Value="N" />
                    </td>
                </tr>
            </table>
            <br />
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"> </div>   
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</asp:Content>

