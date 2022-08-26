<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditCCMODA.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_EditCCMODA"
    Title="Customer Contract Master - ODA" %>
    <%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        
        // JScript File
        var months = new Array("","January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December");

        var dtCh= "/";
        var minYear=1900;
        var maxYear=2100;
        
        function disableenter()
        {
        
        }
        
        function isInteger(s)
        {
            for (var i = 0; i < s.length; i++)
            {   
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag)
        {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++)
            {   
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            
            return returnString;
        }

        function daysInFebruary (year)
        {
	        // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
        }

        function DaysArray(n)
        {
            for (var i = 1; i <= n; i++)
            {
		        this[i] = 31
		        if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		        if (i==2) {this[i] = 29}
            }
            
            return this
        }

        function isDate1(dtStr)
        {
	        var daysInMonth = DaysArray(12)
	        var pos1 = dtStr.indexOf(dtCh)
	        var pos2 = dtStr.indexOf(dtCh,pos1+1)
	        var strDay = dtStr.substring(0,pos1)
	        var strMonth = dtStr.substring(pos1+1,pos2)
	        var strYear = dtStr.substring(pos2+1)
        	
	        strYr = strYear
        	
	        if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	        if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
        	
	        for (var i = 1; i <= 3; i++)
	        {
		        if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	        }
        	
	        month = parseInt(strMonth)
	        day = parseInt(strDay)
	        year = parseInt(strYr)
        	
	        if (pos1==-1 || pos2==-1)
	        {
		        alert("The date format should be : dd/mm/yyyy")
		        return false
	        }
        	
	        if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
	        {
		        alert("Please enter a valid day")
		        return false
	        }
        	
	        if (strMonth.length<1 || month<1 || month>12)
	        {
		        alert("Please enter a valid month")
		        return false
	        }
        	
	        if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
	        {
		        alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		        return false
	        }
        	
	        if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
	        {
		        alert("Please enter a valid date")
		        return false
	        }
        	
            return true
        }

        function ValidateDate(obj)
        {  
            if (obj.value!="")
            {
	            var dockdt=obj.value
        	
		        if(dockdt.length<10)
		        {
		            alert("Please enter the date in dd/mm/yyyy format")
		            obj.focus();
		            return false;
		        }
        	
	            if (isDate1(obj.value)==false)
	            {
		            obj.focus()
		            return false
	            }
        	    
                return true
            }  
        }
         
        function MyDateDiff( start, end, interval, rounding )
        {
            var iOut = 0;
            var bufferA = Date.parse( start ) ;
            var bufferB = Date.parse( end ) ;
            	
            // check that the start parameter is a valid Date. 
            if ( isNaN (bufferA) || isNaN (bufferB) )
            {
                alert( startMsg ) ;
                return null ;
            }
        	
            // check that an interval parameter was not numeric. 
            if ( interval.charAt == 'undefined' )
            {
                // the user specified an incorrect interval, handle the error. 
                alert( intervalMsg ) ;
                return null ;
            }
            
            var number = bufferB-bufferA ;
            
            // what kind of add to do? 
            switch (interval.charAt(0))
            {
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

        function IsNumeric(sText)
        {
           var ValidChars = "0123456789.";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
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
	
        function Nagative_Chk_woDecimal(obj)
        {
	        var temp = obj.value 
        						
	        if (temp == "")	
	        {
		        //alert("Value can not be blank")
		        //obj.focus();
		        return true;
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
        	
	        if(temp.indexOf(".") > 0)
	        {
		        alert("Value should not contain decimal point")
		        obj.focus();
		        return false;
	        } 
        	
	        obj.value=Math.round(temp)
        	 	
	        return true;					 				   
        }

        function rounditn(Num, decplaces)
        {
	        Places = decplaces
        	
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
	        else
	        {
	            return Math.round(Num);
            }
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
        
    </script>

    <script language="javascript" type="text/javascript">
        
        function CheckBranchCityMatrix(MOT, BranchCity)
        {
            var mCtlForFRFrom = "ctl00_MyCPH1_txtFromFor" + MOT + "For" + BranchCity;
            var mCtlForFRFromErrorLabel = "ctl00_MyCPH1_lblFromFor" + MOT + "For" + BranchCity;
            var mCtlForFRTo = "ctl00_MyCPH1_txtToFor" + MOT + "For" + BranchCity;
            var mCtlForFRToErrorLabel = "ctl00_MyCPH1_lblToFor" + MOT + "For" + BranchCity;
            var mCtlForTrDays = "ctl00_MyCPH1_txtTrDaysFor" + MOT + "For" + BranchCity;
            var mCtlForRateType = "ctl00_MyCPH1_ddlRateTypeFor" + MOT + BranchCity;
            var mCtlForSlab1 = "ctl00_MyCPH1_txtSlab1For" + MOT + BranchCity;
            var mCtlForSlab2 = "ctl00_MyCPH1_txtSlab2For" + MOT + BranchCity;
            var mCtlForSlab3 = "ctl00_MyCPH1_txtSlab3For" + MOT + BranchCity;
            var mCtlForSlab4 = "ctl00_MyCPH1_txtSlab4For" + MOT + BranchCity;
            var mCtlForSlab5 = "ctl00_MyCPH1_txtSlab5For" + MOT + BranchCity;
            var mCtlForSlab6 = "ctl00_MyCPH1_txtSlab6For" + MOT + BranchCity;
            var mCtlForFRFromZone = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow";
            var mCtlForFRToZone = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow";
            
            var mVarBM = "";
            var mVarBMTemp = "";
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter) && document.getElementById(mCtlForFRTo + mLoopCounter) ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter) && document.getElementById(mCtlForFRToZone + mLoopCounter) ))
                {
//                    var mFromValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
//                    var mToValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
                    var mDataExists = 0;
                    
                    if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" && document.getElementById(mCtlForFRTo + mLoopCounter).value != "" ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1" && document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1" ))
                    {
                        mDataExists = 1;
                    }
                    //if((document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" || document.getElementById(mCtlForFRFrom + mLoopCounter).value != "-1") && (document.getElementById(mCtlForFRTo + mLoopCounter).value != "" || document.getElementById(mCtlForFRTo + mLoopCounter).value != "-1"))
                    if(mDataExists == 1)
                    {   
                        //Check for Branch From for Mode of Transport 
                        if(BranchCity == "Zone")
                        {
                            if(document.getElementById(mCtlForFRFromZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1")
                                {
                                    mVarBMTemp = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Select Zone From for " + MOT);
                                    document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                                    return false;
                                }
                            }
                    
                            //Check for Branch/City To for Mode of Transport
                            if(document.getElementById(mCtlForFRToZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1")
                                {
                                    mVarBMTemp += "," + document.getElementById(mCtlForFRToZone + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Select Zone To for " + MOT);
                                    document.getElementById(mCtlForFRToZone + mLoopCounter).focus();
                                    return false;
                                }
                            }
                        }
                        else
                        {
                            if(document.getElementById(mCtlForFRFrom + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRFrom + mLoopCounter).value != "")
                                {
                                    if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter))
                                    {
                                        if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter).style.display == '')
                                        {
                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
                                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    mVarBMTemp = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
                                    document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                    return false;
                                }
                            }
                            
                            //Check for Branch/City To for Mode of Transport
                            if(document.getElementById(mCtlForFRTo + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRTo + mLoopCounter).value != "")
                                {
                                    if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter))
                                    {
                                        if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter).style.display == '')
                                        {
                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
                                            document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    mVarBMTemp += "," + document.getElementById(mCtlForFRTo + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
                                    document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                    return false;
                                }
                            }
                        }
                        
                        //Check for Transit Days for Mode of Transport Branch/City/Zone
                        if(document.getElementById(mCtlForTrDays + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForTrDays + mLoopCounter).value == "")
                            {
                                alert("Enter 'Transit Days' for '" + MOT + "' For '" + BranchCity + "'");
                                document.getElementById(mCtlForTrDays + mLoopCounter).focus();
                                return false;
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForTrDays + mLoopCounter).value;
                            }
                        }
                                    
                        //Check for Rate Type for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForRateType + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForRateType + mLoopCounter).value == "-1")
                            {
                                alert("Select 'Rate Type' from the list");
                                document.getElementById(mCtlForRateType + mLoopCounter).focus();
                                return false;
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForRateType + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 1 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab1 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab1 + mLoopCounter).value == "")
                            {
                                alert("Enter 'Slab 1' from the list");
                                document.getElementById(mCtlForSlab1 + mLoopCounter).focus();
                                return false;
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab1 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 2 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab2 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab2 + mLoopCounter).value == "")
                            {
                                mVarBMTemp += ",";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab2 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 3 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab3 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab3 + mLoopCounter).value == "")
                            {
                                mVarBMTemp += ",";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab3 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 4 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab4 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab4 + mLoopCounter).value == "")
                            {
                                mVarBMTemp += ",";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab4 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 5 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab5 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab5 + mLoopCounter).value == "")
                            {
                                mVarBMTemp += ",";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab5 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 6 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab6 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab6 + mLoopCounter).value == "")
                            {
                                mVarBMTemp += ",";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mCtlForSlab6 + mLoopCounter).value;
                            }
                        }
                        
                        if(mVarBMTemp != "")
                        {
                            mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
                            mVarBMTemp = "";
                        }
                    }
                    else
                    {
                        if(mLoopCounter == 1)
                        {
                            alert("Enter/Select Freight Matrix Details!");
                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                            return false;
                        }    
                    }
                }
            }
            
            //Check for Distinct Pair of Branch/City From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                var mVarBranchCityFrom = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
                var mVarBranchCityTo = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
                
                if(mVarBranchCityFrom != "" && mVarBranchCityTo != "")
                {
                    if(CheckDuplicateBranchCity(mVarBranchCityFrom, mVarBranchCityTo, mLoopCounter, MOT, BranchCity) == true)
                    {
                        alert("Please select/enter distinct '" + BranchCity + " From' & '" + BranchCity + " To'!");
                        if(BranchCity != "Zone")
                        {
                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                        }
                        else
                        {
                            document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                        }
                        return false;
                    }
                }
            }
            
            if(BranchCity == "Branch")
            {
                if(document.getElementById("ctl00_MyCPH1_HidBM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidBM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            else if(BranchCity == "City")
            {
                if(document.getElementById("ctl00_MyCPH1_HidCM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidCM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            else if(BranchCity == "Zone")
            {
                if(document.getElementById("ctl00_MyCPH1_HidZM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidZM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            
            return true;
        }
        
        function CheckBranchCityBasicDetails(MOT, BranchCity)
        {
            //Check for Branch Matrix for Road
            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity))
            {
                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity).style.display == '')
                {   
                    //Check for Branch Code for Road
                    if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT))
                    {
                        if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).value != "")
                        {
                            if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT))
                            {
                                if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT).style.display == '')
                                {
                                    alert("Invalid 'Branch Code' for " + MOT);
                                    document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
                                    return false;
                                }
                            }
                        }
                        else
                        {
                            alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
                            document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
                            return false;
                        }
                    }
                    else
                    {
                        alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
                        document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
                        return false;
                    }
                    
                    if(CheckBranchCityMatrix(MOT, BranchCity) == false)
                    {
                        return false;
                    }
                }
            }
        }
        
        function CheckZoneBasicDetails(MOT)
        {
            //Check for Zone Matrix for Mode of Transaction
            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "ForZone"))
            {
                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "ForZone").style.display == '')
                {   
                    //Check for Branch Code for Road
                    if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT))
                    {
                        if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT).value == "-1")
                        {
                            alert("Select 'Zone' for " + MOT + " from the list!");
                            document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT).focus();
                            return false;
                        }                        
                    }
                    else
                    {
                        alert("Zone selection list is not available for " + MOT);
                        return false;
                    }
                    
                    if(CheckBranchCityMatrix(MOT, "Zone") == false)
                    {
                        return false;
                    }
                }
            }
        }
        
        function BranchPopup(strPopupURL)
        {
            var strWinFeature = "height=375,width=350,scrollbars=yes,left=300,top=125"
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function ValidateData()
        {
            //Check for selection of Rate Type
            if(document.getElementById("ctl00_MyCPH1_ddlRateType"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddlRateType").value == "-1")
                {
                    alert("Please select Rate Type from the list");
                    document.getElementById("ctl00_MyCPH1_ddlRateType").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list for Rate Type is not available!");
                return false;
            }
            
            //Check for selection of ODA Rate Type
            if(document.getElementById("ctl00_MyCPH1_ddlODARateType"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddlODARateType").value == "-1")
                {
                    alert("Please select ODA Rate Type from the list");
                    document.getElementById("ctl00_MyCPH1_ddlODARateType").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list for ODA Rate Type is not available!");
                return false;
            }
            
            //Check for Minimum ODA Charge
//            if(document.getElementById("ctl00_MyCPH1_txtMinODACharges"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_txtMinODACharges").value == "")
//                {
//                    alert("Enter Value for 'Minimum ODA Charge'");
//                    document.getElementById("ctl00_MyCPH1_txtMinODACharges").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Input Box for 'Minimum ODA Charge' is not available!");
//                return false;
//            }
            
            //Check for atleast one From and To Slab entry
            if(document.getElementById("ctl00_MyCPH1_txtFromSlab1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtFromSlab1").value == "")
                {
                    alert("Enter Value for 'Slab From' 1");
                    document.getElementById("ctl00_MyCPH1_txtFromSlab1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'Slab From 1' is not available!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_txtToSlab1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtToSlab1").value == "")
                {
                    alert("Enter Value for 'Slab To' 1");
                    document.getElementById("ctl00_MyCPH1_txtToSlab1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'Slab To 1' is not available!");
                return false;
            }
        
            //Check for atleast one From and To ODA Distance Slab entry
            if(document.getElementById("ctl00_MyCPH1_txtFromODA1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtFromODA1").value == "")
                {
                    alert("Enter Value for 'ODA From' 1");
                    document.getElementById("ctl00_MyCPH1_txtFromODA1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'ODA From 1' is not available!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_txtToODA1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtToODA1").value == "")
                {
                    alert("Enter Value for 'ODA To' 1");
                    document.getElementById("ctl00_MyCPH1_txtToODA1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'ODA To 1' is not available!");
                return false;
            }
            
            //Check for atleast one Transit Days and Slab entry
            if(document.getElementById("ctl00_MyCPH1_txtTrODA1ForRow1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtTrODA1ForRow1").value == "")
                {
                    alert("Enter Value for 'Transit Days' for Slab 1");
                    document.getElementById("ctl00_MyCPH1_txtTrODA1ForRow1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'Transit Days' for Slab 1 is not available!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_txtSlabODA1ForRow1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtSlabODA1ForRow1").value == "")
                {
                    alert("Enter Value for 'ODA Charges For Slab 1'");
                    document.getElementById("ctl00_MyCPH1_txtSlabODA1ForRow1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'ODA Charges For Slab 1' is not available!");
                return false;
            }
            
            return true;
        }
            
        function CheckDuplicateBranchCity(BranchCityFrom, BranchCityTo, BranchCityRow, MOT, BranchCity)
        {
            var mVarControlForBranchCityFrom;
            var mVarControlForBranchCityTo;
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                if(mLoopCounter != BranchCityRow)
                {
                    //Create control ID's
                    if(BranchCity != "Zone")
                    {
                        mVarControlForBranchCityFrom = "ctl00_MyCPH1_txtFRFrom" + MOT + "For" + BranchCity + mLoopCounter;
                        mVarControlForBranchCityTo = "ctl00_MyCPH1_txtFRTo" + MOT + "For" + BranchCity + mLoopCounter;
                    }
                    else
                    {
                        mVarControlForBranchCityFrom = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow" + mLoopCounter;
                        mVarControlForBranchCityTo = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow" + mLoopCounter;
                    }
                    
                    //Check for Branch/City From & To Duplication
                    if(BranchCity != "Zone")
                    {
                        if(document.getElementById(mVarControlForBranchCityFrom) && document.getElementById(mVarControlForBranchCityTo))
                        {
                            if(document.getElementById(mVarControlForBranchCityFrom).value != "" && document.getElementById(mVarControlForBranchCityTo).value != "")
                            {
                                if(document.getElementById(mVarControlForBranchCityFrom).value == BranchCityFrom && document.getElementById(mVarControlForBranchCityTo).value == BranchCityTo)
                                {
                                    return true;
                                }
                            }
                        }
                    }
                    else
                    {
                        if(document.getElementById(mVarControlForBranchCityFrom) && document.getElementById(mVarControlForBranchCityTo))
                        {
                            if(document.getElementById(mVarControlForBranchCityFrom).value != "-1" && document.getElementById(mVarControlForBranchCityTo).value != "-1")
                            {
                                if(document.getElementById(mVarControlForBranchCityFrom).value == BranchCityFrom && document.getElementById(mVarControlForBranchCityTo).value == BranchCityTo)
                                {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
            
            return false;
        }
        
    </script>


     <cust:CustInfo runat="server" ID="cstheader" />
    <div>
        <table border="0" cellpadding="0" width="85%" cellspacing="0" align="center" class="boxbg">
            <tr style="background-color: White">
                <td align="center" colspan="4">
                    <br style="font-size: 6pt;" />
                    <table border="0" cellpadding="1" width="100%" cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: White">
                            <td align="right">
                                <label class="blackfnt">
                                    Select Rate Type:&nbsp;
                                </label>
                            </td>
                            <td align="left">
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlRateType" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
                                    <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="right">
                                <label class="blackfnt">
                                    ODA Rate Type:&nbsp;
                                </label>
                            </td>
                            <td align="left">
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlODARateType" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
                                    <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
                                    <asp:ListItem Value="F" Text="Flat Rate"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="right">
                                <label class="blackfnt">
                                    Minimum ODA Charge:&nbsp;
                                </label>
                            </td>
                            <td align="left">
                                <input id="txtMinODACharges" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: White">
                <td align="center" colspan="4">
                    <br style="font-size: 6pt;" />
                    <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: White">
                            <td align="center" colspan="12">
                                <label class="bluefnt">
                                    <b>Define Weight/Package Slab </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 1
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 2
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 3
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 4
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 5
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    Slab 6
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <input id="txtFromSlab1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromSlab2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromSlab3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromSlab4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromSlab5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromSlab6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToSlab6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: White">
                <td align="center" colspan="4">
                    <br style="font-size: 6pt;" />
                    <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: White">
                            <td align="center" colspan="12">
                                <label class="bluefnt">
                                    <b>Define ODA Distance ODA in Km. </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 1
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 2
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 3
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 4
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 5
                                </label>
                            </td>
                            <td align="center" colspan="2">
                                <label class="blackfnt">
                                    ODA 6
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    From
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    To
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <input id="txtFromODA1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromODA2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromODA3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromODA4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromODA5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtFromODA6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtToODA6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: White">
                <td align="center" colspan="4">
                    <br style="font-size: 6pt;" />
                    <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: White">
                            <td align="center" colspan="12">
                                <label class="bluefnt">
                                    <b>Define ODA Charges </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    Distance
                                    <br />
                                    From Delivery<br />
                                    Location
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Extra Transit<br />
                                    Days
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Slab 1
                                </label>
                            </td>
                            <td align="center" style="width: 72px">
                                <label class="blackfnt">
                                    Slab 2
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Slab 3
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Slab 4
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Slab 5
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    Slab 6
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 1
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow1" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 2
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow2" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 3
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow3" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 4
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow4" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 5
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow5" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="blackfnt">
                                    ODA 6
                                </label>
                            </td>
                            <td align="center">
                                <input id="txtTrODA1ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_woDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA1ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center" style="width: 72px">
                                <input id="txtSlabODA2ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA3ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA4ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA5ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td align="center">
                                <input id="txtSlabODA6ForRow6" type="text" size="10" maxlength="6" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
            <tr class="bgbluegrey">
                <td colspan="8" align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClientClick="return ValidateData()"
                        OnClick="btnSubmit_Click" ToolTip="Click here to Submit and Proceed" />
                </td>
            </tr>
        </table>
        </td>
        </tr>
        </table>
        <br />
        <asp:UpdateProgress ID="uppMain" runat="server">
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
            </asp:UpdateProgress>
    </div>
</asp:Content>
