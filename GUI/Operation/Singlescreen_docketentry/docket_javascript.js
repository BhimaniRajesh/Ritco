// JScript File
var client_name="Webxpress"
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
function fOnChangepaybas_redonly_party(paybas,consignor_Bill)
{
//    alert("hi")
    
    if (paybas.value=="P01" ||paybas.value=="P03" )
		{
					consignor_Bill.value=""
					consignor_Bill.readOnly=true
					//custpup12.disabled=true
					
					
		}
		else
		{
			consignor_Bill.readOnly=false
			//custpup12.disabled=false
		}
}
function Partydetail(str1)
{
  winNew=window.open(str1,null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15")
}
function Clear_Csgn(paybas,consignor_name,consignor_add,consignor_pin,consignor_telno,consignor_city,consignor_email)
{
						
	if(paybas.value=="P02")
	{
											consignor_add.value=""
											consignor_name.value=""
											consignor_pin.value=""
											consignor_telno.value=""
											consignor_city.value=""
											consignor_email.value=""
											
	}
	else
	{
	consignor_name_B.value=""
	}
}
 function num_email_chk(consignor_email,consignee_email,consignor_pin,consignee_pin)
 {
    if (consignor_email.value!="")
    {
        
        if(consignor_email.value.indexOf("@")==-1 || consignor_email.value.indexOf(".")==-1)
	          {
	           alert("Invalid  Consignor  Email Address")
	           consignor_email.focus();
			   return false;
	          }
    }
    
    if (consignee_email.value!="")
    {
            if(consignee_email.value.indexOf("@")==-1 || consignee_email.value.indexOf(".")==-1)
	          {
	           alert("Invalid Consignee  Email Address")
	           consignee_email.focus();
			   return false;
	          }
    }
    if (consignor_pin.value!="")
    {
          if (isNaN(consignor_pin.value))
            {
              alert("Please enter the Consignor Pincode' in numeric")
              consignor_pin.focus();
              return false;
            }
    
             if(consignor_pin.value.length!=6)
             {
              alert("Consignor Pincode' should be 6-digit number.")
              consignor_pin.focus();
              return false;
             }
    }
    if (consignee_pin.value!="")
    {
          if (isNaN(consignee_pin.value))
            {
              alert("Please enter the Consignee Pincode' in numeric")
              consignee_pin.focus();
              return false;
            }
    
             if(consignee_pin.value.length!=6)
             {
              alert("Consignee Pincode' should be 6-digit number.")
              consignee_pin.focus();
              return false;
             }
    }
}
var mflg=0;
function modvatblur(modvat,totmodvat)
{
    //alert(modvat.checked)
	if (modvat.checked==false)
	{
								
								totmodvat.value=""
								mflg=0;
								
								totmodvat.disabled=true
						      
								//modu.value="No"
							
	}
	else
	{
			mflg=1
			//modu.value="Yes"
			totmodvat.disabled=false
			
	}  
 }
 function disable_enable(permit_yn,permitno)
	{
		//	alert(permit_yn.value)
		if(permit_yn.checked!=true)
		{
					permitno.focus();
		}
		
		
	}
	function fSpecialChar(invno)
    {
    
	var uid=invno.value 
	var str1="'!@#$%^&*()+~`.[]{}: "
	flag="0"
	for(k=0;k<uid.length;k++)
		 {   for(j=0;j<str1.length;j++)
				{
					if(uid.charAt(k)==str1.charAt(j))
						{
							flag="1";
							break;
						}
					if(flag=="1")
					   {
						   break;
					   }
				}
		}
		if(flag=="1")
			{
				alert("Please Enter Character or Numeric Values only\n You cannot enter special characters .");
				invno.focus();
				return false;
			}
						
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
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.focus();
		return false;
	}
	obj.value=roundit(temp) 
	return true;					   
}
	
function Nagative_Chk_woDecimal(obj)
{
	var temp
	temp=obj.value 
						
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.focus();
		return false;
	}
	if(temp.indexOf(".")>0 )
	{
		alert("Value should not contain decimal point")
		obj.focus();
		return false;
	} 
	obj.value=Math.round(temp) 	
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

function TotalCalc()
{
 var cwt_db="0"
     Form_name="ctl00$MyCPH1$"
     var totpkg=""
   var totactwt=""
   var totchrgwt=""
   var totcftval=""
   var totdecl=""
   var temp1
    maxrows=parseInt(document.getElementById(Form_name+"noofrows1").value)
    
   
    if (maxrows>=1)
    {
		for(i=0;i<maxrows;i++)
	    {   
	            j = i + 2;
	           
	            if(i < 10)
                {
                    frm=Form_name+"invdata$ctl"+"0"+j+"$"
                    
                }
                else
                {
                    frm=Form_name+"invdata$ctl"+j+"$"
                   
                }
                
	          
	                if (document.getElementById(frm+"declvalue").value!="0")
				     {
				      
				        
						if (isNaN(document.getElementById(frm+"declvalue").value))
						 {
						   alert("Please enter the Declared value in numeric !!!")
						   document.getElementById(frm+"declvalue").focus();
						   return false;
						 }
				      else
						{
						  if(totdecl=="")
						  {
						    totdecl = parseInt(document.getElementById(frm+"declvalue").value)
						  }
						 else
						  {
						    totdecl = parseInt(totdecl)+ parseInt(document.getElementById(frm+"declvalue").value)
						  }   
						} 
				   }
				else if (document.getElementById(frm+"declvalue").value =="")
				  {
						  if(totdecl=="")
						  {
						    totdecl = 0
						  }
						 else
						  {
						    totdecl = parseInt(totdecl)+ 0
						  }   
				  }			
            //alert(totdecl)


				//Total of Packages
				
				if (document.getElementById(frm+"pkgno").value !="0")
				   {
						if (isNaN(document.getElementById(frm+"pkgno").value))
						 {
						   alert("Please enter the No. of packages in numeric !!!")
						   document.getElementById(frm+"pkgno").focus();
						   return false;
						 }
						else if (parseFloat(document.getElementById(frm+"pkgno").value)<=0)
						 {
						   alert("No. of packages should be greater than zero !!!")
						   document.getElementById(frm+"pkgno").focus();
						   return false;
						 }
				      
				      else
						{
						  if(totpkg=="")
						  {
						    totpkg = parseInt(document.getElementById(frm+"pkgno").value)
						  }
						 else
						  {
						    totpkg = parseInt(totpkg)+ parseInt(document.getElementById(frm+"pkgno").value)
						  }   
						} 
				   }
				else if (document.getElementById(frm+"pkgno").value =="")
				  {
						  if(totpkg=="")
						  {
						    totpkg = 0
						  }
						 else
						  {
						    totpkg = parseInt(totpkg)+ 0
						  }   
				  }
				  	
//		  if(CFT_YN=='Y')
//		  {

//				//alert("<%=CFT_YN%>")
//				if (cftratio.value=="")		
//				{
//					   alert("Please enter the value of Cubic ft. Conversion ratio")
//					   cftratio.focus();
//					   return false;
//				}

//				if (cftratio.value!="")		
//				{
//					 if(isNaN(cftratio.value))
//					  {
//					   alert("Please enter the value of Cubic ft. Conversion ratio in numeric")
//					   cftratio.focus();
//					   return false;
//					  }
//				}
//				
//				if(parseFloat(cftratio.value)<8||(cftratio.value)>20)
//				{	   
//						alert("Cubic ft. Conversion ratio should be between 8 to 20 ")
//					   cftratio.focus();
//					   return false;
//				}
//				
//				if (length[i].value!="")		
//				{
//					 if(isNaN(length[i].value))
//					  {
//					   alert("Please enter the value of CFT-Length in numeric")
//					   length[i].focus();
//					   return false;
//					  }
//				}

//				if (breadth[i].value!="")		
//				{
//					 if(isNaN(breadth[i].value))
//					  {
//					   alert("Please enter the value of CFT-Breadth in numeric")
//					   breadth[i].focus();
//					   return false;
//					  }
//				}

//				if (height[i].value!="")		
//				{
//					 if(isNaN(height[i].value))
//					  {
//					   alert("Please enter the value of CFT-Height in numeric")
//					   height[i].focus();
//					   return false;
//					  }
//				}

//				if (length[i].value!="" && breadth[i].value!="" && height[i].value!="" )
//					{
//						cftval[i].value = round((parseInt(length[i].value) *  parseInt(breadth[i].value) *  parseInt(height[i].value) * parseFloat(pkgno[i].value))/1728)
//						if (parseInt(cftval[i].value)<=0)
//						 {
//						   cftval[i].value=1
//						 }
//						 //alert("CFT. TOTAL")
//						 //cwt=totchrgwt
//						  if(totchrgwt=="")
//						  {
//						    totchrgwt = (parseInt(cftratio.value)* parseInt(cftval[i].value))
//						    totcftval=parseInt(cftval[i].value)
//						  }
//						 else
//						  {
//						    totchrgwt = parseInt(totchrgwt)+ (parseInt(cftratio.value)* parseInt(cftval[i].value))
//						    totcftval=parseInt(totcftval)+ parseInt(cftval[i].value)
//						  }
//						  
//					 }
//					 
//					 total_cft.value  =totcftval
//	   	
//				}
//	 

							




					// Total of Actual weight
					 if (document.getElementById(frm+"actwt").value !="0")
					    {
							if (isNaN(document.getElementById(frm+"actwt").value))
							 {
							   alert("Please enter the Actual weight in numeric !!!")
							   document.getElementById(frm+"actwt").focus();
							   return false;
							 }
							else if (parseFloat(document.getElementById(frm+"actwt").value)<=0)
							 {
							   alert("Actual weight should be greater than zero !!!")
							   document.getElementById(frm+"actwt").focus();
							   return false;
							 }

					       else
							{
							  if(totactwt=="")
							  {
							    totactwt = parseInt(document.getElementById(frm+"actwt").value)
							  }
							 else
							  {
							    totactwt = parseInt(totactwt)+ parseInt(document.getElementById(frm+"actwt").value)
							  }   
							} 
					    }
					 else if (document.getElementById(frm+"actwt").value =="")
					   {
							  if(totactwt=="")
							  {
							    totactwt = 0
							  }
							 else
							  {
							    totactwt = parseInt(totactwt)+ 0
							  }   
					   }			
			 }	
		 }	 
	    
	     document.getElementById(Form_name+"decl").value=totdecl
	      document.getElementById(Form_name+"pkg").value=totpkg
	 	 document.getElementById(Form_name+"awt").value=totactwt
	 	 
	 	 if(totchrgwt!="")
	 	 {
	 		if(parseFloat(totchrgwt)>parseFloat(cwt_db))	
	 		{
				if (parseFloat(min_cwt)>parseFloat(totchrgwt))
				{
						document.getElementById(Form_name+"cwt").value=min_cwt
				}
				else
				{
	 	     		document.getElementById(Form_name+"cwt").value=totchrgwt
				}
	 	    }
	 	   else
	 	   {
		   	if (parseFloat(min_cwt)>parseFloat(cwt_db))
				{
						document.getElementById(Form_name+"cwt").value=min_cwt
				}
				else
				{
	 	     		document.getElementById(Form_name+"cwt").value=cwt_db
				}
	 	    // cwt.value=cwt_db
	 	   }  
	 	 }
	 	else
	 	{
	 	  if (parseFloat(totactwt)> parseFloat(cwt_db))
	 	  {
	 	  document.getElementById(Form_name+"cwt").value=totactwt
	 	  }
	 	  else
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=cwt_db
	 	  }
	 	}
	 
	 	//alert("ChargeWt:"+totchrgwt)
		temp1 =document.getElementById(Form_name+"cwt").value%5
		//alert(temp1)
		if(temp1 != 0)
		{
		  document.getElementById(Form_name+"cwt").value = Number(document.getElementById(Form_name+"cwt").value)// + (5 - temp1)
		}

	 	if(parseInt(totchrgwt)< (totactwt) ) 
	 	{
	 	  if (parseFloat(totactwt)> parseFloat(cwt_db))
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=totactwt
	 	  }
	 	 else
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=cwt_db
	 	  }   
	 	}



	if(document.getElementById(Form_name+"DocketMode").value=="F" || document.getElementById(Form_name+"DocketMode").value=="E")
	 {
		//calc()
		//alert("***")
		FreightCalc(document.getElementById(Form_name+"ratetype").value,document.getElementById(Form_name+"rate").value)
	 }	
		
}


 function calc()
	 {
						    Form_name="ctl00$MyCPH1$"
							paybas=document.getElementById(Form_name+"paybas").value
							
							//if((paybas!="P02")||((paybas=="P02")&&("<%=mode%>"=="2")))
							//{
								//FreightCalc(ratetype.value,frieght.value)
								
								if (document.getElementById(Form_name+"awt").value=="")
								{
									document.getElementById(Form_name+"awt").value="0.0";
								}
								
								if (isNaN(document.getElementById(Form_name+"awt").value))
		   					    {
									document.getElementById(Form_name+"awt").value="0";
									document.getElementById(Form_name+"awt").focus();
									return false;
								}
								if (isNaN(document.getElementById(Form_name+"cwt").value))
								 {
								   document.getElementById(Form_name+"cwt").value="0";
								  document.getElementById(Form_name+"cwt").focus();
								   return false;
								 }
								 
								 if((document.getElementById(Form_name+"paybas").value=="P02"))
								 {
//										var arg_cwt= document.getElementById(Form_name+"cwt").value
//										var min_chrgwt= document.getElementById(Form_name+"min_chrgwt").value
//										if (parseFloat(min_chrgwt)>parseFloat(arg_cwt))
//										{
//											alert("Minimum Charge wt. is " + min_chrgwt + " for this party ")
//											document.getElementById(Form_name+"frieght").value=roundit(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(min_chrgwt),2) 
//											document.getElementById(Form_name+"cwt").value=min_chrgwt
//											 quck_validation="N"
//										}
//										var arg_pkgno=document.getElementById(Form_name+"pkg").value
//										var min_pkgsno=document.getElementById(Form_name+"min_pkgsno").value
//										if (parseFloat(min_pkgsno)>parseFloat(arg_pkgno))
//										{
//											alert("Minimum Packages is " + min_pkgsno + " for this party ")
//											document.getElementById(Form_name+"frieght").value=roundit(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(min_pkgsno),2) 
//											document.getElementById(Form_name+"pkg").value=min_pkgsno
//											 quck_validation="N"
//										}
//										  frieght = parseFloat(document.getElementById(Form_name+"frieght").value)
//										 min_frt = parseFloat(document.getElementById(Form_name+"min_frt").value)
//										if (parseFloat(min_frt)>parseFloat(frieght))
//										{
//											alert("Minimum Feright is " + min_frt + " for this party ")
//											document.getElementById(Form_name+"frieght").value=min_frt
//											 quck_validation="N"
//										}
								}

							//	alert(rate.value)
								
								if (document.getElementById(Form_name+"rate").value =="")
								 {
								  //rate.value=0
								//   alert("Please enter the 'Booking Rate Value'")
								   //rate.focus();
								   document.getElementById(Form_name+"rate").value="0.00";
								 //  return false;
								 }
						 
								if (isNaN(document.getElementById(Form_name+"rate").value))
								 {
								   alert("Please enter the 'Booking Rate Value' in Numeric")
								   document.getElementById(Form_name+"rate").value="0.00";
								   return false;
								 }

								if (document.getElementById(Form_name+"decl").value=="")
								{
								   alert("Please enter the 'Declared value'")
								   document.getElementById(Form_name+"decl").focus();
								   return false;
								}

								if (isNaN(document.getElementById(Form_name+"decl").value))
								{
								   alert("Please enter the 'Declared value' in numeric")
								   document.getElementById(Form_name+"decl").focus();
								   return false;
								}

							
								if (document.getElementById(Form_name+"frieght").value=="")
								{
								   	document.getElementById(Form_name+"frieght").value="0"
								}
								
								if (isNaN(document.getElementById(Form_name+"frieght").value))
								{
								   document.getElementById(Form_name+"frieght").value="0.00";
								   return false;
								}
								//fov_calc();
								
								
						        frieght = parseFloat(document.getElementById(Form_name+"frieght").value)
						       // total1= parseFloat(document.getElementById(Form_name+"total1").value)
						      
						     
								surchrg = parseFloat(document.getElementById("COLL_SURCHRG").value)
								 
								riskchrg = parseFloat(document.getElementById("RiskCharge").value)
								fovchrg = parseFloat(document.getElementById("FOV_charged").value)
								hamalichrg = parseFloat(document.getElementById("COLL_LOADCHRG").value)
								dcddchrg = parseFloat(document.getElementById("COLL_DCDDCHRG").value)
								stsrechrg = parseFloat(document.getElementById("COLL_STSRECHRG").value)
								statchrg = parseFloat(document.getElementById("StatisticalCharge").value)
								other_chg = parseFloat(document.getElementById("OTCHG").value)
								
								DKTCHG = parseFloat(document.getElementById("DKTCHG").value)
								nform_chrg = parseFloat(document.getElementById("nform_chrg").value)
								hld_chrg = parseFloat(document.getElementById("hld_chrg").value)
								oct_chrg = parseFloat(document.getElementById("oct_chrg").value)
								DCCharge = parseFloat(document.getElementById("DCCharge").value)
								DDCharge = parseFloat(document.getElementById("DDCharge").value)
								hld_dlychrg = parseFloat(document.getElementById("hld_dlychrg").value)
								CODCHG = parseFloat(document.getElementById("CODCHG").value)
								DACC_CHRG = parseFloat(document.getElementById("DACC_CHRG").value)
								state_chrg = parseFloat(document.getElementById("state_chrg").value)
								demchgs = parseFloat(document.getElementById("demchgs").value)
								MathadiCharge = parseFloat(document.getElementById("MathadiCharge").value)
								DIPLOMATCHG = parseFloat(document.getElementById("DIPLOMATCHG").value)
								FUELCHRG = parseFloat(document.getElementById("FUELCHRG").value)
								User_chrg_1 = parseFloat(document.getElementById("User_chrg_1").value)
								User_chrg_2 = parseFloat(document.getElementById("User_chrg_2").value)
								User_chrg_3 = parseFloat(document.getElementById("User_chrg_3").value)
								User_chrg_4 = parseFloat(document.getElementById("User_chrg_4").value)
								User_chrg_5 = parseFloat(document.getElementById("User_chrg_5").value)
								///**************for substraction***************************/
								User_chrg_6 = parseFloat(document.getElementById("User_chrg_6").value)
								User_chrg_7 = parseFloat(document.getElementById("User_chrg_7").value)
								User_chrg_8 = parseFloat(document.getElementById("User_chrg_8").value)
								User_chrg_9 = parseFloat(document.getElementById("User_chrg_9").value)
								User_chrg_10 = parseFloat(document.getElementById("User_chrg_10").value)
								///*******************************************************/
								FODCharge = parseFloat(document.getElementById("FODCharge").value)
								//var subtotal=0
								subtotal=roundit(frieght+surchrg+riskchrg+fovchrg+hamalichrg+dcddchrg+stsrechrg+statchrg+other_chg+state_chrg)
								//alert("1-"+subtotal)
								subtotal=roundit(parseFloat(subtotal)+parseFloat(DKTCHG+nform_chrg+hld_chrg+oct_chrg+DCCharge+DDCharge+hld_dlychrg+CODCHG+DACC_CHRG))
									//alert("2-"+subtotal)
								subtotal=roundit(parseFloat(subtotal)+parseFloat(demchgs+MathadiCharge+DIPLOMATCHG+FUELCHRG+User_chrg_1+User_chrg_2+User_chrg_3+User_chrg_4+User_chrg_5+FODCharge))
									//alert("3-"+subtotal)
								subtotal=roundit(parseFloat(subtotal)-parseFloat(User_chrg_6+User_chrg_7+User_chrg_8+User_chrg_9+User_chrg_10))	
								//subtotal.value=subtotal
								//alert(subtotal)
							//return false;
						        if (client_name=="ASL")
								{
								document.getElementById(Form_name+"subtotal").value=roundit(Math.round(subtotal))
								}
								else
								{
								document.getElementById(Form_name+"subtotal").value=roundit(subtotal)
								}
						        
						     
								if(document.getElementById(Form_name+"stax_s").value=="")
								{
								   document.getElementById(Form_name+"stax_s").value=""
								}
       
								if((document.getElementById(Form_name+"stax_s").value!=0) && (document.getElementById(Form_name+"stax_s").value!=document.getElementById(Form_name+"stax").value))
								{
								  //stax_s.focus();
								}

								if(document.getElementById(Form_name+"stax_s").value!="")
								{
								  if (isNaN(document.getElementById(Form_name+"stax_s").value))
								   {
								     alert("Please enter the 'Service Tax (suggested)' in Numeric")
								     document.getElementById(Form_name+"stax_s").value="";
								     document.getElementById(Form_name+"stax_s").focus();
								     calc()
								     return false;
								   }
								}
								var svctax = 12/100//("<%=ServiceTax%>"/100)
								var othertax =3/100// ("<%=OtherTax%>"/100)
						
								var  svctype=document.getElementById(Form_name+"service").value;
							
								transval=document.getElementById(Form_name+"trans").value	
							
								document.getElementById(Form_name+"stax").value= 0
								document.getElementById(Form_name+"otax").value= 0	
								document.getElementById(Form_name+"stax_s").value= 0
								document.getElementById(Form_name+"otax_s").value= 0	
							
								//alert("svctype" + svctype)				

								
								if(svctype=="2")//if FTL then
								{
									
										if(transval=="2")//for Road
										{
												if (parseInt(subtotal.value)>1500)
												 {
												document.getElementById(Form_name+"stax").value= Math.round(parseInt(document.getElementById(Form_name+"subtotal").value)* (0.25) * parseFloat(svctax))
												document.getElementById(Form_name+"otax").value= Math.round(parseInt(document.getElementById(Form_name+"stax").value)*  parseFloat(othertax)) 
												}
												else
												 {
													document.getElementById(Form_name+"stax").value= 0
													document.getElementById(Form_name+"otax").value= 0
													document.getElementById(Form_name+"stax_s").value=0
													document.getElementById(Form_name+"otax_s").value=0
												 }
										}
										else
										{
											document.getElementById(Form_name+"stax").value= Math.round(parseInt(document.getElementById(Form_name+"subtotal").value)* parseFloat(svctax))
											document.getElementById(Form_name+"otax").value= Math.round(parseInt(document.getElementById(Form_name+"stax").value)* parseFloat(othertax)) 
										}
										document.getElementById(Form_name+"stax_s").value=document.getElementById(Form_name+"stax").value;
										document.getElementById(Form_name+"otax_s").value=document.getElementById(Form_name+"otax").value;
									 
								   
								}
								else
								{
									//alert("subtotal" + subtotal)
									//alert("transval" + transval)
									//alert("svctax" + svctax)
									
									
										if(transval=="2")
										{
												if (parseInt(subtotal.value)>750)
												{
													document.getElementById(Form_name+"stax").value= Math.round(parseInt(document.getElementById(Form_name+"subtotal").value)* (0.25) * parseFloat(svctax))
													document.getElementById(Form_name+"otax").value= Math.round(parseInt(document.getElementById(Form_name+"stax").value)*  parseFloat(othertax)) //(0.25) *
												}
												else
												{
													document.getElementById(Form_name+"stax").value= 0
													document.getElementById(Form_name+"otax").value= 0
													document.getElementById(Form_name+"stax_s").value=0
													document.getElementById(Form_name+"otax_s").value=0
												}	
										}
										else
										{
											document.getElementById(Form_name+"stax").value= Math.round(parseInt(document.getElementById(Form_name+"subtotal").value)* parseFloat(svctax))
											document.getElementById(Form_name+"otax").value= Math.round(parseInt(document.getElementById(Form_name+"stax").value)* parseFloat(othertax)) 
										}
										//alert("stax : " + stax.value  )
										//alert("otax : " + otax.value  )
										document.getElementById(Form_name+"stax_s").value=document.getElementById(Form_name+"stax").value;
										document.getElementById(Form_name+"otax_s").value=document.getElementById(Form_name+"otax").value;
									}
								    
								
							
							if(document.getElementById(Form_name+"staxpaidby").value!="Transporter")
							{
								document.getElementById(Form_name+"stax_s").value=0
								document.getElementById(Form_name+"otax_s").value=0
							}
							dkttotal= parseFloat(subtotal) + parseFloat(document.getElementById(Form_name+"stax_s").value)+parseFloat(document.getElementById(Form_name+"otax_s").value)
							//total.value =roundit(dkttotal)
							if (client_name=="ASL")
								{
								
								dkttotal=roundit(Math.round(dkttotal))
								}
								else
								{
								
								dkttotal=roundit(dkttotal)
								}
								document.getElementById(Form_name+"total").value =dkttotal
							//alert(dkttotal)
							document.getElementById(Form_name+"cwt").value=document.getElementById(Form_name+"cwt").value
							document.getElementById(Form_name+"awt").value=document.getElementById(Form_name+"awt").value
  
						//	}	
					 }
function FreightCalc()
{       
    Form_name="ctl00$MyCPH1$"
    ratetype=document.getElementById(Form_name+"ratetype").value
		if (document.getElementById(Form_name+"frieght").value=="")
		{
		   document.getElementById(Form_name+"frieght").value="0"
		}		
		if (isNaN(document.getElementById(Form_name+"frieght").value))
		{
		 document.getElementById(Form_name+"frieght").value="0"
		}
		
		service=document.getElementById(Form_name+"service").value;
		frtrate=document.getElementById(Form_name+"rate").value
		if(isNaN(frtrate))
			document.getElementById(Form_name+"rate").value=0
		///service=1 Sundry  2-- FTL 3-- CLOTH
		if((service==1)||(service==3))
		{
			if (ratetype=="P")
			{
				if (document.getElementById(Form_name+"pkg").value !="0" && document.getElementById(Form_name+"pkg").value!="" )
				 {
				  
				   
				   	if(client_name=="ASL")
					{
				   document.getElementById(Form_name+"frieght").value = roundit(Math.round(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(document.getElementById(Form_name+"cwt").value),2))
				   }
				   else
				   {
				   	document.getElementById(Form_name+"frieght").value = roundit(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(document.getElementById(Form_name+"pkg").value),2)
				   }
				 }
				else
				 {
				   document.getElementById(Form_name+"frieght").value =0
				 } 
			}
			else if (ratetype=="W")
			{
				if (document.getElementById(Form_name+"cwt").value !="0" && document.getElementById(Form_name+"cwt").value!="" )
				{
					 //frieght.value = roundit(parseFloat(rate.value) * parseInt(cwt.value),2)
					 if(client_name=="ASL")
					{
					 document.getElementById(Form_name+"frieght").value = roundit(Math.round(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(document.getElementById(Form_name+"cwt").value),2))
					 }
					 else
					 {
					 document.getElementById(Form_name+"frieght").value = roundit(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(document.getElementById(Form_name+"cwt").value),2)
					 }
				}
				else
				{
				   document.getElementById(Form_name+"frieght").value =0
				} 
			}
			
		} 
		else
		{
			if (ratetype=="P")
			{
				if (document.getElementById(Form_name+"pkg").value !="0" && document.getElementById(Form_name+"pkg").value!="" )
				 {
				   document.getElementById(Form_name+"rate").value = roundit(parseFloat(document.getElementById(Form_name+"frieght").value) / parseInt(document.getElementById(Form_name+"pkg").value),2)
				 }
				else
				 {
				   document.getElementById(Form_name+"rate").value =0
				 } 
			}
			else if (ratetype=="W")
			{
				if (document.getElementById(Form_name+"cwt").value !="0" && document.getElementById(Form_name+"cwt").value!="" )
				{
					 document.getElementById(Form_name+"rate").value = roundit(parseFloat(document.getElementById(Form_name+"frieght").value) / parseInt(document.getElementById(Form_name+"cwt").value),2)
				}
				else
				{
				   document.getElementById(Form_name+"rate").value =0
				} 
			}
				 
		}
		calc();
		
}

function SubmitData()
{			
	
 // var system_manual="<%=System_Manual%>"
 //
	//var loccodeval="<%=wstr%>" // Operational Informtion Validation	
  Form_name="ctl00$MyCPH1$"
 document.getElementById(Form_name+"DocketMode").value=="F"
   
 // if ((document.getElementById(Form_name+"DocketMode").value=="O")||(document.getElementById(Form_name+"DocketMode").value=="F")||(completion_mode=="Y"))
 //{		
			if (document.getElementById(Form_name+"dockno").value=="")
			{
				alert("Please enter the CN No.")
				document.getElementById(Form_name+"dockno").focus();
				return false;
			}
			dktno=document.getElementById(Form_name+"dockno").value
			
			//if(dktno.length<7){
			//		alert("CN Number Length should be 7 digit !!!")
			//	dockno.focus();
			//	return false;
			//}
			
			
//			if (document.getElementById(Form_name+"docksf").value=="")
//			{
//				document.getElementById(Form_name+"docksf").value="."
//			}
						
			/*}*/
			/*if ((trans.value=="1")&&(orgn.value==destn.value))
			{
				alert("Air Mode is not valid for local consignment!!!");
				trans.focus();
				return ;
			}*/
			
		
			if (document.getElementById(Form_name+"paybas").value=="")
			{
				alert("Please select Payment Type.")
				document.getElementById(Form_name+"paybas").focus();
				return false;
			}
		   
			if(document.getElementById(Form_name+"dockdt").value=="")
			{
				alert("Please enter CN Date.")		
				document.getElementById(Form_name+"dockdt").focus();
				return false;     
			}
				
//			if (ValidateForm(document.getElementById(Form_name+"dockdt"))==false)
//			{
//				return false;
//			}
					   
			var dockdt=document.getElementById(Form_name+"dockdt").value
		
			dockdt_dd=dockdt.substring(0,2)
			dockdt_mm=parseInt(dockdt.substring(3,5))
			dockdt_yy=dockdt.substring(6,10)
	
			var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
			var dt =dockdt.value
			var dt_dd=dt.substring(0,2)
			var dt_mm=dt.substring(3,5)
			var dt_yy=dt.substring(6,10)
		
			dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
			if (dt>dock_dt)
			{
					alert( "CN date should not be greater than today's date !!!")
					document.getElementById(Form_name+"dockdt").focus();
					return false;
			}
		
			if (document.getElementById(Form_name+"destn").value=="")
			{
				alert("Please enter Destination.")
				document.getElementById(Form_name+"destn").focus();
				return false;
			}
//			if(loccodeval.indexOf(document.getElementById(Form_name+"destn").value)==-1 )
//  			{
//  				alert("Invalid Location code")
//  				document.getElementById(Form_name+"destn").focus();
//				return false;
//  			}	

//  	
//			/*if (DocketMode.value=="O")
//			{
//				if (tohub_br.value=="")
//				{
//					alert("Please enter the next stop location")
//					tohub_br.focus();
//					return false;
//				}
//				if(loccodeval.indexOf(tohub_br.value)==-1 )
//  				{
//  					alert("Invalid Location code")
//  					tohub_br.focus();
//					return false;
//  				}	
//			}*/
//			if (document.getElementById(Form_name+"service").value=="")
//			{
//				alert("Please select Service Type.")//Service
//				document.getElementById(Form_name+"service").focus();
//				return false;
//			}
//		
//		
//			if((document.getElementById(Form_name+"trans").value=="1")||(document.getElementById(Form_name+"trans").value=="3"))
//			{
//				//alert("hi")
//				document.getElementById(Form_name+"service").selectedIndex=0;
//				document.getElementById(Form_name+"service_ftl").selectedIndex=0;
//			}
//	
//			if (document.getElementById(Form_name+"service").value=="2")
//			{
//						if (document.getElementById(Form_name+"service_ftl").value=="")
//							{
//								alert("Please select Type of FTL")
//								document.getElementById(Form_name+"service_ftl").focus();
//								return false;
//							}
//						if ((document.getElementById(Form_name+"service_ftl").value=="By Weight") && (parseInt(document.getElementById(Form_name+"awt").value)<=0)&&(document.getElementById(Form_name+"paybas").value!="P04"))
//							{
//								alert("If type of FTL is 'By Weight', Weight cannot be zero")
//								document.getElementById(Form_name+"service_ftl").focus();
//								return false;
//							}	
//						
//							
//			}
//			/*if (destfrom.value=="")
//			{
//				alert("Please enter Destination From.")//Service
//				destfrom.focus();
//				return false;
//			}
//			if (destto.value=="")
//			{
//				alert("Please enter Destination To.")//Service
//				destto.focus();
//				return false;
//			}*/
//			
//			if (document.getElementById(Form_name+"cboPickupDely").value=="")
//			{
//				alert("Please select pickup/delivery option.")//Service
//				document.getElementById(Form_name+"cboPickupDely").focus();
//				return false;
//			}
//			if((document.getElementById(Form_name+"paybas").value=="P02"))//&&("<%=mode%>"=="2")
//			{
//				if (document.getElementById(Form_name+"fincmplbr").value=="")
//				{
//					alert("Please enter Billed At.")//Service
//					document.getElementById(Form_name+"fincmplbr").focus();
//					return false;
//				}
//			}
//			//Consignor /Consignee validations starts here
//			if(document.getElementById(Form_name+"paybas").value=="P02")//TBB Check
//			{
//				if (document.getElementById(Form_name+"consignor_name_B").value=="")
//			   	 {
//			   	   alert("Please enter the 'Consignor Code'")
//			   	   document.getElementById(Form_name+"consignor_name_B").focus();
//			   	   return false;
//			   	 }
//			   	/*if (consignee_name_B.value=="")
//			   	 {
//			   	   alert("Please Enter  the 'Consignee Code'")
//			   	   consignee_name_B.focus();
//			   	   return false;
//			   	 }*/
//			   	if((document.getElementById(Form_name+"paybas").value=="P02"))//&&("<%=mode%>"=="2")
//				{
//					if ((document.getElementById(Form_name+"consignor_Bill").value==""))
//			   		 {
//			   		   alert("Please select the 'Billing Party'")
//			   		   document.getElementById(Form_name+"consignor_Bill").focus();
//			   		   return false;
//			   		 }
//			   	}	 
//				//staxpaidby
//				//staxregno
//			}
//			else
//			{
//				if (document.getElementById(Form_name+"consignor_name_B").value=="" && document.getElementById(Form_name+"consignor_name").value=="")
//			   	 {
//			   	   alert("Please select/enter the 'Consignor'")
//			   	   document.getElementById(Form_name+"consignor_name_B").focus();
//			   	   return false;
//			   	 }
//			   	 if (document.getElementById(Form_name+"consignor_name_B").value=="")
//				 {  
//					if(document.getElementById(Form_name+"consignor_add").value=="")
//					 {
//					  alert("Please enter the 'Consignor's Address'");
//					  document.getElementById(Form_name+"consignor_add").focus();
//					  return false;
//					 }


//					if(document.getElementById(Form_name+"consignor_city").value=="")
//					 {
//					  alert("Please enter the 'Consignor's City'");
//					  document.getElementById(Form_name+"consignor_city").focus();
//					  return false;
//					 }


//					if(document.getElementById(Form_name+"consignor_telno").value!="")
//					 {
//						if (isNaN(document.getElementById(Form_name+"consignor_telno").value))
//						 {
//						  alert("Please enter the 'Consignor's Phone.' in numeric");
//						  document.getElementById(Form_name+"consignor_telno").focus();
//						  return false;
//						 }
//					 }
//					if( document.getElementById(Form_name+"consignor_pin").value=="")
//					 {
//					   alert("Please enter the 'Consignor's Pincode.'");
//					    document.getElementById(Form_name+"consignor_pin").focus();
//					   return false;
//					 }

//					if (isNaN(document.getElementById(Form_name+"consignor_pin").value))
//					 {
//					  alert("Please enter the 'Consignor's Pincode.' in numeric");
//					  document.getElementById(Form_name+"consignor_pin").focus();
//					  return false;
//					 }
//					/* if (consignor_lst_cstno.value=="")
//					 {
//					  alert("Please enter the 'Consignor's LST/CST Number '")
//					  consignor_lst_cstno.focus();
//					  return false;
//					 }
//					 */
//					 
//				}
//			}
//			if(pay.value=="P06")//Topay billing check
//			{
//				if (document.getElementById(Form_name+"consignee_name_B").value=="")
//			   	 {
//			   	   alert("Please select the 'Consignee'")
//			   	   document.getElementById(Form_name+"consignee_name_B").focus();
//			   	   return false;
//			   	 }
//			}							
//			else
//			{
//				if (document.getElementById(Form_name+"consignee_name_B").value=="" && document.getElementById(Form_name+"consignee_name").value=="")
//			   	 {
//			   	   alert("Please select/enter the 'Consignee'")
//			   	   document.getElementById(Form_name+"consignee_name_B").focus();
//			   	   return false;
//			   	 }
//				if (document.getElementById(Form_name+"consignee_name_B").value=="")
//				{
//					if(document.getElementById(Form_name+"consignee_name").value=="")
//					{
//					   alert("Please enter the 'Consignee '")
//					   document.getElementById(Form_name+"consignee_name").focus();
//					   return false;
//					}

//					if(document.getElementById(Form_name+"consignee_add").value=="")
//					 {
//					  alert("Please enter the 'Consignee's Address'");
//					  document.getElementById(Form_name+"consignee_add").focus();
//					  return false;
//					 }
//					
//					if(document.getElementById(Form_name+"consignee_city").value=="")
//					 {
//					  alert("Please enter the 'Consignee's City'");
//					  document.getElementById(Form_name+"consignee_city").focus();
//					  return false;
//					 }
//					 				 
//					/*if(consignee_telno.value=="")
//					 {
//					  alert("Please enter the 'Consignee's Telephone no.'");
//					  consignee_telno.focus();
//					  return false;
//					 }*/
//					if( document.getElementById(Form_name+"consignee_telno").value!="")
//					 {
//						if (isNaN( document.getElementById(Form_name+"consignee_telno").value))
//						 {
//						  alert("Please enter the 'Consignee's Phone.' in numeric");
//						   document.getElementById(Form_name+"consignee_telno").focus();
//						  return false;
//						 }
//					 }

//					if(document.getElementById(Form_name+"consignee_pin")consignee_pin.value=="")
//					 {
//					  alert("Please enter the 'Consignee's Pincode.'");
//					  document.getElementById(Form_name+"consignee_pin").focus();
//					  return false;
//					 }

//					if (isNaN(document.getElementById(Form_name+"consignee_pin").value))
//					 {
//					  alert("Please enter the 'Consignee's Pincode.' in numeric");
//					  document.getElementById(Form_name+"consignee_pin").focus();
//					  return false;
//					 }
//				
//				}	 
//			}
//			
//			
//					 
//			
//			
////			if("<%=mode%>"!="2")//("<%=mode%>"=="2")||(pay.value!="P02")
////			{
////				if(ins[0].checked==false && ins[1].checked==false)
////				{
////					alert("Please select the Risk type")
////					ins[0].focus();
////					return false;
////				}
////				
////				if((ins[1].checked==true))// ||||(ins[0].checked==true) 
////				 {
////				   						
////				}
////								  	

////				if(modvat.checked==1)
////				 {
////				  /*if(modvatnp.value=="")
////				   {
////				    alert("Please enter the 'MODVAT No.'")
////				    modvatnp.focus();
////				    return false;
////				   }*/
////								      
////				  if(totmodvat.value=="")
////				   {
////				    alert("Please enter the 'No. of MODVAT Covers'")
////				    totmodvat.focus();
////				    return false;
////				   }


////				  if (isNaN(totmodvat.value))
////				   {
////				    alert("Please enter the 'No. of MODVAT Covers' in Numeric")
////				    totmodvat.focus();
////				    return false;
////				   }

////				  if (totmodvat.value.indexOf(".")!=-1)
////				   {
////				    alert("Decimal value is not allowed")
////				    totmodvat.focus();
////				    return false;
////				   }
////								    
////				   if (parseFloat(totmodvat.value)<=0)
////				   {
////				    alert("'No. of MODVAT Covers' should be greate than ZERO.")
////				    totmodvat.focus();
////				    return false;
////				   }
////								    
////				}

////				if (covers.value!="")
////				{
////				  if (isNaN(covers.value))
////				  {
////				    alert("Please enter the 'No. of Internal Covers' in Numeric")
////				    covers.focus();
////				    return false;
////				  }
////								    
////				  if (covers.value.indexOf(".")!=-1)
////				  {
////				    alert("Decimal value is not allowed")
////				    covers.focus();
////				    return false;
////				  }
////								    
////				   if (parseFloat(covers.value)<0)
////				   {
////				    alert("'No. of Internal Covers' should be greate than/equals to ZERO.")
////				    covers.focus();
////				    return false;
////				   }

////				}
////			}

//			//Permit Check starts here
//			document.getElementById(Form_name+"txtpermit_yn").value="No"
//			if(document.getElementById(Form_name+"permit_yn").checked==1)
//			 {
//				 document.getElementById(Form_name+"txtpermit_yn").value="Yes"
//					
//				 
//				  if(document.getElementById(Form_name+"permit_recvd_at").value=="")
//				  {
//				    alert("Please enter the 'Permit Received At'")
//				    document.getElementById(Form_name+"permit_recvd_at").focus();
//				    return false;
//				  }
//				  
//				 if(document.getElementById(Form_name+"permit_recvd_at").value=="B")
//				  {
//				    				      
//						  if(document.getElementById(Form_name+"permitno").value=="")
//				   {
//				    alert("Please enter the 'Permit No.'")
//				    document.getElementById(Form_name+"permitno").focus();
//				    return false;
//				   }
//						  if(document.getElementById(Form_name+"permitdt").value=="")
//						   {
//							alert("Please enter the 'Permit Date'")
//							document.getElementById(Form_name+"permitdt").focus();
//							return false;
//						   }
//						   if (ValidateForm(document.getElementById(Form_name+"permitdt"))==false)
//						   {
//								return false;
//						   }
//						   
//						  
//						    if(document.getElementById(Form_name+"permit_val_dt").value=="")
//						   {
//							alert("Please enter the 'Permit Validity Date'")
//							document.getElementById(Form_name+"permit_val_dt").focus();
//							return false;
//						   }
//						    //******for date valiation ***********
//						   
//						   var dt =dockdt.value
//							var dt_dd=dt.substring(0,2)
//							var dt_mm=dt.substring(3,5)
//							var dt_yy=dt.substring(6,10)
//							
//						dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
//						
//							var Pt=permit_val_dt.value
//							var Pt_dd=Pt.substring(0,2)
//							var Pt_mm=Pt.substring(3,5)
//							var Pt_yy=Pt.substring(6,10)
//						Pt=new Date(months[parseFloat(Pt_mm)] + " " + parseFloat(Pt_dd) + ", " + parseFloat(Pt_yy))
//						
//						
//						
//							if (Pt<dt)
//							{
//									alert( "'Permit Validity Date'' date should not be less than Docket date !!!")
//									document.getElementById(Form_name+"permit_val_dt").focus();
//									return false;
//							}
//		
//						var diff=MyDateDiff(dt,Pt,'d',0)
//						if(parseInt(diff)<3)
//						{
//									alert( "'Permit Validity Date'' date should  be More than  3 days of Docket date !!!")
//									document.getElementById(Form_name+"permit_val_dt").focus();
//									return false;
//						}
//							
//						   //*************************************
//						   if (ValidateForm(document.getElementById(Form_name+"permit_val_dt"))==false)
//						   {
//								return false;
//						   }
//						  if(document.getElementById(Form_name+"permit_recvd_at").value=="B")
//						  {
//								if(document.getElementById(Form_name+"permit_recvd_dt").value=="")
//								{
//								 alert("Please enter the 'Permit received Date'")
//								 document.getElementById(Form_name+"permit_recvd_dt").focus();
//								 return false;
//								}
//								if (ValidateForm(document.getElementById(Form_name+"permit_recvd_dt"))==false)
//								{
//										return false;
//								}
//						  }
//				}
//				else
//				{
//							document.getElementById(Form_name+"permitdt").value=""
//							document.getElementById(Form_name+"permit_recvd_dt").value=""
//							document.getElementById(Form_name+"permit_val_dt").value=""
//				}
//				  		    
//			}
//			else
//			{
//				document.getElementById(Form_name+"permit_recvd_at").value=""	
//				document.getElementById(Form_name+"permitdt").value=""
//				document.getElementById(Form_name+"permit_recvd_dt").value=""
//			}
//							
//					
//			//documents check here
//			
//			totdoc=parseInt(document.getElementById(Form_name+"totdoc").value);
//			if (totdoc==1)
//			{
//				docu=document.getElementById(Form_name+"docu").value
//				if(docu=="")
//				{
//					alert("Please enter enclosed document number")
//					document.getElementById(Form_name+"docu").focus();
//					return false;
//				} 
//			}
//			else if (totdoc>1)  
//			{
//				for(i=0;i<totdoc;i++)
//				{
//					docu=document.getElementById(Form_name+"docu")[i].value
//					if(docu=="")
//					{
//						alert("Please enter enclosed document number")
//						document.getElementById(Form_name+"docu")[i].focus();
//						return false;
//					} 
//				}
//			}
//			//ends here 
//			
//			if(!fnInvoiceDetail())
//				return false;
//		  
//			/*
//			if(parseInt(pkg.value)>parseInt(pkg_o.value) || parseInt(pkg.value)<parseInt(pkg_o.value))	
//			 {
//			   alert("Total No. of packages should  be equals to " + pkg_o.value)
//			   return false;
//			 }
//			

//			if(parseInt(awt.value)>parseInt(awt_o.value) || parseInt(awt.value)<parseInt(awt_o.value))	
//			 {
//			   alert("Total Actual weight should be equals to " + awt_o.value)
//			   return false;
//			 }
//			 */
//		   
//			if((document.getElementById(Form_name+"service").selectedIndex==0)&&(document.getElementById(Form_name+"paybas").value!="P04"))
//			{
//			   if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
//				{
//				   alert("Actual Weight should be greater than ZERO")
//				   document.getElementById(Form_name+"actwt").focus();
//				   return false;
//				}	
//			}	
//			
//	//	alert(completion_mode)
//		if(completion_mode!="Y")
//		{
//				if (document.getElementById(Form_name+"trans").value!="2")
//				{
//					if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
//					{
//					   alert("Actual Weight should be greater than ZERO")
//					   document.getElementById(Form_name+"actwt").focus();
//					   return false;
//					}
//					if (parseInt(document.getElementById(Form_name+"cwt").value)<=0)		
//					{
//					   alert("Charge Weight should be greater than ZERO")
//					   document.getElementById(Form_name+"cwt").focus();
//					   return false;
//					}
//				 }
//				 
//				 
//			 
//		}
//		else
//		{
//			if (quck_validation!="N")
//			{
//						if(parseInt(document.getElementById(Form_name+"pkg").value)!=argPkgs){
//						//	submitedFlag=false;
//							alert("Total Pkgs does not match with Pkgs entered at Quick Entry :(")
//							return false;
//						}
//		
//				}		
//						if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
//						{
//						   alert("Actual Weight should be greater than ZERO")
//						   awt.focus();
//						   return false;
//						}
//						if(parseInt(document.getElementById(Form_name+"awt").value)!=argActWt)
//						{
//							//submitedFlag=false;
//							alert("Total Actual Wt does not match with Actual Wt. entered at Quick Entry :(")
//							return false;	
//						}
//				
//						if(Trim(document.getElementById(Form_name+"cwt").value)=='' || isNaN(document.getElementById(Form_name+"cwt").value))
//						{
//					//submitedFlag=false;
//							alert("Charge Wt. in Invalid or Empty :(")
//							document.getElementById(Form_name+"cwt").focus();
//							return false
//						} 
//						else 
//						{
//							if(parseInt(document.getElementById(Form_name+"cwt").value)<parseInt(document.getElementById(Form_name+"awt").value)){
//								//submitedFlag=false;
//								alert("Charged Wt. < Actual Wt. :(");
//								parseInt(document.getElementById(Form_name+"cwt").focus();
//								return false
//						}
//		
//			
//		}
//			 
//		   if(parseInt(document.getElementById(Form_name+"pkgtyp").value=="")
//		   {
//		    alert("Please select the 'Package Type'")
//		    parseInt(document.getElementById(Form_name+"pkgtyp").focus();
//		    return false;
//		   }
//			
//		}
//			
//		  if(parseInt(document.getElementById(Form_name+"pkgtyp")prod.value=="")
//		   {
//		    alert("Please select the 'Product'")
//		    parseInt(document.getElementById(Form_name+"pkgtyp").focus();
//		    return false;
//		   }

//			
//			var spl_inst
//			spl_inst =parseInt(document.getElementById(Form_name+"spl_inst").value.length);
//			if (spl_inst>250)
//			{
//			  alert("'Special Service Requirement' Exceeds 250 characters.")
//			  document.getElementById(Form_name+"spl_inst").focus();
//			  return false;
//			}
//			
//	}
//	
//						
//			
//		
//		// Financial Informtion Validation						    
//		//if((pay.value!="P02")||("<%=mode%>"=="2"))
//		//{
//					//if(trans.value!="3")
//					//{
//						if((document.getElementById(Form_name+"spl_inst")pay.value!="P04")) 
//			   			{
//							//if(parseFloat(stax.value)>0)
//							//{
//								if (document.getElementById(Form_name+"spl_inst")staxpaidby.value=="")
//			   					 {
//			   					   alert("Please select the 'Service Tax Paid By'")
//			   					   document.getElementById(Form_name+"spl_inst")staxpaidby.focus();
//			   					   return false;
//			   					 }
//								/*if((staxpaidby.selectedIndex!=4)&&(trans.value=="1"))
//			   					 {
//			   					     alert("For Air Service Tax paid by Transporter only.'")
//			   					     staxpaidby.selectedIndex=4;
//			   					     return false;
//			   					 }*/
//								 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="1"))
//			   					 {
//			   					     alert("For Air Service Tax paid by Transporter only.'")
//			   					     document.getElementById(Form_name+"staxpaidby").focus();
//			   					     return false;
//									 
//			   					 }
//								 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="3"))
//			   					 {
//			   					     alert("For Train Service Tax paid by Transporter only.'")
//			   					     document.getElementById(Form_name+"staxpaidby").focus();
//			   					     return false;
//									 
//			   					 }
//								 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="4"))
//			   					 {
//			   					     alert("For Express Service Tax paid by Transporter only.'")
//			   					     document.getElementById(Form_name+"staxpaidby").focus();
//			   					     return false;
//									
//			   					 }
//								/*if (staxregno.value=="")
//			   					 {
//			   					   alert("Please enter the 'Service Tax Reg. No.'")
//			   					   staxregno.focus();
//			   					   return false;
//			   					 }*/
//			   				//}	 
//						}
//					//}
//					else
//					{
//						document.getElementById(Form_name+"staxpaidby").selectedIndex=0;
//						document.getElementById(Form_name+"staxregno").value="";
//					}
//					if((parseFloat(document.getElementById(Form_name+"frieght").value)==0)&&(document.getElementById(Form_name+"paybas").value!="P04"))
//					{
//					 alert("Freight charge should be greater than zero")
//					 document.getElementById(Form_name+"frieght").focus();
//					 return false;
//					}
//					calc();
//		//}		
//		//alert("submit not done")
//		//return false;
//		//if((pay.value!="P02")||("<%=mode%>"=="2"))
//		//{
//			document.getElementById(Form_name+"frieght").disabled=false;
//			document.getElementById(Form_name+"rate").disabled=false;
//		//}
//		submit1.value="Processing..."  
//		action="docupdt.asp"  
//		submit()
//        //fshow()	
}