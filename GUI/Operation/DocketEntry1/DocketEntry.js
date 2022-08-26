// JScript File

var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
// ON BLUR OF FREIGHT  CHARGE



function validateStep2()
{

    // CHECKING IF AJAX IS OPERATING OR NOT
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    if(hdnajaxstate.value!="0")
	    {
	        alert("Let the internal process over...Try after 5-10 Seconds...");
	        return false;
	    }

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    
    var cmbpickupdel = document.getElementById("ctl00_MyCPH1_cmbpickupdel");
    var cmbtransmode = document.getElementById("ctl00_MyCPH1_cmbtransmode");
    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbftltype = document.getElementById("ctl00_MyCPH1_cmbftltype");
    var cmbpacktype = document.getElementById("ctl00_MyCPH1_cmbpacktype");
    var cmbprodtype = document.getElementById("ctl00_MyCPH1_cmbprodtype");
    var cmbbusinesstype = document.getElementById("ctl00_MyCPH1_cmbbusinesstype");
    var cmbloadtype = document.getElementById("ctl00_MyCPH1_cmbloadtype");

    if(cmbpickupdel.value=="0")    
    {
        alert("Please Select PickUp/Delivery Type....");
        cmbpickupdel.focus();
        return false;
    }
    
    if(cmbtransmode.value=="0")    
    {
        alert("Please Select Transport Mode....");
        cmbtransmode.focus();
        return false;
    }


    if(cmbservicetype.value=="0")    
    {
        alert("Please Select Service Type....");
        cmbservicetype.focus();
        return false;
    }



    if(cmbftltype.value=="0" && cmbservicetype.value=="2")    
    {
        alert("Please Select FTL Type....");
        cmbftltype.focus();
        return false;
    }


    if(cmbpacktype.value=="0")    
    {
        alert("Please Select Packaging Type....");
        cmbpacktype.focus();
        return false;
    }

    if(cmbprodtype.value=="0")    
    {
        alert("Please Select Product Type....");
        cmbprodtype.focus();
        return false;
    }
//    var txtProdType = document.getElementById('ctl00_MyCPH1_' + 'txtProdType');
//    if (cmbprodtype.options[cmbprodtype.selectedIndex].text.toUpperCase() == "OTHERS" && txtProdType.value.trim() == "") {
//        alert("Please Enter Said To Contains");
//        txtProdType.focus();
//        return false;
//    }

    if(cmbbusinesstype.value=="0")    
    {
        alert("Please Select Business Type....");
        cmbbusinesstype.focus();
        return false;
    }
    
    
    // CLIENT SPECIFIC VALIDATION
    
    var hdnflagloadtype=document.getElementById("ctl00_MyCPH1_hdnflagloadtype");
    var hdnflagmultipickup=document.getElementById("ctl00_MyCPH1_hdnflagmultipickup");
    
        if(hdnflagloadtype.value=="Y")
        {
            if(cmbloadtype.value=="0")    
            {
                alert("Please Select Load Type....");
                cmbloadtype.focus();
                return false;
            }
        }    
        
        if(hdnflagmultipickup.value=="Y")
        {
            var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
            var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
            var txtsourcedockno=document.getElementById("ctl00_MyCPH1_txtsourcedockno");
            
            if(chkmultipickup.checked==true || chkmultidelivery.checked==true)
            {
                if(txtsourcedockno.value=="")
                {
                    alert("Please Enter Source Docket Number");
                    txtsourcedockno.focus();
                    return false;
                }
            }
        }
    

  
    
    
    //Checking from and to city if Docket is Local
    
    var chklocal=document.getElementById("ctl00_MyCPH1_chklocal");
    var txtfrom=document.getElementById("ctl00_MyCPH1_txtfrom");
    var txtto=document.getElementById("ctl00_MyCPH1_txtto");
    
    var lblorgnloc=document.getElementById("ctl00_MyCPH1_lblorgnloc");
    var txtdelloc=document.getElementById("ctl00_MyCPH1_txtdelloc");
    
	if(cmbbusinesstype.value =="3")
	{
		if(txtfrom.value == "")
		{
			alert("Please Enter From City");
			txtfrom.focus();
			return false;
		}

		if(txtto.value == "")
		{
			alert("Please Enter To City");
			txtto.focus();
			return false;
		}

	}

    
    if(chklocal.checked==true || lblorgnloc.innerText==txtdelloc.value)
    {
        if(txtfrom.value=="")
         {
            alert("Enter From City....");
            txtfrom.select();
            return false;
         }
         
        if(txtto.value=="")
         {
            alert("Enter To City....");
            txtto.select();
            return false;
         }
         
    }
    
    if(txtfrom.value!="" && txtto.value!="")
    {
        if(txtfrom.value==txtto.value)
        {
            alert("From and To City can't be Same...");
            txtto.focus();
            return false;
        }
    }
    if(cmbservicetype.value=="2")
    {
        if(txtto.value=="")
         {
            alert("Enter To City....");
            txtto.select();
            return false;
         }
    }
    return true;
}



function paymentClick()
	{
	
	 var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
     if(hdnajaxstate.value!="0")
     {
        alert("Let the internal process over...Try after 5-10 Seconds...");
        return false;
     }
	 
	
        if(!validateCSGN())
            return false;
	        
        if(!validateCSGE())
            return false;
    
        
	    if(!validateDocDetails())
	        return false;

	    if(!validatePermitDetails())
	        return false;
	        
	     if(!validateInvoiceDetails())
	        return false;    
	    
	    return true;
    }



function validateCSGN()
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    if(hdnajaxstate.value!="0")
    {
        alert("Let the internal process over...Try after 5-10 Seconds...");
        return false;
    }

    // Consignor Validations
    var txtcsgncd=document.getElementById("ctl00_MyCPH1_txtcsgncd");
    var txtcsgnname=document.getElementById("ctl00_MyCPH1_txtcsgnname");
    var txtcsgnaddress=document.getElementById("ctl00_MyCPH1_txtcsgnaddress");
    var txtcsgncity=document.getElementById("ctl00_MyCPH1_txtcsgncity");
    var txtcsgnpin=document.getElementById("ctl00_MyCPH1_txtcsgnpin");
    var txtcsgnphone=document.getElementById("ctl00_MyCPH1_txtcsgnphone");
    var hdnflagmstrcsgn=document.getElementById("ctl00_MyCPH1_hdnflagmstrcsgn");
    var optpartycsgn=document.getElementById("ctl00_MyCPH1_optpartycsgn");
    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");

    if(hdnflagmstrcsgn.value=="Y" )
    {
        if(cmbpaybas.value=="P02")
        {
            if(optpartycsgn.checked == true)
            {
                if(txtcsgncd.value=="")
                {
                    alert("Please Enter Consignor Code and Name...");
                    txtcsgncd.focus();
                    return false;
                }
            }
        }
        else
        {
            if(txtcsgncd.value=="")
            {
                alert("Please Enter Consignor Code and Name...");
                txtcsgncd.focus();
                return false;
            }
        }
        
    }
    
    if(txtcsgncd.value=="")
    {
        if(txtcsgnname.value=="")
        {
            alert("Please Enter Consignor Name...");
            txtcsgnname.select();
            return false;
        }
        
        
         var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
    if(hdnclient.value!="RITCO")
    {
        if(txtcsgnaddress.value=="")
        {
            alert("Please Enter Consignor Address...");
            txtcsgnaddress.select();
            return false;
        }
        
        if(txtcsgncity.value=="")
        {
            alert("Please Enter Consignor City...");
            txtcsgncity.select();
            return false;
        }
        
        if(txtcsgnpin.value=="")
        {
            alert("Please Enter Consignor PinCode...");
            txtcsgnpin.select();
            return false;  
        }
        
        if(txtcsgnpin.value.length!=6)
        {
            alert("Please Enter valid Consignor Pincode.");
            txtcsgnpin.select();
            txtcsgnpin.focus();
            return false;
        }
        
        if(txtcsgnphone.value=="")
        {
            alert("Please Enter Consignor Phone Number...");
            txtcsgnphone.select();
            return false;
        }
      }
    }
    return true;
}

function validateCSGE()
{
    // Consignee Validations
    var txtcsgecd=document.getElementById("ctl00_MyCPH1_txtcsgecd");
    var txtcsgename=document.getElementById("ctl00_MyCPH1_txtcsgename");
    var txtcsgeaddress=document.getElementById("ctl00_MyCPH1_txtcsgeaddress");
    var txtcsgecity=document.getElementById("ctl00_MyCPH1_txtcsgecity");
    var txtcsgepin=document.getElementById("ctl00_MyCPH1_txtcsgepin");
    var txtcsgephone=document.getElementById("ctl00_MyCPH1_txtcsgephone");
    var hdnflagmstrcsge=document.getElementById("ctl00_MyCPH1_hdnflagmstrcsge");
    var optpartycsge=document.getElementById("ctl00_MyCPH1_optpartycsge");
    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");

    if(hdnflagmstrcsge.value=="Y")
    {
        if(cmbpaybas.value=="P02")
        {
            if(optpartycsge.checked == true)
            {
                if(txtcsgecd.value=="")
                {
                    alert("Please Enter Consignee Code and NameE...");
                    txtcsgecd.focus();
                    return false;
                }
            }
        }
        else 
        {
            if(txtcsgecd.value=="")
            {
                alert("Please Enter Consignee Code and Nameyu...");
                txtcsgecd.focus();
                return false;
            }
        }   
    }
    
    if(txtcsgecd.value=="")
    {
        if(txtcsgename.value=="")
        {
            alert("Please Enter Consignee Name...");
            txtcsgename.select();
            return false;
        }
        
         var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
    if(hdnclient.value!="RITCO")
    {
        if(txtcsgeaddress.value=="")
        {
            alert("Please Enter Consignee Address...");
            txtcsgeaddress.select();
            return false;
        }
        
        if(txtcsgecity.value=="")
        {
            alert("Please Enter Consignee City...");
            txtcsgecity.select();
            return false;
        }
        
        if(txtcsgepin.value=="")
        {
            alert("Please Enter Consignee PinCode...");
            txtcsgepin.select();
            return false;  
        }
        
        if(txtcsgepin.value.length!=6)
        {
            alert("Please Enter valid Consignee Pincode.");
            txtcsgepin.select();
            txtcsgepin.focus();
            return false;
        }
        
        if(txtcsgephone.value=="")
        {
            alert("Please Enter Consignee Phone Number...");
            txtcsgephone.select();
            return false;
        }
      }
    }
    
return true;
}


function validatePermitDetails()
{
    var chkpermit=document.getElementById("ctl00_MyCPH1_chkpermit");
    var cmbpermitrecvdat = document.getElementById("ctl00_MyCPH1_cmbpermitrecvdat");
    var txtpermitno=document.getElementById("ctl00_MyCPH1_txtpermitno");
    var txtpermitdate=document.getElementById("ctl00_MyCPH1_txtpermitdate");
    var txtpermitvaldate=document.getElementById("ctl00_MyCPH1_txtpermitvaldate");
    var txtpremitrecvddate=document.getElementById("ctl00_MyCPH1_txtpermitrecvddate");
    
    if(chkpermit.checked==true)
    {
        if(cmbpermitrecvdat.value=="0")
        {
            alert("Please Select Permit Recieved At.....");
            cmbpermitrecvdat.focus();
            return false;
        }
        
        if(txtpermitno.value=="")
        {
            alert("Please Enter Permit Numebr .....");
            txtpermitno.select();
            return false;
        }
        
        if(txtpermitdate.value=="")
        {
            alert("Please Enter Permit Date .....");
            txtpermitdate.select();
            return false;
        }
        
        if(txtpermitvaldate.value=="")
        {
            alert("Please Enter Permit Validity Date .....");
            txtpermitvaldate.select();
            return false;
        }
        
        if(txtpremitrecvddate.value=="")
        {
            alert("Please Enter Permit Recieved Date .....");
            txtpremitrecvddate.select();
            return false;
        }
    } // check of permit ENDS HERE
    return true;
}

function validateDocDetails()
{
    var grid=document.getElementById("ctl00_MyCPH1_grvdoc");
    if(grid)
    {
        var rws=grid.rows.length;
        for(var i=2;i<rws+1;i++)
        {
            var pref="";
            
            if(i<10)
                pref="ctl00_MyCPH1_grvdoc_ctl0" + i + "_";
            else
                pref="ctl00_MyCPH1_grvdoc_ctl" + i + "_";
                
            
            var txtdocno=document.getElementById(pref + "txtdocumentno");
            if(txtdocno.value=="")
            {
                alert("Please Enter Document Number....");
                txtdocno.select();
                return false;
            }
        }
    }
    return true;
}



// WHETHER PERMIT IS SELECTED OR NOT
function permitCheck()
	{
	
	    var tblpermit=document.getElementById("ctl00_MyCPH1_tblpermit");
	    var chk=document.getElementById("ctl00_MyCPH1_chkpermit");
	    
	    if(chk.checked==true)
	        tblpermit.style.display="block";
        else
            tblpermit.style.display="none";
	}





function calculateFuelSurCharge()
{
    
    var hdnfuelsurchargebas=document.getElementById("ctl00_MyCPH1_hdnfuelsurchargebas");
    var hdnfuelsurchargerate=document.getElementById("ctl00_MyCPH1_hdnfuelsurchargerate");
    var hdnfuelsurmincharge=document.getElementById("ctl00_MyCPH1_hdnfuelsurmincharge");
    var hdnfuelsurmaxcharge=document.getElementById("ctl00_MyCPH1_hdnfuelsurmaxcharge");
    
    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txtchargedweight=document.getElementById("ctl00_MyCPH1_txtchargedweight");
    var fuelsurcharge=0.00;
    switch(hdnfuelsurchargebas.value)
    {
        case "%":
                fuelsurcharge=parseFloat(txtfreightcharge.value)*parseFloat(hdnfuelsurchargerate.value)/100;
                
                break;
        case "W":
                fuelsurcharge=parseFloat(txtchargedweight.value)*parseFloat(hdnfuelsurchargerate.value)/100;
                break;
        case "F":
                fuelsurcharge=parseFloat(hdnfuelsurchargerate.value);
                break;
    }
    

    if(fuelsurcharge<parseFloat(hdnfuelsurmincharge.value))
        fuelsurcharge=parseFloat(hdnfuelsurmincharge.value);
        
    if(fuelsurcharge>parseFloat(hdnfuelsurmaxcharge.value))
        fuelsurcharge=parseFloat(hdnfuelsurmaxcharge.value);
        
    
// NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows=grvcharges.rows.length;
    rows=parseFloat(rows)+1;
    var i=0;
    var pref="";
    for(i=2;i<=rows;i++)
    {
        if(i<10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
    
        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
        
        if(hdnchargecode1.value=="SCHG20")
        {
            txtcharge1.value=roundNumber(fuelsurcharge,2);
        }
        
        if(hdnchargecode2.value=="SCHG20")
        {
            txtcharge2.value=roundNumber(fuelsurcharge,2);
        }
    }   
    
    return false;
}





function calculateProRata()
{
    
    var hdnftlmaxcapacity=document.getElementById("ctl00_MyCPH1_hdnftlmaxcapacity");
    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
    var diff=0.00,prorata=0.00;
    if(hdnftlmaxcapacity.value=="")
        hdnftlmaxcapacity.value=="0";
        
        diff=parseFloat(txttotchargedweight.value) - parseFloat(hdnftlmaxcapacity.value)
        if(diff<0)
        {
            diff=0;
        }
        prorata=diff * parseFloat(txtfreightcharge.value) / parseFloat(hdnftlmaxcapacity.value);
        prorata=roundNumber(prorata,2);
        
// NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows=grvcharges.rows.length;
    
    var i=0;
    var pref="";
    for(i=2;i<=rows+1;i++)
    {
        if(i<10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
    
        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
        
        if(hdnchargecode1.value=="SCHG17")
        {
            txtcharge1.value=prorata;
        }
        
        if(hdnchargecode2.value=="SCHG17")
        {
            txtcharge2.value=prorata;
        }
       
    }       
    
    return false;
}




function submitClick()
	{
	    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    if(hdnajaxstate.value!="0")
	    {
	        alert("Let the internal process over...Try after 5-10 Seconds...");
	        return false;
	    }
	
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");
	    var txtdockettotal=document.getElementById("ctl00_MyCPH1_txtdockettotal");
	    var txtbilledat=document.getElementById("ctl00_MyCPH1_txtbilledat");
	    var txtedd=document.getElementById("ctl00_MyCPH1_txtedd");
	    var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
	    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	    var optcarrierrisk=document.getElementById("ctl00_MyCPH1_optcarrierrisk");
	    var txtfovcharged=document.getElementById("ctl00_MyCPH1_txtfovcharged");
	    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
	      
	    if(txtbilledat.value=="")
	    {
	        alert("Billing Location is Not Entered. Can't Book " + dkt_call);
	        return false;
	    }

	    if(txtedd.value=="")
	    {
	        alert("Expected Date of Delivery is not Specifed. Please Enter EDD.");
	        txtedd.focus();
	        return false;
	    }
	    
	    if(cmbstaxpaidby.value=="" || cmbstaxpaidby.value=="0")
	    {
	        alert("Please Select Service Tax Payer.");
	        cmbstaxpaidby.focus();
	        return false;
	    }
	    
	    
	    
	    
	    
	    if(cmbpaybas.value=="P04")
	    {
	            if(parseFloat(txtfreightcharge.value)>0)
                {
                    alert("Freight Amount Must be Zero for FOC " + dkt_call);
                    return false;
                }
                
                if(parseFloat(txtfreightrate.value)>0)
                {
                    alert("Freight Rate Must be Zero for FOC " + dkt_call);
                    return false;
                }
	    }
	    else
	    {
	        var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	        var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
	        
	        if(chkmultipickup.checked==false && chkmultidelivery.checked==false)
	        {
                if(parseFloat(txtfreightcharge.value)==0 || txtfreightcharge.value=="")
                {
                    alert("Freight Amount is Zero. Cannot Enter " + dkt_call);
                    return false;
                }
                
                if(parseFloat(txtfreightrate.value)==0 || txtfreightrate.value=="")
                {
                    alert("Freight Rate is Zero. Cannot Enter " + dkt_call);
                    return false;
                }
            }
            
            
            if(parseFloat(txtsubtotal.value)==0 || txtsubtotal.value=="")
            {
                alert("SubTotal Amount is Zero. Cannot Enter " + dkt_call);
                return false;
            }
            
            if(parseFloat(txtdockettotal.value)==0 || txtdockettotal.value=="")
            {
                alert("Total Amount is Zero. Cannot Enter " + dkt_call);
                return false;
            }
	    }
	    
	    
	    
	   // FROM CONTRACT MASTERS DECIDE MINIMUM CRITERIA
	    var hdnminfreighttype=document.getElementById("ctl00_MyCPH1_hdnminfreighttype");
	    var hdncontractdepth=document.getElementById("ctl00_MyCPH1_hdncontractdepth");
        	    
	    if(hdncontractdepth.value=="M")
	    {
	        if(hdnminfreighttype.value=="%")
	        {
	            if(!calculateMinPercentSubTotal())
                    return false;
                    
                if(!calculateMinimumFreight())
                    return false;
            }
        }

	      // CLIENT SPECIFIC SETTINGS
	    if(hdnclient.value=="RLL")
	    {
	        var chkcoddod = document.getElementById("ctl00_MyCPH1_chkcoddod");
	        var chkdacc = document.getElementById("ctl00_MyCPH1_chkdacc");
	        var chkoda = document.getElementById("ctl00_MyCPH1_chkoda");
	      
	        if(chkcoddod.checked==true)
	        {
	            var txtcoddodcharged=document.getElementById("ctl00_MyCPH1_txtcoddodcharged");
	            if(parseFloat(txtcoddodcharged.value)==0)
	            {
	                
	                alert("COD/DOD Amount can't be Zero...");
	                return false;
	            }
	        }
	        
	        if(chkdacc.checked==true)
	        {
	            var txtdacccharged=document.getElementById("ctl00_MyCPH1_txtdacccharged");
	            if(parseFloat(txtdacccharged.value)==0)
	            {
	                alert("DACC Amount Can't be Zero...");
	                return false;
	            }
	        }
	        
	        if(chkoda.checked==true)
	        {
	            // NOW ADDING SIMPLE CHARGES
                var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
                var rows=grvcharges.rows.length;
                
                    var i=0;
                    var pref="";
                    for(i=2;i<=rows+1;i++)
                    {
                        if(i<10)
                            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                        else
                            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
                    
                        var txtcharge1 = document.getElementById(pref + "txtcharge1");
                        var txtcharge2 = document.getElementById(pref + "txtcharge2");
                        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
                        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
                        
                        
                        if(hdnchargecode1.value=="SCHG19")
                        {
                            if(parseFloat(txtcharge1.value)==0)
                            {
                                alert("ODA  Amount Can't be Zero...");
                                return false;
                            }
                        }
                	    
                	    if(hdnchargecode2.value=="SCHG19")
                        {
                            if(parseFloat(txtcharge2.value)==0)
                            {
                                alert("ODA  Amount Can't be Zero...");
                                return false;
                            }
                        }   
	                }
             } // ODA if
	    
	    
	    
	            // RLL LOCAL AND EDD
              // date validation not future for all clients
              var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
              var datediff=0;
               
              var txtdockdate=document.getElementById("ctl00_MyCPH1_txtdockdate");
              var arredd=txtedd.value.split('/');
              var arrdockdt=txtdockdate.value.split('/');
              
              
              var dtdockdate=new Date(months[parseFloat(arrdockdt[1])] + " " +  arrdockdt[0] + "," + arrdockdt[2]);
              var dtedd=new Date(months[parseFloat(arredd[1])] + " " +  arredd[0] + "," + arredd[2]);
	          var chklocal=document.getElementById("ctl00_MyCPH1_chklocal");
	          var datediff = MyDateDiff(dtdockdate,dtedd,'D',true);
	         
	          if(chklocal.checked==false)
	          {
	          
	              if(datediff<=0)
	              {
	                    alert("EDD can't be less than or equal to " + dkt_call + " Date");
	                    return false;
	              }
	          }
	         
	              if(dtdockdate>dtedd)
	                  {
	                        alert("EDD can't be less than " + dkt_call + " Date");
	                        return false;
	                  }
	         
	          
	    }  // RLL over
	    
	   
	    
	    
//	    if(hdnclient.value=="RITCO")
//	    {
//	        if(optcarrierrisk.checked==true)
//	        {
//	            if(txtfovcharged.value=="" || parseFloat(txtfovcharged.value)==0)
//	            {
//	                alert("For Carrier Risk FOV Charged can't be zero....");
//	                txtfovcharged.focus();
//	                return false;
//	            }
//	        }
//	    }
	    
	    
	    if(parseFloat(txtdockettotal.value)>50000)
	    {
	        if(!confirm(dkt_call + " Total is greater than 50000 are you want to continue ???"))
	            return false;
	    }
	    
	    
	    if(parseFloat(txtdockettotal.value)>100000)
	    {
	        if(!confirm(dkt_call + " Total is greater than 100000 are you want to continue ???"))
	            return false;
	    }
	    
	    
	    if(!confirm("Are you sure you want to save this " + dkt_call))
	        return false;
	    
	    var btnsubmit=document.getElementById("ctl00_MyCPH1_btnsubmit");
	    btnsubmit.style.display="none";
	    
	    //Enabling all
	    enableAllFins();
	    
	    return true;
	}

	function freightChargeBlur()
	{
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");
	    var hdndbfreightrate = document.getElementById("ctl00_MyCPH1_hdndbfreightrate");
		var hdndbfreightcharge = document.getElementById("ctl00_MyCPH1_hdndbfreightcharge");
    
		var hdnfreightcharge = document.getElementById("ctl00_MyCPH1_hdnfreightcharge");
		if (parseFloat(txtfreightcharge.value) < parseFloat(hdnfreightcharge.value)) {
			alert('Freight can not be less than ' + parseFloat(hdnfreightcharge.value));
			txtfreightcharge.focus();
			return false;
		}
    
	    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
	    var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");
    
	    var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	    var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
	    
	    

        if(cmbratetype.value=="W")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(txttotchargedweight.value);
        }
        else if(cmbratetype.value=="P")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(hdntotnopkgs.value);
        }
        else if(cmbratetype.value=="T")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/(parseFloat(txttotchargedweight.value)*1000);
        }
        else if(cmbratetype.value=="F")
        {
            txtfreightrate.value = txtfreightcharge.value;
        }
        
        txtfreightrate.value=roundNumber(txtfreightrate.value,2);
	    
	    if(chkmultipickup.checked==true || chkmultidelivery.checked==true)
	    {
	        txtfreightrate.value="0.00";
	        txtfreightcharge.value="0.00";
	    }
	   
        var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");	        
        if(parseFloat(txtfreightcharge.value)==0 && cmbpaybas.value!="P04")
        {
            if(chkmultipickup.checked==false && chkmultidelivery.checked==false)
	        {
                alert("Freight Rate Can't be Zero. Please Re-Enter");
                txtfreightcharge.focus();
            }
        }

            /************************************************************************************
                CALCULATING MINIMUM FREIGHT IN CASE OF MANUAL ENTRY
            *************************************************************************************/
	        if(!calculateMinimumFreight())
	        {
	            
	        }
	    
	    // calculate fuel surcharge
	    calculateFuelSurCharge();
	  
	    //Calculating Subtotal
	    calculateSubTotal();
	    
	    return false;
	}
	
	function calculateMinPercentSubTotal()
	{
	       var hdnflagminsubtotalper=document.getElementById("ctl00_MyCPH1_hdnflagminsubtotalper");
	       if(hdnflagminsubtotalper.value=="N"  || hdnflagminsubtotalper.value=="")
	            return true;

	       var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");	  
	       var hdnyieldsubtotalrate=document.getElementById("ctl00_MyCPH1_hdnyieldsubtotalrate");	
	       
	       var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");	  	  
	       var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");	  
           var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");	
             
	       var hdnminsubtotal=document.getElementById("ctl00_MyCPH1_hdnminsubtotal");	  
	       var hdnlowlimsubtotal=document.getElementById("ctl00_MyCPH1_hdnlowlimsubtotal");	  
	       var hdnupplimsubtotal=document.getElementById("ctl00_MyCPH1_hdnupplimsubtotal");	
	       
	       var lowlim=0.00,upplim=0.00,newrate=0.00;
	       lowlim=parseFloat(hdnyieldsubtotalrate.value)*parseFloat(hdnlowlimsubtotal.value)/100;
           upplim=parseFloat(hdnyieldsubtotalrate.value)*parseFloat(hdnupplimsubtotal.value)/100;
           
           
            if(cmbratetype.value=="W")
                newrate=parseFloat(txtsubtotal.value)/parseFloat(txttotchargedweight.value);
            else if(cmbratetype.value=="P")
                newrate=parseFloat(txtsubtotal.value)/parseFloat(hdntotnopkgs.value);
            else if(cmbratetype.value=="T")
                newrate=parseFloat(txtsubtotal.value)/(parseFloat(txttotchargedweight.value)*1000);
            else
                return false;
           
           
           if(newrate<lowlim)
           {
                alert("Subtotal Yield is less than Minimum Subtotal Limit i.e. " + hdnlowlimsubtotal.value + "%");
                return false;
           }
           
           if(newrate>upplim)
           {
                alert("SubTotal Yield is more than Maximum Subtotal Limit i.e." + hdnupplimsubtotal.value + "%");
                return false;
           }
           
           
           if(parseFloat(txtsubtotal.value)<parseFloat(hdnminsubtotal.value))
           {
                alert("SubTotal is Less than Minimum Subtotal(in RS.) i.e. " + hdnminsubtotal.value + " RS");
                return false;
           }
           
       
	    return true;
	}
	
	function calculateMinPercentFreight()
	{
	        
	       var hdnflagminfreightper=document.getElementById("ctl00_MyCPH1_hdnflagminfreightper");
	       if(hdnflagminfreightper.value=="N"  || hdnflagminfreightper.value=="")
	            return true;
	
	       var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");	  
           var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
           var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");	  	  
           var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");	  
           var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");	  
           var hdndbfreightrate=document.getElementById("ctl00_MyCPH1_hdndbfreightrate");	
           
           var hdnminfreightrate=document.getElementById("ctl00_MyCPH1_hdnminfreightrate");	  
	       var hdnlowlimfreightrate=document.getElementById("ctl00_MyCPH1_hdnlowlimfreightrate");	  
	       var hdnupplimfreightrate=document.getElementById("ctl00_MyCPH1_hdnupplimfreightrate");	
	      
	       
	       var lowlim=0.00,upplim=0.00;
	       lowlim=parseFloat(hdndbfreightrate.value)*parseFloat(hdnlowlimfreightrate.value)/100;
           upplim=parseFloat(hdndbfreightrate.value)*parseFloat(hdnupplimfreightrate.value)/100;
           
           
           if(parseFloat(txtfreightrate.value)<lowlim)
           {
                alert("Freight Rate Lower Limit Reached. Lower Freight Rate Applied.");
                txtfreightrate.value=roundNumber(lowlim,2);
           }
           
           if(parseFloat(txtfreightrate.value)>upplim)
           {
                alert("Freight Rate Upper Limit Reached. Upper Freight Rate Applied.");
                txtfreightrate.value=roundNumber(upplim,2);
           }
           
           
            if(cmbratetype.value=="W")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)*parseFloat(txttotchargedweight.value);
            else if(cmbratetype.value=="P")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)*parseFloat(hdntotnopkgs.value);
            else if(cmbratetype.value=="T")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)* (parseFloat(txttotchargedweight.value)/1000);
            else
                return false;
                    
            txtfreightrate.value=roundNumber(txtfreightrate.value,2);
            txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
            
           
           
           //  Now Checking Flat Minimum
           if(parseFloat(txtfreightcharge.value)<parseFloat(hdnminfreightrate.value))
           {
                alert("Minimum Freight in RS applied");
                txtfreightcharge.value=roundNumber(hdnminfreightrate.value,2);
                
                if(cmbratetype.value=="W")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(txttotchargedweight.value);
                else if(cmbratetype.value=="P")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(hdntotnopkgs.value);
                else if(cmbratetype.value=="T")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/(parseFloat(txttotchargedweight.value)*1000);
                else
                    return false;
               
                txtfreightrate.value=roundNumber(txtfreightrate.value,2);
                txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
               
           }
           
           return true;
	}
	
function validateStep1()
{

     var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        if(hdnajaxstate.value!="0")
        {
            alert("Let the internal process over...Try after 5-10 Seconds...");
            return false;
        }


  var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
  var hdnserverdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");      
  var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
  var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
  var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
  var txtpartyname=document.getElementById("ctl00_MyCPH1_txtpartyname");
  var txtdelloc=document.getElementById("ctl00_MyCPH1_txtdelloc");
  var divdisable=document.getElementById("ctl00_MyCPH1_divdisable");
  var divstep1=document.getElementById("ctl00_MyCPH1_divstep1");
  var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
 
    //Empty Check 
   var optentrytype=document.getElementById("ctl00_MyCPH1_optentrytype_0");
   if(optentrytype.checked=="N")
   {
      if(txtdockno.value=="")
      {
            alert("Please Enter " + dkt_call + " Number....");
            txtdockno.select();
            return false;
      }
   }
   
  var txtdockdate=document.getElementById("ctl00_MyCPH1_txtdockdate");
  if(txtdockdate.value=="")
  {
    alert("Please Enter " + dkt_call + " Date.....");
    txtdockdate.select();
    return false;
  }
  
 
      if(!bookingDateEntryTime())
        return false;
  
  if(cmbpaybas.value=="0")
  {
    alert("Please Select Payment Type....");
    cmbpaybas.focus();
    return false;
  }
  
    var hdncontractsets=document.getElementById("ctl00_MyCPH1_hdncontractsets");
    var arrsets=hdncontractsets.value.split(',');
    
    switch(cmbpaybas.value)
    {
    
        case "P01":
                    if(arrsets[0]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
                    }
                    break;
        case "P02":
                    if(txtpartycode.value=="")
                    {
                        alert("Please Enter Party Code");
                        txtpartycode.focus();
                        return false;
                    }
                    break;
        case "P03":
                    if(arrsets[2]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
                    }
                    break;
    }
  
  
  if(txtdelloc.value=="")
  {
    alert("Please Enter Delivery Location....");
    txtdelloc.select();
    return false;
  }
  
  
  if(!isValidDate(txtdockdate.value,dkt_call))
  {
    txtdockdate.select();
    return false;
  }
  
  
  var trpickupdel = document.getElementById("ctl00_MyCPH1_trpickupdel");
  var trtransmode = document.getElementById("ctl00_MyCPH1_trtransmode");
  var trpacktype = document.getElementById("ctl00_MyCPH1_trpacktype");
  var trbtnstep2 = document.getElementById("ctl00_MyCPH1_trbtnstep2");
  
  
  trpickupdel.style.display="block";
  trtransmode.style.display="block";
  trpacktype.style.display="block";
  trbtnstep2.style.display="block";
  
  return true;
}
	
	
	
	
	
	// Inner Function to be called on all simple charges including COD/DOD, DACC
	function chargeBlur(id)
	{
	    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    var txtcharge = document.getElementById(id);
	    var hdndefaultfov=document.getElementById("ctl00_MyCPH1_hdndefaultfov");
	    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	  
	    if(id=="ctl00_MyCPH1_txtfovcharged")
	    {
	        if(hdnclient.value=="RCPL")
            {
                if(cmbpaybas.value=="P01" || cmbpaybas.value=="P03")
                {
                    if(parseFloat(txtcharge.value)<parseFloat(hdndefaultfov.value))
                    {
                        alert("FOV Charge can't be less than Default Charge");
                        txtcharge.value=hdndefaultfov.value;
                    }
                }      
            }
        }
	    
	    
	    // Rounding Charge Off
	    txtcharge.value=roundNumber(parseFloat(txtcharge.value),2);
	    
	    // Calculating Subtotal
	    calculateSubTotal();
	    return false;
	}

	function gridChargeBlur(id) {
	   // debugger
	    //alert(id.value);
	    //alert("hi1");
	   // var strid = document.getElementById(id);
	    //alert("id:"+strid.name);
	    //alert("idval:" + strid.value);
	    
        var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
        var hdnid=id.replace("txtcharge","hdnchargevalue")
        var txtcharge=document.getElementById(id);
        var hdncharge=document.getElementById(hdnid);
        
        var tc=roundNumber(txtcharge.value,2);
        var hc=roundNumber(hdncharge.value,2);
       //alert("tc:" + tc);
      // alert("hc:" + hc);

       //alert("hdnid:" + hdnid.value);
       //alert("txtcharge:" + txtcharge.value);
       //alert("hdncharge:" + hdncharge.value);

        
        //txtcharge.value=tc;
        //alert("hi2");
        if (parseFloat(tc) < parseFloat(hc))
            {
                alert("Can't Insert Charge Less than " + hdncharge.value);
                txtcharge.focus();
                return false;
            }
       
        // Calculating Subtotal
	    calculateSubTotal();
	    return false;
    }

	
function calculateFOV()
{
    var txtfovrate = document.getElementById("ctl00_MyCPH1_txtfovrate");
    var txtfovcalculated = document.getElementById("ctl00_MyCPH1_txtfovcalculated");
    var txtfovcharged = document.getElementById("ctl00_MyCPH1_txtfovcharged");
    
    var hdntotdeclval = document.getElementById("ctl00_MyCPH1_hdntotdeclval");
    var fovcharge=0.00;
    
    // Rounding FOVRate off
    txtfovrate.value=roundNumber(parseFloat(txtfovrate.value),2);
    
    fovcharge = parseFloat(hdntotdeclval.value) * parseFloat(txtfovrate.value) / 100;
    
    txtfovcalculated.value=roundNumber(fovcharge,2);
    txtfovcharged.value=roundNumber(fovcharge,2);
   
    var hdndefaultfov=document.getElementById("ctl00_MyCPH1_hdndefaultfov");
	var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
   
        if(hdnclient.value=="RCPL")
            {
                if(cmbpaybas.value=="P01" || cmbpaybas.value=="P03")
                {
                    if(parseFloat(txtfovcharged.value)<parseFloat(hdndefaultfov.value))
                    {
                        alert("FOV Charge can't be less than Default Charge");
                        txtfovcharged.value=hdndefaultfov.value;
                        txtfovrate.value=parseFloat(hdndefaultfov.value)/parseFloat(hdntotdeclval.value);
                    }
                }      
            }
   
   // After Getting Fov we need to make SubTotal Again
   calculateSubTotal();
   
    return false;
}
	
	
function parcelClick()
{
    var optentrytype=document.getElementById("ctl00_MyCPH1_optentrytype_0");
    var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
    var lbldockno=document.getElementById("ctl00_MyCPH1_lbldockno");
    
    if(optentrytype.checked==true)
    {
        txtdockno.style.display="block";
        lbldockno.style.display="none";
        txtdockno.value="";
    }
    else
    {
        txtdockno.style.display="none";
        lbldockno.style.display="block";
        txtdockno.value=lbldockno.innerText;
    }

}