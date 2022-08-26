<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="miscmr_step1.aspx.cs" Inherits="GUI_Finance_MoneyRecpt_miscmr_step1" Title="Untitled Page" %>

<%@ Register Src="../../../Usercontrol/WebUserControl.ascx" TagName="WebUserControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js" ></script>
<script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
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
 function ValidateForm(obj)
    {

      if (obj.value!="")
      {
        
	    if (isDate(obj.value)==false)
	    {
    	
		    obj.focus()
		    return false
	    }
        return true
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
function popuplist(mode,ctlid,tbl)
 { 
    
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
       return false;
 }
 function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value 
	//alert(temp)					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.0";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.0";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.0";
		obj.focus();
		return false;
	}
	obj.value=rounditn(temp,3) 
	return true;					   
}
function rounditn(Num,decplaces)
	{
		Places=decplaces
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
				//alert("Hi")
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
 function GetXMLHttpObject()
  { 
      var xmlHttp;
      try
        {    
            xmlHttp=new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
      catch (e)
        {
            // Internet Explorer    
            try
              {  
                  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
              }
            catch (e)
              {      
                try
                    {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
                catch (e)
                    {
                        alert("Your browser does not support AJAX!");        
                        return false;        
                    }      
              }    
         }
         return xmlHttp;  
   }
   
 function partyBlur()
 {
//    debugger
    var txt=document.getElementById("ctl00_MyCPH1_txtpartycode");
    if(txt.value==null)
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="../Billing/BillEdit/CheckExist.aspx?mode=party&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Party Code Is not Valid..Enter Proper Party Code....");
                            txt.value="";
                            txt.select();
                            return false;
                       }
                }
          }
      findobj.send(null);
    }
}

function docBlur()
{
    //debugger
    var docno=document.getElementById("ctl00_MyCPH1_txtdockno");
    if(docno.value=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="../Billing/BillEdit/BringDocDetails.aspx?mode=Misc_doc&docno=" + docno.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                       alert(res[1])
                       // alert("Docket Number is not Valid... Please Enter Valid Document No.")
                        docno.value="";
                       docno.focus();
                        return false;
                    }
                    txtpartycode.value=res[1];
                    txtlocation.value=res[2];
                }
         }
         
    findobj.send(null);
    }
    return false;
}

function Cal(txtdoordely_chrg,txtdem_chrg,txtwarehouse_chrg,txtmathadi_chrg, txtother_chrg, subtotal, tds_rate,tds_chrg, ded_oth,netamt)
{
    if(tds_rate.value >= 100)
    {
       alert("TDS Rate Should not greater than 100%");
       tds_rate.focus();
       tds_rate.value = "0.0";
       return false;
    }
    var varsubtotal = parseFloat(Number(txtdoordely_chrg.value) + Number(txtdem_chrg.value) + Number(txtwarehouse_chrg.value) + Number(txtmathadi_chrg.value) + Number(txtother_chrg.value)) ;
    subtotal.value = varsubtotal;
    tds_chrg.value = rounditn(Math.round(parseFloat(Number(varsubtotal)* Number(tds_rate.value) / Number(100))),2);
    netamt.value = Math.round(parseFloat(Number(varsubtotal) - Number(tds_chrg.value) - Number(ded_oth.value)).toFixed(2));
}

function Check(txtpartycode,txtpartyname,netamt)
{
     var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
   
   
   if(document.getElementById('ctl00_MyCPH1_txtmrdt').value =="")
    {
        alert("Please Enter Mrs Date");
        txtpartycode.focus();
        return false;
    }
                 var dt =document.getElementById('ctl00_MyCPH1_txtmrdt').value
               // alert(dt)
                var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
    dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
//			alert("server_dt : " + server_dt)
//			alert("dt : " + dt)

				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			         //   alert(FinYear_todate1)	
					//	alert(FinYear_fromdate1)	
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO MRs date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById('ctl00_MyCPH1_txtmrdt').focus();
						return false;
				}
					//alert(server_dt)	
						//alert(dt)		
				if (dt>server_dt)
				{
						alert( "MRs date should not be greater than today's date !!!");
						document.getElementById('ctl00_MyCPH1_txtmrdt').focus();
						return false;
				}
    
    if((txtpartycode.value == "") && (txtpartyname.value == ""))
    {
        alert("Please Select Party Code OR Enter the Party Name");
        txtpartycode.focus();
        return false;
    }
    
    if(document.getElementById('ctl00_MyCPH1_chqdetail11_cbopaytype').value != "Cash")
    {
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtchqno').value == "")
        {
            alert("Please Enter the Check Number");
            return false;
        }
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtchqdt').value == "")
        {
            alert("Please Enter the Check Date");
            return false;
        }
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtindchqamt').value == "")
        {
            alert("Please Enter the Check Amount");
            return false;
        }
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtindclamt').value == "")
        {
            alert("Please Enter the Accounted Amount");
            return false;
        }
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtbanknm').value == "")
        {
            alert("Please Enter the Bank Name");
            return false;
        }
        if(document.getElementById('ctl00_MyCPH1_chqdetail11_txtbankbrn').value == "")
        {
            alert("Please Enter the Bank Branch Name");
            return false;
        }
        
    }
    
    if(document.getElementById('ctl00_MyCPH1_chqdetail11_colamt').value == "")
     {
            alert("Please Enter the Collected Amount");
            return false;
     }
     if(document.getElementById('ctl00_MyCPH1_chqdetail11_cbopaytype').value == "Cash")
     {
        if(parseFloat(netamt.value) != parseFloat(document.getElementById('ctl00_MyCPH1_chqdetail11_colamt').value))
        {
            alert("Collected Amount and Net Amount Should be Equal");
            return false;
        }
     }
     if(document.getElementById('ctl00_MyCPH1_chqdetail11_tdsacccode').value == "")
     {
            alert("Please Select the TDS Type");
            return false;
     }
     
}

function ClAmt(netamt)
{
    if(document.getElementById('ctl00_MyCPH1_chqdetail11_cbopaytype').value == "Cash")
    {
        document.getElementById('ctl00_MyCPH1_chqdetail11_colamt').value = netamt.value;
        return false;
    }
}
function CheckSf(docksf)
{
    if(docksf.value != "." && docksf.value != "")
    {
        alert("Invalid Character");
        docksf.focus();
        docksf.value = "";
        return false;
    }
}


 
 
	
</script>
 <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
<table  border="0" cellpadding="0" cellspacing="0" width="900" align="left">
<tr> 
    <td></td>
  </tr>
  <tr>
  <td>
  <table width="100%" border="0" class="boxbg" cellpadding="0" cellspacing="1" style="text-align:center; background-color:White" >
  <tr>
        <td style="height:30px"></td>
        </tr>
        
        <tr> 
          <td class="horzblue"></td>
        </tr>
        <tr> 
          <td>
      <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt"></asp:Label></td>
        </tr>
        <tr> 
          <td style="text-align:right"><a href="javascript:window.history.go(-1)" >BACK</a></td>
        </tr>
        <tr>
            <td style="text-align: center">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width:39%; text-align: left;" valign="top">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="text-align:center">
                                        <table cellspacing="1" cellpadding="3" border="0" style="text-align:center"  width="95%" class="boxbg" >
                                            <tr class="bgbluegrey"><td valign="top" colspan="4" align="center">
                                                <strong>MR Summary</strong></td></tr>
                                                <tr style="background-color:#ffffff" >
                                                <td style="width:20%; text-align: left;" class="blackfnt">MR No.</td>
                                                <td class="blackfnt" style="text-align: left"><font color="red" ><b> < System Generated > </b></font></td>
                                                <td style="width:20%; text-align: left;" class="blackfnt">Date</td>
                                                <td class="blackfnt" style="text-align: left">
                                                <asp:TextBox runat="server"    onblur="javascript:ValidateForm(this)"   ID="txtmrdt" MaxLength="10" TabIndex = "0" Width="98px" ></asp:TextBox>
                                                   <a href="#" onclick="cal.select(ctl00$MyCPH1$txtmrdt,'anchor101','dd/MM/yyyy'); return false;" id="anchor101" name="anchor101" > <img  alt="cal" style="border:0"   src="../../images/calendar.jpg" /></a><%--<asp:RequiredFieldValidator
                                                       ID="RFVFromDate" runat="server" ControlToValidate="txtmrdt" CssClass="blackfnt"
                                                       ErrorMessage="Date cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                           ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmrdt" ErrorMessage="Invalid Date "
                                                           ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                           ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%></td>
                                            </tr>
                                            <tr style="background-color:#ffffff">
                                                <td style="width:20%; text-align: left;" class="blackfnt">MR Type</td>
					                            <td class="blackfnt" style="text-align: left">Misc. MR</td>
					                            <td style="width:20%; text-align: left;" class="blackfnt">MR Branch </td>
					                            <td class="blackfnt" style="text-align: left">
                                                    <asp:Label ID="lblBranchCode" runat="server"></asp:Label>
                                                    :
                                                    <asp:Label ID="lblBranchName" runat="server"></asp:Label></td>
                                            </tr>
                                             <tr style="background-color:#ffffff">
                                                <td class="blackfnt" style="text-align: left">Party </td>
                                                <td colspan="1" class="blackfnt" style="text-align: left">
					                                <asp:TextBox ID="txtpartycode" runat="server" TabIndex="2" MaxLength="9" Width="76px"></asp:TextBox>
					                                <button  id="branchpopup" runat="server" class="blackfnt"  value="..."></button>
					                              <%--  <asp:Button runat="server" ID="branchpopup" Text="..."   />--%>
					                                <br />
                                                    8888 : <asp:TextBox ID="txtpartyname" runat="server" TabIndex="4" MaxLength="50"></asp:TextBox>
                                                </td>
                                                <td valign="top" class="blackfnt" style="text-align: left">Cnote No<strong> </strong>
                                                </td>
                                                <td colspan="1" valign="top" class="blackfnt" style="text-align: left; font-weight: bold;">
					                                <asp:TextBox ID="txtdockno" runat="server" TabIndex="5" MaxLength="15" Width="77px"></asp:TextBox>
					                                <asp:TextBox ID="txtdocksf" runat="server" TabIndex="6" MaxLength="1" Width="40px"></asp:TextBox>
                                                 </td>             
                                             </tr>
                                        </table>
                                        <br />
                                        <div style="text-align:center">
                                            <center>
                                                <table cellspacing="1" cellpadding="3" border="0"  width="95%" class="boxbg">
                                                    <tr class="bgbluegrey"> 
                                                        <td valign="top" colspan="4" align="center" class="blackfnt">
                                                            <strong>
                                                            Collection Details</strong></td>
                                                    </tr>
                                                     <tr style="background-color:#ffffff" > 
                                                        <td valign="top" class="blackfnt" style="text-align: left; width: 197px;" >Request Door Delivery Charges (+)</td>
                                                        <td valign="top" class="blackfnt" style="text-align: left"><asp:TextBox ID="txtdoordely_chrg"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="7" MaxLength="10" Width="80px">0</asp:TextBox></td>
                                                        <td class="blackfnt" style="text-align: left">TDS rate (%)</td>
                                                        <td class="blackfnt" style="text-align: left"><asp:TextBox ID="tds_rate"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="11" MaxLength="6" Width="80px">0</asp:TextBox></td>
                                                     </tr>
                                                     <tr style="background-color:#ffffff" > 
                                                        <td valign="top" class="blackfnt" style="text-align: left; width: 197px;" >Demurrage Charges (+)</td>
                                                        <td valign="top" class="blackfnt" style="text-align: left" ><asp:TextBox ID="txtdem_chrg"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="8" MaxLength="10" Width="80px">0</asp:TextBox></td>
                                                        <td class="blackfnt" style="text-align: left">TDS Amount(-)</td>		
                                                        <td class="blackfnt" style="text-align: left"><asp:TextBox ID="tds_chrg" runat="server" TabIndex="11" MaxLength="6" Width="80px" Enabled="False">0</asp:TextBox></td>
                                                    </tr>
                                                    <tr style="background-color:#ffffff" > 
			                                            <td valign="top" class="blackfnt" style="text-align: left; width: 197px;">Ware House Charges (+)</td>	
			                                            <td valign="top" class="blackfnt" style="text-align: left"><asp:TextBox ID="txtwarehouse_chrg"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="9" MaxLength="10" Width="80px">0</asp:TextBox></td>
			                                            <td class="blackfnt" style="text-align: left">
                                                            Other Deduction (-)</td>
			                                            <td class="blackfnt" style="text-align: left; font-weight: bold;"><asp:TextBox ID="ded_oth"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="11" MaxLength="6" Width="80px">0</asp:TextBox></td>		
		                                            </tr>
		                                            <tr style="background-color:#ffffff; font-weight: bold;" > 
			                                            <td valign="top" class="blackfnt" style="text-align: left; width: 197px;">Mathadi Charges (+)</td>	
			                                            <td valign="top" class="blackfnt" style="text-align: left"><asp:TextBox ID="txtmathadi_chrg"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="10" MaxLength="10" Width="80px">0</asp:TextBox></td>
			                                            <td style="text-align: left"></td>
			                                            <td class="blackfnt" style="text-align: left"></td>		
		                                            </tr>
		                                            <tr style="background-color:#ffffff; font-weight: bold;"> 
			                                            <td valign="top" class="blackfnt" style="text-align: left; width: 197px;">Other Charges (+)</td>	
			                                            <td valign="top" class="blackfnt" style="text-align: left"><asp:TextBox ID="txtother_chrg"  onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server" TabIndex="10" MaxLength="10" Width="80px">0</asp:TextBox></td>
			                                            <td style="text-align: left"></td>
			                                            <td class="blackfnt" style="text-align: left"></td>		
		                                            </tr>
		                                            <tr style="background-color:#ffffff"> 
                                                         <td valign="top" class="blackfnt" style="text-align: left; width: 197px;">
                                                             <strong>
                                                             Total</strong></td>
                                                         <td valign="top"class="blackfnt" style="text-align: left"><asp:TextBox ID="subtotal" runat="server" TabIndex="10" MaxLength="10" Width="80px" Enabled="False">0</asp:TextBox></td>
                                                         <td class="blackfnt" style="text-align: left">
                                                             <strong>
                                                             Net Amount</strong></td>
		                                                 <td class="blackfnt" style="text-align: left">
                                                             <asp:TextBox ID="netamt" runat="server" MaxLength="6" TabIndex="11" Width="80px" Enabled="False">0</asp:TextBox></td>		
	                                                 </tr>
                                                    
                                                     <tr style="background-color:#ffffff">
                                                        <td valign="top" colspan="4">
                                                            &nbsp;<uc1:WebUserControl ID="chqdetail11" runat="server" />
                                                        </td>
                                                     </tr> 
                                                     <tr style="background-color:#ffffff"> 
                                                        <td valign="top" class="blackfnt" style="text-align: left; width: 197px;">Remark</td>
                                                        <td valign="top" colspan="3" class="blackfnt" style="text-align: left"><asp:TextBox runat="server" ID="remark" MaxLength="15" Height="47px" TextMode="MultiLine" Width="230px" ></asp:TextBox>
                                                            </td>
                                                     </tr>
                                                </table>
                                            </center>
                                        </div>
                                     
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:Button ID="btnsubmit" runat="server" CssClass="blackfnt" OnClick="btnsubmit_Click"
                    Text="Submit" /></td>
        </tr>

  </table>
      </td>
  </tr>
</table>
        <div id="Div1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div>    
        </ContentTemplate>
    </asp:UpdatePanel>
 
</asp:Content>

