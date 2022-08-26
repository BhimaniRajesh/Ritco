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
    var all=null;
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
	    function validId(obj,issueid)
	    {
	        if (issueid.value != "")
	        {
	            
	            createXMLHTTPObject();
			    if (doc)
			    {
			        var locc="";
				    doc.onreadystatechange = return_taskId; 
				    doc.open("GET", "serverPage.aspx?Code=" + issueid.value , false);
				    doc.send(null);
				    if (all == "0")
				    {
				        alert("TaskId Either Complete OR Does not Exists !!");
				        return false;
				    }
	            }
	        }
	        else
	        {
	            alert("Enter TaskId !!");
	            return false;
	        }
	                    
	    }
	    function return_taskId()
	    {
	        if (doc.readyState == 4) 
            {
                 all=doc.responseText;
            }
	    }
function valid(obj,chk,dlstCompany,dlstProject,dlstStatus,dlstEmployee)
    {
        
        if (chk.value == "1")
        {
            if (document.getElementById('ctl00_MyCPH1_txtDateFrom_txt_Date').value == "" || document.getElementById('ctl00_MyCPH1_txtDateTo_txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        }
      
       if (dlstCompany.value == "")
       {
            alert("Please Select Company !!");
            return false;
       }
       else if(dlstProject.value == "")
       {
            alert("Please Select Project !!");
            return false;
       }
       else if(dlstStatus.value == "")
       {
            alert("Please Select Status !!");
            return false;
       }
       else if(dlstEmployee.value == "")
       {
            alert("Please Select Employee !!");
            return false;
       }
    }
 
    function CHK1(ClientId)
      {
        var idid = ClientId.value;
        document.getElementById('ctl00_MyCPH1_chk').value = ""
        if (idid == "redFromTo")
        {
            document.getElementById('ctl00_MyCPH1_chk').value = "1";
        }
        else
        {
            document.getElementById('ctl00_MyCPH1_chk').value = "0";
        }
        
      }
