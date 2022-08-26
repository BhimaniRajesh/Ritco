 <script language="javascript" type="text/javascript" >
 
 // JScript File
var client_name="Webxpress"
 var Form_name="ctl00_MyCPH1_"
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");




function fOnChangepaybas_redonly_party(paybas,consignor_Bill,consignor_Bill_name,btnPopUp)
{

    if (paybas.value=="P01" ||paybas.value=="P03" )
		{
					consignor_Bill.value=""
					consignor_Bill_name.readOnly=true
					consignor_Bill.readOnly=true
					btnPopUp.disabled=true
    	}
		else
		{
			consignor_Bill.readOnly=false
			consignor_Bill_name.readOnly=false
			btnPopUp.disabled=false
		}
}


/// TO CHECK CHARGE WEIGHT MUST BE GREATER THAN ZERO

function Onchange_chrgwt()
{
Form_name="ctl00_MyCPH1_"

    if(parseFloat(document.getElementById(Form_name+"awt").value) > parseFloat(document.getElementById(Form_name+"cwt").value))
    {
    alert("CHarge Wheight Should be Greater than or Equals to Actual Weight")
    document.getElementById(Form_name+"cwt").value="0";
    document.getElementById(Form_name+"cwt").focus();
    return false;
    }
}

function Edit_svc_detail()
    {
        var svctaxamt=document.getElementById("ctl00_MyCPH1_stax_s");
        var cessamt=document.getElementById("ctl00_MyCPH1_otax_s");
        var heducess=document.getElementById("ctl00_MyCPH1_hotax_s");
        var Subtotamt=document.getElementById("ctl00_MyCPH1_subtotal");
        var Total_amount=document.getElementById("ctl00_MyCPH1_total");
        
         var Taxpaidby=document.getElementById("ctl00_MyCPH1_staxpaidby");
        if (Taxpaidby.value=="Transporter")
        {
        
        Total_amount.value=parseFloat(Subtotamt.value)+parseFloat(svctaxamt.value)+parseFloat(cessamt.value)+parseFloat(heducess.value)
        }
       
    }
 

// ENABLE DISABLE PARTY CODE AND NAME
function partyEnable()
{
 var cmb=document.getElementById("ctl00_MyCPH1_paybas");
    var txtconsignor_Bill=document.getElementById("ctl00_MyCPH1_consignor_Bill");
    var txtconsignor_Bill_name=document.getElementById("ctl00_MyCPH1_consignor_Bill_name");
    var btnpopup=document.getElementById("ctl00_MyCPH1_btnPopUp");
   
    if(cmb.value=="P02" || cmb.value=="P08" || cmb.value=="P09")
        {
            txtconsignor_Bill.disabled=false;
            txtconsignor_Bill.style.backgroundColor="#ffffff";
            txtconsignor_Bill_name.style.backgroundColor="#ffffff";
            txtconsignor_Bill_name.disabled=false;
            if(btnpopup)
                btnpopup.style.display="block";
        }
    else //ftl-freight
        {
            txtconsignor_Bill.disabled=true;
            txtconsignor_Bill_name.disabled=true;
            txtconsignor_Bill.style.backgroundColor="#e6e6e6";
            txtconsignor_Bill_name.style.backgroundColor="#e6e6e6";
            if(btnpopup)
                btnpopup.style.display="none";
        }
   
}

//////////////////////// THIS FUNCTION ENBLE/DISABLE FREIGHT/RATE TEXTBOXES   ///////////////////////////
function enableBox()
{
    var cmb=document.getElementById("ctl00_MyCPH1_service");
    var txtfreight=document.getElementById("ctl00_MyCPH1_frieght");
    var txtrate=document.getElementById("ctl00_MyCPH1_rate");
    var cmbftls=document.getElementById("ctl00_MyCPH1_service_ftl");
    var hdnservice=document.getElementById("ctl00_MyCPH1_hdnservice");
   
    hdnservice.value=cmb.value;
    
    
     if(cmb.value=="2")
        cmbftls.disabled=false;
     else
        cmbftls.disabled=true;
    
    if(txtfreight && txtrate)
    {
    if(cmb.value=="2")
        {
        txtfreight.disabled=true;
        txtrate.disabled=false;
        }
    else //ftl-freight
        {
        txtfreight.disabled=false;
        txtrate.disabled=true;
        }
    }
}

function Partydetail(str1)
{
  winNew=window.open(str1,null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15")
}

function rowBlur(id)
{
    var txt=document.getElementById(id);
    var no=parseInt(txt.value);
    if(no<=0)
    {
        alert("Enter No of Rows Properly.[ Not Less Than 1 ]");
        txt.value="1";
        return false;
    }
        

}

function Clear_Csgn(paybas,consignor_name,consignor_add,consignor_pin,consignor_telno,consignor_city,consignor_email,consignor_name_B)
{

    //if(!conCityTest('ctl00_MyCPH1_consignor_city','ctl00_MyCPH1_consignor_pin'))
      //  return false;
						
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

function num_email_chk(consignor_email,consignee_email,consignor_pin,consignee_pin,id)
 {
// alert(id)

    
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
    if(id=="1")
        document.getElementById("ctl00_MyCPH1_consignee_name_B").focus();
    else if(id=="2")
        document.getElementById("ctl00_MyCPH1_ins").focus();
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
	var str1="'!@#_%^&*()+~`.[]{}: "
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
	obj.value=roundit(temp) 
	return true;					   
}
	
function Nagative_Chk_woDecimal(obj)
{
	var temp
	temp=obj.value 
			//alert(obj)			
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.value=""
		obj.focus();
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value=""
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value=""
		obj.focus();
		return false;
	}
	if(temp.indexOf(".")>0 )
	{
		alert("Value should not contain decimal point")
		obj.value=""
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
 var cwt_db=0;
 var min_cwt=0;
    var Form_name="ctl00_MyCPH1_";
   var totpkg=0.00;
   var totactwt=0.00;
   var totchrgwt=0.00;
   var totcftval=0.00;
   var totdecl=0.00;
   var temp1;

   var maxrows=parseInt(document.getElementById(Form_name+"noofrows1").value)
    
         var cft="";
			if (document.getElementById(Form_name+"chkcft").checked)
			{
			    cft="Y";
			}
			else
			{
			    cft="N";
			}
			
			var j="";
			var i=0;
			var frm="";
    if (maxrows>=1)
    {
		for(i=0;i<maxrows;i++)
	    {   
	            j = i + 2;
	           
	            if(i < 10)
                {
                    if (cft=="Y")
                    {
                        frm=Form_name+"invdata_cft_ctl"+"0"+j+"_";
                    }
                    else
                    {
                        frm=Form_name+"invdata_ctl"+"0"+j+"_";
                    }
                    
                }
                else
                {
                   
                    if (cft=="Y")
                    {
                        frm=Form_name+"invdata_cft_ctl"+j+"_";
                    }
                    else
                    {
                        frm=Form_name+"invdata_ctl"+j+"_";
                    }
                   
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
						          if(totdecl==0.00)
						          {
						            totdecl = parseInt(document.getElementById(frm + "declvalue").value);
						          }
						          else
						          {
						            totdecl = parseInt(totdecl)+ parseInt(document.getElementById(frm + "declvalue").value);
						          }   
						    } 
				   }
				else if (document.getElementById(frm+"declvalue").value =="")
				  {
						  if(totdecl=="")
						  {
						    totdecl = 0;
						  }
						 else
						  {
						    totdecl = parseInt(totdecl)+ 0;
						  }   
				  }			
          
				//Total of Packages
				if (parseInt(document.getElementById(frm+"pkgno").value) != 0)
				   {
						if (isNaN(document.getElementById(frm+"pkgno").value))
						 {
						   alert("Please enter the No. of packages in numeric !!!");
						   document.getElementById(frm+"pkgno").focus();
						   return false;
						 }
						else if (parseFloat(document.getElementById(frm+"pkgno").value)<=0)
						 {
						   alert("No. of packages should be greater than zero !!!");
						   document.getElementById(frm+"pkgno").focus();
						   return false;
						 }
				      
				      else
						{
						  if(totpkg == 0.00)
						  {
						    totpkg = parseFloat(document.getElementById(frm+"pkgno").value);
						  }
						 else
						  {
						    totpkg = parseFloat(totpkg)+ parseFloat(document.getElementById(frm+"pkgno").value);
						  }   
						} 
				   }
				else if (document.getElementById(frm+"pkgno").value == 0.00)
				  {
				        totpkg = parseFloat(totpkg);
    			  }
				  	
		  if(cft=='Y')
		  {
				if (document.getElementById(Form_name+"cftratio").value=="")		
				{
					   alert("Please enter the value of Cubic ft. Conversion ratio");
					   document.getElementById(Form_name+"cftratio").focus();
					   return false;
				}

				if (document.getElementById(Form_name+"cftratio").value!="")		
				{
					 if(isNaN(document.getElementById(Form_name+"cftratio").value))
					  {
					   alert("Please enter the value of Cubic ft. Conversion ratio in numeric");
					   document.getElementById(Form_name+"cftratio").focus();
					   return false;
					  }
				}
				
				if(parseFloat(document.getElementById(Form_name+"cftratio").value)<8||(document.getElementById(Form_name+"cftratio").value)>20)
				{	   
					alert("Cubic ft. Conversion ratio should be between 8 to 20 ");
					document.getElementById(Form_name+"cftratio").focus();
					return false;
				}
				
				if (document.getElementById(frm+"length").value!="")		
				{
					 if(isNaN(document.getElementById(frm+"length").value))
					  {
					   alert("Please enter the value of CFT-Length in numeric");
					   document.getElementById(frm+"length").focus();
					   return false;
					  }
				}

				if (document.getElementById(frm+"breadth").value!="")		
				{
					 if(isNaN(document.getElementById(frm+"breadth").value))
					  {
					       alert("Please enter the value of CFT-Breadth in numeric");
					       document.getElementById(frm+"breadth").focus();
					       return false;
					  }
				}

				if (document.getElementById(frm+"height").value!="")		
				{
					 if(isNaN(document.getElementById(frm+"height").value))
					  {
					       alert("Please enter the value of CFT-Height in numeric");
					       document.getElementById(frm+"height").focus();
					       return false;
					  }
				}

				if (document.getElementById(frm+"length").value!="" && document.getElementById(frm+"breadth").value!="" && document.getElementById(frm+"height").value!="" )
					{
						 document.getElementById(frm+"cftval").value = roundit((parseInt(document.getElementById(frm+"length").value) *  parseInt(document.getElementById(frm+"breadth").value) *  parseInt(document.getElementById(frm+"height").value) * parseFloat(document.getElementById(frm+"pkgno").value))/1728)
						if (parseInt(document.getElementById(frm+"cftval").value)<=0)
						 {
						    document.getElementById(frm+"cftval").value=1;
						 }
						
						  if(totchrgwt=="")
						  {
						    totchrgwt = (parseInt(document.getElementById(Form_name+"cftratio").value)* parseInt(document.getElementById(frm+"cftval").value));
						    totcftval=parseInt(document.getElementById(frm+"cftval").value);
						  }
						 else
						  {
						    totchrgwt = parseInt(totchrgwt)+ (parseInt(document.getElementById(Form_name+"cftratio").value)* parseInt(document.getElementById(frm+"cftval").value));
						    totcftval=parseInt(totcftval)+ parseInt(document.getElementById(frm+"cftval").value);
						  }
						  
					 }
					 
					document.getElementById(Form_name+"total_cft").value=totcftval;
	   	
				}
	 

					// Total of Actual weight
					 if (document.getElementById(frm+"actwt").value !="0")
					    {
							if (isNaN(document.getElementById(frm+"actwt").value))
							 {
							   alert("Please enter the Actual weight in numeric !!!");
							   document.getElementById(frm+"actwt").focus();
							   return false;
							 }
							else if (parseFloat(document.getElementById(frm+"actwt").value)<=0)
							 {
							   alert("Actual weight should be greater than zero !!!");
							   document.getElementById(frm+"actwt").focus();
							   return false;
							 }

					       else
							{
							  if(totactwt==0.00)
							  {
							    totactwt = parseFloat(document.getElementById(frm+"actwt").value);
							  }
							 else
							  {
							    totactwt = parseFloat(totactwt)+ parseFloat(document.getElementById(frm+"actwt").value);
							  }   
							} 
					    }
					 else if (document.getElementById(frm+"actwt").value =="")
					   {
    					    totactwt = parseInt(totactwt);
					   }			
			 }	
		 }	 
	    
	     document.getElementById(Form_name+"decl").value=totdecl;
	     document.getElementById(Form_name+"pkg").value=Math.round(totpkg);
	 	 document.getElementById(Form_name+"awt").value=totactwt;
	 	 
	 	 if(totchrgwt!=0.00)
	 	 {
	 		if(parseFloat(totchrgwt)>parseFloat(cwt_db))	
	 		{
				if (parseFloat(min_cwt)>parseFloat(totchrgwt))
				{
						document.getElementById(Form_name+"cwt").value=min_cwt;
				}
				else
				{
	 	     		document.getElementById(Form_name+"cwt").value=totchrgwt;
				}
	 	    }
	 	   else
	 	   {
		   	if (parseFloat(min_cwt)>parseFloat(cwt_db))
				{
						document.getElementById(Form_name+"cwt").value=min_cwt;
				}
				else
				{
	 	     		document.getElementById(Form_name+"cwt").value=cwt_db;
				}
	 	   }  
	 	 }
	 	else
	 	{
	 	  if (parseFloat(totactwt)> parseFloat(cwt_db))
	 	  {
	 	  document.getElementById(Form_name+"cwt").value=totactwt;
	 	  }
	 	  else
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=cwt_db;
	 	  }
	 	}
	 
	 	
		temp1 =document.getElementById(Form_name+"cwt").value%5;
		
		if(temp1 != 0)
		{
		  document.getElementById(Form_name+"cwt").value = Number(document.getElementById(Form_name+"cwt").value);// + (5 - temp1)
		}

	 	if(parseInt(totchrgwt)< (totactwt) ) 
	 	{
	 	  if (parseFloat(totactwt)> parseFloat(cwt_db))
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=totactwt;
	 	  }
	 	 else
	 	  {
	 	    document.getElementById(Form_name+"cwt").value=cwt_db;
	 	  }   
	 	}

	if(document.getElementById(Form_name+"DocketMode").value=="F" || document.getElementById(Form_name+"DocketMode").value=="E")
	 {
		FreightCalc();
	 }	

}

//********************************************
function fnInvoiceDetail()
{
        var txtinvdt;

			var cft="";
			var maxrows;
			if (document.getElementById(Form_name+"chkcft").checked)
			{
		        if(document.getElementById("ctl00_MyCPH1_invdata_cft"))
		            maxrows=document.getElementById("ctl00_MyCPH1_invdata_cft").rows.length-1;
		        else
		            maxrows=0;

			    cft="Y";
			}
			else
			{
		        if(document.getElementById("ctl00_MyCPH1_invdata"))
		            maxrows=document.getElementById("ctl00_MyCPH1_invdata").rows.length-1;
		        else
		            maxrows=0;
			    cft="N";
			}
		
		
	    var invflag="N"
	    
        if (maxrows>=1)
         {
		    for(i=0;i<maxrows;i++)
	        {   
	            j = i + 2;
	           
	            if(i < 10)
                {
                    if (cft=="Y")
                    {
                    frm2=Form_name+"invdata_cft_ctl"+"0"+j+"_";
                    }
                    else
                    {
                    frm2=Form_name+"invdata_ctl"+"0"+j+"_";
                    }
                    
                }
                else
                {
                   if (cft=="Y")
                    {
                    frm2=Form_name+"invdata_cft_ctl"+j+"_";
                    }
                    else
                    {
                     frm2=Form_name+"invdata_ctl"+j+"_";
                    }

                }
				                
					  		if (document.getElementById(frm2+"invno").value!="" || document.getElementById(frm2+"declvalue").value!="0" || document.getElementById(frm2+"pkgno").value!="0" || document.getElementById(frm2+"actwt").value!="0")	
								{
									           invflag="Y"
									           if(document.getElementById(frm2+"invno").value=="")
									           {
									            alert("Please enter the Invoice Number");
									            document.getElementById(frm2+"invno").focus();
									            return false
									           }
									           
									           txtinvdt=document.getElementById(frm2+"invdt");
									           if(txtinvdt.value=="")
									           {
									            alert("Please enter the Invoice Date");
									            txtinvdt.focus();
									            return false
									           }
									         
										        if(txtinvdt.value!="")
	  								             {
                                                    var servdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");
                                                    var arrinvdt=txtinvdt.value.split('/');
                                                    var arrservdate=servdate.value.split('/');
                                                    
                                                    var ddinv=parseFloat(arrinvdt[0]);
                                                    var mminv=parseFloat(arrinvdt[1]);
                                                    var yyinv=parseFloat(arrinvdt[2]);
                                                    
                                                    var ddser=parseFloat(arrservdate[0]);
                                                    var mmser=parseFloat(arrservdate[1]);
                                                    var yyser=parseFloat(arrservdate[2]);
                                                    
                                                    if(yyinv > yyser)
                                                    {
                                                        alert("Invoice date is greater than Today's Date...Please Re-enter");
                                                        return false;
                                                    }
                                                    else
                                                    {
                                                        if(mminv > mmser && yyinv==yyser)
                                                        {
                                                            alert("Invoice date is greater than Today's Date...Please Re-enter");
                                                            return false;
                                                        }
                                                        else
                                                        {
                                                            if(ddinv > ddser && mminv==mmser)
                                                            {
                                                                alert("Invoice date is greater than Today's Date...Please Re-enter");
                                                                return false;
                                                            }
                                                        }
                                                    }
													        
										        }
										        
									           if(document.getElementById(frm2+"declvalue").value=="")
									           {
											        alert("Please enter the Declared value")
											        document.getElementById(frm2+"declvalue").focus();
											        return false
									           }
							                    var sku_yn="N"//sku_yn.value
							                    
							                    
        //********************************************************************
							                            if (sku_yn!="Y")
							                            {
									                               if(document.getElementById(frm2+"pkgno").value=="")
									                               {
									                                alert("Please enter the No. of packages")
									                                document.getElementById(frm2+"pkgno").focus();
									                                return false
									                               }

									                               if (parseInt(document.getElementById(frm2+"pkgno").value)<=0)		
									                               {
										                               alert("No. of packages should be greater than ZERO")
										                               document.getElementById(frm2+"pkgno").focus();
										                               return false;
									                               }

									                               if(cft=="Y")
										                            {
											                            if (document.getElementById(frm2+"length").value=="")		
											                            {
											                               alert("Please enter the value of CFT-Length")
											                               document.getElementById(frm2+"length").focus();
											                               return false;
											                             }

											                            if (document.getElementById(frm2+"breadth").value=="")		
											                            {
											                               alert("Please enter the value of CFT-Breadth")
											                               document.getElementById(frm2+"breadth").focus();
											                               return false;
											                             }

											                            if (document.getElementById(frm2+"height").value=="")		
											                            {
											                               alert("Please enter the value of CFT-Height")
											                               document.getElementById(frm2+"height").focus();
											                               return false;
											                             }
										                            }
										                           
										                            if (document.getElementById(frm2+"actwt").value=="")		
										                            {
										                               alert("Please enter the Actual Weight")
										                               document.getElementById(frm2+"actwt").focus();
										                               return false;
										                             }
										                             if (document.getElementById(Form_name+"trans").value!="2")
										                            {
											                            if ((parseInt(document.getElementById(frm2+"actwt").value)<=0)&&(parseInt(document.getElementById(Form_name+"paybas").value)!="P04"))		
											                            {
											                               alert("Actual Weight should be greater than ZERO")
											                               document.getElementById(frm2+"actwt").focus();
											                               return false;
											                             }
										                             }
							                            }
							                            else
							                            {

							                            }
							                            //************************************************************
										                if (document.getElementById(Form_name+"trans").value!="2")
										                {
											                if ((parseInt(document.getElementById(frm2+"actwt").value)<=0)&&(parseInt(document.getElementById(Form_name+"paybas").value)!="P04"))		
											                {
											                   alert("Actual Weight should be greater than ZERO")
											                  document.getElementById(frm2+"actwt").focus();
											                   return false;
											                 }
										                 }
							    }
					 }
					 
					 
					 //alert(invflag)
					 if(invflag=="N")
					{
							alert("Please enter atleast one Invoice detail")
							if (cft=="Y")
                             {
							document.getElementById("ctl00_MyCPH1_invdata_cft_ctl02_invno").focus()
							}
							else
							{
							document.getElementById("ctl00_MyCPH1_invdata_ctl02_invno").focus()
							}
							return false;
					}
			
			}
				
			if(cft=="Y")
			{								
					if (document.getElementById(Form_name+"cftratio").value=="")		
					{
						   alert("Please enter the value of Cubic ft. Conversion ratio")
						   document.getElementById(Form_name+"cftratio").focus();
						   return false;
					}
			}
        
			return true;	
}


function MyDateDiff( start, end, interval, rounding ) {
		var iOut = 0;
		var bufferA = Date.parse( start ) ;
		var bufferB = Date.parse( end ) ;
		    	
		// check that the start parameter is a valid Date. 
		if ( isNaN (bufferA) || isNaN (bufferB) ) {
			alert( startMsg ) ;
			return null ;
		}
			
		// check that an interval parameter was not numeric. 
		if ( interval.charAt == 'undefined' ) {
			// the user specified an incorrect interval, handle the error. 
			alert( intervalMsg ) ;
			return null ;
		}
		    
		var number = bufferB-bufferA ;
		    
		// what kind of add to do? 
		switch (interval.charAt(0)){
			case 'd': case 'D': 
				iOut = parseInt(number / 86400000) ;
				if(rounding) iOut += parseInt((number % 86400000)/43200001) ;
				break ;
			case 'h': case 'H':
				iOut = parseInt(number / 3600000 ) ;
				if(rounding) iOut += parseInt((number % 3600000)/1800001) ;
				break ;
			case 'm': case 'M':
				iOut = parseInt(number / 60000 ) ;
				if(rounding) iOut += parseInt((number % 60000)/30001) ;
				break ;
			case 's': case 'S':
				iOut = parseInt(number / 1000 ) ;
				if(rounding) iOut += parseInt((number % 1000)/501) ;
				break ;
			default:
				// If we get to here then the interval parameter
				// didn't meet the d,h,m,s criteria.  Handle
				// the error. 		
				alert(intervalMsg) ;
				return null ;
		}
		return iOut ;
	}
	function monthdiff(date1,date2)
	{ 
		var month1,month2,diff;
		var timediff;
		month1=new Date(date1);
		month2=new Date(date2);
		diff =new Date();
		diff.setTime(month1.getTime() - month2.getTime());
		timediff=diff.getTime();
		 mth3= parseFloat((Math.floor(timediff / (1000 * 60 * 60 * 24)))/30);
		return mth3;
	}
	
	
function InvoiceDet()
{
    Form_name="ctl00_MyCPH1_";
    maxrows=parseInt(document.getElementById(Form_name+"noofrows1").value);
    
    if (maxrows>=1)
   {
		for(i=0;i<maxrows;i++)
			 {
			     j = i + 2;
	           
	            if(i < 10)
                {
                                       
                    frm3=Form_name+"invdata_cft_ctl"+"0"+j+"_";
                }
                else
                {
                    frm3=Form_name+"invdata_cft_ctl"+j+"_"
                   
                }
                    
             
			   if (document.getElementById(frm3+"length").value!="")		
			   {
				 if(isNaN(document.getElementById(frm3+"length").value))
				  {
				   alert("Please enter the value of CFT-Length in numeric");
				   document.getElementById(frm3+"length").focus();
				   return false;
				  }
			   }

			   if (document.getElementById(frm3+"breadth").value!="")		
			   {
				 if(isNaN(document.getElementById(frm3+"breadth").value))
				  {
				   alert("Please enter the value of CFT-Breadth in numeric");
				   document.getElementById(frm3+"breadth").focus();
				   return false;
				  }
			   }

			   if (document.getElementById(frm3+"height").value!="")		
			   {
				 if(isNaN(document.getElementById(frm3+"height").value))
				  {
				   alert("Please enter the value of CFT-Height in numeric");
				   document.getElementById(frm3+"height").focus();
				   return false;
				  }
			   }
                
			 
			  if (document.getElementById(frm3+"length").value!="" && document.getElementById(frm3+"breadth").value!="" && document.getElementById(frm3+"height").value!="" )
				{
					document.getElementById(frm3+"cftval").value = roundit((parseInt(document.getElementById(frm3+"length").value) *  parseInt(document.getElementById(frm3+"breadth").value) *  parseInt(document.getElementById(frm3+"height").value)* parseInt(document.getElementById(frm3+"pkgno").value))/1728)
					if (parseInt(document.getElementById(frm3+"cftval").value)<=0)
					{
					  document.getElementById(frm3+"cftval").value=1;
					}
				}
			 }
		}	 	
		TotalCalc();
}


function ValidateForm(obj)
{

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
function CODDOD_validation_checkbox()
{

}
function LocalCN_validation_checkbox()
{
  
    
     return true;
}
function ODA_validation_checkbox()
{
    if (document.getElementById(Form_name+"chkoda").checked==false)
    {
       if (document.getElementById(Form_name+"Orgn").value==document.getElementById(Form_name+"destn").value)
       {
           if(document.getElementById(Form_name+"destto").value=="")
           {
            alert("Plz Enter TO Location")
            document.getElementById(Form_name+"destto").focus();
            return false;
           }
       }
    }
     return true;
}





/***************************************************************************************************************
                    THIS FUNCTIN TEST FOR PARTY CODE AND FILLS THE NAME OF PARTY
/***************************************************************************************************************/
function partyCodeTest(id,nameid)
{
    var txt=document.getElementById(id);
    var txtname=document.getElementById(nameid);
    
    txt.value=txt.value.toUpperCase();
      
    if(txt.value=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
         var strpg="LocationTest.aspx?mode=check&code=partycode&partycode="+ txt.value + "&sid=" + Math.random();
         findobj.open("GET",strpg);
         findobj.onreadystatechange=function()
             {
                 if((findobj.readyState==4) && (findobj.status==200))
                    {
                      var  res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            alert("This Customer doesn't Exists..");
                            txt.select()
                            return false;
                         }
                      else
                      {
                            txtname.value=res[1];
                      }
                    }
             }
            findobj.send(null);
    }
return true;
}






/***************************************************************************************************************
                    THIS FUNCTIN TEST FOR DESTINAION CODE
/***************************************************************************************************************/
function destCodeTest(id)
{
    var txt=document.getElementById(id);
    txt.value=txt.value.toUpperCase();

    if(txt.value=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="LocationTest.aspx?mode=check&code=destcode&destcode="+ txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  if(res[0]=="false")
                     {
                        alert("This Destination Code doesn't Exists..");
                        txt.value="";
                        txt.select();
                        return false;
                     }
                }
         }
        findobj.send(null);
    }
  
return true;
}



/***************************************************************************************************************
                    THIS FUNCTIN TEST FOR ORIGIN LOCATION UNDER ORIGIN CODE
/***************************************************************************************************************/
function originTest(fromid,origincodeid)
{
    
    var txtfromid=document.getElementById(fromid);
    var txtorigincodeid=document.getElementById(origincodeid);
    txtfromid.value=txtfromid.value.toUpperCase();
      
    if(txtfromid.value=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="LocationTest.aspx?mode=check&code=origin&origincode="+ txtorigincodeid.value + "&originloc=" + txtfromid.value + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert("This City doesn't Exists in Origin Location..");
                        txtfromid.select();
                        return false;
                     }
              
                }
         }
         
    findobj.send(null);
    }
  
return true;
}



/***************************************************************************************************************
                    THIS FUNCTIN TEST FOR DESTINATION LOCATION UNDER DESTINAION CODE
/***************************************************************************************************************/
function destTest(destid,delcodeid)
{
    var txtdest=null;
    txtdest=document.getElementById("ctl00_MyCPH1_destto");
    var txtdelcode=document.getElementById("ctl00_MyCPH1_destn");
    if(txtdest==null)
        return false;
    txtdest.value=txtdest.value.toUpperCase();
    
    if(txtdest.value=="")    
        return false;

    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="LocationTest.aspx?mode=check&code=dest&destcode="+ txtdelcode.value + "&destloc=" + txtdest.value + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert("This City doesn't Exists in Delivery Control Location..");
                        txtdest.select();
                        return false;
                     }
                   else
                   {
                        if(res[1]=="Y")
                        {
                            document.getElementById("ctl00_MyCPH1_chkoda").checked=true;
                        }
                        else
                        {
                            document.getElementById("ctl00_MyCPH1_chkoda").checked=false;
                        }
                   }  
                     
              
                }
         }
         
    findobj.send(null);
    }
    
    return true;
   // Citycheck(this);
    
}




/***************************************************************************************************************
                    THIS FUNCTION VALIDATES CITY NAME AND SETS PINCODE
/***************************************************************************************************************/


function conCityTest(cityid,pinid)
{
    var txtcity=document.getElementById(cityid);
    var txtpin=document.getElementById(pinid);
   
    txtcity.value=txtcity.value.toUpperCase();
    
    if(txtcity.value=="")    
        return false;
   
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=city&code=" + txtcity.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert("This City doesn't Exists ");
                        txtcity.select();
                        return false;
                     }

                }
         }
         
    findobj.send(null);
    }
    
   return true;
}


function addItem(ctrl,txt,val)
{ 
    var oOption = document.createElement("OPTION"); 
    oOption.text=txt; 
    oOption.value=val; 
    ctrl.add(oOption); 
}


function otherPinSelect(cmbid,trid,pinid)
{

    var cmb=document.getElementById(cmbid);
    var tr=document.getElementById(trid);
    var txtpin=document.getElementById(pinid);

    if(cmb.value=="O")
        {
            tr.style.display="block";
            
            if(txtpin.style.visibility=="visible" && txtpin.style.display=="block")
                txtpin.focus();
        }
    else
        tr.style.display="none";
        

}


/*****************************************************************************************************************
                                THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
                                    return type XMLHttpObject
*****************************************************************************************************************/
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
   
   


                    
function FreightCalc()
{       
        Form_name="ctl00_MyCPH1_";
        
		var txtfreight=document.getElementById(Form_name+"frieght");
		var txtrate=document.getElementById(Form_name+"rate");
		var txtpkg=document.getElementById(Form_name+"pkg");
		var txtcwt=document.getElementById(Form_name+"cwt");
		
		var service=document.getElementById(Form_name+"service").value;
		var frtrate=document.getElementById(Form_name+"rate").value;
		var ratetype=document.getElementById(Form_name+"ratetype").value;
		
		if (txtfreight.value=="")
		{
		   txtfreight.value="0";
		}		
		
		if (isNaN(txtfreight.value))
		{
		    txtfreight.value="0";
		}
		
		
		if(frtrate=="" || isNaN(frtrate))
		{
		    frtrate="0.00";
		    txtrate.value="0.00";
		}
	
		
		if((service==1)||(service==3))
		{
		    if (ratetype=="P")
			    {
				        if (txtpkg.value !="0" && txtpkg.value!="" )
				         {
				   	            if(client_name=="ASL")
					            {
				                    txtfreight.value = roundit(Math.round(parseFloat(txtrate.value) * parseInt(txtpkg.value),2));
				                }
				                else
				                {
				   	                txtfreight.value = roundit(parseFloat(txtrate.value) * parseInt(txtpkg.value),2);
				                }
				         }
				        else
				         {
				                txtfreight.value = 0;
				         } 
			    }
			    else if (ratetype=="W")
			    {
				        if (txtcwt.value !="0" && txtcwt.value!="" )
				        {
					         if(client_name=="ASL")
					         {
					            txtfreight.value = roundit(Math.round(parseFloat(txtrate.value) * parseInt(txtcwt.value),2));
					         }
					         else
					         {
					            txtfreight.value = roundit(parseFloat(txtrate.value) * parseInt(txtcwt.value));
					         }
				        }
				        else
				        {
				           txtfreight.value = 0;
				        } 
			    }
		} 
		else // TBB DOCKET
		{
		if (ratetype=="P")
			{
				if (txtpkg.value !="0" && txtpkg.value!="")
				 {
				   txtrate.value = roundit(parseFloat(txtfreight.value) / parseInt(txtpkg.value),2)
				 }
				else
				 {
				   txtrate.value =0;
				 } 
			}
			else if (ratetype=="W")
			{
				if (txtcwt.value !="0" && txtcwt.value!="" )
				{
					 txtrate.value = roundit(parseFloat(txtfreight.value) / parseInt(txtcwt.value),2);
				}
				else
				{
				   txtrate.value =0;
				} 
			}
				 
		}
		 //  CHECKING CHARGE WEIGHT APPLICABLE ON BASIS OF CONTRACT TO THAT PARTY
		 var cmbpaybas=document.getElementById("ctl00_MyCPH1_paybas");
		 
								 if(cmbpaybas.value=="P02" || cmbpaybas.value=="P08" || cmbpaybas.value=="P09")
								 {
										var arg_cwt = document.getElementById(Form_name+"cwt").value;
										var min_chrgwt = document.getElementById(Form_name+"min_chrgwt").value;
										
										if (parseFloat(min_chrgwt)>parseFloat(arg_cwt))
										{
											alert("Minimum Charge wt. is " + min_chrgwt + " for this party ");
											txtfreight.value=roundit(parseFloat(document.getElementById(Form_name+"rate").value) * parseInt(min_chrgwt),2);
											txtcwt.value=min_chrgwt;
											quck_validation="N";
										}
										var arg_pkgno=document.getElementById(Form_name+"pkg").value;
										var min_pkgsno=document.getElementById(Form_name+"min_pkgsno").value;
										if (parseFloat(min_pkgsno)>parseFloat(arg_pkgno))
										{
											alert("Minimum Packages is " + min_pkgsno + " for this party ");
											txtfreight.value=roundit(parseFloat(txtrate.value) * parseInt(min_pkgsno),2); 
											txtpkg.value=min_pkgsno;
											quck_validation="N";
										}
										 
										var frieght = parseFloat(txtfreight.value);
										var min_frt = parseFloat(document.getElementById(Form_name+"min_frt").value);
										if (parseFloat(min_frt)>parseFloat(frieght))
										{
											alert("Minimum Feright is " + min_frt + " for this party ");
											txtfreight.value=min_frt;
											quck_validation="N";
										}
										
								}
								
								var hdnfreight=document.getElementById("ctl00_MyCPH1_hdnfreight");
								var hdnfreightrate=document.getElementById("ctl00_MyCPH1_hdnfreightrate");
								//alert()
								hdnfreight.value=txtfreight.value;
								hdnfreightrate.value=txtrate.value;
								
								
		rateTypeBlur();
		Edit_svc_detail();
       return true;	
}
   
function fovRate()
{
      
    var txtfreight=document.getElementById("ctl00_MyCPH1_decl");
    var txtfovrate=document.getElementById("FOV_RATE");
    var txtFOV_decl=document.getElementById("FOV_delc");
    var txtSCHG11=document.getElementById("SCHG11");
    
    if(txtfovrate)
    {
        txtFOV_decl.value = parseFloat(txtfreight.value)*parseFloat(txtfovrate.value)/100;
        if(txtSCHG11)
            txtSCHG11.value = parseFloat(txtfreight.value)*parseFloat(txtfovrate.value)/100;
    }
    
    
    rateTypeBlur();
} 

function rateTypeBlur()
	{
	
	        var subtotal=0.00;
            var dkttotal=0.00;
	        var txtfreight=document.getElementById("ctl00_MyCPH1_frieght");
	        subtotal=subtotal + parseFloat(txtfreight.value);
	        
           
	        var i=1;
	        var a="0";
	        var pref="ctl00_MyCPH1_";
	        var txt;
	        var hdn;
	         
	        for(i=1;i<24;i++)
	        {
            
                if(i<10)
                    a="0" + i;
                else
                    a="" + i;
                   
                    
                if(i==12)
                {
                    txt=document.getElementById("ctl00_MyCPH1_txtcodchrg");
                }
                else
                {
                    txt=document.getElementById("SCHG" + a);
                    hdn=document.getElementById("ctl00_MyCPH1_CHG_SCHG" + a);
                    hdn.value=txt.value;
                }

               
                     if(txt.value=="")
                     {
                        txt.value="0.00";
                        hdn.value="0.00";
                        hdn.value=txt.value;
                     }
                 subtotal=subtotal + parseFloat(txt.value);
	        }
	        
	        for(i=1;i<11;i++)// 10  USER CHARGES HARD CODED
	        {
                if(i<10)
                    a="0" + i;
                else
                    a="" + i;
                    
                txt=document.getElementById("UCHG" + a);
                hdn=document.getElementById("ctl00_MyCPH1_CHG_UCHG" + a);
                
                 if(txt.value=="")
                 {
                     txt.value="0.00";
                     hdn=value="0.00";
                 }
    
                       subtotal=subtotal - parseFloat(txt.value);
	        }
	        
	        var txtsubtotal=document.getElementById("ctl00_MyCPH1_subtotal");
	        txtsubtotal.value=rounditn(subtotal,2);
	        
	        // EDUCATION CESS CALCULATION
	        var srvtax=0.00;
	        var educess=0.00;
	        var heducess=0.00;
	        
	       	 
	        var hdnsrvtax=document.getElementById("ctl00_MyCPH1_hdnstaxrate");
	        var hdneducess=document.getElementById("ctl00_MyCPH1_hdnedurate");
	        var hdnheducess=document.getElementById("ctl00_MyCPH1_hdnhedurate");
	        
	        var txtsrvctax=document.getElementById("ctl00_MyCPH1_stax");
	        var txteducess=document.getElementById("ctl00_MyCPH1_otax");
	        var txtheducess=document.getElementById("ctl00_MyCPH1_hotax");
	        
	        var txtsrvctax_s=document.getElementById("ctl00_MyCPH1_stax_s");
	        var txteducess_s=document.getElementById("ctl00_MyCPH1_otax_s");
	        var txtheducess_s=document.getElementById("ctl00_MyCPH1_hotax_s");

            var cmbtrans=document.getElementById("ctl00_MyCPH1_trans");
            var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_staxpaidby");
            var cmbservice=document.getElementById("ctl00_MyCPH1_service");
        
                
                  if(cmbtrans.value=="2")
                    {
                         if(cmbservice.value=="1" && subtotal > 750)
                         {
	                            srvtax = subtotal * 3/100;
	                            educess = srvtax * parseFloat(hdneducess.value)/100;
	                            heducess = srvtax * parseFloat(hdnheducess.value)/100;
	                            
	                            txtsrvctax.value=Math.round(srvtax);
    	                        txteducess.value=Math.round(educess);
	                            txtheducess.value=Math.round(heducess);
        	                    
	                            if(cmbstaxpaidby.value=="T" || cmbstaxpaidby.value=="Transporter")
            	                {
    	                                txtsrvctax_s.value=Math.round(srvtax);
    	                                txteducess_s.value=Math.round(educess);
    	                                txtheducess_s.value=Math.round(heducess);
            	                }
            	                else
            	                {
            	                    txtsrvctax_s.value="0";
	                                txteducess_s.value="0"
	                                txtheducess_s.value="0";
            	                }
	                     }
	                     else if(cmbservice.value=="2" && subtotal > 1500)// service Tax and subtotal
	                     {
	                         	srvtax = subtotal *3/100;
	                            educess = srvtax * parseFloat(hdneducess.value)/100;
	                            heducess = srvtax * parseFloat(hdnheducess.value)/100;

	                            
	                        txtsrvctax.value=Math.round(srvtax);
    	                    txteducess.value=Math.round(educess);
	                        txtheducess.value=Math.round(heducess);
	                    
	                        if(cmbstaxpaidby.value=="T" || cmbstaxpaidby.value=="Transporter")
            	            {
	                             
    	                            txtsrvctax_s.value=Math.round(srvtax);
    	                            txteducess_s.value=Math.round(educess);
    	                            txtheducess_s.value=Math.round(heducess);
            	            }
            	            else
            	            {
            	                txtsrvctax_s.value="0";
	                            txteducess_s.value="0"
	                            txtheducess_s.value="0";
            	            }
	                    }// service Tax and subtotal
	                    else
	                    {
	                        txtsrvctax.value="0";
    	                    txteducess.value="0";
    	                    txtheducess.value="0";

   	                        txtsrvctax_s.value="0";
	                        txteducess_s.value="0"
	                        txtheducess_s.value="0";
	                    } // service Tax and subtotal
	           }
	           else // trans mode checking
	           {
                         srvtax = subtotal * parseFloat(hdnsrvtax.value)/100;
	                     educess = srvtax * parseFloat(hdneducess.value)/100;
	                     heducess = srvtax * parseFloat(hdnheducess.value)/100;
	                     
	                     txtsrvctax.value=Math.round(srvtax);
	                     txteducess.value=Math.round(educess);
	                     txtheducess.value=Math.round(heducess);
                        
                        if(cmbstaxpaidby.value=="T" || cmbstaxpaidby.value=="Transporter")
            	            {
    	                            txtsrvctax_s.value=Math.round(srvtax);
    	                            txteducess_s.value=Math.round(educess);
    	                            txtheducess_s.value=Math.round(heducess);
            	            }
            	            else
            	            {
            	                txtsrvctax_s.value="0";
	                            txteducess_s.value="0"
	                            txtheducess_s.value="0";
            	            }
                        
	           }
	           
	           
	           // Suffixing Zeros to taxvalues to show in columner format
	           
	                            txtsrvctax_s.value= txtsrvctax_s.value + ".00";
	                            txteducess_s.value=txteducess_s.value + ".00";
	                            txtheducess_s.value=txtheducess_s.value + ".00";
	           

        // BECAUSE THE TEXT BOXES ARE EDITABLE COUNTS FROM TEXT BOXES
        dkttotal=subtotal + parseFloat(txtsrvctax_s.value) + parseFloat(txteducess_s.value) + parseFloat(txtheducess_s.value);

        var txttotal=document.getElementById("ctl00_MyCPH1_total");
        txttotal.value=rounditn(dkttotal,2);
	}
	
	

function SubmitData()
{			
     Onchange_chrgwt();
     Form_name="ctl00_MyCPH1_";
     document.getElementById(Form_name+"DocketMode").value=="F";
   
 			// mode DECIDES WHERE THE WE ARE EDITIN DOCKET OR ADDING NEW DOCKET
 			var mode=document.getElementById(Form_name+"hdnmode");
 			
			    if (document.getElementById(Form_name+"dockno").value=="")
			    {
				    alert("Please enter the <%=sdkt_call %> No.");
				    document.getElementById(Form_name+"dockno").focus();
				    return false;
			    }
    			
			    if (document.getElementById(Form_name+"dockno").value!="" && document.getElementById(Form_name+"validation_chk").value=="<%=sdkt_call %> is in Use or Not in Series or Invalid <%=sdkt_call %>  :()")
			    {
			        alert("<%=sdkt_call %> is in Use or Not in Series or Invalid <%=sdkt_call %>  :()");
			        document.getElementById(Form_name+"dockno").focus();
			        return false;
			    }
			    if (document.getElementById(Form_name+"dockno").value!="" && document.getElementById(Form_name+"validation_chk").value=="Docket is in Use or Not in Series or Invalid Docket")
			    {
			        alert("<%=sdkt_call %> is in Use or Not in Series or Invalid <%=sdkt_call %>  :()");
			        document.getElementById(Form_name+"dockno").focus();
			        return false;
			    }
		    //} // mode ENDED
		    
		    
		      // FROM AND TO LOCATION ACCORDINGLY SERVICE TYPE
                var srvcmb=document.getElementById(Form_name+"service");
              if(srvcmb.value=="0")
                {
                    alert("Select Service Type..");
                    srvcmb.focus();
                }
              else
                {
                    if(srvcmb.value=="2")
                    {
                        if(document.getElementById(Form_name+"destfrom").value=="")
                            {
                                alert("Enter From Location...");
                                document.getElementById(Form_name+"destfrom").focus();
                                return false;
                            }
                        if(document.getElementById(Form_name+"destto").value=="")
                            {
                                alert("Enter To Location...");
                                document.getElementById(Form_name+"destto").focus();
                                return false;
                            }
                    }
                }
		    
			dktno=document.getElementById(Form_name+"dockno").value;
			
			var cmbpaybas=document.getElementById("ctl00_MyCPH1_paybas");
			if (cmbpaybas.value=="" || cmbpaybas.value=="0")
			{
				alert("Please select Payment Type.");
				cmbpaybas.focus();
				return false;
			}
		   
			if(document.getElementById(Form_name+"dockdt").value=="")
			{
				alert("Please enter <%=sdkt_call %> Date.");		
				document.getElementById(Form_name+"dockdt").focus();
				return false;     
			}
				
					   
			var dockdt=document.getElementById(Form_name+"dockdt").value;
		
			dockdt_dd=dockdt.substring(0,2);
			dockdt_mm=parseInt(dockdt.substring(3,5));
			dockdt_yy=dockdt.substring(6,10);
	
			var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
			
			var dt =dockdt;
			var dt =document.getElementById(Form_name+"dockdt").value;
			var dt_dd=dt.substring(0,2);
			var dt_mm=dt.substring(3,5);
			
			var dt_yy=dt.substring(6,10);
             
			dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy));
			
			var dock_dt_dd=dock_dt.substring(0,2);
			var dock_dt_mm=dock_dt.substring(3,5);
			
			var dock_dt_yy=dock_dt.substring(6,10);
             
			dock_dt=new Date(months[parseFloat(dock_dt_mm)] + " " + parseFloat(dock_dt_dd) + ", " + parseFloat(dock_dt_yy));
		   
			if (dt>dock_dt)
			{
					alert( "<%=sdkt_call %> date should not be greater than today's date !!!");
					document.getElementById(Form_name+"dockdt").focus();
					return false;
			}
			
		    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
			if(hdnclient.value=="RLL")
            {
			//************RLl date range validation********
			var Rll_limit_dt="01/02/2008";
			var Rll_limit_dt_dd=Rll_limit_dt.substring(0,2);
			var Rll_limit_dt_mm=Rll_limit_dt.substring(3,5);
			
			var Rll_limit_dt_yy=Rll_limit_dt.substring(6,10);
           
            
			    Rll_limit_dt=new Date(months[parseFloat(Rll_limit_dt_mm)] + " " + parseFloat(Rll_limit_dt_dd) + ", " + parseFloat(Rll_limit_dt_yy));
		       // alert(Rll_limit_dt)
			    if (dt<Rll_limit_dt)
			    {
					    alert( "<%=sdkt_call %> date should not be less than 01 Feb 2008 !!!");
					    document.getElementById(Form_name+"dockdt").focus();
					    return false;
			    }
			}
			//********************************************
			
			
			
			var servdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");
                                                    
		
			if (document.getElementById(Form_name+"destn").value=="")
			{
				alert("Please enter Destination.");
				document.getElementById(Form_name+"destn").focus();
				return false;
			}

			if (document.getElementById(Form_name+"cboPickupDely").value=="")
			{
				alert("Please select pickup/delivery option.");//Service
				document.getElementById(Form_name+"cboPickupDely").focus();
				return false;
			}
			if(cmbpaybas.value=="P02")//&&("<%=mode%>"=="2")
			{
				if (document.getElementById(Form_name+"fincmplbr").value=="")
				{
					alert("Please enter Billed At.");//Service
					document.getElementById(Form_name+"fincmplbr").focus();
					return false;
				}
			}
			if(document.getElementById(Form_name+"destfrom").value!="")
			{
			    if (document.getElementById(Form_name+"destfrom").value==document.getElementById(Form_name+"destto").value)
                   {
                        alert("From And TO Location Should Not Same");
                        document.getElementById(Form_name+"destto").focus();
                        return false;
                   }
             }
             
			if (document.getElementById(Form_name+"chkoda").checked==false)
            {
               if (document.getElementById(Form_name+"Orgn").value==document.getElementById(Form_name+"destn").value)
               {
                   if(document.getElementById(Form_name+"destto").value=="")
                   {
                    alert("Plz Enter TO Location");
                    document.getElementById(Form_name+"destto").focus();
                    return false;
                   }
               }
            }
            
            
            // IF DOCKET IS LOCAL TO ANY ONE CONTROL LOCATION THEN CHECK IS PERFORMED
			if(hdnclient.value!="ASL")
			{
			    if (document.getElementById(Form_name+"local_yn"))
                {
                   if (document.getElementById(Form_name+"Orgn").value!=document.getElementById(Form_name+"destn").value && document.getElementById(Form_name+"local_yn").checked==true)
                   {
                    alert("For The Local <%=sdkt_call %> Origin And Destination Shuold be Same")
                    document.getElementById(Form_name+"destn").focus();
                    return false;
                   }
                   if (document.getElementById(Form_name+"cboPickupDely").value!="3" && document.getElementById(Form_name+"local_yn").checked==true)
			        {
				        alert("For The Local <%=sdkt_call %> PLz Select Door Pickup - Door Delivery")//Service
				        document.getElementById(Form_name+"cboPickupDely").focus();
				        return false;
			        }
                }// Local CN check
             }
            
            
            
			//Consignor /Consignee validations starts here
			if(cmbpaybas.value=="P02")//TBB Check
			{
				if (document.getElementById(Form_name+"consignor_name_B").value=="")
			   	 {
			   	   alert("Please enter the 'Consignor Code'")
			   	   document.getElementById(Form_name+"consignor_name_B").focus();
			   	   return false;
			   	 }
			
			   	if(cmbpaybas.value=="P02")//&&("<%=mode%>"=="2")
				{
					if ((document.getElementById(Form_name+"consignor_Bill").value==""))
			   		 {
			   		   alert("Please select the 'Billing Party'")
			   		   document.getElementById(Form_name+"consignor_Bill").focus();
			   		   return false;
			   		 }
			   		 if (document.getElementById(Form_name+"consignor_Bill").value!="" && document.getElementById(Form_name+"validation_chk").value=="Invalid Party Code!!!")
			          {
			
			            alert("Invalid Party Code !!!")
			            document.getElementById(Form_name+"consignor_Bill").focus();
			            return false;
			          }
			   	}	 
			}
			else
			{
				if (document.getElementById(Form_name+"consignor_name_B").value=="" && document.getElementById(Form_name+"consignor_name").value=="")
			   	 {
			   	   alert("Please select/enter the 'Consignor'")
			   	   document.getElementById(Form_name+"consignor_name_B").focus();
			   	   return false;
			   	 }
			   	 if (document.getElementById(Form_name+"consignor_name_B").value=="")
				 {  
					if(document.getElementById(Form_name+"consignor_add").value=="")
					 {
					  alert("Please enter the 'Consignor's Address'");
					  document.getElementById(Form_name+"consignor_add").focus();
					  return false;
					 }


					if(document.getElementById(Form_name+"consignor_city").value=="")
					 {
					  alert("Please enter the 'Consignor's City'");
					  document.getElementById(Form_name+"consignor_city").focus();
					  return false;
					 }

                    if(document.getElementById(Form_name+"consignor_telno").value=="")
					 {
					     alert("Please enter the 'Consignor's Phone'");
					  document.getElementById(Form_name+"consignor_telno").focus();
					  return false;
					 }
					if(document.getElementById(Form_name+"consignor_telno").value=="")
					 {
						if (isNaN(document.getElementById(Form_name+"consignor_telno").value))
						 {
						  alert("Please enter the 'Consignor's Phone.' in numeric");
						  document.getElementById(Form_name+"consignor_telno").focus();
						  return false;
						 }
					 }
					 
					if(document.getElementById(Form_name+"consignor_pin").value=="")
					 {
					    alert("Please enter the 'Consignor's Pincode.'");
					    document.getElementById(Form_name+"consignor_pin").focus();
					   return false;
					 }
					 

					if (isNaN(document.getElementById(Form_name+"consignor_pin").value))
					 {
					  alert("Please enter the 'Consignor's Pincode.' in numeric");
					  document.getElementById(Form_name+"consignor_pin").focus();
					  return false;
					 }
				}
			}
			
			
			if(cmbpaybas.value=="P06")//Topay billing check
			{
				if (document.getElementById(Form_name+"consignee_name_B").value=="")
			   	 {
			   	   alert("Please select the 'Consignee'")
			   	   document.getElementById(Form_name+"consignee_name_B").focus();
			   	   return false;
			   	 }
			}		
							
			else
			{
				if (document.getElementById(Form_name+"consignee_name_B").value=="" && document.getElementById(Form_name+"consignee_name").value=="")
			   	 {
			   	   alert("Please select/enter the 'Consignee'")
			   	   document.getElementById(Form_name+"consignee_name_B").focus();
			   	   return false;
			   	 }
				if (document.getElementById(Form_name+"consignee_name_B").value=="")
				{
					if(document.getElementById(Form_name+"consignee_name").value=="")
					{
					   alert("Please enter the 'Consignee '")
					   document.getElementById(Form_name+"consignee_name").focus();
					   return false;
					}

					if(document.getElementById(Form_name+"consignee_add").value=="")
					 {
					  alert("Please enter the 'Consignee's Address'");
					  document.getElementById(Form_name+"consignee_add").focus();
					  return false;
					 }
					
					if(document.getElementById(Form_name+"consignee_city").value=="")
					 {
					  alert("Please enter the 'Consignee's City'");
					  document.getElementById(Form_name+"consignee_city").focus();
					  return false;
					 }
					 				 
					if(document.getElementById(Form_name+"consignee_telno").value=="")
					 {
					
					  alert("Please enter the 'Consignee's Phone.'");
					   document.getElementById(Form_name+"consignee_telno").focus();
					  return false;
					 }
					if(document.getElementById(Form_name+"consignee_telno").value=="")
					 {
						if (isNaN(document.getElementById(Form_name+"consignee_telno").value))
						 {
						  alert("Please enter the 'Consignee's Phone.' in numeric");
						   document.getElementById(Form_name+"consignee_telno").focus();
						  return false;
						 }
					 }

					if(document.getElementById(Form_name+"consignee_pin").value=="")
					 {
					  alert("Please enter the 'Consignee's Pincode.'");
					  document.getElementById(Form_name+"consignee_pin").focus();
					  return false;
					 }

					if (isNaN(document.getElementById(Form_name+"consignee_pin").value))
					 {
					  alert("Please enter the 'Consignee's Pincode.' in numeric");
					  document.getElementById(Form_name+"consignee_pin").focus();
					  return false;
					 }
				
			    }	 
			}
			
			
				if(document.getElementById("ctl00_MyCPH1_ins_0").checked==false && document.getElementById("ctl00_MyCPH1_ins_1").checked==false)
				{
					alert("Please select the Risk type")
					document.getElementById("ctl00_MyCPH1_ins_0").focus();
					return false;
				}
				
				if((document.getElementById("ctl00_MyCPH1_ins_0").checked==true))// ||||(ins[0].checked==true) 
				 {
				   						
				 }
								  	

				if(document.getElementById(Form_name+"modvat").checked==1)
				 {
								      
				  if(document.getElementById(Form_name+"totmodvat").value=="")
				   {
				    alert("Please enter the 'No. of MODVAT Covers'")
				    document.getElementById(Form_name+"totmodvat").focus();
				    return false;
				   }


				  if (isNaN(document.getElementById(Form_name+"totmodvat").value))
				   {
				    alert("Please enter the 'No. of MODVAT Covers' in Numeric")
				    document.getElementById(Form_name+"totmodvat").focus();
				    return false;
				   }

				  if (document.getElementById(Form_name+"totmodvat").value.indexOf(".")!=-1)
				   {
				    alert("Decimal value is not allowed")
				    document.getElementById(Form_name+"totmodvat").focus();
				    return false;
				   }
								    
				   if (parseFloat(document.getElementById(Form_name+"totmodvat").value)<=0)
				   {
				    alert("'No. of MODVAT Covers' should be greate than ZERO.")
				    document.getElementById(Form_name+"totmodvat").focus();
				    return false;
				   }
								    
				}

				if (document.getElementById(Form_name+"covers").value!="")
				{
				  if (isNaN(document.getElementById(Form_name+"covers").value))
				  {
				    alert("Please enter the 'No. of Internal Covers' in Numeric")
				    document.getElementById(Form_name+"covers").focus();
				    return false;
				  }
								    
				  if (document.getElementById(Form_name+"covers").value.indexOf(".")!=-1)
				  {
				    alert("Decimal value is not allowed")
				    document.getElementById(Form_name+"covers").focus();
				    return false;
				  }
								    
				   if (parseFloat(document.getElementById(Form_name+"covers").value)<0)
				   {
				    alert("'No. of Internal Covers' should be greate than/equals to ZERO.")
				    document.getElementById(Form_name+"covers").focus();
				    return false;
				   }

				}
					
			//Permit Check starts here
			document.getElementById(Form_name+"txtpermit_yn").value="No"
			if(document.getElementById(Form_name+"permit_yn").checked==1)
			 {
				 document.getElementById(Form_name+"txtpermit_yn").value="Yes"
					
				 
				  if(document.getElementById(Form_name+"permit_recvd_at").value=="")
				  {
				    alert("Please enter the 'Permit Received At'")
				    document.getElementById(Form_name+"permit_recvd_at").focus();
				    return false;
				  }
				  
				 if(document.getElementById(Form_name+"permit_recvd_at").value=="B")
				  {
				    				      
						  if(document.getElementById(Form_name+"permitno").value=="")
				           {
				                alert("Please enter the 'Permit No.'")
				                document.getElementById(Form_name+"permitno").focus();
				                return false;
				            }
						  if(document.getElementById(Form_name+"permitdt").value=="")
						   {
							alert("Please enter the 'Permit Date'")
							document.getElementById(Form_name+"permitdt").focus();
							return false;
						   }
						  
 					      if(document.getElementById(Form_name+"permit_val_dt").value=="")
						   {
							alert("Please enter the 'Permit Validity Date'")
							document.getElementById(Form_name+"permit_val_dt").focus();
							return false;
						   }
						    //******for date valiation ***********
						   
						    var dt =dockdt
							var dt_dd=dt.substring(0,2)
							var dt_mm=dt.substring(3,5)
							var dt_yy=dt.substring(6,10)
							
						    dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
						
							var Pt=document.getElementById(Form_name+"permit_val_dt").value
							var Pt_dd=Pt.substring(0,2)
							var Pt_mm=Pt.substring(3,5)
							var Pt_yy=Pt.substring(6,10)
						    
						    Pt=new Date(months[parseFloat(Pt_mm)] + " " + parseFloat(Pt_dd) + ", " + parseFloat(Pt_yy))
						
							if (Pt<dt)
							{
									alert( "'Permit Validity Date'' date should not be less than <%=sdkt_call %> date !!!")
									document.getElementById(Form_name+"permit_val_dt").focus();
									return false;
							}
		
						var diff=MyDateDiff(dt,Pt,'d',0)
						if(parseInt(diff)<3)
						{
									alert( "'Permit Validity Date'' date should  be More than  3 days of <%=sdkt_call %> date !!!")
									document.getElementById(Form_name+"permit_val_dt").focus();
									return false;
						}
							
						  if(document.getElementById(Form_name+"permit_recvd_at").value=="B")
						  {
								if(document.getElementById(Form_name+"permit_recvd_dt").value=="")
								{
								 alert("Please enter the 'Permit received Date'")
								 document.getElementById(Form_name+"permit_recvd_dt").focus();
								 return false;
								}
						  }
				}
				else
				{
					document.getElementById(Form_name+"permitdt").value=""
					document.getElementById(Form_name+"permit_recvd_dt").value=""
					document.getElementById(Form_name+"permit_val_dt").value=""
				}
			}
			else
			{
				document.getElementById(Form_name+"permit_recvd_at").value="";
				document.getElementById(Form_name+"permitdt").value="";
				document.getElementById(Form_name+"permit_recvd_dt").value="";
			}
			
			if(!fnInvoiceDetail())
				return false;
		
            // SERVICE RELATED THINGS
			if(document.getElementById(Form_name+"service").value==1 && cmbpaybas.value!="P04")
			{
			   if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
				{
				   alert("Actual Weight should be greater than ZERO");
				   return false;
				}	
			}	
			

          
                
        var completion_mode="N";
        
		if(completion_mode!="Y")
		{
				if (document.getElementById(Form_name+"trans").value!="2")
				{
					if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
					{
					   alert("Actual Weight should be greater than ZERO");
					   document.getElementById(Form_name+"actwt").focus();
					   return false;
					}
					if (parseInt(document.getElementById(Form_name+"cwt").value)<=0)		
					{
					   alert("Charge Weight should be greater than ZERO");
					   document.getElementById(Form_name+"cwt").focus();
					   return false;
					}
				 }
		}
		else
		{
			    if (quck_validation!="N")
			    {
						if(parseInt(document.getElementById(Form_name+"pkg").value)!=argPkgs)
						{
							alert("Total Pkgs does not match with Pkgs entered at Quick Entry..");
							return false;
						}
		
				}		
				if (parseInt(document.getElementById(Form_name+"awt").value)<=0)		
				{
				   alert("Actual Weight should be greater than ZERO");
				   document.getElementById(Form_name+"awt").focus();
				   return false;
				}
				if(parseInt(document.getElementById(Form_name+"awt").value)!=argActWt)
				{
					alert("Total Actual Wt does not match with Actual Wt. entered at Quick Entry ")
					return false;	
				}
		
				if(Trim(document.getElementById(Form_name+"cwt").value)=='' || isNaN(document.getElementById(Form_name+"cwt").value))
				{
					alert("Charge Wt. in Invalid or Empty ")
					document.getElementById(Form_name+"cwt").focus();
					return false;
				} 
				else 
				{
					if(parseInt(document.getElementById(Form_name+"cwt").value)<parseInt(document.getElementById(Form_name+"awt").value))
					{
						alert("Charged Wt. < Actual Wt. ");
						document.getElementById(Form_name+"cwt").focus();
						return false;
					}
				}
	        }
	        
	        if(document.getElementById(Form_name+"pkgtyp").value=="")
        	 {
        		    alert("Please select the 'Package Type'");
        		    document.getElementById(Form_name+"pkgtyp").focus();
        		    return false;
        	 }
			
		  if(document.getElementById(Form_name+"prod").value=="")
		   {
		        alert("Please select the 'Product'");
		        document.getElementById(Form_name+"prod").focus();
		        return false;
		   }

			
			var spl_inst;
			spl_inst =parseInt(document.getElementById(Form_name+"spl_inst").value.length);
			if (spl_inst>250)
			{
			  alert("'Special Service Requirement' Exceeds 250 characters.");
			  document.getElementById(Form_name+"spl_inst").focus();
			  return false;
			}
			if (document.getElementById(Form_name+"service").value=="")
			{
				alert("Please select Service Type.");//Service
				document.getElementById(Form_name+"service").focus();
				return false;
			}
		
		
			if((document.getElementById(Form_name+"trans").value=="1")||(document.getElementById(Form_name+"trans").value=="3"))
			{
				document.getElementById(Form_name+"service").selectedIndex=0;
				document.getElementById(Form_name+"service_ftl").selectedIndex=0;
			}
	
			if (document.getElementById(Form_name+"service").value=="2")
			{
				if (document.getElementById(Form_name+"service_ftl").value=="")
					{
						alert("Please select Type of FTL");
						document.getElementById(Form_name+"service_ftl").focus();
						return false;
					}
				if ((document.getElementById(Form_name+"service_ftl").value=="By Weight") && (parseInt(document.getElementById(Form_name+"awt").value)<=0)&&(cmbpaybas.value!="P04"))
					{
						alert("If type of FTL is 'By Weight', Weight cannot be zero");
						document.getElementById(Form_name+"service_ftl").focus();
						return false;
					}	
			}

					if(cmbpaybas.value!="P04") 
		   			{
							if (document.getElementById(Form_name+"staxpaidby").value=="")
		   					 {
		   					   alert("Please select the 'Service Tax Paid By'");
		   					   document.getElementById(Form_name+"staxpaidby").focus();
		   					   return false;
		   					 }
							 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="1"))
		   					 {
		   					     alert("For Air Service Tax paid by Transporter only.'")
		   					     document.getElementById(Form_name+"staxpaidby").focus();
		   					     return false;
								 
		   					 }
							 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="3"))
		   					 {
		   					     alert("For Train Service Tax paid by Transporter only.'")
		   					     document.getElementById(Form_name+"staxpaidby").focus();
		   					     return false;
								 
		   					 }
							 if((document.getElementById(Form_name+"staxpaidby").value!="Transporter")&&(document.getElementById(Form_name+"trans").value=="4"))
		   					 {
		   					     alert("For Express Service Tax paid by Transporter only.'")
		   					     document.getElementById(Form_name+"staxpaidby").focus();
		   					     return false;
		   					 }
					}
    				else
					{
						document.getElementById(Form_name+"staxpaidby").selectedIndex=0;
						document.getElementById(Form_name+"staxregno").value="";
					}
					
					
					var dockdt=document.getElementById(Form_name+"dockdt").value
		
		    	var dt =dockdt
				
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =document.getElementById(Form_name+"txtDelyDt").value
		       
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
				
			 dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		     var EDD_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
		      
		      if (dt>EDD_dt)
				{
			        alert( "Expected Delievry Date should not be less than <%=sdkt_call %> date !!!")
			        document.getElementById(Form_name+"txtDelyDt").focus();
			        return false;
				}
                
                    
                    var txtfreight=document.getElementById("ctl00_MyCPH1_frieght");
					if(txtfreight.value==0 &&cmbpaybas.value!="P04")
					{
					     alert("Freight charge should be greater than zero");
					     txtfreight.focus();
					     return false;
					}
					
					
		var txtdockettotal=document.getElementById("ctl00_MyCPH1_total");
		if(txtdockettotal.value=="" || parseFloat(txtdockettotal.value)==0)
		{
		    alert("<%=sdkt_call %> Total can't be Zero....Please change Information....");
		    return false;
		}
					
					            
	    document.getElementById(Form_name+"hdnfreight").value=document.getElementById(Form_name+"frieght").value;
	    document.getElementById(Form_name+"hdnfreightrate").value=document.getElementById(Form_name+"rate").value;
								
		var txtrate=document.getElementById(Form_name+"rate");
        document.getElementById(Form_name+"subtotal").disabled = false;
        document.getElementById(Form_name+"dockno").disabled = false;
        document.getElementById(Form_name+"total").disabled = false;
		return true;
}
 </script>
