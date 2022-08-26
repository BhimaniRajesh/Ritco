// JScript File

var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
// ON BLUR OF FREIGHT  CHARGE


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
  var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
  var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
  var txtpartyname=document.getElementById("ctl00_MyCPH1_txtpartyname");
  var txtdelloc=document.getElementById("ctl00_MyCPH1_txtdelloc");
  var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
  
  
  var txtdockdate=document.getElementById("ctl00_MyCPH1_txtdockdate");
  if(txtdockdate.value=="")
  {
    alert("Please Enter " + dkt_call + " Date.....");
    txtdockdate.select();
    return false;
  }
  
  // date validation not future for all clients
  var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
  var datediff=0;
  
  var arrserverdate=hdnserverdate.value.split('/');
  var arrdockdt=txtdockdate.value.split('/');
  
  var dtserverdate=new Date(months[parseFloat(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
  var dtdockdate=new Date(months[parseFloat(arrdockdt[1])] + " " +  arrdockdt[0] + "," + arrdockdt[2]);

  //if date2 > date1  then returns positive
  datediff=MyDateDiff(dtserverdate,dtdockdate,'D',true);
  var hdnserverhour=document.getElementById("ctl00_MyCPH1_hdnserverhour");
 
    if(hdnclient.value=="ASL")
    {
       if(datediff>1)
          {
            alert(dkt_call + " Date can't be greater than Today's Date. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
          }
       
        if(datediff<-1)
        {
            alert(dkt_call + " Date can't be lest than Yesterday. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
        }
        
        if(datediff==-1)
        {
            if(parseFloat(hdnserverhour.value)>12)
            {
                alert(dkt_call + " Date/Time is less than Back Dated range. Can't allow");
                txtdockdate.value="";
                txtdockdate.focus();
                return false;
            }
        }
        
        if(datediff==1)
        {
            if(parseFloat(hdnserverhour.value)<12)
            {
                alert(dkt_call + " Date/Time is more than Future range. Can't allow");
                txtdockdate.value="";
                txtdockdate.focus();
                return false;
            }
        }  
    }
    else
    {
        if(datediff>0)
          {
            alert(dkt_call + " Date can't be greater than Today's Date. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
          }
    }
  
  
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
                    if(arrsets[1]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
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
  
  
  var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
  var hdnserverdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");      
  var hdnoldpaybas=document.getElementById("ctl00_MyCPH1_hdnoldpaybas");
  var hdnolddelloc=document.getElementById("ctl00_MyCPH1_hdnolddelloc");
  var hdnoldpartycode=document.getElementById("ctl00_MyCPH1_hdnoldpartycode");
  var hdnolddockdate = document.getElementById("ctl00_MyCPH1_hdnolddockdate");
  
  
  var alertstring="";
  var c=0;
  if(hdnoldpaybas.value!=cmbpaybas.value)
    {
        if(c>0)
            alertstring=alertstring + ", ";
            alertstring=alertstring + "Payment Basis";
            c++;
    }
  

   if(hdnolddockdate.value!=txtdockdate.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "Docket Booking Date";
                c++;
        }
        
   if(hdnolddelloc.value!=txtdelloc.value)
    {
        if(c>0)
            alertstring=alertstring + ", ";
            alertstring=alertstring + "Delivery Location";
            c++;
    }
   
    if(hdnoldpartycode.value!=txtpartycode.value)
    {
        if(c>0)
            alertstring=alertstring + ", ";
            alertstring=alertstring + "Party Code";
            c++;
    }
   
   
    if(alertstring!="")
    {
        alertstring = alertstring + "  has been Changed. New Contract will be Invoked. Are you want to Continue ??";
        if(!confirm(alertstring))
            return false;
    }
  
  
  return true;
}
	
	


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
    var hdnoldtransmode = document.getElementById("ctl00_MyCPH1_hdnoldtransmode");
    var hdnoldservicetype = document.getElementById("ctl00_MyCPH1_hdnoldservicetype");
    var hdnoldftltype = document.getElementById("ctl00_MyCPH1_hdnoldftltype");
    var hdnoldfrom = document.getElementById("ctl00_MyCPH1_hdnoldfrom");
    var hdnoldto = document.getElementById("ctl00_MyCPH1_hdnoldto");
    var hdnoldbusinesstype = document.getElementById("ctl00_MyCPH1_hdnoldbusinesstype");
   
    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var cmbtransmode = document.getElementById("ctl00_MyCPH1_cmbtransmode");
    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbftltype = document.getElementById("ctl00_MyCPH1_cmbftltype");
    var cmbbusinesstype = document.getElementById("ctl00_MyCPH1_cmbbusinesstype");
    var txtfrom = document.getElementById("ctl00_MyCPH1_txtfrom");
    var txtto = document.getElementById("ctl00_MyCPH1_txtto");
    var cmbpickupdel = document.getElementById("ctl00_MyCPH1_cmbpickupdel");
    
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

    //Checking from and to city if Docket is Local
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

    if(cmbpickupdel.value=="0" || cmbpickupdel.value=="")
    {
        alert("Please Select PickUp Delivery Type....");
        cmbpickupdel.focus();
        return false;
    }


    var alertstring="";
    var c=0;
      if(hdnoldtransmode.value!=cmbtransmode.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "Transport Mode";
                c++;
        }
      

      if(hdnoldservicetype.value!=cmbservicetype.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "Service Type";
                c++;
        }

      if(hdnoldftltype.value!=cmbftltype.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "FTL Type";
                c++;
        }
        
      if(hdnoldfrom.value!=txtfrom.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "From City";
                c++;
        }
     
      if(hdnoldto.value!=txtto.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "To City";
                c++;
        }
        
     if(cmbbusinesstype.value!=hdnoldbusinesstype.value)
        {
            if(c>0)
                alertstring=alertstring + ", ";
                alertstring=alertstring + "Business Type";
                c++;
        }   
        
     if(alertstring!="")
        {
            alertstring = alertstring + "  has been Changed. New Contract will be Invoked. Are you want to Continue ??";
            if(!confirm(alertstring))
                return false;
        }
    return true;
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
	    var txtfreightrate = document.getElementById("ctl00_MyCPH1_txtfreightrate");
        
	    var subtotal = SubTotalsGet();
	    var dockettotal = DocketTotalGet();
	    var txtbilledat=document.getElementById("ctl00_MyCPH1_txtbilledat");
	    var txtedd=document.getElementById("ctl00_MyCPH1_txtedd");
	    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	    var hdnoldpaybas=document.getElementById("ctl00_MyCPH1_hdnoldpaybas");
	    var optcarrierrisk=document.getElementById("ctl00_MyCPH1_optcarrierrisk");
	    var txtfovcharged=document.getElementById("ctl00_MyCPH1_txtfovcharged");
	    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
	      
	      if(cmbpaybas.value=="P02")
	      {
	            if(txtbilledat.value=="")
	            {
	                alert("Billing Location is Not Entered. Can't Book " + dkt_call);
	                return false;
	            }
	      }


	    if(txtedd.value=="")
	    {
	        alert("Expected Date of Delivery is not Specifed. Please Enter EDD.");
	        txtedd.focus();
	        return false;
	    }
	    
	    if(hdnoldpaybas.value=="P01" && (cmbpaybas.value=="P02" || cmbpaybas.value=="P03"))
	    {
	        var txtmrcancelreason = document.getElementById("ctl00_MyCPH1_txtmrcancelreason");
	        var txtmrcanceldate = document.getElementById("ctl00_MyCPH1_txtmrcanceldate");
	     
	        if(txtmrcancelreason.value=="")
	        {
	            alert("Please Enter MR Cancel Reason........");
	            txtmrcancelreason.focus();
	            return false;
	        }
	        
	        if(txtmrcanceldate.value=="")
	        {
	            alert("Please Enter MR Cancel Date........");
	            txtmrcanceldate.focus();
	            return false;
	        }
	        else
	        {
	            if(!isValidDate(txtmrcanceldate.value,"MR Cancel"))
	            {
	                txtmrcanceldate.value="";
	                txtmrcanceldate.focus();
	                return false;
	            }
	        }
	        
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
            
	        /* KK Cess */
	        //if(parseFloat(txtsubtotal.value)==0 || txtsubtotal.value=="")
	        if (parseFloat(subtotal) == 0 || subtotal == "") 
            {
                alert("SubTotal Amount is Zero. Cannot Enter " + dkt_call);
                return false;
            }
            
	        /* KK Cess */
	        //if(parseFloat(txtdockettotal.value)==0 || txtdockettotal.value=="")
	        if (parseFloat(dockettotal) == 0 || dockettotal == "") 
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

        try {
            validationOnSubmit();
        }
        catch (ex) {
            alert(ex.message);
            return false;
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
	    
	   
	    
	    
	    //if(hdnclient.value=="RITCO")
	    //{
	    //    if(optcarrierrisk.checked==true)
	    //    {
	    //        if(txtfovcharged.value=="" || parseFloat(txtfovcharged.value)==0)
	    //        {
	    //            alert("For Carrier Risk FOV Charged can't be zero....");
	    //            txtfovcharged.focus();
	    //            return false;
	    //        }
	    //    }
	    //}
	    
        /* KK Cess */
    //if(parseFloat(txtdockettotal.value)>50000)
	    if (parseFloat(dockettotal) > 50000) 
	    {
	        if(!confirm(dkt_call + " Total is greater than 50000 are you want to continue ???"))
	            return false;
	    }
	    
        /* KK Cess */
    //if(parseFloat(txtdockettotal.value)>100000)
	    if (parseFloat(dockettotal) > 50000) 
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
	try
	{
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");

	    //var hdnfreightcharge = document.getElementById("ctl00_MyCPH1_hdnfreightcharge");
	    //if (parseFloat(txtfreightcharge.value) < parseFloat(hdnfreightcharge.value)) {
	    //   alert('Freight can not be less than ' + parseFloat(hdnfreightcharge.value));
	    //  txtfreightcharge.focus();
	    // return false;
	    //}
	    
	    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
	    var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");
    
	    var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	    var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
	    
	    txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
	    
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
            txtfreightrate.value=txtfreightcharge.value;
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
	    }catch(e){alert(e.message)}
	}
	
		
		
	function calculateMinPercentSubTotal()
	{
	       var hdnflagminsubtotalper=document.getElementById("ctl00_MyCPH1_hdnflagminsubtotalper");
	       if(hdnflagminsubtotalper.value=="N"  || hdnflagminsubtotalper.value=="")
	            return true;

	        /* KK Cess */
	        //var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");	
	       var subtotal = GetSubTotalValue();
	        /* KK Cess */
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
                //newrate=parseFloat(txtsubtotal.value)/parseFloat(txttotchargedweight.value);
                newrate = parseFloat(subtotal) / parseFloat(txttotchargedweight.value);/* KK Cess */
            else if(cmbratetype.value=="P")
                //newrate=parseFloat(txtsubtotal.value)/parseFloat(hdntotnopkgs.value);
                newrate = parseFloat(subtotal) / parseFloat(hdntotnopkgs.value);/* KK Cess */
            else if(cmbratetype.value=="T")
                //newrate=parseFloat(txtsubtotal.value)/(parseFloat(txttotchargedweight.value)*1000);
                newrate = parseFloat(subtotal) / (parseFloat(txttotchargedweight.value) * 1000);/* KK Cess */
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
           
	        /* KK Cess */
           //if (parseFloat(txtsubtotal.value) < parseFloat(hdnminsubtotal.value))
           if (parseFloat(subtotal) < parseFloat(hdnminsubtotal.value))
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
                    
                txtfreightrate.value=roundNumber(txtfreightrate.value,2);
                txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
               
           }
           
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
	

	
	

