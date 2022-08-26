// JScript File
var doc = null; 
    var formObj = null;
    var desc = null;
    var list_amt=null;
    var quout=null;
    var quan_tity=null;
    var strStock=null;
    var strnet_value=null;
    var Net_Val=null;
 
      function createXMLHTTPObject(){
	        if (window.XMLHttpRequest) { // Mozilla, Safari,...
	            doc = new XMLHttpRequest();
	            if (doc.overrideMimeType) {
	                doc.overrideMimeType('text/xml');
	            }
	        } else if (window.ActiveXObject) { // IE
	            try {
	                doc = new ActiveXObject("Msxml2.XMLHTTP");
	            } catch (e) {
	                try {
	                    doc = new ActiveXObject("Microsoft.XMLHTTP");
	                } catch (e) {}
	            }
	        }
	    }
var tManCode= null;	     
function validcode(obj,txtManCode)
{
    tManCode = txtManCode;
    createXMLHTTPObject();
			if (doc)
			{ 
			    var locc="";
				doc.onreadystatechange = man_code_change; 
				doc.open("GET", "serverPage.aspx?Code=" + txtManCode.value , false);
				doc.send(null); 
				
			}            
}
function man_code_change()
{
    if (doc.readyState == 4) 
    {
        
        var all=doc.responseText;
        if (all != "0")
        {
            alert("Code Exists !!");
            return false;
        }
    }
}

function loc_code()
{
    if (doc.readyState == 4) 
    {
        var all=doc.responseText;
        if (all == "0")
        {
            alert("Location Doesn't Exist !!");
            return false;
        }
    }
}
    function Create_Group()
    {
        window.open('Account_Add_PopUp.aspx' ,'myWindow','height=440,width=800,resizable=yes,scrollbars=yes,left=310,top=15'); 
    }
    function Create_SubGroup()
    {
        window.open('Account_Add_SubGroup_PopUp.aspx' ,'myWindow','height=440,width=800,resizable=yes,scrollbars=yes,left=310,top=15'); 
    }
    function openLocation()
    {
        window.open('frmLocation.aspx' ,'myWindow','height=440,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
    }
    function valid(obj,dlstCategory,dlstGroup,txtManCode,txtAcctDesc,dlstAcctCategory,txtAcctNumber,txtLocation)
    {
        //alert(dlstCategory.value)
        if (dlstCategory.value == "")
        {
            alert("Please Select Category !!")
            return false;
        }
        else if (dlstGroup.value == "Select")
        {
            alert("Please Select Group !!")
            return false;
        }
        else if (txtManCode.value == "")
        {
            alert("Please Enter Manual Account Code !!")
            return false;
        }
        else if (txtAcctDesc.value == "")
        {
            alert("Please Enter Account Description !!")
            return false;
        }
        else if (dlstAcctCategory.value == "")
        {
            alert("Please Select Account Category !!")
            return false;
        }
        else if (dlstAcctCategory.value == "BANK")
        {
            if (txtAcctNumber.value == "")
            {
                 alert("Please Enter Account Number !!")
                 return false;
            }
            else if (txtLocation.value == "")
            {
                 alert("Please Enter Applicable to Locations !!")
                 return false;
            }
            
        }
       else
       {
        return true;
       } 
       
    }
