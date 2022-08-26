// JScript File
function valid(obja,obj)
    {
        if(obja.checked==true)
        {
            if (obj >= 0 && obj <= 8)
            {
                
                var obj = '0'+ parseInt(eval(obj)+1)
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtMin').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtHour').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlst_am_pm').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_fuAttachment').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').value = "0.30";
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').value = "Awaiting for Approval";
            }
            else if (obj >= 9 && obj <= 99)
            {
                var obj = parseInt(eval(obj)+1)
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtMin').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtHour').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlst_am_pm').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_fuAttachment').disabled = false;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').value = "0.30";
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').value = "Awaiting for Approval";
            }
        }
        else
        {
            if (obj >= 0 && obj <= 8)
            {
                var obj = '0'+ parseInt(eval(obj)+1)
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtMin').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtHour').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlst_am_pm').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').value = "";
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_fuAttachment').disabled = true;                
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').value = ""
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').value = "";
            }
            else if (obj >= 9 && obj <= 99)
            {
                var obj = parseInt(eval(obj)+1)
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtMin').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtHour').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlst_am_pm').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_dlstTest_Live').value = "";
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').disabled = true;
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_fuAttachment').disabled = true;                
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtEffort').value = ""
                document.getElementById('ctl00_MyCPH1_DataGrid1_ctl'+obj+'_txtRemarks').value = "";
            }
        }
    }
    function valideffort(obja,obj)
    {
     
        if(obj.value == "")
        {
            alert("Enter Valid Effort !!");
            obj.value ="0.30"
            obj.focus();
        }
        else if (isNaN(obj.value))
        {
            alert("Enter Valid Number !!");
            obj.value ="0.30";
            obj.focus();
        }
       
        else if((parseFloat(obj.value)) <= 0.00)
        {
            alert("Effort should be grater then 0.00");
            obj.value ="0.30";
            return false;
        }
        
        else if ((parseFloat(obj.value)) >= 0.00)
        {
            obj.value = roundit(obj.value);
        }
        
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
    function validRemarks(obja,obj)
    {
        if(obj.value == "")
        {
            alert("Enter Remarks !!");
            obj.value ="Resolved";
            obj.focus();
        }
    }
    function validdlstTest_Live(obja,obj)
    {
        if(obj.value == "")
        {
            alert("Select Test/Live/Both !!");
            obj.value ="";
            obj.focus();
        }
    }
    function validMin(obja,obj)
    {
        if(obj.value == "")
        {
            alert("Enter Valid Minutes !!");
            obj.value ="00"
            obj.focus();
        }
        else if (isNaN(obj.value))
        {
            alert("Enter Valid Minutes !!");
            obj.value ="00";
            obj.focus();
        }
    }
var normalColor;

function Hilite(row) 
{
       normalColor = row.style.backgroundColor; 
       row.style.backgroundColor = 'SkyBlue';
}
function ColorOn(row)
{
       normalColor = row.style.backgroundColor; 
       row.style.backgroundColor = 'SkyBlue';
}
function Restore(row)
{
 row.style.backgroundColor = normalColor;
}


