
<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"     AutoEventWireup="true" CodeFile="UpdateMR_step3.aspx.cs" Inherits="GUI_Finance_MoneyRecipt_UpdateMR_step3"   %>
<%@ Register  TagPrefix="collectiondetail" TagName="chqdetail" 	Src="~/Usercontrol/WebUserControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
--%>    <script language="javascript" type="text/javascript">
   var  total_row="<%=intTotalRecords%>"
   var totaltds=0 
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	//**********************For date range Validation*****************************
	    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
		var Fromdate="<%=fromdt%>"
		var Todate="<%=Todt%>"
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
	//***************************************************************
 function fcal_MRamt(tdsrate,tdsamt,other_ded,Other_amt,totalamt,totMramt,Colamt,servchrg)
{

	if (isNaN(tdsrate.value))
	{
		alert("'TDS Rate' should be numeric.")
		tdsrate.focus();
		return false;
	} 
	if (parseFloat(tdsrate.value)<0)
	{
		alert("'TDS Rate' should not be negative.")
		tdsrate.focus();
		return false;
	} 
	if (parseFloat(tdsrate.value)>100)
	{
		alert("'TDS Rate' should not greater than 100%.")
		tdsrate.focus();
		return false;
	} 
	tdsamt.value=Math.round(parseFloat(servchrg.value) * (parseFloat(tdsrate.value)/100))
   // col_frt=parseFloat(document.frm.col_frt.value)
	//col_stax=parseFloat(document.frm.col_stax.value)
	//miscchrg=parseFloat(document.frm.miscchrg.value)
	subtotal=totMramt.value
	//document.frm.subtotal.value=roundit(subtotal)
	var_tdsamt=parseFloat(tdsamt.value)
	var_Other_amt=parseFloat(Other_amt.value)
	var_other_ded=parseFloat(other_ded.value)
	netamt=Math.round(subtotal-var_tdsamt-var_other_ded+var_Other_amt)
	totalamt.value=netamt
	
	//alert(Colamt)
	//alert(total_row)
	var var_totalamt=0
	for (i=0;i<total_row;i++)
		{
		     j = i + 2;
		      if(i < 10)
                {
                    From_name = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + j + "$"
                }
                else
                {
                    From_name = "ctl00$MyCPH1$GV_Booking$ctl" + j + "$"
                }
          // alert(document.getElementById(From_name+"totalamt"))     
          var_totalamt=parseFloat(var_totalamt)+parseFloat(document.getElementById(From_name+"totalamt").value)
		}
	     k=j+1
	            if(i < 10)
                {
                    From_name1 = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + k + "$"
                }
                else
                {
                    From_name1 = "ctl00$MyCPH1$GV_Booking$ctl" + k + "$"
                }
	  
	 // alert(From_name1)
	document.getElementById(From_name1+"TotalNetamt").value=var_totalamt
}

function ClearDockets(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt,txtbanknm,txtbankbrn,tottds,tdsacccode,netamt,cbsdt)
{
						
						    Frmnae="ctl00$MyCPH1$"
                           var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                        //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
                            // return false;
				            if(document.getElementById(Frmnae+"TxtCBSDT").value=="")
				            {
				              alert("Please enter the Financial Close Date")
				              document.getElementById(Frmnae+"TxtCBSDT").focus();
				              return false;
				            }
						  if (ValidateForm(document.getElementById(Frmnae+"TxtCBSDT"))==false)
				            {
					            document.getElementById(Frmnae+"TxtCBSDT").focus();
					            return  false ;
				            }
				        	  var dt =document.getElementById(Frmnae+"TxtCBSDT").value
				
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
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(Frmnae+"TxtCBSDT").focus();
						return false;
				}
				
				var Fromdate_dd=Fromdate.substring(0,2)
				var Fromdate_mm=Fromdate.substring(3,5)
				var Fromdate_yy=Fromdate.substring(6,10)
				Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
				
				var Todate_dd=Todate.substring(0,2)
				var Todate_mm=Todate.substring(3,5)
				var Todate_yy=Todate.substring(6,10)
				Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
                //alert(dt)
               // alert(Todate1)
               // alert(Fromdate1)
                if (dt<Fromdate1)//Fromdate1
				                {
						                alert( "Financial Close Date Should Be Between  Greater than  "+ Fromdate +" !!!")
						                document.getElementById(Frmnae+"TxtCBSDT").focus();
						                return false;
				                }
                		
				                if (dt>server_dt)
				                {
						                alert( "Financial Close Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"TxtCBSDT").focus();
						                return false;
				                }
		
						    var var_totalamt1=0
						   for (i=0;i<total_row;i++)
		                    {
		                             j = i + 2;
		                              if(i < 10)
                                        {
                                            From_name = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + j + "$"
                                        }
                                        else
                                        {
                                            From_name = "ctl00$MyCPH1$GV_Booking$ctl" + j + "$"
                                        }
                                  // alert(document.getElementById(From_name+"totalamt"))     
                                  var_totalamt1=parseFloat(var_totalamt1)+parseFloat(document.getElementById(From_name+"totalamt").value)
		                   }
	                             k=j+1
	                                    if(i < 10)
                                        {
                                            From_name1 = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + k + "$"
                                        }
                                        else
                                        {
                                            From_name1 = "ctl00$MyCPH1$GV_Booking$ctl" + k + "$"
                                        }
                        	  
	                         // alert(From_name1)
	                        document.getElementById(From_name1+"TotalNetamt").value=var_totalamt1
							
							paytype=cbopaytype.options[cbopaytype.selectedIndex].value;
							//alert(paytype)
							totclamt=0;
							totchqamt=0;
							//alert(paytype)
								
							if ((paytype=="Cheque") || (paytype=="DD"))
							{
									
								for(i=0;i<3;i++)
								{
																chqno=txtchqno[i].value
																	//alert(chqno)
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
																			if(parseFloat(clamt)!=parseFloat(chqamt))
																			{
																			alert("Amount Collected Against MR should be equal to Cheque Amount")
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
																					alert("Amount Collected Against MR should be less than or equal to Cheque Amount")
																					txtindclamt[i].focus();
																 					return false;
																			}
																			if(txtbanknm[i].value=="")
																			{
																				alert("Please enter Bank Name")
																				txtbanknm[i].focus()
																				return false;
																			}
																			if(txtbankbrn[i].value=="")
																			{
																				alert("Please enter Bank Branch")
																				txtbankbrn[i].focus()
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
								
					}
					
		
	transtype=cbopaytype.value
	if(transtype=="")
	{
		alert("Please Select Mode of transaction !!! ")
		cbopaytype.focus();
		return false;
	}
	
//	if(tdsacccode.value==0)
//	{
//				alert("Please select TDS Type!!!")
//				tdsacccode.focus();
//				return false;
//	}
	varcolamt=parseFloat(colamt.value)
    
	varnetamt=parseFloat(document.getElementById(From_name1+"TotalNetamt").value)
	if(varcolamt != varnetamt)
	{
		alert("collected amount should be equal to Net Amount!!!")
		colamt.focus();
		return false;
	}
	
	
//	click_count=parseFloat(click_count.value)
// 	if(click_count > 0)
//	{
//		alert("Sorry... You cannot click twice !!!")
//		return ;
//	}  
//	else
//	{
//		click_count=click_count+1
//		click_count.value=click_count
//		method="post";
//		action="BillMr_submit.asp";
//		submit(); 
//		//return true;
//	}
	//return;*/
                                    for (i=0;i<total_row;i++)
		                            {
		                                     j = i + 2;
		                                      if(i < 10)
                                                {
                                                    From_name = "ctl00$MyCPH1$GV_Booking$ctl" + "0" + j + "$"
                                                }
                                                else
                                                {
                                                    From_name = "ctl00$MyCPH1$GV_Booking$ctl" + j + "$"
                                                }
                                           
                                         document.getElementById(From_name+"totalamt").disabled=false
                                         document.getElementById(From_name+"txttdsamt").disabled=false
                                         
		                           }
                            	for(i=0;i<3;i++)
								{
											chqno=txtchqno[i].value
											txtchqno[i].disabled=false
											txtchqdt[i].disabled=false
											txtindchqamt[i].disabled=false
											txtonacctamt[i].disabled=false
											txtonacct[i].disabled=false
											txtindclamt[i].disabled=false
											txtbanknm[i].disabled=false
											txtbankbrn[i].disabled=false
								}
//	alert("hi") 
//	return false;
	return true;
}
function ChequeText_validation(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt,txtbanknm,txtbankbrn)
{
//    CHQ_form_name="ctl00$MyCPH1$chqdetail11$"
//    
//    // alert(document.getElementById(CHQ_form_name+"cbopaytype").value)
//     chqno=document.getElementById(CHQ_form_name+"txtchqno")
alert(cbopaytype.value)
   if(cbopaytype.value=="Cash")
   {
                                for(i=0;i<3;i++)
								{
											chqno=txtchqno[i].value
											txtchqno[i].readOnly="true"
											txtchqdt[i].readOnly="true"
											txtindchqamt[i].readOnly="true"
											txtonacctamt[i].readOnly="true"
											txtonacct[i].readOnly="true"
											txtindclamt[i].readOnly="true"
											txtbanknm[i].readOnly="true"
											txtbankbrn[i].readOnly="true"
										
							    }
    }
    else
    {
                                 for(i=0;i<3;i++)
								{
											chqno=txtchqno[i].value
											txtchqno[i].readOnly="false"
											txtchqdt[i].readOnly="false"
											txtindchqamt[i].readOnly="false"
											txtonacctamt[i].readOnly="false"
											txtonacct[i].readOnly="false"
											txtindclamt[i].readOnly="false"
											txtbanknm[i].readOnly="false"
											txtbankbrn[i].readOnly="false"
								}
    
    }
}
function ValidateForm(obj){

  if (obj.value!="")
  {
    
	if (isDate(obj.value)==false){
	
		obj.focus()
		return false
	}
    return true
  }  
 }
 var dtCh= "/";
 var minYear=1900;
var maxYear=2100;
 function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
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
    </script>
    
<%--</head>
<body>
    <form id="frm" runat="server">--%>
    <div>
     <table width="10in" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
 
   <a href="#"><font class="blklnkund"><strong>Finance</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		   Update MR  
		   
		  </strong> </font>
   </td></tr>
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
    <tr>
    <td>
    <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:10in"  align="left">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> You Selected </b></font></td>
            
       </tr>
        
        
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">Customer Code and Name</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblparty" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 282px"  align="center"><font class="blackfnt">MRS 
         Date Range </font></td>
            <td style="width: 339px">
                <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
           
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
        <td style="width: 282px"  align="center"><font class="blackfnt">Mrs Type</font>
            </td>
            <td style="width: 339px">
                <asp:Label ID="lblpaybas" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        
        
       </table>
       </td>
        </tr>
         <tr><td> <img src="../../images/clear.gif" width="15" height="10"></td></tr>
           <tr>
    <td>
    <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:10in"  align="left">
      
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">Manual Mrs NO.</font></td>
            <td style="width: 339px"><asp:TextBox ID="TxtmanualMR" runat="server"  Columns="12"></asp:TextBox></td>
             <td style="width: 282px"  align="center"><font class="blackfnt">Financial Close Date</font></td>
            <td style="width: 339px"><asp:TextBox ID="TxtCBSDT" runat="server"  Columns="10" MaxLength="10"></asp:TextBox>  <a href="#"  onclick="cal.select(ctl00$MyCPH1$TxtCBSDT,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="anchor1" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                                  </a></td>
                
       </tr>
        
        
       </table>
       </td>
        </tr>
      <tr><td> <img src="../../images/clear.gif" width="15" height="10"></td></tr>
      <tr><td>
          <asp:GridView ID="GV_Booking" runat="server" align="left" BorderWidth="1"  Width="10in" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"  
                                                             AllowPaging="true" PageSize="25"
                                    ShowFooter="True"
                            
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            AutoGenerateColumns="false"
                                                               PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                               
                                                               
                                                                <Columns>
                                                                 <asp:TemplateField HeaderText="Sr No."  ItemStyle-CssClass="blackfnt" HeaderStyle-Wrap="false" HeaderStyle-CssClass="blackfnt">
                                                                        <ItemTemplate>
                                                                            <center>
                                                                            <%# Container.DataItemIndex+1 %>
                                                                          <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                      <FooterTemplate>
                                                                     
                                                                      </FooterTemplate>
                                                             </asp:TemplateField>
                                                               <%--   <asp:BoundField  DataField="MRSNO"   ItemStyle-Wrap="False"  HeaderText="MR. No"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                            <%-- <asp:BoundField  DataField="DOckno" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="Docket No."   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             --%>
                                                                                                    <%--<asp:TemplateField HeaderText="MRS NO. " HeaderStyle-Font-Bold="true">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"update_Manual_MR_3.aspx?mrno=" +DataBinder.Eval(Container.DataItem, "mrsno")%>' Text= '<%#DataBinder.Eval(Container.DataItem, "mrsno")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>   --%> 
                                                                   <asp:BoundField  DataField="mrsno" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="MRs NO"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                  <asp:BoundField  DataField="mrsdate" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="MRs Date"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                    <%--<asp:BoundField  DataField="mrstyp" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="MRs Type"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                  
                                                                  <asp:BoundField  DataField="ptname"  HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="false"  HeaderText="MR Customer "   > 
                                                                            <HeaderStyle HorizontalAlign="Center"     CssClass="blackfnt" />
                                                                           <ItemStyle      HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                    <asp:TemplateField>
                                                                                  <HeaderTemplate>
                                                                                  <asp:Label ID="Freight_Amt"  Font-Bold="true" CssClass="blackfnt"  Text="Freight Amt." runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                    <asp:Label ID="Freight_Amt1" CssClass="blackfnt" Text=<%# DataBinder.Eval(Container.DataItem,"COL_FRT") %> runat="server"></asp:Label>
                                                                                                  <asp:HiddenField ID="Frtamt" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"COL_FRT") %>/>
                                                                                                  <asp:HiddenField ID="Hidden_MRSNO" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"mrsno") %>/>
                                                                                                  <asp:HiddenField ID="Hidden_ptname" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"ptname") %>/>
                                                                                                  <asp:HiddenField ID="Hidden_ptcd" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"ptcd") %>/>
                                                                                                  <asp:HiddenField ID="Hidden_svctax_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"svctax_rate") %>/>
                                                                                                  <asp:HiddenField ID="Hidden_cess_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"cess_rate") %>/>
                                                                                                   <asp:HiddenField ID="Hidden_H_cess_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"H_cess_rate") %>/>
                                                                                                    <asp:HiddenField ID="DOckno" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"DOckno") %>/>
                                                                                
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                       <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="lblsvctax"   Font-Bold="true" CssClass="blackfnt" Text="Service Charge" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                     <asp:Label ID="lblsvctax1" CssClass="blackfnt" Text=<%# DataBinder.Eval(Container.DataItem,"servchrg") %> runat="server"></asp:Label>
                                                                                                    <asp:HiddenField ID="svctax_amt" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"svctax") %>/>
                                                                                                    <asp:HiddenField ID="servchrg" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"servchrg") %>/>
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                  <asp:BoundField  DataField="MRSamt"    HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="False"  HeaderText="MR Amount "   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField> 
                                                                       <%--<asp:BoundField  DataField="DED_TDS" HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="False"  HeaderText="TDS Amount"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField> 
                                                                  <asp:BoundField  DataField="DED_OTH" HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="False"  HeaderText="Other Deduction"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField> --%>
                                                                          <%--       <asp:BoundField  DataField="netamt" HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="False"  HeaderText="Net Amount "   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                 <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="TDS"   Font-Bold="true" CssClass="blackfnt" Text="TDS Rate (%)" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                  <asp:TextBox  TabIndex="1"  ID ="txttds_rate" runat="server" MaxLength="10" Columns="8"  Text="0"></asp:TextBox>
                                                                                                  <asp:HiddenField ID="totMramt" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"netamt") %>/>
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                     <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="tdsamt"  Font-Bold="true"  CssClass="blackfnt" Text="TDS amount (-)" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                  <asp:TextBox  ID ="txttdsamt" MaxLength="10" Enabled="False"  Columns="8"  runat="server" Text="0"></asp:TextBox>
                                                                                       
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                     <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="DED_OTH"  Font-Bold="true"  CssClass="blackfnt" Text="Other Deduction (-)" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                  <asp:TextBox  ID ="txtDED_OTH" TabIndex="1"   MaxLength="10" Columns="8"  runat="server" Text="0"></asp:TextBox>
                                                                                       
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                     <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="lblotchg"  Font-Bold="true"  CssClass="blackfnt" Text="Other Charges (+)" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                  <asp:TextBox  ID ="txtotchg"  TabIndex="1"   MaxLength="10" Columns="8" runat="server" Text="0"></asp:TextBox>
                                                                                       
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                     </asp:TemplateField>
                                                                     <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="lblnetamt"  Font-Bold="true"  CssClass="blackfnt" Text="Net Amount" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                                  <asp:TextBox  ID ="totalamt" MaxLength="10" Columns="8"  Enabled="False"  Text=<%# DataBinder.Eval(Container.DataItem,"netamt") %>  runat="server"></asp:TextBox>
                                                                                       
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                                    
                                                                                     <FooterTemplate>
                                                                                     <asp:TextBox ID="TotalNetamt"  Font-Bold="true"  runat="server" Enabled="false"    Text="0.00" Columns="8"></asp:TextBox>						            
                                                                              
                                                                                     </FooterTemplate>
                                                                     </asp:TemplateField>

                                                                  
                                                                           
                                        <%--<a href="Login_2_2.aspx?strDateRange=" +'<%#Request.QueryString["strDateRange"]%>'>                                   
                                        
                                         <asp:HyperLink  Font-Underline="True"  ForeColor="#000099"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>' Text= '<%#DataBinder.Eval(Container.DataItem, "LEFT_TOTDKTS")%>' ID="Hyperlink2"/>



   <%#DataBinder.Eval(Container.DataItem, "totdkt")%>                                 
                                           <font cssclass="Blackfnt">
                                        </a>--%>
                                        
                                                         
                                                                                    
                                                                                  <%--  <asp:HyperLinkField   DataNavigateUrlFields="mrsno" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString ="DetailFlow.aspx?loc={0}&reppara=1"  DataTextField="mrsno" />
                                                                                  --%>      
                                                                                    
                                 
                                                                       
                                                                                                                            
                                                                                         
                                                                 
                                                                 </Columns>
                                                                 
                                                                
                                              

                                                                </asp:GridView>
                                                                </td></tr> 
                                                                  <tr><td> <img src="../../images/clear.gif" width="15" height="10"></td></tr>
        <tr>
        <td>
       <p>
          
       <collectiondetail:chqdetail runat="server" ID="chqdetail11" />
       </p>
       <p></p>
        
<p></p>
<center><asp:Button ID="submit" runat="server" Text="submit"  OnClick="submit_Click1"/></center>
     </td>
        </tr>
       </table>
       </div>
       <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
      
        <script language="javascript" type="text/javascript">
//        window.onload=ChequeText_validation
        </script>
       
       </asp:Content>
    <%--</form>
</body>
</html>--%>
