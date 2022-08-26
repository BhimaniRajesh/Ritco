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
	    //,,
function valid(obj,chk,dlstCustomer,status,dlstEmployee,dlstIssueType,txtPendingTime)
    {
        
        if (chk.value == "1")
        {
            if (document.getElementById('ctl00_MyCPH1_txtDateFrom_txt_Date').value == "" || document.getElementById('ctl00_MyCPH1_txtDateTo_txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        }
      
       if (dlstCustomer.value == "")
       {
            alert("Please Select Customer !!");
            return false;
       }
       else if(status.value == "")
       {
            alert("Please Select Status !!");
            return false;
       }
       else if(dlstEmployee.value == "")
       {
            alert("Please Select Employee !!");
            return false;
       }
       else if(dlstIssueType.value == "")
       {
            alert("Please Select Employee !!");
            return false;
       }
       else if(txtPendingTime.value != "")
       {
            if(isNaN(txtPendingTime.value))
            {
                alert("Enter Value Number !!!");
                return false;
            }
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
      
      function validuser(obj,oldPass,newPass)
	    {
	        if (oldPass.value == "")
	        {
	            alert("Enter Old Password !!");
	            oldPass.focus();
	            return false;
	        }
	        else if (newPass.value == "")
	        {
	            alert("Enter New Password !!");
	            newPass.focus();
	            return false;
	        }
	        else if (oldPass.value != "" && newPass != "")
	        {
	            createXMLHTTPObject();
			    if (doc)
			    {
			        var locc="";
				    doc.onreadystatechange = return_password; 
				    doc.open("GET", "serverPage.aspx?Code=" + oldPass.value , false);
				    doc.send(null);
				    if (all == "0")
				    {
				        alert("Your Old Password Does Not Match !!");
				        oldPass.className = "redfnt";
				        return false;
				    }
	            }
	        }
	        
	    }
	    function return_password()
	    {
	        if (doc.readyState == 4) 
            {
                 all=doc.responseText;
            }
	    }
	    
	    function selectCom(obj,company,dlstCompanyI)
	    {
	        
	        if (company.value == "" && dlstCompanyI.value== "")
	        {
	            alert("Please Select Company !!");
	            return false;
	        }
	        else if (company.value != "" && dlstCompanyI.value != "")
	        {
	            alert("Please Select One Company !!");
	            return false;
	        }
	    }
	    function selectMod(obj,dlstModuleA,dlstModuleI)
	    {
	        if (dlstModuleA.value == "" && dlstModuleI.value== "")
	        {
	            alert("Please Select Module !!");
	            return false;
	        }
	        else if (dlstModuleA.value != "" && dlstModuleI.value != "")
	        {
	            alert("Please Select One Module !!");
	            return false;
	        }
	    }
	    function selectUser(obj,dlstUserA,dlstUserI)
	    {
	        if (dlstUserA.value == "" && dlstUserI.value== "")
	        {
	            alert("Please Select User !!");
	            return false;
	        }
	        else if (dlstUserA.value != "" && dlstUserI.value != "")
	        {
	            alert("Please Select One User !!");
	            return false;
	        }
	    }
	    function validCompany(obj,txtClientName,txtClientAddtrss,txtCLIENT_CONTACT_NO,dlstProjMag,txtEmail)
	    {
	        if(txtClientName.value == "")
	        {
	            alert("Enter Client Name !!")
	            txtClientName.focus();
	            return false;
	        }
	        else if(txtClientAddtrss.value == "")
	        {
	            alert("Enter Client Address !!")
	            txtClientAddtrss.focus();
	            return false;
	        }
	        else if (txtCLIENT_CONTACT_NO.value == "")
	        {
	            alert("Enter Client Contact Number !!")
	            txtCLIENT_CONTACT_NO.focus();
	            return false;
	        }
	        else if (dlstProjMag.value == "")
	        {
	            alert("Select Project Manager !!")
	            dlstProjMag.focus();
	            return false;
	        }
	        else if (txtEmail.value == "")
	        {
	             alert("Enter at least One Email Address !!")
	             txtEmail.focus();
	             return false;
	        }
	    }
	    //////////////////////////////////////
	    function ValidUserName(obj)
	    {
	        if (obj.value != "")
	        {
	            createXMLHTTPObject();
			    if (doc)
			    {
			        var locc="";
				    doc.onreadystatechange = return_UserName; 
				    doc.open("GET", "serverUserName.aspx?Code=" + obj.value , false);
				    doc.send(null);
				    if (all > 0)
				    {
				        alert("User Name Already Exists !!");
				        obj.value = "";
				        return false;
				    }
	            }
	        }
	    }
	    function return_UserName()
	    {
	        if (doc.readyState == 4) 
            {
                 all=doc.responseText;
            }
	    }
	    function UserMastervalid(obj,txtUserName,txtClientPassword,dlstPwsQus,txtPwsAns,txtBranchCode,txtFullName,txtEmail)
	    {
	        
	        if (txtUserName.value == "")
	        {
	            alert("Please Enter User Id!!");
	            return false;
	        }
	        else if (txtClientPassword.value == "")
	        {
	            alert("Please Enter Password!!");
	            return false;
	        }
	        else if (dlstPwsQus.value == "")
	        {
	            alert("Please Select Password Question!!");
	            return false;
	        }
	        else if (txtPwsAns.value == "")
	        {
	            alert("Please Enter Password Answers!!");
	            return false;
	        }
	        else if (txtBranchCode.value == "")
	        {
	            alert("Please Enter Branch Code/Name !!");
	            return false;
	        }
	        else if (txtFullName.value == "")
	        {
	            alert("Please Enter Full Name !!");
	            return false;
	        }
	        else if (txtEmail.value == "")
	        {
	            alert("Please Enter Email !!");
	            return false;
	        }
	        else if(txtEmail.value != "")
	        {
	            var testresults;
	            var str=txtEmail.value
                var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
                if (filter.test(str))
                testresults=true
                else
                {
                    alert("Please input a valid email address!")
                    return false;
	            }
	        }
	    }
	    function openPopUp(obj)
	    {
	        window.open('issue/issuePopUp.aspx?ID=' + document.getElementById('ctl00_MyCPH1_txtIssueno').value  ,null,'height=200, width=800,status= no, resizable= yes, scrollbars=yes, toolbar=no,location=no,menubar=no ');
	    }
	    function validProject(obj,dlstProject)
	    {
	        if(dlstProject.value != "")
	        {
	            createXMLHTTPObject();
	            if (doc)
			    {
			        
				    doc.onreadystatechange = return_ProjectNum; 
				    doc.open("GET", "serverPageProjectTask.aspx?Code=" + dlstProject.value , false);
				    doc.send(null);
				    if (all != "0")
				    {
				        alert("Your " + all + " Task's still Open Please Close Task's in Order To Close This Project");
				        return false;
				    }
	            }
	        }
	        else if(dlstProject.value == "")
	        {
	            alert("Please Select One Project !!");
	            return false;
	        }
	        
	    }
	    function return_ProjectNum()
	    {
	        if (doc.readyState == 4) 
            {
                 all=doc.responseText;
            }
	    }
