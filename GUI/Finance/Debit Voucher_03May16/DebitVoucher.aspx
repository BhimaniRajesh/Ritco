<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
     CodeFile="DebitVoucher.aspx.cs" Inherits="GUI_Finance_Accounts_Debit_Voucher_DebitVoucher"
    Title="Debit Voucher" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("Div1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var FinYear="<%=Session["FinYear"]%>";
        
        //maintain this for back dated entery not allowed in RCPL
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
		
		var dtCh= "/";
        var minYear="1900";
        var maxYear="2100";
        
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
        function ValidateDate1(obj)
        {
          if (obj.value!="")
          { 
	        if (isDate(obj.value)==false)
	        {
		        obj.focus()
		        return false
	        }
	        var svctx_yn = document.getElementById("ctl00_MyCPH1_Svctax_yn");
	        var tdstx_yn = document.getElementById("ctl00_MyCPH1_TDS_yn");
	        var txtsvctax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
            var txtEduCess = document.getElementById("ctl00_MyCPH1_txtEduCess");
            var txtHEducess = document.getElementById("ctl00_MyCPH1_txtHEduCess");
            var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
            var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate");
            var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
            var rows=tbl.rows.length;
            if(rows < 10)
            {
                TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + rows + "_txtTotAmt");
            }
            else
            {
                TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + rows + "_txtTotAmt");
            }
        
            var txtAmtAppl = document.getElementById("ctl00_MyCPH1_txtAmtAppl");
            var txtAmtApplL = document.getElementById("ctl00_MyCPH1_txtAmtApplL");
            var txtAmtApplA = document.getElementById("ctl00_MyCPH1_txtAmtApplA");
            var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
            var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
            var txtNetPay = document.getElementById("ctl00_MyCPH1_txtNetPay");
        
	        if(svctx_yn.checked)
	        {
	            svctx_yn.checked = false;
	            txtsvctax.value="0.00";
	            txtEduCess.value="0.00";
	            txtHEducess.value="0.00";
	        }
	        if(tdstx_yn.checked)
	        {
	            tdstx_yn.checked = false;
	            txtTDSAmt.value = "0.00";
	            txtTDSRate.value = "0.00";
	        }
	        txtAmtAppl.value = TotAmt.value;
	        txtAmtApplL.value = TotAmt.value;
	        txtAmtApplA.value = TotAmt.value;
	        txtNetPay.value = TotAmt.value;
            return true
          }
        }
        function popuplist(mode,ctlid,tbl)
        {    
              var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
              var url="";
              url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
              confirmWin=window.open(url,"",winOpts);
              return false;
        }
        function LocBlur(id)
        {   
            var str="";
            for(var i=0;i<id.length-14;i++)
            {
                str+=id.charAt(i);
            }
            document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
            var txtLocation=document.getElementById(id);
           
            var Location=txtLocation.value;
            if(Location=="")
                return false;
         
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
             var strpg="CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
             findobj.open("GET",strpg,true);
             findobj.onreadystatechange=function()
                 {
                     if(findobj.readyState==4 && findobj.status==200)
                        {
                            var res=findobj.responseText.split("|");
                            if(res[0]=="false")
                            {
                                alert("Location Code is not Valid... Please Enter Valid Location Code");
                                txtLocation.value="";
                                txtLocation.focus();
                                return false;
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
            document.getElementById(id).value=document.getElementById(id).value.toUpperCase();
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
        function Manualbillblur(id)
        {
            //debugger;
            var txtManualBillno=document.getElementById(id);
            var Manualbill = txtManualBillno.value;
            if(Manualbill=="")
            {
                return false
            }
            if(Manualbill=="NA")
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
        function PaidBlur(id)
         {
         
            var str="";
            for(var i=0;i<id.length-9;i++)
            {
                str+=id.charAt(i);
            }
            document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
            var txtLocation=document.getElementById(id);
           
            var Location=txtLocation.value.toUpperCase();
            if(Location=="")
                return false;
         
            var findobj=false;
            findobj=GetXMLHttpObject();
            if(findobj)
            {
             var strpg="CheckVendorCode.aspx?mode=Paid&Code=" + Location + "&sid=" + Math.random();
             findobj.open("GET",strpg,true);
             findobj.onreadystatechange=function()
                 {
                     
                     if(findobj.readyState==4 && findobj.status==200)
                        {
                            var res=findobj.responseText.split("|");
                            if(res[0]=="false")
                            {
                                alert("Vendor/Customer Code is not Valid... Please Enter Valid Vendor Code");
                                txtLocation.value="";
                                txtLocation.focus();
                                return false;
                            }
                            else
                            {
                                document.getElementById('ctl00$MyCPH1$txtPaidTo_Name').value = res[0];
                            }
                           
                        }
                 }
            findobj.send(null);
            }
            return false;
        }
        function openVend()
        {
                window.open('popup-vendor.aspx?type=ven' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
        }
        function openCust()
        {
                window.open('popup-customer.aspx?type=cust' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
        }
        function Nagative_Chk_wDecimal(obj)
        {
	        var temp
	        temp=obj.value			
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
        function Nagative_Chk_wDecimal_SvcTax(obj)
        {
	        var temp
	        temp=obj.value 
	        var HdnRoundOffRule = document.getElementById("ctl00_MyCPH1_hdnroundoff");
	        //alert(temp)					
	        if (temp=="")	
	        {
		        alert("Value can not be blank")
		        obj.focus();
		        if(HdnRoundOffRule.value == "Y")
                    obj.value="0";
                else
                    obj.value="0.00";                    
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
	        obj.value=roundit(temp) 
	        return true;					   
        }
        function Nagative_Chk_wDecimal_TDS(obj,type)
        {
	        var temp
	        temp=obj.value
	        //alert(type);
	        var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate");
            var txtTDSAmt = document.getElementById("ctl00_MyCPH1_txtTDSAmt");
	        if (temp=="")	
	        {
		        alert("Value can not be blank")
		        if(type == "Tdsrate")
	                obj.value = "0.000";
	            else
	                obj.value="0.00";
	            obj.focus();    
                //obj.value="0.000";
		        return false;
	        }
	        if(isNaN(temp))
	        {
		        alert("Value should be Numeric")
		        if(type == "Tdsrate")
	                obj.value = "0.000";
	            else
	                obj.value="0.00";
	            obj.focus();
		        return false;
	        } 					  
	        if(parseFloat(temp)<0)
	        {
		        alert("Value should be greater than zero")
		        if(type == "Tdsrate")
	                obj.value = "0.000";
	            else
	                obj.value="0.00";
	            obj.focus();
		        return false;
	        }
	        obj.value=roundit_TDS(temp) 
	        if(type == "Tdsrate")
	            txtTDSAmt.value = "0.00";
	        else
	            txtTDSRate.value = "0.000";
	        return true;					   
        }
        function roundit_TDS(Num)
        {
            Places=3
            if (Places > 0) 
            {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
                {
	                if (Num.toString().lastIndexOf('.') < 0) 
	                {
		                return Num.toString() +'.000';
	                }
	                var Rounder = Math.pow(10, Places);
	                return Math.round(Num * Rounder) / Rounder;
                }
                else 
                {
	                if (Num.toString().lastIndexOf('.') < 0) 
	                {
		                return Num.toString() +'.000';
	                }
	                else
	                {   
		                if (Num.toString().lastIndexOf('.')+1 == Num.toString().length-1)
			                return Num.toString() +'00';
			            else if (Num.toString().lastIndexOf('.')+2 == Num.toString().length-1)
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
	    function CheckPan(obj)
	    {
	        if(obj.value!="")
	        {
	            if(obj.value.length!=10)
                {
                    alert("PAN No length Should be > 10");
                    obj.focus();
                    return false;
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
			    alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO Journal Voucher  Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
			    date.focus();
			    return false;
		    }
    		
		    if (dt>server_dt)
		     {
                alert( voucher + " Date should not be Greater than today's date !!!")
                date.focus();
                return false;
		     }
		    //This Case is Only For RCPL Client
		    if (dt<server_dt)
            {
	            if(client == 'RCPL')
                {
        	        if(brcd != 'HQTR')
                    {     
                        //alert( voucher + " Date should not be Less than today's date !!!")
                        //date.focus();
                        //return false;
                    }   
                }
                if(client == 'Ritco')
                {
        	        //alert( voucher + " Date should not be Less than today's date !!!")
                    //date.focus();
                    //return false;
                }
            }
		    return true;   
	    }
	function GetTot()
	{
	    var i,Amt,TotAmt,T=0;
	    var HdnRoundOffRule = document.getElementById("ctl00_MyCPH1_hdnroundoff");
	    var txtNarration = document.getElementById("ctl00_MyCPH1_txtNarration");
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        {
            if(i<10)
            {
               Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAmt").value;
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               Narration=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtNarration"); 
            }
            else
            {
                Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAmt").value;
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
                Narration=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtNarration");
            }
            if(Acccode!="")
            {
                T = parseFloat(Number(T) + Number(Amt)).toFixed(2);
                //Narration.value = txtNarration.value;
            }
        }
        
        var j = Number(rows);
        
        if(j<10)
        {
           TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + j + "_txtTotAmt");
        }
        else
        {
           TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + j + "_txtTotAmt");
        }
        
        //TotAmt.value = T;
        
        if(HdnRoundOffRule.value == "Y")
            TotAmt.value = rounditn(Math.round(Number(T)),2);
        else
            TotAmt.value = roundNumber((Number(T)),2);
        
        var AmtAppl = document.getElementById("ctl00_MyCPH1_txtAmtAppl");
        
        //AmtAppl.value = roundit(TotAmt.value,2);
        
        if(HdnRoundOffRule.value == "Y")
            AmtAppl.value = rounditn(Math.round(TotAmt.value),2);
        else
            AmtAppl.value = roundNumber((TotAmt.value),2);
        
        
        var HdnServiceTaxRate = document.getElementById("ctl00_MyCPH1_HdnServiceTaxRate");
        var HdnEduCessRate = document.getElementById("ctl00_MyCPH1_HdnEduCessRate");
        var HdnHEduCessRate = document.getElementById("ctl00_MyCPH1_HdnHEduCessRate");
        
        var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
        var txtEduCess = document.getElementById("ctl00_MyCPH1_txtEduCess");
        var txtHEduCess = document.getElementById("ctl00_MyCPH1_txtHEduCess");
        
        var HdnServiceTax = document.getElementById("ctl00_MyCPH1_HdnServiceTax");
        var HdnEduCess = document.getElementById("ctl00_MyCPH1_HdnEduCess");
        var HdnHEduCess = document.getElementById("ctl00_MyCPH1_HdnHEduCess");

        var txtSBCess = document.getElementById("ctl00_MyCPH1_txtSBCess");
        var HdnSBCRate = document.getElementById("ctl00_MyCPH1_HdnSBCRate");
        
        var hdneditablsvctaxrate = document.getElementById("ctl00_MyCPH1_hdneditablsvctaxrate");
        var txtSvrTaxRate = document.getElementById("ctl00_MyCPH1_txtSvrTaxRate");
        
        if(hdneditablsvctaxrate.value == "Y")
        {   
            if(Number(txtSvrTaxRate.value) > 100)
            {
                alert("Service Tax Rate Should Not Greater Than 100%");
                txtSvrTaxRate.value = "0.00";
                txtSvrTaxRate.focus();
                //return false;
            }
            HdnServiceTaxRate.value = txtSvrTaxRate.value;
        }
        
        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
        {
            txtServiceTax.value=rounditn((parseFloat(AmtAppl.value)*parseFloat(HdnServiceTaxRate.value)/100),2);
            txtEduCess.value=rounditn((parseFloat(txtServiceTax.value)*parseFloat(HdnEduCessRate.value)/100),2);
            txtHEduCess.value=rounditn((parseFloat(txtServiceTax.value)*parseFloat(HdnHEduCessRate.value)/100),2);
            txtSBCess.value = rounditn((parseFloat(AmtAppl.value) * parseFloat(HdnSBCRate.value) / 100), 2);

            if(HdnRoundOffRule.value == "Y")
            {
                txtServiceTax.value=rounditn(Math.round(txtServiceTax.value),2);
                txtEduCess.value=rounditn(Math.round(txtEduCess.value),2);
                txtHEduCess.value = rounditn(Math.round(txtHEduCess.value), 2);
                txtSBCess.value = rounditn(Math.round(txtSBCess.value), 2);
            }
            else
            {
                txtServiceTax.value=roundNumber(txtServiceTax.value,2);
                txtEduCess.value=roundNumber(txtEduCess.value,2);
                txtHEduCess.value = roundNumber(txtHEduCess.value, 2);
                txtSBCess.value = roundNumber(txtSBCess.value, 2);
            }
            
            HdnServiceTax.value = txtServiceTax.value;
            HdnEduCess.value = txtEduCess.value;
            HdnHEduCess.value = txtHEduCess.value;
            
        }
        else
        {
            txtServiceTax.value="0.00";
            txtEduCess.value="0.00";
            txtHEduCess.value="0.00";
            txtSBCess.value = "0.00";

            HdnServiceTax.value = txtServiceTax.value;
            HdnEduCess.value = txtEduCess.value;
            HdnHEduCess.value = txtHEduCess.value;
        }
              
        //var TP = parseFloat(Number(AmtAppl.value)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value));
        
        var TP = 0;
        
        if(HdnRoundOffRule.value == "Y")
        {   
            TP = rounditn(Math.round(Number(AmtAppl.value) + Number(txtServiceTax.value) + Number(txtEduCess.value) + Number(txtHEduCess.value) + Number(txtSBCess.value)), 2);
        }
        else
        {
            TP = roundNumber((Number(AmtAppl.value) + Number(txtServiceTax.value) + Number(txtEduCess.value) + Number(txtHEduCess.value) + Number(txtSBCess.value)), 2);
        }
        
        var AmtApplL = document.getElementById("ctl00_MyCPH1_txtAmtApplL");
        
        //AmtApplL.value = roundit(TP,2);
        
        if(HdnRoundOffRule.value == "Y")
        {   
            AmtApplL.value = rounditn(Math.round(TP),2);
        }
        else
        {
            AmtApplL.value = roundNumber(TP,2);                    
        }
        
        var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
        var HdnTdsAmt= document.getElementById("ctl00_MyCPH1_HdnTdsAmt");
        var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate");
        var HdnTDSRate = document.getElementById("ctl00_MyCPH1_HdnTDSRate");
        var txtSrvTaxNo = document.getElementById("ctl00_MyCPH1_txtSrvTaxNo");
        
        if(HdnRoundOffRule.value == "Y")
        {   
            txtTDSAmt.value = rounditn(Math.round(txtTDSAmt.value),2);
        }
        else
        {
            txtTDSAmt.value = roundNumber(txtTDSAmt.value,2);                    
        }
        
        HdnTDSRate.value = txtTDSRate.value;
        HdnTdsAmt.value = txtTDSAmt.value;
                
        if(Number(HdnTDSRate.value) > 100)
        {
            alert("TDS Rate Should Not Greater Than 100%");
            txtTDSRate.value = "0.000";
            txtTDSAmt.value = "0.00";
            HdnTDSRate.value = txtTDSRate.value;
            HdnTdsAmt.value = txtTDSAmt.value;
            txtTDSRate.focus();
            return false;
        }
        // This code is edited for editable tds rate and tds amount
        
        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked)
        {   
            if(Number(HdnTDSRate.value) > 0)
            {   
                if(HdnRoundOffRule.value == "Y")
                {   
                    txtTDSAmt.value = rounditn(Math.round((Number(AmtApplL.value)* Number(HdnTDSRate.value))/Number(100)),2);
                }
                else
                {
                    txtTDSAmt.value = roundNumber(((Number(AmtApplL.value)* Number(HdnTDSRate.value))/Number(100)),2);
                }
                HdnTdsAmt.value = txtTDSAmt.value;
                HdnTDSRate.value = txtTDSRate.value;
                
                if(Number(HdnTDSRate.value) > 100)
                {
                    alert("TDS Rate Should Not Greater Than 100%");
                    txtTDSRate.value = "0.000";
                    txtTDSAmt.value = "0.00";
                    HdnTDSRate.value = txtTDSRate.value;
                    HdnTdsAmt.value = txtTDSAmt.value;
                    txtTDSRate.focus();
                    return false;
                }
            }
            else if(Number(HdnTdsAmt.value) > 0)
            {   
                txtTDSRate.value = rounditn((parseFloat((Number(HdnTdsAmt.value)) * Number(100)/Number(AmtApplL.value)).toFixed(3)),3);
                HdnTDSRate.value = txtTDSRate.value;
                HdnTdsAmt.value = txtTDSAmt.value;
                if(Number(HdnTdsAmt.value) > Number(AmtApplL.value))
                {
                    alert("TDS Amount Should Not Greater Than Applicable Amount");
                    txtTDSRate.value = "0.000";
                    txtTDSAmt.value = "0.00";
                    HdnTDSRate.value = txtTDSRate.value;
                    HdnTdsAmt.value = txtTDSAmt.value;
                    txtTDSRate.focus();
                    return false;
                }
            }
        }
        else
        {
            txtTDSAmt.value = "0.00";
            txtTDSRate.value = "0.000";
            HdnTdsAmt.value = txtTDSAmt.value;
            HdnTDSRate.value = txtTDSRate.value;
        }
        //END
        
        var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
        
        txtNetPay.value = roundit((parseFloat(Number(AmtAppl.value) - Number(txtTDSAmt.value) + Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtSBCess").value))), 2);
        document.getElementById("ctl00_MyCPH1_txtAmtApplA").value=roundit((txtNetPay.value),2);
        document.getElementById("ctl00_MyCPH1_Hnd_totalAmount").value=roundit((txtNetPay.value),2);
        
        /* edited on 26/06/2008 by MANISH KHER */
       
        var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
        
        var txtCashAmt = "";
        var txtChqAmt = "";
        
        if(ddlPayMode.value == "Cash")
        {
            txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
            txtCashAmt.value = document.getElementById("ctl00_MyCPH1_txtAmtApplA").value;
        }
        if(ddlPayMode.value == "Bank")
        {
            txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
            txtChqAmt.value = document.getElementById("ctl00_MyCPH1_txtAmtApplA").value;
        }
        if(ddlPayMode.value == "Both")
        {
            txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
            txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
            
            txtCashAmt.value = "";     
            txtChqAmt.value = "";
        }
        var txtChqAmt  = document.getElementById("ctl00_MyCPH1_txtChqAmt");
        
        /* for DRS & OTHER CLIENT ONLY */
        
        return false;
	}
	function CheckCashBank()
	{
	    var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
	    var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
	    var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
	    var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
	    var temp;
	    
	    if(ddlPayMode.value == "Cash")
	    {
	        if(txtCashAmt.value !=  txtNetPay.value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                txtCashAmt.focus();
                txtCashAmt.value = "";
                return false;
            }
         }
         else if(ddlPayMode.value == "Bank")
         {
            if(txtChqAmt.value !=  txtNetPay.value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                txtChqAmt.focus();
                txtChqAmt.value = "";
                return false;
            }
         }
         else if(ddlPayMode.value == "Both")
         {
            
            if(txtCashAmt.value == 0.00 || txtCashAmt.value == "")
            {
                if(Number(txtChqAmt.value) > Number(txtNetPay.value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtChqAmt.focus();
                    return false;
                }
            }
            else if (txtChqAmt.value == 0.00 || txtChqAmt.value == "")
            {
                if(Number(txtCashAmt.value) > Number(txtNetPay.value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtCashAmt.focus();
                    return false;
                }
            }
            else
            {
                //temp = parseFloat(Number(txtCashAmt.value) + Number(txtChqAmt.value));
                //if(temp !=  txtNetPay.value)
                if(roundit((parseFloat(txtCashAmt.value) + parseFloat(txtChqAmt.value)),2) != roundit((txtNetPay.value),2))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtCashAmt.value = "";
                    txtChqAmt.value = "";
                    return false;
                }
            }
         }
	}
	
	function FillNarration(id)
	{   
	    id.value = id.value.toUpperCase();
	    
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var Totalcount=tbl.rows.length;
        var Acccode = "",Narration = "";
        for(i = 2; i < Totalcount ; i++)
        {
            if(i<10)
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               Narration=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtNarration"); 
            }
            else
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
               Narration=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtNarration");
            }
            if(Acccode != "")
            {
                Narration.value = id.value;
            }
        }   
	    
	}
	function CheckData()
	{
	    //debugger;
	    var ddlBusinessDiv =  document.getElementById("ctl00_MyCPH1_ddlBusinessDiv");
        var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
        var txtManualNo = document.getElementById("ctl00_MyCPH1_txtManualNo");
        var txtPreparedLoc = document.getElementById("ctl00_MyCPH1_txtPreparedLoc");
        var txtPreparedBy = document.getElementById("ctl00_MyCPH1_txtPreparedBy");
        var txtAccLoc = document.getElementById("ctl00_MyCPH1_txtAccLoc");
        var txtPreparedFor = document.getElementById("ctl00_MyCPH1_txtPreparedFor");
        var txtReferenceNo = document.getElementById("ctl00_MyCPH1_txtReferenceNo");
        var txtPaidTo = document.getElementById("ctl00_MyCPH1_txtPaidTo");
        var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
        var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
        var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
        var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
        var txtChqNo = document.getElementById("ctl00_MyCPH1_txtChqNo");
        var txtAcc = document.getElementById("ctl00_MyCPH1_txtAcc");
        var txtBank = document.getElementById("ctl00_MyCPH1_txtBank");
        var txtChqDate = document.getElementById("ctl00_MyCPH1_txtChqDate");
        var ddrCashcode = document.getElementById("ctl00_MyCPH1_ddrCashcode");
        var ddrBankaccode = document.getElementById("ctl00_MyCPH1_ddrBankaccode");
	    var txtCode = document.getElementById("ctl00_MyCPH1_txtCode");
	    var Dr_Pbov_list = document.getElementById("ctl00_MyCPH1_Dr_Pbov_list");
	    var RAD_Customer = document.getElementById("ctl00_MyCPH1_RAD_Customer");
	    var RAD_Vendor = document.getElementById("ctl00_MyCPH1_RAD_Vendor");
	    var RAD_Emp = document.getElementById("ctl00_MyCPH1_RAD_Emp");
	    var RAD_Driver = document.getElementById("ctl00_MyCPH1_RAD_Driver");
	    var RAD_Vehicle = document.getElementById("ctl00_MyCPH1_RAD_Vehicle");
	    
	    var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)
             
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
            txtManualNo.focus();
            return false;
        }
        if(ddlBusinessDiv.value == "-1")
	    {
	        alert("Please Selet Business Division");
	        ddlBusinessDiv.focus();
	        return false;
	    }   
        if(txtPreparedLoc.value == "")
        {
            alert("Please Enter Prepared Location");
            txtPreparedLoc.focus();
            return false;
        }
        if(txtPreparedBy.value == "")
        {
            alert("Please Enter Prepared By");
            txtPreparedBy.focus();
            return false;
        }
        if(txtAccLoc.value == "")
        {
            alert("Please Enter Account Location");
            txtAccLoc.focus();
            return false;
        }
        if(Dr_Pbov_list.value == "" && txtCode.value == "")
        {
            alert("Please Select Customer/Vendor/Employee Name");
            Dr_Pbov_list.focus();
            return false;
        }
        
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var Totalcount=tbl.rows.length;
        var Acccode_flag="N";
        for(i = 2; i < Totalcount ; i++)
        {
            if(i<10)
            {
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
            }
            else
            {
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
            }
            if(Acccode!="")
            {
                Acccode_flag="Y";
            }
            //alert(Acccode);
            
            if(client == "PTN")
            {
                //alert("client " + client);   
                //alert("Acccode " + Acccode);   
                //alert("Manual Code " + txtCode.value);  
                //alert("RAD_Emp.checked " + RAD_Emp.checked); 
                
                if(Acccode == "ACA0040" || Acccode == "ACA0041" || Acccode == "CLA0001" || Acccode == "CLA0004" || Acccode == "ACA0028" || Acccode == "ACA0029" || Acccode == "CLA0028")
                {
                    if(txtCode.value != "" || RAD_Emp.checked == false)
                    {   
                        alert("You Can't Select Vendor Or Customer Or Driver Or Vehicle Or Enter Manual Employee");
                        alert("Plz Select Employee from Employee List");
                        
                        txtCode.value = "";
                        txtCode.disabled = true;
                        
                        RAD_Customer.checked = false;
                        RAD_Vendor.checked = false;
                        RAD_Driver.checked = false;
                        RAD_Vehicle.checked = false;
                        
                        RAD_Customer.disabled = true;
                        RAD_Vendor.disabled = true;
                        RAD_Driver.disabled = true;
                        RAD_Vehicle.disabled = true;
                        RAD_Emp.disabled = false;
                        
                        Dr_Pbov_list.focus();
                        
                        return false;
                    }   
                }   
            }
        }
       if(Acccode_flag!="Y")
       {
             alert("Please Enter Atleast One Account Code");
             return false;
       }
       for(i = 2; i < Totalcount ; i++)
        {
           if(i<10)
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAmt");
            }
            else
            {
               Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAmt");
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
            }
            if(Acccode!="")
            {
                if(parseFloat(Amount.value)<= 0 )
                    {
                         alert("Please Enter Amount Greater than Zero");
                         Amount.focus();
                         return false;
                    }
             }
        }
        
       var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
	   var txtSrvTaxNo = document.getElementById("ctl00_MyCPH1_txtSrvTaxNo");
	   var txtPanNo = document.getElementById("ctl00_MyCPH1_txtPanNo");
	   var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
	   
	   if(parseFloat(txtServiceTax.value)>0.00)
       {
            if(txtSrvTaxNo.value == "")
            {
                alert("Please Enter Service Tax No.");
                txtSrvTaxNo.focus();
                return false;
            }
            
       }
       if(txtTDSAmt.value != 0.00)
       {
            if(txtPanNo.value == "")
            {
                alert("Please Enter Pan No.");
                txtPanNo.focus();
                return false;
            }
       }
       
        if(ddlPayMode.value == "-1")
        {
            alert("Please Enter Payment Mode");
            ddlPayMode.focus();
            return false;
        }
        if(ddlPayMode.value == "Cash" || ddlPayMode.value == "Both" )
        {
            if(ddrCashcode.value == "")
            {
                alert("Please Select Cash Account");
                ddrCashcode.focus();
                return false;
            }
            if(txtCashAmt.value == "")
            {
                 alert("Please Enter Cash Amount");
                 txtCashAmt.focus();
                return false;
            }
            
       }
        
       if(ddlPayMode.value == "Bank" || ddlPayMode.value == "Both" )
        {
            if(ddrBankaccode.value == "")
            {
                alert("Please Select Bank Account");
                ddrBankaccode.focus();
                return false;
            }
            if(txtChqAmt.value == "")
            {
                alert("Please Enter Cheque Amount");
                txtChqAmt.focus();
                return false;
            }
            if(txtChqNo.value == "")
            {
                alert("Please Enter Cheque Number");
                txtChqNo.focus();
                return false;
            }
           
            if(txtChqDate.value == "")
            {
                alert("Please Enter Cheque Date");
                txtChqDate.focus();
                return false;
            }
            //var dateflag = CheckFinacialYear(txtChqDate,"Cheque");
            
            //if(!dateflag)
            //    return false; 
       }
       
       if(ddlPayMode.value == "Both" )
       {
               
                //if(parseFloat(txtCashAmt.value)+parseFloat(txtChqAmt.value) != parseFloat(txtNetPay.value))
                if(roundit((parseFloat(txtCashAmt.value) + parseFloat(txtChqAmt.value)),2) != roundit((txtNetPay.value),2))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtCashAmt.value = "0.00";
                    txtChqAmt.value = "0.00";
                    return false;
                }
       }
       if(ddlPayMode.value == "Cash" )
       {
               
                if(parseFloat(txtCashAmt.value) != parseFloat(txtNetPay.value))
                {
                    alert("Cash Amount MUST be equal to Net payable");
                    txtCashAmt.value = "0.00";
                    //txtChqAmt.value = "0.00";
                    return false;
                }
       }
       if(ddlPayMode.value == "Bank" )
       {
               
                if(parseFloat(txtChqAmt.value) != parseFloat(txtNetPay.value))
                {
                    alert("Cheque Amount MUST be equal to Net payable");
                    //txtCashAmt.value = "0.00";
                    txtChqAmt.value = "0.00";
                    return false;
                }
       }
       
        document.getElementById("ctl00_MyCPH1_txtVoucherDate").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtManualNo").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtPreparedLoc").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtPreparedBy").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtAccLoc").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtPreparedFor").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtReferenceNo").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtNetPay").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtCashAmt").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtChqAmt").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtChqNo").disabled=false;
        document.getElementById("ctl00_MyCPH1_txtChqDate").disabled=false;
        document.getElementById('ctl00$MyCPH1$txtCode').disabled=false;
        document.getElementById("ctl00_MyCPH1_txtServiceTax").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtSrvTaxNo").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtPanNo").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtTDSAmt").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtAmtAppl").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtAmtApplL").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtAmtApplA").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtEduCess").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtTDSRate").disabled=false;
	    document.getElementById("ctl00_MyCPH1_txtHEduCess").disabled=false;
	    
	    //return false;
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        {
            if(i<10)
            {
               document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAmt").disabled=false;
               document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").disabled=false;
               document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtDescription").disabled=false;
               
            }
            else
            {
                document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAmt").disabled=false;
                document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").disabled=false;
                document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtDescription").disabled=false;
            }
            
        }
       if(i<10)
            document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" +  rows + "_txtTotAmt").disabled=false;
       else
            document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" +  rows + "_txtTotAmt").disabled=false ;
       
       //return false;
         
       if(click_count > 0)
        {
            alert("Sorry... You cannot click twice !!!");
            return false;
        }
       else
        {
            click_count=click_count+1;
            document.getElementById("ctl00_MyCPH1_click_count").value=click_count;
            return true;
        }
        
        //return false; 
          
	}
    </script>

    <div style="width: 10.0in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" border="0" /></a>
    </div>
    <div style="text-align: center; width: 10.0in">
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Debit Voucher</strong>
                </td>
            </tr>
        </table>
     <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><br />
     <asp:UpdatePanel ID="UpdatePanel3" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>  
              <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr style="background-color: White"> 
                  <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                    &nbsp;Voucher No</td>
                  <td class="blackfnt"  nowrap style="text-align: left"> <span style="color: #ff0000">&nbsp;&lt;System Generated&gt;</span></td>
                  <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Voucher Date</td>
                  <td width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                    <asp:TextBox ID="txtVoucherDate" runat="server" Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                                    id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a></td>
                  <td class="blackfnt" nowrap  style="text-align: left"> &nbsp;Manual No.</td>
                  <td class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                    <asp:TextBox ID="txtManualNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px" MaxLength="50"></asp:TextBox></td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;"   nowrap class="blackfnt"> &nbsp;Prepared at location</td>
                  <td class="blackfnt" style="text-align: left"> &nbsp; <asp:TextBox ID="txtPreparedLoc" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"  MaxLength="0"  Enabled="False"></asp:TextBox> 
                    <input id="btnPreparedLoc"  nowrap  type="button" value="..." runat="server" /></td>
                  <td style="text-align: left"   nowrap class="blackfnt"> &nbsp;Prepared By</td>
                  <td style="text-align: left"  nowrap  class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedBy" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"  MaxLength="50"  Enabled="False"></asp:TextBox></td>
                  <td style="text-align: left"   nowrap class="blackfnt"> &nbsp;Business Division</td>
                  <td style="text-align: left" nowrap   class="blackfnt"> &nbsp; 
                        <asp:DropDownList ID="ddlBusinessDiv" runat="server" Width="105px"> 
                        </asp:DropDownList>
                  </td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Accounting Location</td>
                  <td class="blackfnt" style="text-align: left"> &nbsp; <asp:TextBox ID="txtAccLoc" runat="server" BorderStyle="Groove" CssClass="input" Width="100px" MaxLength="5"  Enabled="False"></asp:TextBox> 
                    <input id="btnAccLoc" type="button" value="..." runat="server" /></td>
                  <td style="text-align: left" class="blackfnt"> &nbsp;Prepared For</td>
                  <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedFor" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px" MaxLength="50"></asp:TextBox></td>
                  <td style="text-align: left" class="blackfnt"> &nbsp;Reference No.</td>
                  <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtReferenceNo" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="100px" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr style="background-color: White"> 
                  <td rowspan="3" class="blackfnt" style="text-align: left; "> &nbsp;Paid To</td>
                  <td align="left"> <asp:RadioButton ID="RAD_Customer"  Checked="true" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Customer" OnCheckedChanged="Show_Pbov_list" />  </td>
                  <td align="left"><asp:RadioButton ID="RAD_Vendor" AutoPostBack="true" GroupName="Pbov_list" runat="server"  Text="Vendor" OnCheckedChanged="Show_Pbov_list" /></td>
                  <td align="left"><asp:RadioButton ID="RAD_Emp" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Employee" OnCheckedChanged="Show_Pbov_list" /></td>
                  <td align="left"><asp:RadioButton ID="RAD_Driver" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Driver" OnCheckedChanged="Show_Pbov_list" /></td>
                  <td align="left"><asp:RadioButton ID="RAD_Vehicle" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Vehicle" OnCheckedChanged="Show_Pbov_list" /></td>
                </tr>
                <tr style="background-color: White">
                  <td colspan="5" align="left"> 
                        <asp:DropDownList ID="Dr_Pbov_list" runat="server" Width="300px" CssClass="blackfnt"></asp:DropDownList>
                  </td>
                </tr>
                <tr style="background-color: White"> 
                  <td colspan="5" align="left">
                    <b>8888 :</b> <asp:TextBox Enabled="true" ID="txtCode" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="250px" MaxLength="100" ></asp:TextBox></td>
                </tr>
                <tr style="background-color: White"> 
                  <td style="text-align: left; width: 151px;" class="blackfnt"> 
                        &nbsp;Narration
                        <asp:HiddenField ID="Hnd_totalAmount" runat="server" Value="0.00" />
                  </td>
                  <td style="text-align: left" colspan="5" class="blackfnt"> 
                        &nbsp; <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="Blackfnt" onblur="javascript:FillNarration(this)" TextMode="MultiLine" Width="300px" MaxLength="200"></asp:TextBox>
                  </td>
                </tr>
              </table>
            <br />
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
            <asp:UpdatePanel ID="UpdatePanel4" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Enter No. of Rows
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" onkeypress="javascript:validInt(event);" CssClass="input" Width="100px" MaxLength="3"></asp:TextBox>
                                    &nbsp;<asp:Button ID="btnAdd" UseSubmitBehavior="false" runat="server" Text="Add Rows"  OnClick="btnAdd_Click" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" width="800">
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True" OnRowDataBound="grvcontrols_RowDataBound">
                                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                                <FooterStyle CssClass="boxbg" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Sr. No.">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Account Code">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            &nbsp;<asp:TextBox ID="txtAccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                                Enabled="true" Width="100px" MaxLength="15"></asp:TextBox>
                                                            <asp:TextBox ID="txtDescription" runat="server" BorderStyle="Groove"
                                                                Width="150px" CssClass="input" Enabled="false"></asp:TextBox>
                                                            <asp:Button ID="btnAccCode" UseSubmitBehavior="false" runat="server" Text="..." />
                                                              </ItemTemplate>
                                                               <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                               <FooterTemplate>
                                                            <strong>&nbsp; Total</strong>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <ItemTemplate>
                                                            &nbsp;
                                                            <asp:TextBox ID="txtAmt" onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                                BorderStyle="Groove" CssClass="input" Width="100px" Text="0.00" style="text-align:right;" MaxLength="12"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <FooterTemplate>
                                                            &nbsp;&nbsp;<asp:TextBox ID="txtTotAmt" runat="server" CssClass="input" BorderStyle="Groove"
                                                                Width="100px" MaxLength="12" style="text-align:right;" Enabled="False"></asp:TextBox>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Narration">
                                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            &nbsp;
                                                            <asp:TextBox ID="txtNarration"  onblur="javascript:this.value=this.value.toUpperCase()"  runat="server" BorderStyle="Groove" CssClass="input" TextMode="MultiLine" Width="150px" MaxLength="200"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Left" />
                                            </asp:GridView>
                                </td>
                            </tr>
                        </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="Svctax_yn" CssClass="bgbluegrey" runat="server" AutoPostBack="true" onclick="javascript:GetTot()" /> <strong> <font  color="red">Plz Check Here to Enable Service Tax </font></strong>
                </td>
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="TDS_yn" runat="server"  onclick="javascript:GetTot()" /> <strong> <font  color="red">Plz Check Here to Enable TDS </font></strong>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="2">
                    <strong>ADD Service Tax(+) </strong>
                </td>
                <td style="text-align: center" class="blackfnt" colspan="2">
                    <strong>LESS TDS (-) </strong>
                </td>
            </tr>
            <tr style="background-color: White" id="trSvcTaxRate" runat="server" visible="false">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Service Tax Rate
                </td>
                <td colspan="3" style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtSvrTaxRate" runat="server" Text="0.00" style="text-align:right" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="true" onchange="javascript:Nagative_Chk_wDecimal_SvcTax(this)" onblur="javascript:GetTot()"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtAppl" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" OnTextChanged="txtAmtApplL_TextChanged" style="text-align:right;"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Service tax (+)
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox>
                    <asp:HiddenField ID="HdnServiceTax" runat="server" />
                    <asp:HiddenField ID="HdnServiceTaxRate" runat="server" />
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left" class="blackfnt">
                   &nbsp;<asp:DropDownList ID="Tdssection" runat="server" Width="200px" >
                         </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Education Cess (+)
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt"> 
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox>
                    <asp:HiddenField ID="HdnEduCess" runat="server" />
                    <asp:HiddenField ID="HdnEduCessRate" runat="server" />
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Rate
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" BorderStyle="Groove" onchange="javascript:Nagative_Chk_wDecimal_TDS(this,'Tdsrate')" CssClass="input" Width="80px" style="text-align:right;" MaxLength="7"></asp:TextBox>
                    <asp:HiddenField ID="HdnTDSRate" runat="server" />
                </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Higher Education Cess (+)
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox>
                    <asp:HiddenField ID="HdnHEduCess" runat="server" />
                    <asp:HiddenField ID="HdnHEduCessRate" runat="server" />
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Amount (-)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" onchange="javascript:Nagative_Chk_wDecimal_TDS(this,'Tdsamt')" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="true" style="text-align:right;" MaxLength="10"></asp:TextBox>
                    <asp:HiddenField ID="HdnTdsAmt" runat="server" />
                </td>
            </tr>
            <%--SB Cess--%>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Swachh Bharat Cess Tax (+)
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtSBCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox>
                    <asp:HiddenField ID="HdnSBCRate" runat="server" />
                    <asp:HiddenField ID="HdnSBCess" runat="server" />
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;
                </td>
                <td style="text-align: left" class="blackfnt">
                   &nbsp;
                </td>
            </tr>
            <%-- End SB Cess--%>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Service Tax Reg No.
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtSrvTaxNo" runat="server" BorderStyle="Groove" CssClass="input" Width="140px" MaxLength="20"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;PAN Number
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtPanNo" runat="server" BorderStyle="Groove" CssClass="input" Columns="10" MaxLength="10" Width="80px"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px; height: 26px;" class="blackfnt">
                    &nbsp;Payment Mode
                </td>
                <td style="text-align: left; width: 190px; height: 26px;" class="blackfnt">
                    &nbsp;<asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True" CssClass="blackfnt"
                        OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged">
                        <asp:ListItem Value="-1">--Select--</asp:ListItem>
                        <asp:ListItem>Cash</asp:ListItem>
                        <asp:ListItem>Bank</asp:ListItem>
                        <asp:ListItem>Both</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="text-align: left; width: 143px; height: 26px;" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left; height: 26px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtApplA" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Cash Amount
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtCashAmt" runat="server" Text="0.00" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox></td>
                <td style="text-align: left; width: 143px;" class="blackfnt">
                    &nbsp;Cash Account
                </td>
                <td style="text-align: left" class="blackfnt"> 
                &nbsp;<asp:DropDownList ID="ddrCashcode" runat="server"   CssClass="Blackfnt" >
                    </asp:DropDownList>
                    </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Cheque Amount
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtChqAmt" runat="server" Text="0.00" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox></td>
                <td style="text-align: left; width: 143px;" class="blackfnt">
                    &nbsp;Bank Account
                </td>
                <td style="text-align: left" class="blackfnt">
                     &nbsp;<asp:DropDownList ID="ddrBankaccode" runat="server"   CssClass="Blackfnt" >
                     </asp:DropDownList>
               </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                    &nbsp;Cheque No.
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtChqNo" MaxLength="6" runat="server" BorderStyle="Groove" CssClass="input"  Columns="6" Enabled="False" style="text-align:right;"></asp:TextBox></td>
                <td style="text-align: left; width: 143px;" class="blackfnt">
                    &nbsp;Cheque date
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtChqDate" runat="server" onblur="javascript:ValidateDate(this)"
                        BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChqDate,'anchor11','dd/MM/yyyy'); return false;"
                        id="a1" name="anchor11">
                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 213px;" class="blackfnt">
                </td>
                <td style="text-align: left; width: 190px;" class="blackfnt">
                </td>
                <td style="text-align: left; width: 143px;" class="blackfnt">
                    <strong>&nbsp;NET PAYABLE </strong>
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtNetPay" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align:right;"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" />
                    <asp:HiddenField ID="click_count" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnroundoff" runat="server" Value="N" />
                    <asp:HiddenField ID="hdneditablsvctaxrate" runat="server" Value="N" />           
                </td>
            </tr>
        </table>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
