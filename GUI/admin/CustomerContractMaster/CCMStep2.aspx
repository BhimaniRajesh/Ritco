<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CCMStep2.aspx.cs" Inherits="GUI_Admin_CustomerContractMaster_CCMStep2"
    EnableEventValidation="false" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
    
    function minFreightTypeClick()
    {
        var optminfreihgttype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0");
        var tblpercentwiseminfreight=document.getElementById("ctl00_MyCPH1_tblpercentwiseminfreight");
        var tblbasewiseminfreight=document.getElementById("ctl00_MyCPH1_tblbasewiseminfreight");

        if(optminfreihgttype.checked==true)
        {
            tblbasewiseminfreight.style.display="block";
            tblpercentwiseminfreight.style.display="none";
        }
        else
        {
            tblbasewiseminfreight.style.display="none";
            tblpercentwiseminfreight.style.display="block";
        }
        
            return true;
    }
    
    function octroiSurChargeClick()
    {
        var chkoctroisurcharge=document.getElementById("ctl00_MyCPH1_chkoctroisurcharge");
        var troctroisurcharge=document.getElementById("ctl00_MyCPH1_troctroisurcharge");
        
        if(chkoctroisurcharge.checked==true)
            troctroisurcharge.style.display="block";
        else
            troctroisurcharge.style.display="none";
    
    }
    
function validateOctroiSurCharge()
{
     var chkoctroisurcharge=document.getElementById("ctl00_MyCPH1_chkoctroisurcharge");
     
     var cmboctroisurchargebas=document.getElementById("ctl00_MyCPH1_cmboctroisurchargebas");
     var txtoctroisurchargerate=document.getElementById("ctl00_MyCPH1_txtoctroisurchargerate");
     var txtminoctroisurcharge=document.getElementById("ctl00_MyCPH1_txtminoctroisurcharge");
     var txtmaxoctroisurcharge=document.getElementById("ctl00_MyCPH1_txtmaxoctroisurcharge");
     
     if(chkoctroisurcharge.checked==true)
     {
     
        if(cmboctroisurchargebas.value=="" || cmboctroisurchargebas.value=="0")
        {
            alert("Please Select Octroi Surcharge Base");
            cmboctroisurchargebas.focus();
            return false;
        }
     
        if(txtoctroisurchargerate.value=="")
        {
            alert("Please Enter Octroi Surcharge Rate");
            txtoctroisurchargerate.focus();
            return false;
        }
        
        if(txtminoctroisurcharge.value=="")
        {
            alert("Please Enter Minimum Octroi Surcharge (in RS)");
            txtminoctroisurcharge.focus();
            return false;
        }
        
        if(txtmaxoctroisurcharge.value=="")
        {
            alert("Please Enter Maximum Octroi Surcharge (in RS)");
            txtmaxoctroisurcharge.focus();
            return false;
        }
        
        if(parseFloat(txtmaxoctroisurcharge.value)<parseFloat(txtminoctroisurcharge.value))
        {
            alert("Maximum Octroi Surcharge is Less than Minimum Octroi SurCharge");
            txtminoctroisurcharge.focus();
            return false;
        }
        
     }
     
     
     return true;
}
    
function validateFuelSurCharge()
{
    var chkfuelsurcharge=document.getElementById("ctl00_MyCPH1_chkfuelsurcharge");
    
    var txtfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeair");
    var txtfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeroad");
    var txtfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtfuelsurchargetrain");
    var txtfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeexpress");
    
    var txtminfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeair");
    var txtminfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeroad");
    var txtminfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargetrain");
    var txtminfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeexpress");
    
    var txtmaxfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeair");
    var txtmaxfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeroad");
    var txtmaxfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargetrain");
    var txtmaxfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeexpress");
    
    var cmbfuelsurchargebasair=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasair");
    var cmbfuelsurchargebasroad=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasroad");
    var cmbfuelsurchargebastrain=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebastrain");
    var cmbfuelsurchargebasexpress=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasexpress");
    
    var chkair=document.getElementById("ctl00_MyCPH1_chkair");
    var chkroad=document.getElementById("ctl00_MyCPH1_chkroad");
    var chktrain=document.getElementById("ctl00_MyCPH1_chktrain");
    var chkexpress=document.getElementById("ctl00_MyCPH1_chkexpress");
    
    if(chkfuelsurcharge.checked==true)
    {
        if(chkair.checked==true)
        {
         // air
            if(cmbfuelsurchargebasair.value=="" || cmbfuelsurchargebasair.value=="0")
                {
                    alert("Please Select Fuel Sur Charge Bas for Air");
                    cmbfuelsurchargebasair.focus();
                    return false;
                }
             if(txtminfuelsurchargeair.value=="")
                {
                    alert("Please enter Minimum Fuel Surcharge (in RS) for Air");
                    txtminfuelsurchargeair.value="0.00";
                    txtminfuelsurchargeair.focus();
                    return false;
                }
            if(txtmaxfuelsurchargeair.value=="")
                {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Air");
                        txtmaxfuelsurchargeair.value="0.00";
                        txtmaxfuelsurchargeair.focus();
                        return false;
                }
                    if(cmbfuelsurchargebasair.value!="F")
                    {
                            if(txtminfuelsurchargeair.value=="")
                            {
                                alert("Please enter Minimum Fuel Surcharge (in RS) for Air");
                                txtminfuelsurchargeair.value="0.00";
                                txtminfuelsurchargeair.focus();
                                return false;
                            }
                    
                            if(txtmaxfuelsurchargeair.value=="")
                            {
                                alert("Please enter Maximum Fuel SurCharge (in RS) for Air");
                                txtmaxfuelsurchargeair.value="0.00";
                                txtmaxfuelsurchargeair.focus();
                                return false;
                            }
                    }
              if(parseFloat(txtmaxfuelsurchargeair.value)<parseFloat(txtminfuelsurchargeair.value))
                    {
                        alert("For Air Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeair.focus();
                        return false;
                    }
                    
                if(txtfuelsurchargeair.value=="")
                {
                    alert("Please Enter Fuel Surcharge rate for Air");
                    txtfuelsurchargeair.value="0.00";
                    txtfuelsurchargeair.focus();
                    return false;
                }    
        } // end of air checking
        
        
         //road
        if(chkroad.checked==true)
        {
             if(cmbfuelsurchargebasroad.value=="" || cmbfuelsurchargebasroad.value=="0")
                {
                    alert("Please Select Fuel Sur Charge Bas for Road");
                    cmbfuelsurchargebasroad.focus();
                    return false;
                }
            if(txtminfuelsurchargeroad.value=="")
                {
                    alert("Please enter Minimum Fuel Surcharge (in RS) for Road");
                    txtminfuelsurchargeroad.value="0.00";
                    txtminfuelsurchargeroad.focus();
                    return false;
                }
            if(txtmaxfuelsurchargeroad.value=="")
                {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Road");
                        txtmaxfuelsurchargeroad.value="0.00";
                        txtmaxfuelsurchargeroad.focus();
                        return false;
                }
                 if(cmbfuelsurchargebasroad.value!="F")
                    {
                            if(txtminfuelsurchargeroad.value=="")
                            {
                                alert("Please enter Minimum Fuel Surcharge (in RS) for Road");
                                txtminfuelsurchargeroad.value="0.00";
                                txtminfuelsurchargeroad.focus();
                                return false;
                            }
                    
                            if(txtmaxfuelsurchargeroad.value=="")
                            {
                                alert("Please enter Maximum Fuel SurCharge (in RS) for Road");
                                txtmaxfuelsurchargeroad.value="0.00";
                                txtmaxfuelsurchargeroad.focus();
                                return false;
                            }
                    }
                    if(parseFloat(txtmaxfuelsurchargeroad.value)<parseFloat(txtminfuelsurchargeroad.value))
                    {
                        alert("For Road Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeroad.focus();
                        return false;
                    }
                    if(txtfuelsurchargeroad.value=="")
                    {
                        alert("Please Enter Fuel Surcharge PerCent for Road");
                        txtfuelsurchargeroad.value="0.00";
                        txtfuelsurchargeroad.focus();
                        return false;
                    }
         }  // end of road checking
         
         
         // train
        if(chktrain.checked==true)
        {
             if(cmbfuelsurchargebastrain.value=="" || cmbfuelsurchargebastrain.value=="0")
                {
                    alert("Please Select Fuel Sur Charge Bas for Train");
                    cmbfuelsurchargebastrain.focus();
                    return false;
                }
        
             if(txtminfuelsurchargetrain.value=="")
                {
                    alert("Please enter Minimum Fuel Surcharge (in RS) for Train");
                    txtminfuelsurchargetrain.value="0.00";
                    txtminfuelsurchargetrain.focus();
                    return false;
                }
            
                if(txtmaxfuelsurchargetrain.value=="")
                    {
                            alert("Please enter Maximum Fuel SurCharge (in RS) for Train");
                            txtmaxfuelsurchargetrain.value="0.00";
                            txtmaxfuelsurchargetrain.focus();
                            return false;
                    }
                if(cmbfuelsurchargebastrain.value!="F")
                {
                        if(txtminfuelsurchargetrain.value=="")
                        {
                            alert("Please enter Minimum Fuel Surcharge (in RS) for Train");
                            txtminfuelsurchargetrain.value="0.00";
                            txtminfuelsurchargetrain.focus();
                            return false;
                        }
                
                        if(txtmaxfuelsurchargetrain.value=="")
                        {
                            alert("Please enter Maximum Fuel SurCharge (in RS) for Train");
                            txtmaxfuelsurchargetrain.value="0.00";
                            txtmaxfuelsurchargetrain.focus();
                            return false;
                        }
                 }
               if(parseFloat(txtmaxfuelsurchargetrain.value)<parseFloat(txtminfuelsurchargetrain.value))
                    {
                        alert("For Train Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargetrain.focus();
                        return false;
                    }
                if(txtfuelsurchargetrain.value=="")
                {
                    alert("Please Enter Fuel Surcharge for Train");
                    txtfuelsurchargetrain.value="0.00";
                    txtfuelsurchargetrain.focus();
                    return false;
                }
         }  // end of train checking
         
            
         // express  
        if(chkexpress.checked==true)
        {
              if(cmbfuelsurchargebasexpress.value=="" || cmbfuelsurchargebasexpress.value=="0")
                {
                    alert("Please Select Fuel Sur Charge Bas for Express");
                    cmbfuelsurchargebasexpress.focus();
                    return false;
                }
            
             if(txtminfuelsurchargeexpress.value=="")
                {
                    alert("Please enter Minimum Fuel Surcharge (in RS) for Express");
                    txtminfuelsurchargeexpress.value="0.00";
                    txtminfuelsurchargeexpress.focus();
                    return false;
                }
            
                if(txtmaxfuelsurchargeexpress.value=="")
                {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Express");
                        txtmaxfuelsurchargeexpress.value="0.00";
                        txtmaxfuelsurchargeexpress.focus();
                        return false;
                }   
                if(cmbfuelsurchargebasexpress.value!="F")
                {
                        if(txtminfuelsurchargeexpress.value=="")
                        {
                            alert("Please enter Minimum Fuel Surcharge (in RS) for Express");
                            txtminfuelsurchargeexpress.value="0.00";
                            txtminfuelsurchargeexpress.focus();
                            return false;
                        }
                
                        if(txtmaxfuelsurchargeexpress.value=="")
                        {
                            alert("Please enter Maximum Fuel SurCharge (in RS for Express)");
                            txtmaxfuelsurchargeexpress.value="0.00";
                            txtmaxfuelsurchargeexpress.focus();
                            return false;
                        }
                 }    
              if(parseFloat(txtmaxfuelsurchargeexpress.value)<parseFloat(txtminfuelsurchargeexpress.value))
                    {
                        alert("For Express Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeexpress.focus();
                        return false;
                    }
                if(txtfuelsurchargeexpress.value=="")
                {
                    alert("Please Enter Fuel Surcharge for Express");
                    txtfuelsurchargeexpress.value="0.00";
                    txtfuelsurchargeexpress.focus();
                    return false;
                }
        }  // end of express checking
     }  // end of fuel surcharge yes no
     return true;
     
}

function fuelSurChargeClick()
{

    var trfuelsurcharge=document.getElementById("ctl00_MyCPH1_trfuelsurcharge");
    var chkfuelsurcharge=document.getElementById("ctl00_MyCPH1_chkfuelsurcharge");
        if(chkfuelsurcharge.checked==true)
                trfuelsurcharge.style.display="block";
        else
                trfuelsurcharge.style.display="none";

}

	// Inner Function to Ropund upto defined decimal places, returns string
	function roundNumber(num, dec) 
	{
	
	    if(num=="." || num==".0" || num=="0" || num=="0." || num=="" || !num)
	        return "0.00";
	     
	    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	           
        var len=0;
        var number=result.toString();
        len=number.length;
        
        if(number=="." || number==".0" || number=="0" || number=="0." || num=="" || !num)
	        return "0.00";
	        
        if(number.indexOf('.') == parseInt(len - 2) && len>=2)
        {
            number=number + "0";
        }
        else if(number.indexOf('.') == parseInt(len - 1))
        {
            number = number + "00";
        }
        else if(number.indexOf('.')== -1)
        {
            number = number + ".00";
        }
        
        	return number;    
    }
	
	

function chkMultiPointPickUp(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatmultipointpickup");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocmultipointpickup");
    var trloading=document.getElementById("ctl00_MyCPH1_trloading");
    
    if(id=="ctl00_MyCPH1_chkflatmultipointpickup")
        {
            if(chkflat.checked==true)
            {
                chkloc.checked=false;
                trloading.style.display="block";
            }
        }
     else
     {
            if(chkloc.checked==true)
            {
                chkflat.checked=false;
                trloading.style.display="block";
            }
     }
     
     if(chkloc.checked==true || chkflat.checked==true)
         trloading.style.display="block";
     else
         trloading.style.display="none";
     
}


function chkMultiPointDelivery(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatmultipointdelivery");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocmultipointdelivery");
    var trunloading=document.getElementById("ctl00_MyCPH1_trunloading");
    
    if(id=="ctl00_MyCPH1_chkflatmultipointdelivery")
        {
            if(chkflat.checked==true)
            {
                chkloc.checked=false;
            }
        }
     else
     {
            if(chkloc.checked==true)
            {
                chkflat.checked=false;
            }
     }
     
     if(chkloc.checked==true || chkflat.checked==true)
         trunloading.style.display="block";
     else
         trunloading.style.display="none";
     
}
       
            
function chkLoading(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatloading");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocloading");
    
     if(id=="ctl00_MyCPH1_chkflatloading")
        {
            if(chkflat.checked==true)
                chkloc.checked=false;
        }
     else
     {
            if(chkloc.checked==true)
                chkflat.checked=false;
     }
}

function chkUnLoading(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatunloading");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocunloading");
    
    if(id=="ctl00_MyCPH1_chkflatunloading")
        {
            if(chkflat.checked==true)
                chkloc.checked=false;
        }
     else
     {
            if(chkloc.checked==true)
                chkflat.checked=false;
     }
}


function locCodeBlur(id,locname)
        {
        
             var txt=document.getElementById(id);
             txt.value=txt.value.toUpperCase();
             if(txt.value=="")
                return false;
             var findobj=false;
             findobj=GetXMLHttpObject();
            
            if(findobj)
            {
                 var strpg="LocationTest.aspx?mode=check&code=loccode&loccode="+ txt.value + "&sid=" + Math.random();
                 findobj.open("GET",strpg);
                 findobj.onreadystatechange=function()
                     {
                         if((findobj.readyState==4) && (findobj.status==200))
                            {
                                  var  res=findobj.responseText.split("|");
                                  if(res[0]=="false")
                                     {
                                        alert("This " + locname + " doesn't Exists..");
                                        txt.select()
                                        return false;
                                     }
                            }
                     }
                 findobj.send(null);
             }
             return true;
        }

// JScript File
function cmbFOVChange()
{
    var cmb=document.getElementById("ctl00_MyCPH1_ddlFOVType");
    var tdper=document.getElementById("ctl00_MyCPH1_tdfovpercentage");
    var tdcharge=document.getElementById("ctl00_MyCPH1_tdfovcharge");

    if(cmb.value=="RS")
    {
        tdcharge.style.display="block";
        tdper.style.display="none";
    }
    else
    {
        tdper.style.display="block";
        tdcharge.style.display="none";
    }
}
            
            
function chkVolumetricChange()
{
    var chk=document.getElementById("ctl00_MyCPH1_chkTSVolumetric");
    var tr=document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked");
    
    if(chk.checked==true)
        tr.style.display="block";
    else
        tr.style.display="none";
}
            
            
function chkDACCChange()
{
    var chk=document.getElementById("ctl00_MyCPH1_chkTSDACC");
    var tr=document.getElementById("ctl00_MyCPH1_trTSDACCChecked");
    
    if(chk.checked==true)
        tr.style.display="block";
    else
        tr.style.display="none";

}

function trimAll(strValue) 
{
    //Trimming left most white space characters
    while (strValue.substring(0,1) == ' ')
    {
        strValue = strValue.substring(1, strValue.length);
    }
    //Trimming right most white space characters
    while (strValue.substring(strValue.length-1, strValue.length) == ' ')
    {
        strValue = strValue.substring(0, strValue.length-1);
    }
    
    return strValue;
}


function Nagative_Chk_wDecimal(obj)
{
	var temp = trimAll(obj.value) 
	
	if (temp == "")	
	{
		return true;
	}
	
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.focus();
		return false;
	} 				
		  
	if(parseFloat(temp) < 0)
	{
		alert("Value should be greater than zero")
		obj.focus();
		return false;
	}
	
	obj.value=roundit(temp) 
	
	return true;					   
}
	


function roundit(Num)
{
	Places = 2
	
	if (Places > 0)
	{
		if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		{
			if (Num.toString().lastIndexOf('.') < 0) 
			{
				return Num.toString() + '.00';
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
				{
					return Num.toString() +'0';
				}
				else
				{
					return Num.toString();
				}
			}
		}
	}
	else
	{
	    return Math.round(Num);
	}
}
        
          
            function CODDODChecked(objCODDOD)
            {
                if(document.getElementById("ctl00_MyCPH1_trTSCODChecked"))
                {
                    var mCODDODApplicableYN = "<%=blnAppForCODDOD %>"
                    
                    if (mCODDODApplicableYN == "Y")
                    {
                        if(objCODDOD.checked == true)
                        {
                            document.getElementById("ctl00_MyCPH1_trTSCODChecked").style.display = '';
                        }
                        else
                        {
                            document.getElementById("ctl00_MyCPH1_trTSCODChecked").style.display = 'none';
                        }
                    }
                }
            }
                     
            function ValidateData()
            {
                //Check for Mode of Transport checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkroad") && document.getElementById("ctl00_MyCPH1_chkair") && document.getElementById("ctl00_MyCPH1_chktrain") && document.getElementById("ctl00_MyCPH1_chkexpress"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkroad").checked == false && document.getElementById("ctl00_MyCPH1_chkair").checked == false && document.getElementById("ctl00_MyCPH1_chktrain").checked == false && document.getElementById("ctl00_MyCPH1_chkexpress").checked == false)
                    {
                        alert("Please select at least one Mode of Transport");
                        document.getElementById("ctl00_MyCPH1_chkair").focus();
                        return false;
                    }
                }
                
                //Check for Type of Load checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkTLFTL") && document.getElementById("ctl00_MyCPH1_chkTLSundry"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTLFTL").checked == false && document.getElementById("ctl00_MyCPH1_chkTLSundry").checked == false)
                    {
                        alert("Please select at least one Type of Load");
                        document.getElementById("ctl00_MyCPH1_chkTLFTL").focus();
                        return false;
                    }
                }
                
                //Check for 'FTL' Type of Load checkbox
                //Road and/or Express checkbox must be checked
                //None of the other checkboxes can be checked
                if(document.getElementById("ctl00_MyCPH1_chkTLFTL"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTLFTL").checked == true && document.getElementById("ctl00_MyCPH1_chkTLSundry").checked == false)
                    {
                        if((document.getElementById("ctl00_MyCPH1_chkroad").checked == false && document.getElementById("ctl00_MyCPH1_chkexpress").checked == false) || (document.getElementById("ctl00_MyCPH1_chkair").checked == true)  || (document.getElementById("ctl00_MyCPH1_chktrain").checked == true))
                        {
                            alert("For 'FTL' Type of Load, you can select 'Road' and/or 'Express' as Mode of Transport");
                            document.getElementById("ctl00_MyCPH1_chkroad").focus();
                            return false;
                        }
                    }
                }
                
                //Check for Pickup-Delivery checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkGD") && document.getElementById("ctl00_MyCPH1_chkGG") && document.getElementById("ctl00_MyCPH1_chkDD") && document.getElementById("ctl00_MyCPH1_chkDG"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkGD").checked == false && document.getElementById("ctl00_MyCPH1_chkGG").checked == false && document.getElementById("ctl00_MyCPH1_chkDD").checked == false && document.getElementById("ctl00_MyCPH1_chkDG").checked == false)
                    {
                        alert("Please select at least one Pickup-Delivery from the list");
                        document.getElementById("ctl00_MyCPH1_chkGD").focus();
                        return false;
                    }
                }
                
                //Check for Godown-Door checkbox
                //Minimum Charges and Rate/Kg. for DELIVERY must be entered
                if(document.getElementById("ctl00_MyCPH1_chkGD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkGD").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg.
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Door-Door checkbox
                //Minimum Charges and Rate/Kg. for both PICKUP & DELIVERY must be entered
                if(document.getElementById("ctl00_MyCPH1_chkDD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkDD").checked == true)
                    {
                        //Check for Minimum Charges for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").focus();
                                return false;
                            }
                        }
                        
                        //Check for Minimum Charges for Delivery
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Delivery
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Door-Godown checkbox
                //Minimum Charges and Rate/Kg. for both PICKUP must be entered
                if(document.getElementById("ctl00_MyCPH1_chkDG"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkDG").checked == true)
                    {
                        //Check for Minimum Charges for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").focus();
                                return false;
                            }
                        }
                    }    
                }
                
                //Check for FOV details
                if(document.getElementById("ctl00_MyCPH1_trFOVCharge"))
                {
                   if(document.getElementById("ctl00_MyCPH1_ddlFOVType"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "-1")
                        {
                            alert("Please select 'FOV Type' from the list");
                            document.getElementById("ctl00_MyCPH1_ddlFOVType").focus();
                            return false;
                        }
                        else if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "RS")
                        {
                             if(document.getElementById("ctl00_MyCPH1_txtFOVCharge"))
                                {
                                    document.getElementById("ctl00_MyCPH1_txtFOVCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtFOVCharge").value)
                                    if(document.getElementById("ctl00_MyCPH1_txtFOVCharge").value == "")
                                    {
                                        alert("Please enter 'FOV Rate'");
                                        document.getElementById("ctl00_MyCPH1_txtFOVCharge").focus();
                                        return false;
                                    }
                                }
                        }
                        else if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "%")
                        {
                            if(document.getElementById("ctl00_MyCPH1_txtcarrierrisk"))
                            {
                                if(document.getElementById("ctl00_MyCPH1_txtcarrierrisk").value=="")
                                {
                                    alert("Please enter Carrier's Risk");
                                    return false;
                                }
                            }
                            
                            if(document.getElementById("ctl00_MyCPH1_txtownerrisk"))
                            {
                                if(document.getElementById("ctl00_MyCPH1_txtownerrisk").value=="")
                                {
                                    alert("Please enter Owner's Risk");
                                    return false;
                                }
                            }
                        }
                    }
                 }
                
               
                var optownerrisk=document.getElementById("ctl00_MyCPH1_optrisktype_0")
                var optcarrierrisk=document.getElementById("ctl00_MyCPH1_optrisktype_1")
                if(optownerrisk.checked==false && optcarrierrisk.checked==false)
                {
                    alert("Please Select Risk Type......");
                    optownerrisk.focus();
                    return false;
                }
                
                var optbastype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0")
                var optpercenttype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_1")
                if(optbastype.checked==false && optpercenttype.checked==false)
                {
                    alert("Please Minimum Freight Type......");
                    optbastype.focus();
                    return false;
                }
                
                
                //Check for COD-DOD checkbox
                //Minimum Charges and % of Amount must be entered
                if(document.getElementById("ctl00_MyCPH1_chkTSCODDOD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTSCODDOD").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_txtCODCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCODCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCODCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCODCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for COD/DOD");
                                document.getElementById("ctl00_MyCPH1_txtCODCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for % of Amount
                        if(document.getElementById("ctl00_MyCPH1_txtCODChargePer"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCODChargePer").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCODChargePer").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCODChargePer").value == "")
                            {
                                alert("Please enter '% of Amount' for COD/DOD");
                                document.getElementById("ctl00_MyCPH1_txtCODChargePer").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Volumetric checkbox
                //Minimum Charges and % of Amount must be entered
                if(document.getElementById("ctl00_MyCPH1_chkTSVolumetric"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTSVolumetric").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_ddlVolMeasure"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlVolMeasure").value == "-1")
                            {
                                alert("Please select 'Volumetric Measure' from the list");
                                document.getElementById("ctl00_MyCPH1_ddlVolMeasure").focus();
                                return false;
                            }
                        }
                        
                        //Check for Volumetric Conversion
                        if(document.getElementById("ctl00_MyCPH1_txtCFTToKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCFTToKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCFTToKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCFTToKg").value == "")
                            {
                                alert("Please enter 'Volumetric Conversion 1 CFT = Kg.'");
                                document.getElementById("ctl00_MyCPH1_txtCFTToKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                    //Check for DACC checkbox
                    //Minimum Charges and % of Amount must be entered
                    var chkdacc=document.getElementById("ctl00_MyCPH1_chkTSDACC");
                    var txtdacccharge=document.getElementById("ctl00_MyCPH1_txtDACCChargeRs");
                    var txtdaccpercent=document.getElementById("ctl00_MyCPH1_txtDACCChargePer");
                    if(chkdacc.checked == true)
                    {
                        //Check for Minimum in Rs.
                        if(txtdacccharge.value == "")
                        {
                            alert("Please enter 'Minimum in Rs.'");
                            txtdacccharge.focus();
                            return false;
                        }
                        //Check for % of Freight
                        if(txtdaccpercent.value == "")
                        {
                            alert("Please enter '% of Freight'");
                            txtdaccpercent.focus();
                            return false;
                        }
                    }
                    
                    // Fuel surcharge validation
                    if(!validateFuelSurCharge())
                        return false;
                        
                    // Octroi SurCharge Validation
                    if(!validateOctroiSurCharge())
                         return false;
                        
                
                    //Check for Bill Generation at Location
                    var txtbillgenloc=document.getElementById("ctl00_MyCPH1_txtBillGen");
                    if(txtbillgenloc.value == "")
                    {
                        alert("Please enter 'Bill Generation at Location'");
                        txtbillgenloc.focus();
                        return false;
                    }
                
                    //Check for Billing Instance
                    var cmbbillinginst=document.getElementById("ctl00_MyCPH1_ddlBillingInstance");
                    if(cmbbillinginst.value == "0" || cmbbillinginst.value == "")
                    {
                        alert("Please select 'Billing Instance' from the list");
                        cmbbillinginst.focus();
                        return false;
                    }
               
                    //Check for Bill Submission at Location
                    var txtbillsubloc=document.getElementById("ctl00_MyCPH1_txtBillSubLocation");
                    if(txtbillsubloc.value == "")
                    {
                        alert("Please enter 'Bill Submission at Location'");
                        txtbillsubloc.focus();
                        return false;
                    }
                
                    //Check for Bill Collection at Location
                    var txtbillcolloc=document.getElementById("ctl00_MyCPH1_txtBillCollLocation");
                    if(txtbillcolloc.value == "")
                    {
                        alert("Please enter 'Bill Collection at Location'");
                        txtbillcolloc.focus();
                        return false;
                    }
                
                    //Check for Service Tax Applicable & Paid By
                    var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
                    if(cmbstaxpaidby.value == "0" || cmbstaxpaidby.value=="")
                      {
                            alert("Please select 'Service Tax Paid by' from the list");
                            cmbstaxpaidby.focus();
                            return false;
                      }                    

                                
                //Check for Minimum Freight entries
                
                //Rate and Basis must be entered/selected for Air row
                //If 'Air' Mode of Transport is checked
                
                var optminfreihgttype_bas=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0");
                var chkair=document.getElementById("ctl00_MyCPH1_chkair");
                var txtbasrateair=document.getElementById("ctl00_MyCPH1_txtairrateforfreight");
                var cmbbasair=document.getElementById("ctl00_MyCPH1_ddlairbasisforfreight");
                
                var chkroad=document.getElementById("ctl00_MyCPH1_chkroad");
                var txtbasrateroad=document.getElementById("ctl00_MyCPH1_txtroadrateforfreight");
                var cmbbasroad=document.getElementById("ctl00_MyCPH1_ddlroadbasisforfreight");
                
                var chktrain=document.getElementById("ctl00_MyCPH1_chktrain");
                var txtbasratetrain=document.getElementById("ctl00_MyCPH1_txttrainrateforfreight");
                var cmbbastrain=document.getElementById("ctl00_MyCPH1_ddltrainbasisforfreight");
                
                var chkexpress=document.getElementById("ctl00_MyCPH1_chkexpress");
                var txtbasrateexpress=document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight");
                var cmbbasexpress=document.getElementById("ctl00_MyCPH1_ddlexpressbasisforfreight");
                
                if(optminfreihgttype_bas.checked==true)
                {
                        if(chkair.checked == true)
                        {
                            if(txtbasrateair.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Air' Mode of Transport");
                                txtbasrateair.focus();
                                return false;
                            }
                            
                            if(cmbbasair.value == "-1" || cmbbasair.value == "" )
                            {
                                alert("Please select 'Basis' for 'Air' Mode of Transport, from the list");
                                cmbbasair.focus();
                                return false;
                            }
                        } // air checked
                
                        if(chkroad.checked == true)
                        {
                            if(txtbasrateroad.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Road' Mode of Transport");
                                txtbasrateroad.focus();
                                return false;
                            }
                        
                            if(cmbbasroad.value == "-1")
                            {
                                alert("Please select 'Basis' for 'Road' Mode of Transport, from the list");
                                cmbbasroad.focus();
                                return false;
                            }
                        } // road checked
                 
                        if(chktrain.checked == true)
                        {
                            if(txtbasratetrain.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Train' Mode of Transport");
                                txtbasratetrain.focus();
                                return false;
                            }

                            if(cmbbastrain.value == "-1" || cmbbastrain.value == "")
                            {
                                alert("Please select 'Basis' for 'Train' Mode of Transport, from the list");
                                cmbbastrain.focus();
                                return false;
                            }
                        } // train checked
                    
                        if(chkexpress.checked == true)
                        {
                            if(txtbasrateexpress.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Express' Mode of Transport");
                                txtbasrateexpress.focus();
                                return false;
                            }
                            
                            if(cmbbasexpress.value == "-1" || cmbbasexpress.value == "")
                            {
                                alert("Please select 'Basis' for 'Express' Mode of Transport, from the list");
                                cmbbasexpress.focus();
                                return false;
                            }
                        } // express checked
                   
                } // end of min freihgt bas checking
                
                
                
                //ONLY FOR RCPL
                var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
                if(hdnclient.value=="RCPL")
                {
                    var txtcombus=document.getElementById("ctl00_MyCPH1_txtcommitedbusiness");
                    if(txtcombus.value=="")
                    {
                        alert("Please Enter Commite Business...");
                        txtcombus.select();
                        return false;
                    }
                }
                var ddlCreditType = document.getElementById("ctl00_MyCPH1_ddlCreditType");
                if (ddlCreditType.value == "" ) {
                    alert("Please select 'Credit Type' from the list");
                    ddlCreditType.focus();
                    return false;
                }
                
                return true;
            }
            
   
       
    function chkcoddodchange()
    {
        var chkcod=document.getElementById("ctl00_MyCPH1_chkTSCODDOD");
        var tr=document.getElementById("ctl00_MyCPH1_trTSCODChecked");
       
            if(chkcod.checked==true)
                tr.style.display="block";
            else
                tr.style.display="none";
       
        return true;
    }

  
     function chktsvolumetricchange()
        {
            var chk=document.getElementById("ctl00_MyCPH1_chkTSVolumetric");
            var tr=document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked");
                       
                if(chk.checked==true)
                    tr.style.display="block";
                else
                    tr.style.display="none";
          
            return true;
        }
   
    
    function chktsdaccchange()
    {
        var chk=document.getElementById("ctl00_MyCPH1_chkTSDACC");
        var tr=document.getElementById("ctl00_MyCPH1_trTSDACCChecked");
        var hdn=document.getElementById("ctl00_MyCPH1_HidDACCApp");
        
        if(hdn.value=="Y")
        {
            if(chk.checked==true)
                tr.style.display="block";
            else
                tr.style.display="none";
        }
        
        return true;
    }
    
    </script>

    <div>
        <cust:CustInfo runat="server" ID="cstheader" />
        <asp:Table Style="width: 10in" runat="server" HorizontalAlign="left" CellSpacing="0">
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="left">
                    <asp:Table Width="100%" runat="server" CellSpacing="0">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:Table Width="100%" runat="server" CellSpacing="0">
                                    <asp:TableRow>
                                        <asp:TableCell VerticalAlign="top">
                                            <asp:Table border="0" runat="server" Width="100%" CellSpacing="1" HorizontalAlign="center"
                                                CssClass="boxbg">
                                                <asp:TableRow CssClass="bgbluegrey">
                                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="left" CssClass="blackfnt">
                                                        <b>&nbsp;Step 2: Service Selection </b>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White;" CssClass="blackfnt">
                                                            Mode of Transport:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkair" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkroad" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chktrain" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="2">
                                                        <asp:CheckBox ID="chkexpress" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White" CssClass="blackfnt">
                                                            &nbsp;Type of Load:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTLFTL" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="4">
                                                        <asp:CheckBox ID="chkTLSundry" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trmultipointpickup" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat MultiPoint PickUp
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatmultipointpickup" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointPickUp(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise MultiPoint PickUp
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocmultipointpickup" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointPickUp(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trloading" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat Loading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise Loading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trmultipointdelivery" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat MultiPoint Delivery
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatmultipointdelivery" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointDelivery(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise MultiPoint Delivery
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocmultipointdelivery" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointDelivery(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trunloading" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat Unloading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatunloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkUnLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise Unloading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocunloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkUnLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                            &nbsp;Pickup-Delivery:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkGD" runat="server" CssClass="blackfnt" />
                                                        Godown-Door
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkGG" runat="server" CssClass="blackfnt" />
                                                        Godown-Godown
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkDD" runat="server" CssClass="blackfnt" />
                                                        Door-Door
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <asp:CheckBox ID="chkDG" runat="server" CssClass="blackfnt" />
                                                        Door-Godown
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trDoorPickupCharge" runat="server" Visible="false" Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;Door Pickup Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDoorPickupCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px; border-style: groove;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Rate/Kg.:
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDoorPickupChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trDoorDeliveryCharge" runat="server" Visible="false" Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;Door Delivery Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDoorDeliveryCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                       
                                                            &nbsp;Rate/Kg.:
                                                       
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDoorDeliveryChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: white; width: 100%" ID="trFOVCharge" runat="server"
                                                    Visible="false">
                                                    <asp:TableCell>
                                                            FOV Type:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="ddlFOVType" BackColor="White" onchange="javascript:return cmbFOVChange()"
                                                            runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="RS." Value="RS"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="% of Invoice" Value="%"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                    <asp:TableCell ID="tdfovcharge" ColumnSpan="4" runat="server" CssClass="blackfnt">
                                                        <asp:Table Width="100%" CellSpacing="1" runat="server" CssClass="boxbg">
                                                            <asp:TableRow BackColor="#ffffff">
                                                                <asp:TableCell>
                                                                    FOV Rate:</asp:TableCell>
                                                                <asp:TableCell ColumnSpan="3">
                                                                    <input id="txtFOVCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                    <asp:TableCell ID="tdfovpercentage" ColumnSpan="4" Style="display: none;" CssClass="blackfnt"
                                                        runat="server">
                                                        <asp:Table runat="server" Width="100%" CellSpacing="1" CssClass="boxbg">
                                                            <asp:TableRow BackColor="#ffffff">
                                                                <asp:TableCell>
                                                                    FOV Owner Risk(%)</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtownerrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    FOV Carrier Risk(%)</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtcarrierrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>Risk Type</asp:TableCell>
                                                    <asp:TableCell ColumnSpan="5">
                                                        <asp:RadioButtonList ID="optrisktype" runat="server" RepeatDirection="Horizontal"
                                                            CssClass="blackfnt">
                                                            <asp:ListItem Value="C" Text="Carrier Risk"></asp:ListItem>
                                                            <asp:ListItem Value="O" Text="Owner Risk"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                            Type of Minimum Freight 
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="5">
                                                        <asp:RadioButtonList ID="optminfreihgttype" onclick="javascript:return minFreightTypeClick()"
                                                            runat="server" RepeatDirection="Horizontal" CssClass="blackfnt">
                                                            <asp:ListItem Value="B" Text="Base Wise"></asp:ListItem>
                                                            <asp:ListItem Value="%" Text="Percent Wise"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        &nbsp;
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        &nbsp;
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                      
                                                            &nbsp;Insurance Percentage:
                                                      
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="4">
                                                        <input id="txtInsPer" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px; border-left-style: groove;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White">
                                                            &nbsp;Type of Service:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTSCODDOD" runat="server" onclick="javascript:return chkcoddodchange()"
                                                            Style="margin-left: 1px;" />
                                                        COD/DOD
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <input type="checkbox" id="chkTSODA" runat="server" style="margin-left: 1px;" />
                                                        ODA
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTSVolumetric" runat="server" onclick="javascript:return chkVolumetricChange();"
                                                            Style="margin-left: 1px;" />
                                                        Volumetric
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="2" VerticalAlign="top">
                                                        <asp:CheckBox ID="chkTSDACC" runat="server" onclick="javascript:return chkDACCChange();"
                                                            Style="margin-left: 1px;" />
                                                        DACC
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for COD-DOD (Type of Service) checkbox checked--%>
                                                <asp:TableRow ID="trTSCODChecked" runat="server" Style="background-color: White">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;COD/DOD Charges:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;Minimum in Rs.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCODCharge" type="text" size="10" class="blackfnt" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;% of Amount:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCODChargePer" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Volumetric (Type of Service) checkbox checked--%>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                        Fuel Surcharge Applicable
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkfuelsurcharge" runat="server" onclick="javascript:return fuelSurChargeClick()" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Octroi Surcharge Applicable
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkoctroisurcharge" runat="server" onclick="javascript:return octroiSurChargeClick()" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2"></asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White" ID="trfuelsurcharge" runat="server">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table runat="server" ID="tblfuelsurcharge" Style="width: 100%;" CssClass="boxbg"
                                                            CellSpacing="1">
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell></asp:TableCell>
                                                                <asp:TableCell>Air</asp:TableCell>
                                                                <asp:TableCell>Road</asp:TableCell>
                                                                <asp:TableCell>Train</asp:TableCell>
                                                                <asp:TableCell>Express</asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Fuel Surcharge Based On
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasair" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasroad" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebastrain" BackColor="White" runat="server"
                                                                        CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasexpress" BackColor="White" runat="server"
                                                                        CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Rate</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Min Charges in RS</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Max Charge in RS</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White" runat="server" ID="troctroisurcharge">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table runat="server" Style="width: 100%;" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>Octroi Sur Charge Based On</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmboctroisurchargebas" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="O">PerCent on Octroi Value</asp:ListItem>
                                                                        <asp:ListItem Value="I">PerCent on Invoice Value</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat in RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>Octroi SurCharge</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtoctroisurchargerate" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Minimum Octroi Charge in RS
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminoctroisurcharge" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    Maximum Octroi Charge in RS
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxoctroisurcharge" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trTSVolumetricChecked" Style="display: none;" runat="server">
                                                    <asp:TableCell ColumnSpan="6" Style="background-color: White">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;Volumetric Measure:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <label style="margin-left: 5px;">
                                                                    </label>
                                                                    <asp:DropDownList ID="ddlVolMeasure" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                                                        <asp:ListItem Selected="False" Text="Cm" Value="CM"></asp:ListItem>
                                                                        <asp:ListItem Selected="False" Text="Inches" Value="INCHES"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell ColumnSpan="2">
                                                                        &nbsp;Volumetric conversion 1 CFT=Kg.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCFTToKg" type="text" size="10" cssclass="blackfnt" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="margin-left: 5px; border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trTSDACCChecked" runat="server" Style="background-color: White;
                                                    display: none;">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="0" BackColor="#999999">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;DACC Charges:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;Minimum in Rs.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtDACCChargeRs" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;% of Freight:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtDACCChargePer" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Demurrage after days--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        <%--<label CssClass="blackfnt">
                                                            &nbsp;Demurrage after days:
                                                        </label>--%>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                   <%--     <input id="txtDemAfterDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />--%>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="4">
                                                        &nbsp;
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Applicabl_yn_dem="Y"--%>
                                                <asp:TableRow ID="trDemurrageCharges" Style="background-color: White" runat="Server"
                                                    Visible="false">
                                                    <asp:TableCell>
                                                            &nbsp;Demurrage Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDemChargeRs" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Per Kg.:
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDemChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Docket Total Min Max --%>
                                                <asp:TableRow ID="TableRow1" Style="background-color: White" runat="Server">
                                                    <asp:TableCell>
                                                            Validate Docket Total Min Max:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            <asp:CheckBox ID="chkValidateDocketTotalMinMax" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Min Docket Total Value
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            <asp:TextBox ID="txtMinDocketTotalValue" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server" Text="0" MaxLength="50" ></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Max Docket Total Value
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            <asp:TextBox ID="txtMaxDocketTotalValue" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server" Text="0" MaxLength="50"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Generation Location--%>
                                                <asp:TableRow Style="background-color: White" ID="trbillgen" runat="server">
                                                    <asp:TableCell>
                                                        &nbsp;<asp:Label ID="lblbillgenname" runat="server" CssClass="blackfnt"></asp:Label>Bill
                                                        Generation at Location:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillGen" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Submission')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Billing Instance:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="ddlBillingInstance" BackColor="White" runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="On Booking" Value="BKG"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="POD" Value="POD"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Submission Location--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        <asp:Label ID="lblbillsubname" runat="server" CssClass="blackfnt">Bill Submission at Location:</asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillSubLocation" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Submission')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Total credit limit Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtCreditLimit" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell ColumnSpan="2">
                                                        </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        &nbsp;Buffer credit limit Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell >
                                                        <input id="txtBufferLimitrs" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Collection Location--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        <asp:Label ID="lblbillcolname" runat="server" CssClass="blackfnt">Bill Collection at Location:</asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillCollLocation" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Collection')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Credit days from generation:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtCreditDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell >
                                                       Credit Type
                                                        </asp:TableCell>
                                                     <asp:TableCell>
                                                            <asp:DropDownList ID="ddlCreditType" CssClass="blackfnt" BackColor="White" runat="server">
                                                            <asp:ListItem Selected="True" Text="Select" Value=""></asp:ListItem>
                                                            <asp:ListItem Text="Monthly" Value="M"></asp:ListItem>
                                                            <asp:ListItem Text="Half Month" Value="H"></asp:ListItem>
                                                            <asp:ListItem Text="Weekly" Value="W"></asp:ListItem>
                                                            <asp:ListItem  Text="Daily" Value="D"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        &nbsp;Buffer credit days:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtBufferDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for SKU Wise Y/N--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;SKU Wise Y/N:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input type="checkbox" id="chkSKU" runat="server" style="margin-left: 1px;" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="left" CssClass="blackfnt">
                                                        Service Tax Paid By
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="cmbstaxpaidby" CssClass="blackfnt" BackColor="White" runat="server">
                                                            <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="Transporter" Value="T"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="Party" Value="P"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trcombus" runat="server" Style="background-color: White;">
                                                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="left">
                                                        Committed Business
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input type="text" id="txtcommitedbusiness" class="blackfnt" maxlength="11" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            runat="server" style="margin-left: 1px; text-align: right;" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="left" CssClass="blackfnt">
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                  <asp:TableRow ID="TableRow4" runat="server" CssClass="bgwhite" style="display:none">
                
                <asp:TableCell>
                    Delivery allowed<br /> w/o Demurrage Bill Generation
                </asp:TableCell>
                <asp:TableCell>
                    <asp:CheckBox ID="chkAllowDemBillGeneration" runat="server" CssClass="nfnt" />
                </asp:TableCell>
                <asp:TableCell>
                Demurrage Calculation Basis
                </asp:TableCell>
                <asp:TableCell>
                    <asp:DropDownList ID="ddlDemmurageCalculationBasis" runat="server" CssClass="ddlm">
                        <asp:ListItem Text="Inclusive of free storage days" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Exclusive of free storage days " Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell>
                    Free Storage Days
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtDemurrageDays" runat="server" onkeypress="javascript:return validInt(event)"
                        onblur="javascript:this.value=roundNumber(this.value,0)" Text="0" CssClass="rtxt"
                        MaxLength="3" Width="50px"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableRow2" runat="server" CssClass="bgwhite" style="display:none">
                <asp:TableCell>
                    Min Demurrage Charges
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtMinDemurrageCharge" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                        onblur="javascript:this.value=roundNumber(this.value,2)" Text="0.00" CssClass="rtxtm"
                        MaxLength="9" Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>Demurrage Rate & Rate Type</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtDemurrageRate" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                        onblur="javascript:this.value=roundNumber(this.value,2)" Text="0.00" CssClass="rtxtm"
                        MaxLength="9" Width="80px"></asp:TextBox>
                    <asp:DropDownList ID="ddlDemurrageRateType"
                        runat="server" CssClass="ddlm">
                        <asp:ListItem Text="% of Invoice" Value="%I"></asp:ListItem>
                        <asp:ListItem Text="Per Kg Per Day" Value="WD"></asp:ListItem>
                        <asp:ListItem Text="Per PKg Per Day" Value="PD"></asp:ListItem>
                        </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell>
                    Max Demuarrge Charges
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtMaxDemurrageCharge" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                        onblur="javascript:this.value=roundNumber(this.value,2)" Text="0.00" CssClass="rtxtm"
                        MaxLength="9" Width="80px"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                    </asp:Table>
                    <%--<asp:Table runat="server" Style="width: 10in" runat="server" HorizontalAlign="left" CellSpacing="0">
                    <asp:TableRow CssClass="hrow" ID="TableRow3" runat="server">
                <asp:TableCell ColumnSpan="6" Font-Bold="true">Demurrage Information</asp:TableCell>
            </asp:TableRow>
          
                    
                    
                    </asp:Table>--%>
                </asp:TableCell>
            </asp:TableRow>
           
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                    <br />
                    <asp:Table ID="tblbasewiseminfreight" runat="server" Width="40%" CellSpacing="1"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell>
                                    &nbsp;Mode of Transport
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Rate
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Basis
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblairname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtairrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlairbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblroadname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtroadrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlroadbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lbltrainname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txttrainrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddltrainbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblexpressname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtexpressrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlexpressbasisforfreight" BackColor="White" runat="server"
                                    CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Style="display: none;">
                <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true">Minimum Subtotal</asp:TableCell>
            </asp:TableRow>
            
            
             
           
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Table ID="tblpercentwiseminfreight" runat="server" Width="50%" CellSpacing="1"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    Freght Rate
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    SubTotal
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                <asp:CheckBox ID="chkapplyfreight" runat="server" Text="Freight Rate Limits Applicable"
                                    CssClass="blackfnt" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                <asp:CheckBox ID="chkapplysubtotal" runat="server" Text="Sub Total Limits Applicable"
                                    CssClass="blackfnt" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell>
                                    &nbsp;Mode of Transport
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Minimum Freight<br /> (in RS)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Minimum<br /> (in RS)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameair" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameroad" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenametrain" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratetrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotaltrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameexpress" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="center">
                    <br />
                    <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Style="width: 8in">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center">
                                <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                    OnClientClick="javascript:return ValidateData()" OnClick="btnsubmit_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
       <%-- <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
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
            </asp:UpdateProgress>--%>
    </div>
    <%--                HIDDEN AREA             --%>
    <input type="hidden" id="HidCODDODApp" runat="server" />
    <input type="hidden" id="HidDACCApp" runat="server" />
    <input type="hidden" id="HidFTL" runat="server" />
    <input type="hidden" id="HidSUNDRY" runat="server" />
    <input type="hidden" id="HidMOTAir" runat="server" />
    <input type="hidden" id="HidMOTRoad" runat="server" />
    <input type="hidden" id="HidMOTTrain" runat="server" />
    <input type="hidden" id="HidMOTExpress" runat="server" />
    <input type="hidden" id="hdnclient" runat="server" />
</asp:Content>
