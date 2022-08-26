<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="update_Manual_MR_3.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" Trace="true" %>

<%@ Register Src="../../Usercontrol/WebUserControl.ascx" TagName="WebUserControl"
    TagPrefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}
var tottds;	
var val;
	function fcaltotchqamt1(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt)
	{
							//alert(txtchqno)
							paytype=cbopaytype.options[cbopaytype.selectedIndex].value;
							//alert(paytype)
							totclamt=0;
							totchqamt=0;
							
							if ((paytype=="Cheque") || (paytype=="DD"))
							{
									
								for(i=0;i<3;i++)
								{
																chqno=txtchqno[i].value
																//	alert(chqno)
																if ((chqno=="") &&(i==0))
																{
																	alert("Please enter Cheque/DD No")
																	txtchqno[i].focus();
																	return false;
																}
																if(isNaN(chqno)&&(i==0))
																{
																	alert("Cheque/DD No Should be Numeric,cannot contain characters!!! ")
																	txtchqno[i].focus();
																	return false;
																}
									
																if(chqno!="")
																{
																	//check for valid cheque date
																			
																			if(txtchqdt[i].value=="")
																			{
																				alert("Please enter cheque date")
																				txtchqdt[i].focus()
																				return false;
																			}
//																			if(txtchqdt[i].value!="")
//																			{
//																				if (ValidateForm(txtchqdt[i])==false)
//																				{
//																					 return false;
//																				}
//																			}
																				
																			
																			chqamt=txtindchqamt[i].value
																			if (isNaN(chqamt))
																			{
																					alert("Please enter proper Cheque amount")
																					txtindchqamt[i].focus();
																					return false;
																			}
																			
																			
																			clamt =	txtindclamt[i].value
																			if (isNaN(clamt))
																			{
																					alert("Please enter proper Collection amount")
																					txtindclamt[i].focus();
																					return false;
																			}
																			onacctamt=txtonacctamt[i].value
																			if(onacctamt!="")
																			{
																				if(parseFloat(onacctamt)<parseFloat(clamt))
																				{
																					alert("Accounted amount should be less than or equal to on account balance amount")
																					txtindclamt[i].focus();
																					return false;
																				}	
																			}
																			if((parseFloat(clamt)>parseFloat(chqamt))&&(parseFloat(chqamt)!=0))
																			{
																					alert("Amount Collected Against Bill should be less than or equal to Cheque Amount")
																					txtindclamt[i].focus();
																 					return false;
																			}
																			totclamt=totclamt + parseFloat(clamt);
																			totchqamt=totchqamt + parseFloat(chqamt);
																}
																else
																{
																	
																			if(txtchqdt[i].value!="")
																			{
																				if(txtchqdt[i].value!="")
																				{
																					if (ValidateForm(txtchqdt[i])==false)
																					{
																						 return false;
																					}
																				}
																			}	
																			chqamt=txtindchqamt[i].value
																			if (isNaN(chqamt) && chqamt !="")
																			{
																								alert("Please enter proper Cheque amount")
																								txtindchqamt[i].focus();
																								return false;
																			}
 																			clamt =	txtindclamt[i].value
	 																		if (isNaN(clamt) && clamt !="")
		 																	{
			    																	alert("Please enter proper Collection amount")
							    													txtindclamt[i].focus();
																				    return false;
																			 }
																}
								}
								for(i=0;i<3;i++)
								{
									currchqno=txtchqno[i].value
									currchqdt=txtchqdt[i].value
									for(j=i+1;j<3&&i!=j;j++)
									{
										chqno=txtchqno[j].value
										chqdt=txtchqdt[j].value
										if(chqno!="")
										{
											if((chqno==currchqno)&&(chqdt==currchqdt)) 
											{
												alert("Duplicate cheque Found")
							    				txtchqno[j].focus();
												return false;
											}
										}	
									}
								}
								colamt.value=parseFloat(totclamt)
								//colamt.value=roundit(parseFloat(totclamt),2)
								//txtclamt.value=roundit(parseFloat(totclamt),2)
					}
					return true;
}



//function fclearChq(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt)
//{
//	transtype=cbopaytype.value;
//	if (transtype=="Cash") 
//	{	
//		for (i=0;i<3;i++)
//		{
//				txtchqdt[i].value=""
//				txtchqno[i].value=""
//				txtindchqamt[i].value=""
//				txtindclamt[i].value=""
//				txtbanknm[i].value=""
//				txtbankbrn[i].value=""
//		}
//	}	
//}
function ValidateForm(obj){
	if (isDate(obj.value)==false){
		obj.focus()
		return false
	}
    return true
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

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}
var doc = null; 
	var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;

	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
function OnBlurChqDetail(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt,txtbanknm,txtbankbrn)
	{
		
		for(currRow=0;currRow<3;currRow++)
		{
		            var cnt = 0;
		            var tmpStr = '';
            //		formObj = Obj;
		            arg=new Date();
		            chqdate=txtchqdt[currRow].value
		            chqno=txtchqno[currRow].value
		            
		            transtype=cbopaytype.value
		            
		            
		            /*if(txtchqdt[currRow].value!="")
		            {
			            if(txtchqdt[currRow].value!="")
			            {
				            if (ValidateForm(txtchqdt[currRow])==false)
				            {
					             return false;
				            }
			            }
		            }*/
		            if(chqdate!=''&&chqno!=''&&transtype=='Cheque')
		            {
				           // MyDiv = document.getElementById("divchqamt" + currRow);
				            createXMLHTTPObject();
				            if (doc)
				            { 
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dyn_combo.aspx?Search=onacctmrchq&chqno=" + chqno + "&chqdate=" + chqdate + "&RandText="+arg, false);
					            doc.send(null);
					            //alert(chqno)
				            }	
				             //alert(val)
                                var val_arr=val.split('~')
                    				
                    			
		                        txtchqno[currRow].value=val_arr[0]
			                    txtchqdt[currRow].value=val_arr[1]
			                    txtindchqamt[currRow].value=val_arr[2]
		                        txtonacct[currRow].value=val_arr[3];    
		                        txtbanknm[currRow].value=val_arr[4];
		                        txtbankbrn[currRow].value=val_arr[5];
		            }
//		            onacctamt=txtonacctamt[currRow].value
//		            if(onacctamt!="")
//		            {
//			            txtonacct[currRow].value=onacctamt;
//			            txtindclamt[currRow].select();
//			            txtindclamt[currRow].focus();
//		            }
//		            else
//		            {
//			            txtonacct[currRow].value="";
//			            txtindchqamt[currRow].select();
//			            txtindchqamt[currRow].focus();
//		            }
           
		 }
	}
	function doWork() {
	    if (doc.readyState == 4) {
	            //alert(doc.responseText)
	            val=doc.responseText
				
				//MyDiv.innerHTML = doc.responseText;
				//document.form1.submit1.focus();
	    }
	}


// ]]>

//function calculation1(t_tdsamt,t_mramt,t_tds)
//{
//var TDSAmt =t_tdsamt.value 
//var MRAmt = t_mramt.value
//var TDSRate = t_tds.value
//var tot = (Number(TDSRate)*Number(MRAmt)/100)
//t_tdsamt.value = tot
//}
//" + t_tds.ClientID + "," + t_othrdid.ClientID + "," + t_othramt.ClientID + "," + t_tdsamt.ClientID + "," + t_mramt.ClientID + "," + t_netamt.ClientID + ")");
function calculation1(t_tds,t_othrdid,t_othramt,t_tdsamt,t_mramt,t_netamt,lbltds)
{
debugger
var TDSAmt =parseFloat(t_tdsamt.value)
var MRAmt = parseFloat(t_mramt.value)
var TDSRate = parseFloat(t_tds.value)
var netamt = parseFloat(t_netamt.value)
var othamt = parseFloat(t_othramt.value)
var othdid = parseFloat(t_othrdid.value)


var tot = Math.round((TDSRate)*(MRAmt)/100)
t_tdsamt.value = tot
lbltds.value=tot

//document.getElementById("ctl00$MyCPH1$lbltds").innerText=tot;
var tot2=MRAmt-tot
t_netamt.value=tot2

//var othamt = t_othramt.value
//var tot9 = Number(t_netamt.value) + Number(othamt)
//t_netamt.value = tot9

//alert(t_netamt.value)
//var othdid = t_othrdid.value
//var tot11 = Number(t_netamt.value) - Number(othdid)
//t_netamt.value = tot11
var tot9 = MRAmt + othamt- othdid-tot
t_netamt.value = tot9

//alert(t_netamt.value)
}
function san1(t_netamt,colamt)
{

var net = t_netamt.value
var col = colamt.value

if(net==col)
{
}
else
{
alert("Net Amount is not equal to Collection Amount")
return false;
}


}



</script>
 
                                                           
                                                   
                                                             
                                                            
                                                            
                                 <center>
                                   <br  />
                                   <br  />
                                   
                                    
                                                            <table border="0" cellspacing="1"  class="boxbg" style="width: 90%">
                                                             
                                                                <tr class="bgbluegrey">
                                                                    <td align="center" colspan="4" style="height: 21px">
                                                                    <asp:Label ID="lblerr" runat="server" Font-Bold="true" ForeColor="red" Width="116px"></asp:Label> 
                                                                        <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        MR Summary
                                    </asp:Label>
                                                                    </td>
                                                                    
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        <asp:Label ID="lll" runat="server" CssClass="blackfnt" Text="MR No." Width="145px"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="lmrno" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="Date" Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="ldate" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="MR Type" Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="lmrtype" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="MR Branch " Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="lmrbranch" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Party " Width="145px"></asp:Label></td>
                                                                    <td align="left"  style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="lparty" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                    <td align="left" colspan="2"  style="width: 359px; height: 21px" valign="top">
                                                                    </td>
                                                                   
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="Booking Branch "
                                                                            Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="lbranch" runat="server" CssClass="blackfnt" Text=" " Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="Delivery Branch " Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="ldlybranch" runat="server" CssClass="blackfnt" Text="" Width="145px"></asp:Label></td>
                                                                </tr>
                                                               
                                                            </table>
                                                                 <br  />
                                                                    
                                                                     
                                   <table border="0" cellspacing="1"  class="boxbg" style="width: 90%" cellpadding="1">  
                                   <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                                         
                                             <td style="width: 100px">
                                                 <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Text="CN No" Width="86px"></asp:Label></td>
                                             <td style="width: 100px">
                                                 <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Octroi Receipt Number "
                                                     Width="93px"></asp:Label></td>
                                             <td style="width: 80px">
                                                 <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="Octroi Amount " Width="128px"></asp:Label></td>
                                             <td style="width: 100px">
                                                 <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Text="Service Charge % "
                                                     Width="128px"></asp:Label></td>
                                             <td style="width: 97px">
                                                 <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Text="Amount " Width="145px"></asp:Label></td>
                                             <td style="width: 100px">
                                                 <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Text="Other amount" Width="138px"></asp:Label></td>
                                             <td style="width: 100px">
                                                 <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Text="MR Amount" Width="115px"></asp:Label></td>
                                         </tr>
                                          
                                           <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                  
                                               <td style="width: 100px; height: 21px">
                                                 <asp:Label ID="lcno" runat="server" CssClass="blackfnt" Width="86px"></asp:Label></td>
                                             <td style="width: 100px; height: 21px">
                                                 <asp:Label ID="lrecptno" runat="server" CssClass="blackfnt" Width="93px"></asp:Label></td>
                                             <td style="width: 80px; height: 21px">
                                                 <asp:Label ID="loctamt" runat="server" CssClass="blackfnt" Width="129px"></asp:Label></td>
                                             <td style="width: 100px; height: 21px">
                                                 <asp:Label ID="lservchg" runat="server" CssClass="blackfnt"
                                                     Width="128px"></asp:Label></td>
                                             <td style="width: 97px; height: 21px">
                                                 <asp:Label ID="lamt" runat="server" CssClass="blackfnt" Width="145px"></asp:Label></td>
                                             <td style="width: 100px; height: 21px">
                                                 <asp:Label ID="lothamt" runat="server" CssClass="blackfnt" Width="136px"></asp:Label></td>
                                             <td style="width: 100px; height: 21px">
                                                 <asp:Label ID="lmramt" runat="server" CssClass="blackfnt" Width="116px"></asp:Label></td>
                                         </tr>
                                     </table>
                                   <br  />
                                   
                                     
                                     <table border="0" cellspacing="1"  class="boxbg" style="width: 90%">
                                                             
                                                                <tr class="bgbluegrey">
                                                                    <td align="center" colspan="4" style="height: 21px">
                                                                        <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true">
                             Update Collection Details
                                    </asp:Label>
                                                                    </td>
                                                                    
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        &nbsp;<asp:Label ID="Label19" runat="server" CssClass="blackfnt" Text="MR Amount"
                                                                            Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:TextBox ID="t_mramt" Enabled="false" runat="server"></asp:TextBox></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text=" TDS rate (%)" Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:TextBox ID="t_tds" runat="server"></asp:TextBox></td>
                                                                </tr>
                                                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                                    <td align="left" style="height: 21px; width: 148px;" valign="top">
                                                                        <asp:Label ID="Label14" runat="server" CssClass="blackfnt" Text="Service Tax(+) "
                                                                            Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:TextBox ID="t_servtax" Enabled="false" runat="server"></asp:TextBox></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label21" runat="server" CssClass="blackfnt" Text=" TDS amount (-)" Width="145px"></asp:Label></td>
                                                                    <td align="left" style="width: 359px; height: 21px" valign="top">
                                                                        <asp:TextBox ID="t_tdsamt" runat="server" Enabled="false"></asp:TextBox>
                                                                         
                                                                         <asp:HiddenField ID="lbltds" runat="server" />
                                                                         </td>
                                                                </tr>
                                         <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                             <td align="left" style="width: 148px; height: 21px" valign="top">
                                             </td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                             </td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:Label ID="Label33" runat="server" CssClass="blackfnt" Text="TDS Deducted For"
                                                     Width="145px"></asp:Label></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:DropDownList ID="ddltdsdidfor" runat="server">
                                                   <asp:ListItem Value="C">Corporate</asp:ListItem>
                                                   <asp:ListItem Value="NC">Non Corporate</asp:ListItem>
                                    
                                                 </asp:DropDownList></td>
                                         </tr>
                                         <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                             <td align="left" style="width: 148px; height: 21px" valign="top">
                                                                        <asp:Label ID="Label23" runat="server" CssClass="blackfnt" Text="Total " Width="145px"></asp:Label></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:TextBox ID="t_tot" runat="server"></asp:TextBox></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:Label ID="Label32" runat="server" CssClass="blackfnt" Text="Other Deduction (-)"
                                                     Width="145px"></asp:Label></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:TextBox ID="t_othrdid" runat="server"></asp:TextBox></td>
                                         </tr>
                                         <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                             <td align="left" style="width: 148px; height: 21px" valign="top">
                                                 <asp:Label ID="Label29" runat="server" CssClass="blackfnt" Text=" Net Amount" Width="145px"></asp:Label></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:TextBox ID="t_netamt" Enabled="false" runat="server"></asp:TextBox></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:Label ID="Label31" runat="server" CssClass="blackfnt" Text="Other Amount (+)"
                                                     Width="145px"></asp:Label></td>
                                             <td align="left" style="width: 359px; height: 21px" valign="top">
                                                 <asp:TextBox ID="t_othramt" runat="server"></asp:TextBox></td>
                                         </tr>
                                                               
                                                            </table>
                                                                
                                                                    </center>
    <center>
        &nbsp;</center>
    <center>
        <%--<table border="0" cellspacing="1"  class="boxbg" style="width: 90%">  
                                   <tr class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman">
                                           <td colspan="7">
                    <div align="center">
                        <font class="blackfnt" ><b>Cheque /DD Details</b></font></div>
                     </td>
            </tr>
            <tr class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Cheque
                            <br />
                            Number</font></div>
                </td>
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Cheque Date</font></div>
                </td>
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Cheque Amount </font>
                    </div>
                </td>
                <td style="width: 100px; height: 21px">
                    <font class="blackfnt">On Acct. Balance Rs. </font></td>
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Amount to be
                            <br />
                            accounted</font></div>
                </td>
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Bank name</font></div>
                </td>
                <td style="width: 100px; height: 21px">
                    <div align="center">
                        <font class="blackfnt">Bank Branch</font></div>
                </td>
            </tr>
            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox1" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox4" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox7" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox10" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox13" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox16" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox19" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox2" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox5" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox8" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox11" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox14" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox17" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox20" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox3" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox6" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox9" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox12" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox15" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox18" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox21" runat="server" Height="15px" Width="108px"></asp:TextBox></td>
            </tr>
        </table>--%>
        <br />
        <%--<table border="0" cellspacing="1" cellpadding="4" width="90%" align="center" class="boxbg">
						<tr class="bgbluegrey"> 
          <td colspan=4 align="center"><font class="blackfnt">
           Collection Details
          </td>
          </tr>
						<tr bgcolor="#FFFFFF">
                            <td colspan="2">
                                <font class="blackfnt">Mode Of Transaction  </font>
                            </td>
				        <td >
                            <asp:DropDownList ID="cbopaytype" runat="server">
                            <asp:ListItem Value="Cash">Cash</asp:ListItem>
                            <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                            <asp:ListItem Value="DD">DD</asp:ListItem>
                            </asp:DropDownList></td>
				        <td ></td>
				        </tr>
				        <tr class="bgbluegrey"> 
          <td vAlign="top" colspan="4">
            <div align="center"><font class="blackfnt"><b>Cheque 
              /DD Details</font></div>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td vAlign="top" colspan="4">
            <table width="100%" border="1" cellspacing="2" cellpadding="2" align="center">
              <tr class="bgbluegrey"> 
                <td> 
                  <div align="center"><font class="blackfnt">Cheque 
                    <br>
                    Number</font></div>
                </td>
                <td> 
                  <div align="center"><font class="blackfnt">Cheque 
                    Date</font></div>
                </td>
                <td> 
                  <div align="center"><font class="blackfnt">Cheque 
                    Amount</font></div>
                </td>
                 <td> 
                  <div align="center"><font class="blackfnt" color="red">On Acct. Balance Rs. 
                  </font>
                  </div>
                </td>
                <td> 
                  <div align="center"><font class="blackfnt">Amount 
                    to be <br>
                    accounted</font></div>
                </td>
                <td> 
                  <div align="center"><font class="blackfnt">Bank 
                    name</font></div>
                </td>
                <td> 
                  <div align="center"><font class="blackfnt">Bank 
                    Branch</font></div>
                </td>
                
              </tr>
              <%for(int i=0;i<3;i++)
                {   
                     %>
                <tr  bgcolor="white">
                    <td align="center">
                        <asp:TextBox ID="txtchqno" runat="server" Columns="6" MaxLength="6"></asp:TextBox></td>
                    <td align="center">
                        <asp:TextBox ID="txtchqdt" runat="server" Columns="12" MaxLength="10"></asp:TextBox></td>
                    <td align="center">
                        <asp:TextBox ID="txtindchqamt" runat="server" Columns="10" MaxLength="10"></asp:TextBox>
                        <asp:HiddenField ID="txtonacctamt" runat="server" />
                        </td>
                    <td align="center">
                        <asp:TextBox ID="txtonacct" runat="server" Columns="10" MaxLength="10" ReadOnly="true"></asp:TextBox></td>
                    <td align="center">
                        <asp:TextBox ID="txtindclamt" runat="server" Columns="10" MaxLength="10"></asp:TextBox></td>
                    <td align="center">
                        <asp:TextBox ID="txtbanknm" runat="server" Columns="20" MaxLength="50"></asp:TextBox></td>
                    <td align="center">
                        <asp:TextBox ID="txtbankbrn" runat="server" Columns="20" MaxLength="50"></asp:TextBox></td>
                </tr>
                <%} %>
                <tr bgcolor="white">
                    <td>
                       <font class="blackfnt"> Collected Amount</font></td>
                    <td>
                        <asp:TextBox ID="colamt" runat="server" Columns="12" MaxLength="10"></asp:TextBox></td>
                    <td>
                       <font class="blackfnt">TDS type</font></td>
                    <td>
                        <asp:DropDownList ID="tdsacccode" runat="server">
                        <asp:ListItem Value="">Select </asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
											 
						 </table>
              Remarks :
              <asp:TextBox ID="TextBox1" runat="server" Columns="12" MaxLength="10" Width="179px" Height="68px" TextMode="MultiLine"></asp:TextBox></td>
						 </tr>
						 </table>--%>
        
<uc1:WebUserControl
            ID="chqdetail11" runat="server" />
                     <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Update MR" Width="116px" />
        <asp:Button ID="Button1" runat="server" OnClick="btnsubmit_Click" Text="Close MR" Width="117px" />
    </center>
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                    &nbsp;<%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%> 
                                                                
                                                                
                                            
                                                               <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                
                                                               
                                                                
                                                            
                                                            
                                                       
                                      
    
    

</asp:Content>
