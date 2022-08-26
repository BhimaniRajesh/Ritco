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
	    function validId(obj,issueid1,issueid2,type)
	    {
	        if (issueid1.value != "")
	        {   
	            createXMLHTTPObject();
			    if (doc)
			    {
			        var locc="";
				    doc.onreadystatechange = return_taskId; 
				    doc.open("GET", "serverPage.aspx?ManualCode=" + issueid1.value + "&SystemCode=" + issueid2.innerText, false);
				    doc.send(null);
				    var res=all.split(",");
				    if(type.value == "new")
				    {
				        if (Number(res[0]) > 0)
				        {
				            alert("Company Code Already Exists .. Plz Enter Valid Company Code");
				            issueid1.value = "";
				            return false;
				        }
				        if (Number(res[1]) > 0)
				        {
				            alert("Company Code Already Exists As System Generated Code");
				            issueid1.value = "";
				            return false;
				        }
				    }
				    else
				    {
				        if (Number(res[0]) > 1)
				        {
				            alert("Company Code Already Exists .. Plz Enter Valid Company Code");
				            issueid1.value = "";
				            return false;
				        }
				        if (Number(res[1]) > 1)
				        {
				            alert("Company Code Already Exists As System Generated Code");
				            issueid1.value = "";
				            return false;
				        }
				    }
	            }
	        }
	        else
	        {
	            //alert("Plz Enter Company Code !!");
	            //return false;
	        }
	                    
	    }
	    function return_taskId()
	    {
	        if (doc.readyState == 4) 
            {
                 all=doc.responseText;
            }
	    }