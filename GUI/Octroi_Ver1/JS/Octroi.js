// JScript File
User_Ctrl_FrmNm="ctl00_MyCPH1_UCMyPaymentControl1_"

/******************On Submit Octroi Bill Calculation *************************/
FRM_NM="ctl00_MyCPH1_"
function OctroiBill_OnSubmit()
 { 
           
//alert("hi...1")
            FRM_NM="ctl00_MyCPH1_"            
            var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;            
	         var MIn_dt=document.getElementById(FRM_NM+"Hnd_Mindate").value
             var Max_Date =document.getElementById(FRM_NM+"Hnd_Maxdate").value
				if(document.getElementById(FRM_NM+"txtbgndt").value=="")
				{
				  alert("Please Enter the Bill Date")
				  document.getElementById(FRM_NM+"txtbgndt").focus();
				  return false;
				}

				var dt =document.getElementById(FRM_NM+"txtbgndt").value
				var hdndockdt;
				var hdndockNo;
				var txtrcptdate;
			    var Maxdt="01/01/2007";
			    var mTotalRecords = "<%=intTotalRecords %>";
			    Grid_Id="OctroiBillDetails1_DataGrid1"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
//alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 Check_One="N"
                // alert(rows)
               for(var b=2;b<=rows;b++)
                  {
                    //alert(b)
                    if(b < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidDockDate";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdockno";
                        txtrcptdate = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtrcptdate";
                        hidrcptdate = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidrcptdate";
                        
                        txtdeclval = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdeclval";
                        hiddeclval = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hiddeclval";
                        
                        txtoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtoctamt";
                        hidoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidoctamt";
                        
                        txtrcptno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtrcptno";
                        hidrcptno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidrcptno";
                         
                        
                       // alert(hdndockdt)
                       // checkyn = document.getElementById("ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_chkOrderNo").checked;
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_hidDockDate";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_txtdockno";
                         txtrcptdate = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_txtrcptdate";
                         hidrcptdate = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_hidrcptdate";
                        
                        txtdeclval = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_txtdeclval";
                        hiddeclval = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_hiddeclval";
                        
                        txtoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_txtoctamt";
                        hidoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_hidoctamt";
                        
                        txtrcptno = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_txtrcptno";
                        hidrcptno = "ctl00_MyCPH1_"+Grid_Id+"_ctl"  + b + "_hidrcptno";                       
                        
                        
                       // checkyn = document.getElementById("ctl00_MyCPH1_dockdata_ctl" + b + "_chkOrderNo").checked;
                    }
                    //alert(document.getElementById(hdndockdt).value)
                   if(document.getElementById(hdndockno).value!="")
                   {
                             var Maxdt1 =Maxdt
    				         Check_One="Y"
				             var Maxdt_dd=Maxdt1.substring(0,2)
				             var Maxdt_mm=Maxdt1.substring(3,5)
				             var Maxdt_yy=Maxdt1.substring(6,10)
                                
		                     var hdndockdt1 =hdndockdt
				             var hdndockdt_dd=hdndockdt1.substring(0,2)
				             var hdndockdt_mm=hdndockdt1.substring(3,5)
				             var hdndockdt_yy=hdndockdt1.substring(6,10)
        				    
				             Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                     hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

                            if (hdndockdt1>Maxdt1)
                            {
                            Maxdt1=hdndockdt1
                            Maxdt=hdndockdt
                            }
                               if(document.getElementById(txtrcptdate).value== "")
                                {
                                    alert("Please Enter Receipt Date....");  
                                    document.getElementById(txtrcptdate).focus(); 
                                    return false;                         
                                }
                        document.getElementById(hiddeclval).value = document.getElementById(txtdeclval).value;
                        document.getElementById(hidoctamt).value = document.getElementById(txtoctamt).value;
                        document.getElementById(hidrcptno).value = document.getElementById(txtrcptno).value;
                        document.getElementById(hidrcptdate).value = document.getElementById(txtrcptdate).value;                              
                  }
                }
//alert("hi...2")
               var dt =document.getElementById(FRM_NM+"txtbgndt").value
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
				
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
				
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}

			    var MIn_dt1 =MIn_dt;
				var MIn_dt_dd=MIn_dt1.substring(0,2);
				var MIn_dt_mm=MIn_dt1.substring(3,5);
				var MIn_dt_yy=MIn_dt1.substring(6,10);
				MIn_dt1=new Date(months[parseFloat(MIn_dt_mm)] + " " + parseFloat(MIn_dt_dd) + ", " + parseFloat(MIn_dt_yy));
				
				 var Max_Date1 =Max_Date;
				var Max_Date_dd=Max_Date1.substring(0,2);
				var Max_Date_mm=Max_Date1.substring(3,5);
				var Max_Date_yy=Max_Date1.substring(6,10);
				Max_Date1=new Date(months[parseFloat(Max_Date_mm)] + " " + parseFloat(Max_Date_dd) + ", " + parseFloat(Max_Date_yy));
				 Fromdate1=Maxdt1
			     Fromdate=Maxdt
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}
//alert("hi..")
		        if (dt<MIn_dt1)
				{
						    alert( "Bill Date Should  be Greater than "+ MIn_dt + " !!!");
						    document.getElementById(FRM_NM+"txtbgndt").focus();
						    return false;
				}
				if (dt>Max_Date1)
				{
						    alert( "Bill date should  be less than  "+ Max_Date + " !!!");
						    document.getElementById(FRM_NM+"txtbgndt").focus();
						    return false;
				}
                
				if(document.getElementById(FRM_NM+"txtduedate").value=="")
				{
						alert("Please enter the Bill Due Date");
						document.getElementById(FRM_NM+"txtduedate").focus();
						
						return false;
				}
//alert("hi..1")
				var bduedt  =document.getElementById(FRM_NM+"txtduedate").value;
				var bduedt_dd=bduedt.substring(0,2);
				var bduedt_mm=bduedt.substring(3,5);
				var bduedt_yy=bduedt.substring(6,10);
                bduedt1=new Date(months[parseFloat(bduedt_mm)] + " " + parseFloat(bduedt_dd) + ", " + parseFloat(bduedt_yy));
			  	if (dt>bduedt1)
				{
						alert( "Bill Due date should be greater than Bill date !!!");
						document.getElementById(FRM_NM+"txtduedate").focus();
						return false ;
				}	
//alert("hi..2")
				billcolbrcd=document.getElementById(FRM_NM+"txtbillcolloc").value;
				billsubbrcd=document.getElementById(FRM_NM+"txtbillsubloc").value;
				if(billsubbrcd=="")
				{
					alert("Please enter Submission Branch");
					document.getElementById(FRM_NM+"txtbillsubloc").focus();
					return false;
				} 
//alert("hi..3")
				 var Search_Char="~"
		        if (document.getElementById(FRM_NM+"txtbillsubloc").value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  Submission Location  Name~Code Format");
		           document.getElementById(FRM_NM+"txtbillsubloc").focus();
		           return false
		        }

				if(billcolbrcd=="")
				{
					alert("Please enter Collection Branch");
					document.getElementById(FRM_NM+"txtbillcolloc").focus();
					return false;
				} 
				 if (document.getElementById(FRM_NM+"txtbillcolloc").value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  Collection Location  Name~Code Format");
		           document.getElementById(FRM_NM+"txtbillcolloc").focus();
		           return false
		        }	 
		        
		        if(document.getElementById(FRM_NM+"Hnd_manual_billno_Mandatory").value=="Y")
		        {
				    if(document.getElementById(FRM_NM+"txtManualbillno").value=="")
				    {
						    alert("Please enter Manual Billno");
						    document.getElementById(FRM_NM+"txtManualbillno").focus();
						    return false;
				    }
				 } 
				if(parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt")).value <=0)
				{
						alert("Bill Amount Should be Greater Then Zero !!");
						//parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						return false;
				} 
				if(document.getElementById(FRM_NM+"Hnd_ON_CR_Limit_Allow").value=="N")
				{
				    if(parseFloat(document.getElementById(FRM_NM+"Lbl_Credit_Limit").innerText)<parseFloat(document.getElementById(FRM_NM+"txtbillamt").value))
				    {
						    alert("Bill Amount is Greater Then Credit Limit Of The same Customer. !!");
						    //parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						    return false;
				    }
				} 
			if(document.getElementById(FRM_NM+"Hnd_OutStd_Limit_Allow").value=="N")
				{
				     if(parseFloat(document.getElementById(FRM_NM+"Lbl_Credit_Limit").innerText)<parseFloat(document.getElementById(FRM_NM+"Lbl_Outstanding_amt").innerText))
				     {
						    alert("OutStanding Amount is Greater Then Credit Limit Of The same Customer. !!");
						    //parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						    return false;
				     } 
				}
	 
            
              if(!confirm("Are You Sure That All Bill Details Are Correct Or Not"))
            return false;
                if (Check_One=="N")
                {
                                              alert( "PLz Enter Atleast Once Record !!!")
						                     // document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                      return false;
                }
                click_count=parseFloat(document.getElementById("ctl00$MyCPH1$click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00$MyCPH1$click_count").value=click_count
					document.getElementById(FRM_NM+"Txt_BillAmt").disabled=false
					return true;
				}
}
        
  
  
  
        
/******************On Submit Octroi Bill Entry Calculation *************************/
function OctroiBillEntry_OnSubmit()
 {
            // alert("hi...1")
           var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;
				if(document.getElementById(FRM_NM+"txtbilldt").value=="")
				{
				  alert("Please Enter the Bill Entry Date")
				  document.getElementById(FRM_NM+"txtbilldt").focus();
				  return false;
				}
				if(document.getElementById(FRM_NM+"txtOctAgent").value=="")
				{
				  alert("Please Enter the Octroi Agent")
				  document.getElementById(FRM_NM+"txtOctAgent").focus();
				  return false;
				}
				if(document.getElementById(FRM_NM+"txtagntbillno").value=="")
				{
				  alert("Please Enter Agent Bill No.")
				  document.getElementById(FRM_NM+"txtagntbillno").focus();
				  return false;
				}
                var Search_Char="~"
		        if (document.getElementById(FRM_NM+'txtOctAgent').value.indexOf(Search_Char)==-1)
		        {
		                           alert("Invalid Octroi Agent Name~Code Format");
		                           document.getElementById(FRM_NM+'txtOctAgent').focus();
		                           return false
		        }
                
			var dt =document.getElementById(FRM_NM+"txtbilldt").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			    var mTotalRecords = "<%=intTotalRecords %>";
			     Grid_Id="OctroiBillEntry1_gvBillEntry"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 //alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 Check_One="N"
                 
               for(var b=2;b<=rows-1;b++)
                  {
                    //alert(b)
                    if(b < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidDockDate";
                        hdndockNo = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdockno";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockNo = document.getElementById(hdndockNo).value;
                        
                        txtrcpdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtrcpdt";
                        hidrcpdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidrcpdt";                        
                        
                        txtoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtoctamt";
                        hidoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidoctamt";
                        
                        txtrcpno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtrcpno";
                        hidrcpno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidrcpno";
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_hidDockDate";
                        hdndockNo = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdockno";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockNo = document.getElementById(hdndockNo).value;
                        
                        txtrcpdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_txtrcpdt";
                        hidrcpdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_hidrcpdt";                        
                        
                        txtoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_txtoctamt";
                        hidoctamt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_hidoctamt";
                        
                        txtrcpno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_txtrcpno";
                        hidrcpno = "ctl00_MyCPH1_"+Grid_Id+"_ctl" +  b + "_hidrcpno";
                    }
                   // alert(hdndockNo)
                    if(hdndockNo!="")
                    {
                         var Maxdt1 =Maxdt
    				     Check_One="Y"
				         var Maxdt_dd=Maxdt1.substring(0,2)
				         var Maxdt_mm=Maxdt1.substring(3,5)
				         var Maxdt_yy=Maxdt1.substring(6,10)
                            
		                 var hdndockdt1 =hdndockdt
				         var hdndockdt_dd=hdndockdt1.substring(0,2)
				         var hdndockdt_mm=hdndockdt1.substring(3,5)
				         var hdndockdt_yy=hdndockdt1.substring(6,10)
    				    
				         Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                 hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

                        if (hdndockdt1>Maxdt1)
                        {
                        Maxdt1=hdndockdt1
                        Maxdt=hdndockdt
                        }
                    }
                    document.getElementById(hidoctamt).value = document.getElementById(txtoctamt).value;
                    document.getElementById(hidrcpno).value = document.getElementById(txtrcpno).value;
                    document.getElementById(hidrcpdt).value = document.getElementById(txtrcpdt).value;
                }
                //alert("hi....1....")
               // alert(document.getElementById(FRM_NM+"txtbilldt").value)
               var dt =document.getElementById(FRM_NM+"txtbilldt").value
               
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)
 //alert("hi....2...1")
		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
			//	 alert("hi....2...")
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                //alert(FinYear_fromdate)
				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
				//  alert("hi....2")
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"txtbilldt").focus();
						return false;
				}

			    Fromdate1=Maxdt1
			    Fromdate=Maxdt
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						document.getElementById(FRM_NM+"txtbilldt").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"txtbilldt").focus();
						return false;
				}
				if(document.getElementById(FRM_NM+"txtduedate").value=="")
				{
						alert("Please enter the Bill Due Date");
						document.getElementById(FRM_NM+"txtduedate").focus();
						
						return false;
				}
                
				if(document.getElementById(FRM_NM+"txtagntbilldt").value=="")
				{
						alert("Please enter the Agent Bill Due Date");
						document.getElementById(FRM_NM+"txtagntbilldt").focus();
						
						return false;
				}
			//alert("hi..1")
				var bduedt  =document.getElementById(FRM_NM+"txtduedate").value;
				var bduedt_dd=bduedt.substring(0,2);
				var bduedt_mm=bduedt.substring(3,5);
				var bduedt_yy=bduedt.substring(6,10);
                bduedt1=new Date(months[parseFloat(bduedt_mm)] + " " + parseFloat(bduedt_dd) + ", " + parseFloat(bduedt_yy));
			  	if (dt>bduedt1)
				{
						alert( "Bill Due date should be greater than Bill date !!!");
						document.getElementById(FRM_NM+"txtduedate").focus();
						return false ;
				}	
				 
				if(parseFloat(document.getElementById(FRM_NM+"txttotdue").value)<=0)
				{
						alert("BillEntry Amount Should be Greater Then Zero !!");
						//parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						return false;
				} 
				 
                if (Check_One=="N")
                {
                                              alert( "PLz Select  Atleast One Record !!!")
						                     // document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                      return false;
                }
                 if(!confirm("Are You Sure That All Details Are Correct Or Not"))
                 return false;
                click_count=parseFloat(document.getElementById("ctl00$MyCPH1$click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00$MyCPH1$click_count").value=click_count
					document.getElementById(FRM_NM+"txttotdue").disabled=false
					return true;
				}  
				 
				// alert("Done")
				// return false;
}





/******************On Submit Octroi Bill Entry Calculation *************************/
function OctroiDirectVoucher_OnSubmit()
 {
            // alert("hi...1")
            User_CTR_Frm_Name="ctl00_MyCPH1_UCMyPaymentControl1_"
           var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;
				if(document.getElementById(FRM_NM+"Txt_VoucherDate").value=="")
				{
				  alert("Please Enter the Bill Entry Date")
				  document.getElementById(FRM_NM+"Txt_VoucherDate").focus();
				  return false;
				}
				if(document.getElementById(FRM_NM+"txtOctAgent").value=="")
				{
				  alert("Please Enter the Octroi Agent")
				  document.getElementById(FRM_NM+"txtOctAgent").focus();
				  return false;
				}
                var Search_Char="~"
		        if (document.getElementById(FRM_NM+'txtOctAgent').value.indexOf(Search_Char)==-1)
		        {
		                           alert("Invalid Octroi Agent Name~Code Format");
		                           document.getElementById(FRM_NM+'txtOctAgent').focus();
		                           return false
		        }
                
			var dt =document.getElementById(FRM_NM+"Txt_VoucherDate").value
				var hdndockdt;
				var hdndockNo;
			    var Maxdt="01/01/2007";
			    var mTotalRecords = "<%=intTotalRecords %>";
			     Grid_Id="OctroiBillEntry1_gvBillEntry"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 //alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 Check_One="N"
                 
               for(var b=2;b<=rows-1;b++)
                  {
                    //alert(b)
                    if(b < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_hidDockDate";
                        hdndockNo = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdockno";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockNo = document.getElementById(hdndockNo).value;
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_hidDockDate";
                        hdndockNo = "ctl00_MyCPH1_"+Grid_Id+"_ctl" + "0" + b + "_txtdockno";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        hdndockNo = document.getElementById(hdndockNo).value;
                    }
                   // alert(hdndockNo)
                    if(hdndockNo!="")
                    {
                         var Maxdt1 =Maxdt
    				     Check_One="Y"
				         var Maxdt_dd=Maxdt1.substring(0,2)
				         var Maxdt_mm=Maxdt1.substring(3,5)
				         var Maxdt_yy=Maxdt1.substring(6,10)
                            
		                 var hdndockdt1 =hdndockdt
				         var hdndockdt_dd=hdndockdt1.substring(0,2)
				         var hdndockdt_mm=hdndockdt1.substring(3,5)
				         var hdndockdt_yy=hdndockdt1.substring(6,10)
    				    
				         Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                 hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

                        if (hdndockdt1>Maxdt1)
                        {
                        Maxdt1=hdndockdt1
                        Maxdt=hdndockdt
                        }
                    }
                }
                //alert("hi....1....")
               // alert(document.getElementById(FRM_NM+"txtbilldt").value)
               var dt =document.getElementById(FRM_NM+"Txt_VoucherDate").value
               
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)
 //alert("hi....2...1")
		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
			//	 alert("hi....2...")
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                //alert(FinYear_fromdate)
				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
				//  alert("hi....2")
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"Txt_VoucherDate").focus();
						return false;
				}
 			    Fromdate1=Maxdt1
			    Fromdate=Maxdt
			   // alert(Fromdate)
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						document.getElementById(FRM_NM+"Txt_VoucherDate").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"Txt_VoucherDate").focus();
						return false;
				}
				//alert(User_CTR_Frm_Name+"ddlPayMode")
				//alert(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value)
				 
				 if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="-1")
                        {
                                                   alert( "Plz Select Mode of Transacction !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	
                        if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both" && i>1)
                        {
                                                  alert( "You have Selected Multiple Records For Both Payment,You have to select Single Records For Both Paymtn!!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	                		                
		             if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         // document.getElementById(FRM_Name+"txtreqdt").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         
                    }
                    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
                    {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						            // document.getElementById(FRM_Name+"txtreqdt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
                         
                    }
                     else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         document.getElementById(User_CTR_Frm_Name+"txtCashAmt").focus();
						                          return false;
                         }
                          if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						             document.getElementById(User_CTR_Frm_Name+"txtChqAmt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
  
        
        }

            if(!confirm("Are You Sure That All Payment Details Are Correct Or Not"))
            return false; 
				 
                if (Check_One=="N")
                {
                                              alert( "PLz Select  Atleast One Record !!!")
						                     // document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                      return false;
                }
                click_count=parseFloat(document.getElementById("ctl00$MyCPH1$click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00$MyCPH1$click_count").value=click_count
					document.getElementById(FRM_NM+"txttotdue").disabled=false
					return true;
				}  
			 
				  
}

/*************************************************************************************************************
             FUNCTION FOr Check All
*************************************************************************************************************/
var  FRM_NM="ctl00_MyCPH1_"
function Check_All(Grd_Name,Obj_chk_All,Obj_Chk_Ind,CalC_YN)
	    {
	             
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked)
                 {
                      for(var b=2;b<=rows;b++)
                      {
                            // alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                            }       
                             
                                        document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=true
                           //alert("hi..")
                      }
                  }
                  else
                  {
                             for(var b=2;b<=rows;b++)
                              {
                                    //alert(b)
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                    
                                    document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false
                             
                              }
                  }
                  if(CalC_YN=="Y")
                  {
                   // alert("hi..1")
                     Check_Calc('GridDocList','ChkAll','Chk_Docno')
                     // alert("hi..2")
                  }
    }
    
        
    	function Check_Calc(Grd_Name,Obj_chk_All,Obj_Chk_Ind)
	    {        
	            
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                  var Check_ALL="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                  for(var b=2;b<=rows;b++)
                  {
                  
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                 //alert("1...."+b)
                                document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=true
                                if(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked==false)
                                {
                                    //alert(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked)
                                     Check_ALL="Y"
                                }
                                if(Check_ALL=="Y")
                                {
                                    document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=false
                                }
 
                    } 
                  
                  
                 
                
	    }
	    /*****************************************************************************************************************
	    
	    Octroi Bill payment
	    ******************************************************************************************************************/
	    
	    function OnSubmit_BillEntryPayment()
	{
	        //alert(GRID_ID)
	        //alert("hi;;")
	            var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			    GRID_ID="GV_BillList"
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0    
                //  alert(rows)
                  for(var b=2;b<=rows-1;b++)
                  {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_hnd_Billdate" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_hnd_Billdate";
                            }
                          //  alert("he...1")
                            hdndockdt = document.getElementById(hdndockdt).value;     
                                 Check_One="Y"
                                 i=i+1 
                                 var Maxdt1 =Maxdt
                				
				                 var Maxdt_dd=Maxdt1.substring(0,2)
				                 var Maxdt_mm=Maxdt1.substring(3,5)
				                 var Maxdt_yy=Maxdt1.substring(6,10)
                                    
		                         var hdndockdt1 =hdndockdt
				                 var hdndockdt_dd=hdndockdt1.substring(0,2)
				                 var hdndockdt_mm=hdndockdt1.substring(3,5)
				                 var hdndockdt_yy=hdndockdt1.substring(6,10)
				                 Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                         hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                     }
                                if (dt=="")
				                {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
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
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				              //  alert("hi...2")
			            if(document.getElementById(FRM_NM+"Txt_Manual_Voucherno").value=="")
			            {
			                alert("Plz Enter Manual Voucherno")
			                document.getElementById(FRM_NM+"Txt_Manual_Voucherno").focus();
			                return false;
			            }
			            
			            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="-1")
                        {
                                                   alert( "Plz Select Mode of Transacction !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	
                        if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both" && i>1)
                        {
                                                  alert( "You have Selected Multiple Records For Both Payment,You have to select Single Records For Both Paymtn!!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	                		                
		             if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         // document.getElementById(FRM_Name+"txtreqdt").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         
                    }
                    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
                    {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						            // document.getElementById(FRM_Name+"txtreqdt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
                         
                    }
                     else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         document.getElementById(User_CTR_Frm_Name+"txtCashAmt").focus();
						                          return false;
                         }
                          if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						             document.getElementById(User_CTR_Frm_Name+"txtChqAmt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
  
        
        }

            if(!confirm("Are You Sure That All Payment Details Are Correct Or Not"))
            return false; 
           
       	document.getElementById(User_CTR_Frm_Name+"txtChqDate").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqNo").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtNetPay").disabled=false
		document.getElementById(User_CTR_Frm_Name+"txtCashAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").disabled=false	
}   