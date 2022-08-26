<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorBill_step3.aspx.cs" Inherits="VendorPayment_new_vendorBill_step3" Trace="true" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
   var Form_name="ctl00$MyCPH1$"  
   var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

function fsubmit()
{
		var totdkt="<%=totdkt %>"
	if(document.getElementById(Form_name+"billdt").value=="")
	{
		alert("Please enter Bill Generation Date!!!")
		document.getElementById(Form_name+"billdt").focus();
		return false;
	}
	if(document.getElementById(Form_name+"billdt").value!="")
	{
	   if (ValidateForm(document.getElementById(Form_name+"billdt"))==false)
	   {
	   	 return false;
	   }
	}
	var dt =document.getElementById(Form_name+"billdt").value
			//alert(dt)
	var dt_dd=dt.substring(0,2)
	var dt_mm=dt.substring(3,5)
	var dt_yy=dt.substring(6,10)
		
	bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	//alert(duedt)
			
	currdate="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
	dt_dd=currdate.substring(0,2)
	dt_mm=currdate.substring(3,5)
	dt_yy=currdate.substring(6,10)
	//alert("hi")
	currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
	//alert(currdate)
	if (currdate < bgndt)
	{
			alert("Bill Date should be less than or equal to  system Date \n")
			document.getElementById(Form_name+"billdt").focus();
			return false;
	}
	vendorbillno=document.getElementById(Form_name+"vendorbillno").value
	if (vendorbillno=="") 
	{
		alert("Please enter vendor bill no!!!")
		document.getElementById(Form_name+"vendorbillno").focus()
		return false; 
	}
	
	
	if(document.getElementById(Form_name+"vendorbilldt").value=="")
	{
		alert("Please enter Vendor Bill Date!!!")
		document.getElementById(Form_name+"vendorbilldt").focus();
		return false;
	}
	if(document.getElementById(Form_name+"vendorbilldt").value!="")
	{
	   if (ValidateForm(document.getElementById(Form_name+"vendorbilldt"))==false)
	   {
	   	 return false;
	   }
	}
	
	if(document.getElementById(Form_name+"duedt").value=="")
	{
		alert("Please enter Bill Due Date!!!")
		document.getElementById(Form_name+"duedt").focus();
		return false;
	}
	if(document.getElementById(Form_name+"duedt").value!="")
	{
	   if (ValidateForm(document.getElementById(Form_name+"duedt"))==false)
	   {
	   	 return false;
	   }
	}
		//alert("hi")
		var dt =document.getElementById(Form_name+"duedt").value
		//alert(dt)
		var dt_dd=dt.substring(0,2)
		var dt_mm=dt.substring(3,5)
		var dt_yy=dt.substring(6,10)
		
		duedt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		//alert(duedt)
		
		dt =document.getElementById(Form_name+"billdt").value
		dt_dd=dt.substring(0,2)
		dt_mm=dt.substring(3,5)
		dt_yy=dt.substring(6,10)
		
		gendt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
		if (duedt<gendt)
		{
		 alert( "Due Date Should be greater than Bill Date !!!")
		 document.getElementById(Form_name+"duedt").focus();
		 return false;
		}
		
//		if (!fcalbillamt())
//		return
//		
		tdsval=parseFloat(document.getElementById(Form_name+"tdsded").value)
		tdsfor=document.getElementById(Form_name+"tdsfor").value
		tdsacccode=document.getElementById(Form_name+"tdsacccode").value
		if(parseFloat(tdsval)>0)
		{
			if (tdsacccode=="")
			{
				alert("Please select TDS Type!!!") 
				document.getElementById(Form_name+"tdsacccode").focus();
				return false;
			}
			if (tdsfor=="")
			{
				alert("Please select TDS deducted for!!!") 
				document.getElementById(Form_name+"tdsfor").focus();
				return false;
			}
		}
		
		//alert("done ")
		// return false;
		for (i=0;i<totdkt;i++)
		{
		
		 j = i + 2 ;
		      
                 if(i < 10)
                {
                
                    mDerivedControlName_indothamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothamt"
                    mDerivedControlName_indpcamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indpcamt"
                    mDerivedControlName_inddiscount = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$inddiscount"
                    mDerivedControlName_indadvamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indadvamt"
                    mDerivedControlName_indcess = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indcess"
                    mDerivedControlName_indothded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothded"
                    mDerivedControlName_indsvctaxded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctaxded"
                    mDerivedControlName_indtdsded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indtdsded"
                    mDerivedControlName_indnetpay = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indnetpay"
                    mDerivedControlName_indsvctax = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctax"
                    
                   document.getElementById(mDerivedControlName_indsvctax).disabled=false
                    document.getElementById(mDerivedControlName_indcess).disabled=false
                     document.getElementById(mDerivedControlName_indtdsded).disabled=false
                      document.getElementById(mDerivedControlName_indnetpay).disabled=false
                }
                else
                {
                    mDerivedControlName_indothamt = "ctl00$MyCPH1$dockdata$ctl" + j + "$indothamt"
                    mDerivedControlName_indpcamt = "ctl00$MyCPH1$dockdata$ctl" + j + "$indpcamt"
                    mDerivedControlName_inddiscount = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$inddiscount"
                    mDerivedControlName_indadvamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indadvamt"
                    mDerivedControlName_indcess = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indcess"
                    mDerivedControlName_indothded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothded"
                    mDerivedControlName_indsvctaxded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctaxded"
                    mDerivedControlName_indtdsded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indtdsded"
                    mDerivedControlName_indnetpay = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indnetpay"
                    mDerivedControlName_indsvctax = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctax"
                    document.getElementById(mDerivedControlName_indsvctax).disabled=false
                    document.getElementById(mDerivedControlName_indcess).disabled=false
                     document.getElementById(mDerivedControlName_indtdsded).disabled=false
                      document.getElementById(mDerivedControlName_indnetpay).disabled=false
                 }   
       }
		click_count=parseFloat(document.getElementById(Form_name+"click_count").value)
 		if(click_count > 0)
		{
			alert("Sorry... You cannot click twice !!!")
			return  false;
		}  
		else
		{
			click_count=click_count+1
			document.getElementById(Form_name+"click_count").value=click_count
			return  true;
//			method="post";
//			action="vendorbill_submit.asp";
//			submit();
		}	
}
function calculation(indothamt,othamt,inddiscount,totdiscount,cboindsvctaxrate,indsvctax,indcess,indadvamt,indothded,indsvctaxded,indtds_rate,indtdsded,indnetpay,indpcamt,advamt,netamt,pcamt,cessamt,tdsded,othded,svctaxded,svctax)
  {
	var totdkt="<%=totdkt %>"
	var netamount=0
	var billamt=0;
	var gndindsvctaxded=0
	var gndindothded=0
	var gndnetamt=0
	var gndtdsded=0
	var gndpcamt = 0
	var gndothamt = 0
	var gndsvctax = 0
	var gndcess = 0
	var gndindtottds=0
	var gnddiscount=0
	var svctax1 = ("<%=svctax%>"/100)
	var othertax = ("<%=othamt%>"/100)
		
	if (totdkt==1)
	{
			varindpcamt=parseFloat(indpcamt.value)
			varindothamt=parseFloat(indothamt.value)
			varindsvctax=parseFloat(indsvctax.value)
			varindcess=parseFloat(indcess.value)
			varindadvamt=parseFloat(indadvamt.value)
			varindothded=parseFloat(indothded.value)
			varindsvctaxded=parseFloat(indsvctaxded.value)
			varindtdsded=parseFloat(indtdsded.value)
			varindnetpay=parseFloat(indnetpay.value)
			varindtds_rate=parseFloat(indtds_rate.value)
			//varroutecd=routecd.value
			
			varinddiscount=parseFloat(inddiscount.value)
			varindsvctaxrate=parseFloat(cboindsvctaxrate.value)
			
			
			if (varindsvctaxrate>0)
			{		
					if(varindsvctaxrate>99)
					{
						alert("Service tax Cannot be greater than 100%!!!")
						cboindsvctaxrate.focus()
						return false;
					}
					varindsvctax= Math.round((parseInt(varindpcamt))* (parseFloat(varindsvctaxrate)/100))
					varindcess= Math.round((parseInt(varindsvctax))* parseFloat(0.02))
					indsvctax.value=(varindsvctax)
					indcess.value=(varindcess)
			}		 
			
			if(varindsvctaxded>varindsvctax)
			{
					alert("Service tax deduction should be less than service tax charged!!!")
					indsvctax.focus()
					return false;
			}
			
			if(isNaN(indtds_rate.value))
			{
						alert("Please enter valid rate!!!")
						indtds_rate.focus();
						return;
			}
			if(parseFloat(indtds_rate.value)>100)
			{
						alert("Invalid TDS Rate!!!")
						indtds_rate.focus();
						return;
			}
			
			
			indtdsded.value=Math.round((varindpcamt+varindothamt)* varindtds_rate/100)
			
			varindtdsded=parseFloat(indtdsded.value)
			
			/* for net payment */
			
			//varnetamt=parseFloat(varindpcamt)-parseFloat(varindadvamt)
			
			//varnetamt=varnetamt + parseFloat(varindothamt)
			
			/*****************/
			
			varnetamt=parseFloat(varindpcamt)+parseFloat(varindothamt)+parseFloat(varindsvctax)+parseFloat(varindcess)-parseFloat(varindadvamt)-parseFloat(varindothded)-parseFloat(varindsvctaxded)-parseFloat(varindtdsded)-parseFloat(varinddiscount)
			
			if(varnetamt<0)
			{
				alert("Invalid Net Amount, Net Amount cannot be less than zero!!!")
				
				return;
			}
			
//			gndtdsded=roundit(varindtdsded)
//			gndindsvctaxded=roundit(varindsvctaxded)
//			gndindothded=roundit(varindothded)
//			gndnetamt=roundit(netamt)
//			indnetpay.value=roundit(netamt)

            gndtdsded=(varindtdsded)
			gndindsvctaxded=(varindsvctaxded)
			gndindothded=(varindothded)
			gndnetamt=(varnetamt)
			indnetpay.value=(varnetamt)
			
			gndpcamt = gndpcamt + varindpcamt
			gndothamt = gndothamt + varindothamt
			gndsvctax = gndsvctax + varindsvctax
			gndcess = gndcess + varindcess
			gnddiscount = gnddiscount + varinddiscount
			gndindtottds=gndindtottds + parseFloat(indtdsded.value) 
			
	}
	else
	{
//		for (i=0;i<totdkt;i++)
//		{
		   
		   varnetamt=0
			varindpcamt=parseFloat(indpcamt.value)
			varindothamt=parseFloat(indothamt.value)
			varindsvctax=parseFloat(indsvctax.value)
			varindcess=parseFloat(indcess.value)
			varindadvamt=parseFloat(indadvamt.value)
			varindothded=parseFloat(indothded.value)
			varindsvctaxded=parseFloat(indsvctaxded.value)
			varindtdsded=parseFloat(indtdsded.value)
			varindnetpay=parseFloat(indnetpay.value)
			varindtds_rate=parseFloat(indtds_rate.value)
			//routecd=routecd[i]
			
			varinddiscount=parseFloat(inddiscount.value)
			varindsvctaxrate=parseFloat(cboindsvctaxrate.value)
			
			
			if (varindsvctaxrate>0)
			{		
					if(varindsvctaxrate>99)
					{
						alert("Service tax Cannot be greater than 100%!!!")
						cboindsvctaxrate.focus()
						return false;
					}
					varindsvctax= Math.round((parseInt(varindpcamt))* (parseFloat(varindsvctaxrate)/100))
					//alert(varindsvctax)
					varindcess= Math.round((parseInt(varindsvctax))* parseFloat(0.02))
					indsvctax.value=(varindsvctax)
					indcess.value=(varindcess)
			}	
			
			
			
			if(varindsvctaxded>varindsvctax)
			{
				alert("Service tax deduction should be less than service tax charged!!!")
				//varindsvctaxded.select;
				varindsvctaxded.focus();
				return false;
			}
//			if(isNaN(indtds_rate[i]))
//			{
//						alert("Please enter valid rate!!!")
//						indtds_rate[i].focus();
//						return;
//			}
			if(parseFloat(varindtds_rate)>100)
			{
						alert("Invalid TDS Rate!!!")
						varindtds_rate.focus();
						return;
			}
			
			varindtdsded=Math.round((varindpcamt+varindothamt)*varindtds_rate/100)
			varindtdsded=parseFloat(varindtdsded)
			//alert(varindtdsded)
			indtdsded.value=parseFloat(varindtdsded)
			tdsded.value=parseFloat(varindtdsded)
			
			//alert(varindadvamt)
			//alert(varnetamt)
			varnetamt=parseFloat(varindpcamt)+parseFloat(varindothamt)+parseFloat(varindsvctax)+parseFloat(varindcess)-parseFloat(varindadvamt)-parseFloat(varindothded)-parseFloat(varindsvctaxded)-parseFloat(varindtdsded)-parseFloat(varinddiscount)
			//alert(varnetamt)
			
			if(varnetamt<0)
			{
				alert("Invalid Net Amount, Net Amount cannot be less than zero!!!")
				
				return;
			}
			gndindsvctaxded=gndindsvctaxded+varindsvctaxded
			gndindothded=gndindothded+varindothded
			
			gndnetamt=gndnetamt+varnetamt
			
			gndtdsded=gndtdsded+varindtdsded
			
			gndpcamt = gndpcamt + varindpcamt
			gndothamt = gndothamt + varindothamt
			gndsvctax = gndsvctax + varindsvctax
			gndcess = gndcess + varindcess
			
			gndindtottds=gndindtottds + parseFloat(varindtdsded) 
			
			gnddiscount = gnddiscount + varinddiscount
			
			
			
			//varindnetpay=roundit(netamt)
			indnetpay.value=(varnetamt)
			
		//}
		
	}
//	totdiscount.value=roundit(gnddiscount)
//	pcamt.value=roundit(gndpcamt)
//	othamt.value=roundit(gndothamt)
//	cessamt.value=roundit(gndcess)
//	svctax.value=roundit(gndsvctax)
//	
//	tdsded.value=Math.round(gndindtottds)
//	othded.value=roundit(gndindothded)
//	svctaxded.value=roundit(gndindsvctaxded)
//	netamt.value=roundit(gndnetamt)
	
	
	//************************************
	var varindothamt=0;
	var totindothamt=0;
	
	var varindpcamt=0;
	var totindpcamt=0;
	
	var varinddiscount=0;
	var tot_discount=0;
	
	var varindadvamt=0;
	var advanceamt=0;
	 
	var varindcess=0;
	var cess_amt=0;
	
	var varindothded=0;
	var otherdeduction=0;
	
	var varindsvctaxded=0;
	var sevicededuction=0;
	
	var varindtdsded1=0;
	var tdsdeduction=0;
	
	var net_amount=0;
	var varindnetpay1=0;
	
	var service_tax123=0;
	var varindsvctax123=0;
	
		for (i=0;i<totdkt;i++)
		{
		
		 j = i + 2 ;
		      
                 if(i < 10)
                {
                
                    mDerivedControlName_indothamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothamt"
                    mDerivedControlName_indpcamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indpcamt"
                    mDerivedControlName_inddiscount = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$inddiscount"
                    mDerivedControlName_indadvamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indadvamt"
                    mDerivedControlName_indcess = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indcess"
                    mDerivedControlName_indothded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothded"
                    mDerivedControlName_indsvctaxded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctaxded"
                    mDerivedControlName_indtdsded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indtdsded"
                    mDerivedControlName_indnetpay = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indnetpay"
                    mDerivedControlName_indsvctax = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctax"
                   
                }
                else
                {
                    mDerivedControlName_indothamt = "ctl00$MyCPH1$dockdata$ctl" + j + "$indothamt"
                    mDerivedControlName_indpcamt = "ctl00$MyCPH1$dockdata$ctl" + j + "$indpcamt"
                    mDerivedControlName_inddiscount = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$inddiscount"
                    mDerivedControlName_indadvamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indadvamt"
                    mDerivedControlName_indcess = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indcess"
                    mDerivedControlName_indothded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indothded"
                    mDerivedControlName_indsvctaxded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctaxded"
                    mDerivedControlName_indtdsded = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indtdsded"
                    mDerivedControlName_indnetpay = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indnetpay"
                    mDerivedControlName_indsvctax = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$indsvctax"
                    
                    
                }
                if(document.getElementById(mDerivedControlName_indothamt))
                {
                   
                    varindothamt=parseFloat(varindothamt)+parseFloat(document.getElementById(mDerivedControlName_indothamt).value)
                    varindpcamt=parseFloat(varindpcamt)+parseFloat(document.getElementById(mDerivedControlName_indpcamt).value)
                    varinddiscount=parseFloat(varinddiscount)+parseFloat(document.getElementById(mDerivedControlName_inddiscount).value)
                    varindadvamt=parseFloat(varindadvamt)+parseFloat(document.getElementById(mDerivedControlName_indadvamt).value)
                    varindcess=parseFloat(varindcess)+parseFloat(document.getElementById(mDerivedControlName_indcess).value)
                    varindothded=parseFloat(varindothded)+parseFloat(document.getElementById(mDerivedControlName_indothded).value)
                    varindsvctaxded=parseFloat(varindsvctaxded)+parseFloat(document.getElementById(mDerivedControlName_indsvctaxded).value)
                    varindtdsded1=parseFloat(varindtdsded1)+parseFloat(document.getElementById(mDerivedControlName_indtdsded).value)
                    varindnetpay1=parseFloat(varindnetpay1)+parseFloat(document.getElementById(mDerivedControlName_indnetpay).value)
                    varindsvctax123=parseFloat(varindsvctax123)+parseFloat(document.getElementById(mDerivedControlName_indsvctax).value)
                }
               // alert(varindsvctax123)
                totindothamt=varindothamt
                totindpcamt=varindpcamt
                tot_discount=varinddiscount
		        advanceamt=varindadvamt
		        cess_amt=varindcess;
		        otherdeduction = varindothded
		        sevicededuction=varindsvctaxded
		        tdsdeduction=varindtdsded1
		        net_amount = varindnetpay1
		        service_tax123 = varindsvctax123
		        //alert(service_tax123)
		    //alert(tot_discount)
		    //debugger
		        othamt.value=totindothamt
		        pcamt.value=totindpcamt
    		    totdiscount.value=tot_discount
    		    advamt.value=advanceamt
    		    cessamt.value=cess_amt
    		    othded.value=otherdeduction
    		    svctaxded.value=sevicededuction
    		    tdsded.value=tdsdeduction
    		    netamt.value=net_amount
    		    svctax.value=service_tax123
    		    //alert(svctax.value)
    		    /*alert(parseFloat(othamt.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value)+parseFloat(svctax.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value)+parseFloat(svctax.value)-parseFloat(totdiscount.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value)+parseFloat(svctax.value)-parseFloat(totdiscount.value)-parseFloat(advamt.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value)+parseFloat(svctax.value)-parseFloat(totdiscount.value)-parseFloat(advamt.value)-parseFloat(othded.value))
    		    alert(parseFloat(othamt.value)+parseFloat(pcamt.value)+parseFloat(cessamt.value)+parseFloat(netamt.value)+parseFloat(svctax.value)-parseFloat(totdiscount.value)-parseFloat(advamt.value)-parseFloat(othded.value)-parseFloat(tdsded.value))
    		    */
    		    
	                    //netamt.value=netamt.value
    		    //calcolamt(indothamt,othamt,inddiscount,totdiscount,cboindsvctaxrate,indsvctax,indcess,indadvamt,indothded,indsvctaxded,indtds_rate,indtdsded,indnetpay,indpcamt,advamt,netamt,pcamt,cessamt,tdsded,othded,svctaxded,svctax)
		}
	//***********************************
	//totdiscount.value=(gnddiscount)
//	pcamt.value=(gndpcamt)
	//othamt.value=(gndothamt)
	//alert(othamt.value)
	//cessamt.value=(gndcess)
	//svctax.value=(gndsvctax)
	
	//tdsded.value=Math.round(gndindtottds)
	//othded.value=(gndindothded)
	
	//svctaxded.value=(gndindsvctaxded)
	//netamt.value=(gndnetamt)
	
	return true;
}
            
            function calcolamt(indothamt,othamt,inddiscount,totdiscount,cboindsvctaxrate,indsvctax,indcess,indadvamt,indothded,indsvctaxded,indtds_rate,indtdsded,indnetpay,indpcamt,advamt,netamt,pcamt,cessamt,tdsded,othded,svctaxded,svctax)
                {
	                    var totchrg=0
	                    grdindpcamt=parseFloat(pcamt.value)
	                    grdindadvamt=parseFloat(advamt.value)
	                    grdindothamt=parseFloat(othamt.value)
                    	
	                    grdindcess=parseFloat(cessamt.value)
	                    grdindothded=parseFloat(othded.value)
	                    grdindsvctaxded=parseFloat(svctaxded.value)
	                    grdindtdsded=parseFloat(tdsded.value)
	                    grddiscount=parseFloat(totdiscount.value)
	                    //grdindsvctax=parseFloat(svctax.value)
	                    
	                    grdindsvctax=parseFloat(indsvctax.value)
	                    //svctax.value = grdindsvctax
	                    grdindsvctax=parseFloat(varindsvctax) 
	                    //svctax.value = varindsvctax
	                    //alert(varindsvctax)
	                   // alert(totchrg)
	                    totchrg=grdindpcamt-grdindadvamt+grdindothamt+grdindsvctax+grdindcess-grdindothded-grdindsvctaxded-grdindtdsded-grddiscount
	                    tdsval=0	
	                    //alert(totchrg)
	                    
	                    
	                    //alert(netamt.value)
                    	
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
		obj.value =""
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value =""
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
    </script>

   <%-- <form id="form1" runat="server">--%>
    <div align="center">
    
   
      <p align="center"><font class="blackfnt"><b>You Selected</b></font></p>
  
    <table border="0" cellpadding="3" colspan="1" width="40%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
     
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" style="height: 21px"> 
          <font class="blackfnt">Document Date </font>
        </td>
        <td  width="343" align="left" style="height: 20px"> 
          <font class="blackfnt">
              <asp:Label ID="lblDocDate" runat="server" Text=""></asp:Label></font>
        </td>
      </tr>
      
      
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" style="height: 20px"> 
          <font class="blackfnt" >Vendor Type</font>
        </td>
        <td  width="343" align="left"> 
          <font class="blackfnt"><asp:Label ID="lblVendorType" runat="server" Text=""></asp:Label></font>
        </td>
      </tr>
      
      
      <tr bgcolor="#FFFFFF"> 
        <td  width="205" style="height: 20px" > 
          <font class="blackfnt" >Vendor</font>
        </td>
        <td  width="343" align="left"> 
          <font class="blackfnt"><asp:Label ID="lblVendor" runat="server" Text="Label"></asp:Label></font>
        </td>
      </tr>
     
      

      
    </table>
     <br />
          <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" width="70%"  align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt"><asp:HiddenField ID="click_count" Value=0 runat="server" /></b>
       </td>
    </tr>
    </table>
    <br />
    
     <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" width="70%" height="189" align="center" class="boxbg">
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Bill Entry Number</font> 
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt" color="red">System Generated...</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Bill Entry date</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"><asp:TextBox id="billdt" runat="server" Width="70px"></asp:TextBox>  
        
        
      </td>
      
    </tr>
    
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Vendor name</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left"> 
        <div align="left"><font class="blackfnt">
            <asp:Label ID="lblVendorName" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Vendor Bill number</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><asp:TextBox id="vendorbillno" runat="server" Width="70px"></asp:TextBox> </td>
    </tr>
    
    
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Vendor Bill date</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"><asp:TextBox id="vendorbilldt" runat="server" Width="70px"></asp:TextBox> 
       
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Due date</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"> <asp:TextBox id="duedt" runat="server" Width="70px"></asp:TextBox>
       
      </font> 
      </td>
    </tr>
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Contract Amount (+)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left"  width="102"><asp:TextBox id="pcamt" runat="server"  Enabled="false"  Width="70px"></asp:TextBox>
      
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Advance Paid (-)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:TextBox id="advamt"   Enabled="false" runat="server" Width="70px"></asp:TextBox>
        </font></td>
    </tr>
    
    
    <tr> 
       <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Other Amount (+)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF"  align="left" width="102"><asp:TextBox id="othamt" runat="server"  Enabled="false"  Width="70px"></asp:TextBox>
      </td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Deductions (-)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="222"><asp:TextBox id="othded" runat="server"  Enabled="false"  Width="70px"></asp:TextBox></td>
    </tr>
    <tr> 
       <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="135"><font class="blackfnt">Service Tax Charge(+)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"> <asp:TextBox id="svctax" runat="server"   Enabled="false" Width="70px"></asp:TextBox>
        
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Service Tax Deduction (-)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt" size="-1"><asp:TextBox   Enabled="false" id="svctaxded" runat="server" Width="70px"></asp:TextBox>
	  
      </font></td>
    </tr>
    
    
    <tr> 
       <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Cess (+)</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"> <asp:TextBox id="cessamt"  Enabled="false"  runat="server" Width="70px"></asp:TextBox>
        <div align="left"><font class="blackfnt"><font class="blackfnt"></font></div>
      </td>
        <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">TDS Deduction</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"> <asp:TextBox id="tdsded"  Enabled="false" runat="server" Width="70px"></asp:TextBox>
        
      </td></tr>
       <tr> 
      <td bgcolor="#FFFFFF" align="left"><font class="blackfnt">Discount Received (-)</font></td>					
	  <td bgcolor="#FFFFFF" align="left"><asp:TextBox id="totdiscount"  Enabled="false" runat="server" Width="70px"></asp:TextBox></td>	
	  				
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="129"><font class="blackfnt">Net Payable</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="102"> <asp:TextBox id="netamt"  Enabled="false" runat="server" Width="70px"></asp:TextBox>
        
      </td>
      
    </tr>
    <tr>
		<td bgcolor="#FFFFFF" align="left" style="height: 26px"><font class="blackfnt">TDS type</font></td>						     		  
		 <td bgcolor="#FFFFFF" align="left" style="height: 26px"><font class="blackfnt"><asp:DropDownList ID="tdsacccode" runat="server" Mode="Conditional" RenderMode="Inline" Width="152px">
										         <asp:ListItem Text="Select" Value=""></asp:ListItem>
										         </asp:DropDownList>
								     		     </font></td>
								     		     
			<td bgcolor="#FFFFFF" align="left" style="height: 26px"><font class="blackfnt">TDS Deducted For</font></td>						     		  
		 <td bgcolor="#FFFFFF" align="left" style="height: 26px"><font class="blackfnt">	<asp:DropDownList ID="tdsfor" runat="server"  Mode="Conditional" RenderMode="Inline" Width="152px">
						                       <asp:ListItem Text="Select" Value=""></asp:ListItem>
						                       <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
						                       <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
										       </asp:DropDownList>
						                       </td>				     		     
								     		     
								     		   </tr>
    
    </table>
    
    <br />
    
    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" width="95%"  align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td valign="top" height="18"  colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Bill Details</b>
       </td>
    </tr>
    </table>
   <br />
   
      
<asp:GridView align="center" ID="dockdata"  Width="90%" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged"   >
 <%--OnRowDataBound="CustomersGridView_RowDataBound"  --%>
<Columns>
 
 <%--<asp:BoundField  HeaderText="Sr No." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>


<asp:TemplateField HeaderText="SRNo." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
<ItemTemplate>
<asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
</asp:Label>
</ItemTemplate>
</asp:TemplateField>




<%--<asp:BoundField DataField="thcno" HeaderText="DocumentNo." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
<asp:TemplateField>
<HeaderTemplate >
              <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
              </HeaderTemplate>
<ItemTemplate>
<asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>  
</ItemTemplate> 
</asp:TemplateField> 
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblcontractAmt" CssClass="blackfnt" Text="Contract Amount (+)" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox   ID ="indpcamt" runat="server" MaxLength="10" Columns="12"  Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblOtherAmt" CssClass="blackfnt" Text="Other Amount(+) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indothamt" MaxLength="10" Columns="12"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblClaim" CssClass="blackfnt" Text="Discount Recvd(-) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="inddiscount" MaxLength="10" Columns="12"  runat="server" Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblunexpamt" CssClass="blackfnt" Text="Service Tax Rate" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="cboindsvctaxrate"  MaxLength="10" Columns="12" runat="server" Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblServiceTax" CssClass="blackfnt" Text="Service Tax (+) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indsvctax" MaxLength="10"  Enabled="false" Columns="12" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SVCTAX") %>'></asp:TextBox>
                    </center>
                </ItemTemplate>
 </asp:TemplateField>

 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblcess" CssClass="blackfnt" Text="Cess (+) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indcess" MaxLength="10"  Enabled="false" Columns="12" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CESSAMT") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblAdvamt" CssClass="blackfnt" Text=" Advance Paid (-) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indadvamt" MaxLength="10" Columns="12" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>'></asp:TextBox>
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lbldeduction" CssClass="blackfnt" Text="Deductions(-) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indothded" MaxLength="10" Columns="12"   runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblservicededuction" CssClass="blackfnt" Text="Service Tax Dedn.(-) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indsvctaxded" MaxLength="10" Columns="12"   runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SVCTAXDED") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblTDSRate" CssClass="blackfnt" Text="TDS Rate" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indtds_rate" MaxLength="10" Columns="12"   runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"tds_rate") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblTDSdeduction" CssClass="blackfnt" Text="TDS Dedn.(-) " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indtdsded" MaxLength="10"  Enabled="false" Columns="12"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblNetPayable" CssClass="blackfnt" Text="Net Payable" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="indnetpay"  Enabled="false" MaxLength="10" Columns="12"   runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"NET") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>


</Columns>
<RowStyle />
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
   
    <table cellspacing="1" cellpadding="3" border="0" width="95%"  align="center">
    <tr > 
      <td  bgcolor="#FFFFFF" valign="top" height="18"  colspan="4" align="center">
          <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Text="Remarks" style="left: -4px; position: relative; top: -19px"></asp:Label>
          <asp:TextBox ID="Remarks" runat="server" TextMode="MultiLine" Height="54px" Width="280px"></asp:TextBox></td>
    </tr>
    </table>
    
    
    </div>
    <center>
    
    <asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Submit" OnClick="Button1_Click" /></center>
    <%--</form>--%>
</asp:Content>
